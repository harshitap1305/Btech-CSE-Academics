#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/time.h>

// Helper to get current time in milliseconds
double get_time_ms() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (tv.tv_sec * 1000.0) + (tv.tv_usec / 1000.0);
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "Usage: %s <server_ip> <port> <duration_sec> <packet_size>\n", argv[0]);
        exit(1);
    }

    char *server_ip = argv[1];
    int port = atoi(argv[2]);
    int duration_sec = atoi(argv[3]);
    int packet_size = atoi(argv[4]);

    size_t min_req_size = sizeof(int) + sizeof(struct timeval);
    if (packet_size < min_req_size) {
        fprintf(stderr, "Error: packet_size must be at least %zu bytes.\n", min_req_size);
        exit(1);
    }

    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        perror("Socket creation failed");
        exit(1);
    }

    // MAKE THE SOCKET NON-BLOCKING: 
    // This allows us to send and receive simultaneously without getting stuck waiting
    int flags = fcntl(sockfd, F_GETFL, 0);
    fcntl(sockfd, F_SETFL, flags | O_NONBLOCK);

    struct sockaddr_in server_addr;
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(port);
    inet_pton(AF_INET, server_ip, &server_addr.sin_addr);

    char *send_buf = (char *)calloc(1, packet_size);
    char *recv_buf = (char *)malloc(packet_size);

    // Open CSV to log our 1-second interval data for the Python graph
    FILE *csv_file = fopen("iperf_metrics.csv", "w");
    if(!csv_file) {
        perror("Failed to create metrics file");
        exit(1);
    }
    fprintf(csv_file, "Time_s,Throughput_Mbps,AvgDelay_ms\n");

    double start_time = get_time_ms();
    double current_time = start_time;
    double end_time = start_time + (duration_sec * 1000.0);
    double last_report_time = start_time;

    int seq_num = 0;
    long bytes_received_in_sec = 0;
    double delay_sum_in_sec = 0.0;
    int packets_received_in_sec = 0;
    int second_counter = 1;

    printf("Starting iperf-like throughput test to %s:%d for %d seconds\n", server_ip, port, duration_sec);
    printf("Packet Size: %d bytes\n\n", packet_size);

    while (current_time < end_time) {
        // 1. Pack and Send a packet
        seq_num++;
        struct timeval send_tv;
        gettimeofday(&send_tv, NULL);
        memcpy(send_buf, &seq_num, sizeof(int));
        memcpy(send_buf + sizeof(int), &send_tv, sizeof(struct timeval));

        sendto(sockfd, send_buf, packet_size, 0, (struct sockaddr*)&server_addr, sizeof(server_addr));

        // 2. Try to drain all available echoed packets from the receiving buffer
        socklen_t addr_len = sizeof(server_addr);
        int n;
        while ((n = recvfrom(sockfd, recv_buf, packet_size, 0, (struct sockaddr*)&server_addr, &addr_len)) > 0) {
            struct timeval recv_tv, original_send_tv;
            gettimeofday(&recv_tv, NULL);
            memcpy(&original_send_tv, recv_buf + sizeof(int), sizeof(struct timeval));

            // Calculate RTT
            double rtt = (recv_tv.tv_sec - original_send_tv.tv_sec) * 1000.0 +
                         (recv_tv.tv_usec - original_send_tv.tv_usec) / 1000.0;

            bytes_received_in_sec += n;
            delay_sum_in_sec += rtt;
            packets_received_in_sec++;
        }

        current_time = get_time_ms();

        // 3. Every 1 second, calculate metrics and log them
        if (current_time - last_report_time >= 1000.0) {
            // Throughput = (Bytes * 8 bits/byte) / 1,000,000 to get Mbps
            double throughput_mbps = (bytes_received_in_sec * 8.0) / 1000000.0; 
            double avg_delay = packets_received_in_sec > 0 ? (delay_sum_in_sec / packets_received_in_sec) : 0.0;

            printf("[%3ds] Throughput: %8.3f Mbps | Avg Delay: %8.3f ms | Pkts Recv: %d\n",
                   second_counter, throughput_mbps, avg_delay, packets_received_in_sec);

            fprintf(csv_file, "%d,%.3f,%.3f\n", second_counter, throughput_mbps, avg_delay);

            // Reset 1-second window variables
            bytes_received_in_sec = 0;
            delay_sum_in_sec = 0.0;
            packets_received_in_sec = 0;
            last_report_time += 1000.0; // Advance window by 1 second
            second_counter++;
        }

        // Add a micro-delay to prevent 100% CPU lockup and overflowing the local kernel buffers instantly
        usleep(100); 
    }

    printf("\nTest completed. Data saved to iperf_metrics.csv\n");
    fclose(csv_file);
    free(send_buf);
    free(recv_buf);
    close(sockfd);
    return 0;
}