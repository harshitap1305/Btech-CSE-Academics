#include <iostream>
#include <vector>
#include <thread>
#include <chrono>
#include <cstring>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <opencv2/opencv.hpp>

#define DNS_PORT 8080
#define VIDEO_PORT 9000
#define DNS_SERVER_IP "127.0.0.1"

// DNS Request Structure (Must match the server exactly)
typedef struct {
    int transaction_id;
    char qname[256];
} DNS_Request;

// DNS Response Structure
typedef struct {
    int transaction_id;
    char ip_address[16];
} DNS_Response;

// Global flag to stop the keep-alive thread when the user closes the video
bool keep_running = true;

// Background thread function to send keep-alive messages every 150ms
void send_keep_alive(int sock, struct sockaddr_in server_addr) {
    const char* msg = "KEEP_ALIVE";
    while (keep_running) {
        sendto(sock, msg, strlen(msg), 0, (struct sockaddr*)&server_addr, sizeof(server_addr));
        std::this_thread::sleep_for(std::chrono::milliseconds(150));
    }
}

int main() {

    int tcp_sock = socket(AF_INET, SOCK_STREAM, 0);
    if (tcp_sock < 0) {
        perror("[-] TCP Socket creation failed");
        return 1;
    }

    struct sockaddr_in dns_addr;
    memset(&dns_addr, 0, sizeof(dns_addr));
    dns_addr.sin_family = AF_INET;
    dns_addr.sin_port = htons(DNS_PORT);
    inet_pton(AF_INET, DNS_SERVER_IP, &dns_addr.sin_addr);

    if (connect(tcp_sock, (struct sockaddr *)&dns_addr, sizeof(dns_addr)) < 0) {
        perror("[-] Failed to connect to DNS Server");
        return 1;
    }

    // Construct and send the DNS request
    DNS_Request req;
    req.transaction_id = 101; // Random ID
    strcpy(req.qname, "video.server.com");

    std::cout << "Resolving domain name..." << std::endl;
    write(tcp_sock, &req, sizeof(req));

    // Receive the DNS response
    DNS_Response res;
    int n = read(tcp_sock, &res, sizeof(res));
    if (n <= 0) {
        perror("[-] Failed to read DNS response");
        return 1;
    }

    close(tcp_sock); 

    std::cout << "\nDomain: " << req.qname << std::endl;
    std::cout << "IP Address: " << res.ip_address << "\n" << std::endl;

    if (strcmp(res.ip_address, "NOT_FOUND") == 0) {
        std::cout << "Cannot proceed: Domain not found." << std::endl;
        return 1;
    }

    int udp_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (udp_sock < 0) {
        perror("[-] UDP Socket creation failed");
        return 1;
    }

    struct sockaddr_in video_server_addr;
    memset(&video_server_addr, 0, sizeof(video_server_addr));
    video_server_addr.sin_family = AF_INET;
    video_server_addr.sin_port = htons(VIDEO_PORT);
    inet_pton(AF_INET, res.ip_address, &video_server_addr.sin_addr);

    std::cout << "Starting video stream... (Press ESC to quit)" << std::endl;

    // Start the keep-alive thread
    std::thread keep_alive_thread(send_keep_alive, udp_sock, video_server_addr);

    // Buffer to hold incoming JPEG data (Max UDP packet size)
    char buffer[65535]; 

    while (true) {
        socklen_t len = sizeof(video_server_addr);
        int bytes_received = recvfrom(udp_sock, buffer, sizeof(buffer), 0, 
                                     (struct sockaddr*)&video_server_addr, &len);
        
        if (bytes_received > 0) {
            // Deserialize bytes into an OpenCV matrix
            std::vector<uchar> img_data(buffer, buffer + bytes_received);
            cv::Mat frame = cv::imdecode(img_data, cv::IMREAD_COLOR);

            if (!frame.empty()) {
                cv::imshow("Client Video Stream", frame);
                
                // Wait 1ms and check if the user pressed the ESC key (ASCII 27)
                if (cv::waitKey(1) == 27) { 
                    break;
                }
            }
        }
    }

    keep_running = false;
    keep_alive_thread.join(); // Wait for the keep-alive thread to exit gracefully
    close(udp_sock);
    cv::destroyAllWindows();

    return 0;
}