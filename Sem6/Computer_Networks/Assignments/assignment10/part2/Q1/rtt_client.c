#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/time.h>

int main(int argc, char *argv[]) {
    if (argc != 6) {
        fprintf(stderr, "Usage: %s <server_ip> <port> <num_messages> <interval_ms> <packet_size>\n", argv[0]);
        exit(1);
    }

    char *server_ip = argv[1];
    int port = atoi(argv[2]);
    int num_messages = atoi(argv[3]);
    int interval_ms = atoi(argv[4]);
    int packet_size = atoi(argv[5]);

    // Ensure the packet size is large enough to hold our sequence number and timestamp
    size_t min_required_size = sizeof(int) + sizeof(struct timeval);
    if (packet_size < min_required_size) {
        fprintf(stderr, "Error: packet_size must be at least %zu bytes to hold sequence number and timestamp.\n", min_required_size);
        exit(1);
    }

    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        perror("Socket creation failed");
        exit(1);
    }

    // Set a timeout of 1 second for receiving a response (simulating ping timeout)
    struct timeval tv_timeout;
    tv_timeout.tv_sec = 1;
    tv_timeout.tv_usec = 0;
    setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &tv_timeout, sizeof(tv_timeout));

    struct sockaddr_in server_addr;
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(port);
    inet_pton(AF_INET, server_ip, &server_addr.sin_addr);

    // Dynamically allocate buffers equal to the packet size requested by user
    char *send_buf = (char *)calloc(1, packet_size);
    char *recv_buf = (char *)malloc(packet_size);

    int packets_sent = 0;
    int packets_received = 0;

    printf("PING %s:%d with %d bytes of data:\n", server_ip, port, packet_size);

    for (int i = 1; i <= num_messages; i++) {
        int seq_num = i;
        struct timeval send_time, recv_time;

        // 1. Get current timestamp before sending
        gettimeofday(&send_time, NULL);

        // 2. Pack sequence number and timestamp into the buffer
        memcpy(send_buf, &seq_num, sizeof(int));
        memcpy(send_buf + sizeof(int), &send_time, sizeof(struct timeval));

        // 3. Send to server
        sendto(sockfd, send_buf, packet_size, 0, (struct sockaddr*)&server_addr, sizeof(server_addr));
        packets_sent++;

        // 4. Wait for echo response
        socklen_t addr_len = sizeof(server_addr);
        int n = recvfrom(sockfd, recv_buf, packet_size, 0, (struct sockaddr*)&server_addr, &addr_len);

        if (n < 0) {
            // Timeout hit
            printf("Request timeout for icmp_seq %d\n", seq_num);
        } else {
            // Response received, check receive time
            gettimeofday(&recv_time, NULL);
            
            // Extract the original timestamp that the server echoed back
            struct timeval original_send_time;
            memcpy(&original_send_time, recv_buf + sizeof(int), sizeof(struct timeval));

            // Calculate RTT in milliseconds
            double rtt = (recv_time.tv_sec - original_send_time.tv_sec) * 1000.0;
            rtt += (recv_time.tv_usec - original_send_time.tv_usec) / 1000.0;

            printf("%d bytes from %s: seq=%d time=%.3f ms\n", n, server_ip, seq_num, rtt);
            packets_received++;
        }

        // 5. Wait for the specified interval before sending the next packet
        usleep(interval_ms * 1000);
    }

    int packets_lost = packets_sent - packets_received;
    double loss_percentage = ((double)packets_lost / packets_sent) * 100.0;

    printf("\n--- %s ping statistics ---\n", server_ip);
    printf("%d packets transmitted, %d received, %.1f%% packet loss\n", 
           packets_sent, packets_received, loss_percentage);

    free(send_buf);
    free(recv_buf);
    close(sockfd);
    return 0;
}