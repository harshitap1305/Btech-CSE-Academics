#include <iostream>
#include <vector>
#include <chrono>
#include <thread>
#include <cstring>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <opencv2/opencv.hpp>
#include <sys/select.h>

#define VIDEO_PORT 9000

int main() {
    // 1. Create a UDP socket
    int udp_sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (udp_sock < 0) {
        perror("[-] UDP Socket creation failed");
        return 1;
    }

    struct sockaddr_in server_addr, client_addr;
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(VIDEO_PORT);

    if (bind(udp_sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("[-] Bind failed");
        return 1;
    }

    std::cout << "[+] Video Server listening on UDP port " << VIDEO_PORT << std::endl;

    // 2. Initialize OpenCV Video Capture (0 is usually the default webcam)
    cv::VideoCapture cap(0);
    if (!cap.isOpened()) {
        std::cerr << "[-] Error: Could not open the webcam." << std::endl;
        return 1;
    }

    // Reduce resolution to ensure the JPEG fits inside a single UDP packet safely
    cap.set(cv::CAP_PROP_FRAME_WIDTH, 640);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 480);

    char buffer[1024];
    socklen_t client_len = sizeof(client_addr);
    bool client_connected = false;
    
    // Timer to track the 200ms keep-alive constraint
    auto last_keep_alive_time = std::chrono::steady_clock::now();

    // Set socket to non-blocking so we can interleave reading keep-alives and sending video
    struct timeval tv;
    tv.tv_sec = 0;
    tv.tv_usec = 10000; // 10ms timeout for recvfrom
    setsockopt(udp_sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));

    std::cout << "[*] Waiting for client to connect and send a KEEP_ALIVE message..." << std::endl;

    std::vector<uchar> encoded_buffer;
    std::vector<int> encode_params = {cv::IMWRITE_JPEG_QUALITY, 50}; // 50% quality to compress heavily

    cv::Mat frame;

    while (true) {
        // 3. Check for incoming keep-alive messages from the client
        int n = recvfrom(udp_sock, buffer, sizeof(buffer) - 1, 0, 
                         (struct sockaddr*)&client_addr, &client_len);
        
        if (n > 0) {
            buffer[n] = '\0';
            if (strcmp(buffer, "KEEP_ALIVE") == 0) {
                if (!client_connected) {
                    std::cout << "[+] KEEP_ALIVE received! Starting video stream to " 
                              << inet_ntoa(client_addr.sin_addr) << ":" 
                              << ntohs(client_addr.sin_port) << std::endl;
                    client_connected = true;
                }
                // Update the timer
                last_keep_alive_time = std::chrono::steady_clock::now();
            }
        }

        // 4. If connected, verify the keep-alive timer and send frames
        if (client_connected) {
            auto current_time = std::chrono::steady_clock::now();
            auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(current_time - last_keep_alive_time).count();

            // Stop sending if no keep-alive for 200ms
            if (elapsed > 200) {
                std::cout << "[-] Connection lost (No keep-alive for 200ms). Stopping stream." << std::endl;
                client_connected = false;
                continue;
            }

            cap >> frame;
            if (frame.empty()) continue;

            // Compress frame to JPEG
            cv::imencode(".jpg", frame, encoded_buffer, encode_params);

            if (encoded_buffer.size() < 65500) {
                sendto(udp_sock, encoded_buffer.data(), encoded_buffer.size(), 0, 
                       (struct sockaddr*)&client_addr, client_len);
            } else {
                std::cerr << "[!] Frame too large to send over UDP: " << encoded_buffer.size() << " bytes." << std::endl;
            }
            
            std::this_thread::sleep_for(std::chrono::milliseconds(30));
        }
    }

    cap.release();
    close(udp_sock);
    return 0;
}