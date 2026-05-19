#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <netdb.h>

#define MAX_HOPS 30
#define PROBES_PER_HOP 3
#define DEST_PORT 33434 // Standard starting port for traceroute

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <destination_ip_or_domain>\n", argv[0]);
        exit(1);
    }

    char *target = argv[1];
    struct hostent *host_info = gethostbyname(target);
    if (host_info == NULL) {
        fprintf(stderr, "Error: Could not resolve hostname %s\n", target);
        exit(1);
    }

    // Convert resolved hostname to IP string
    char dest_ip[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, host_info->h_addr_list[0], dest_ip, sizeof(dest_ip));

    // 1. Create a UDP socket for sending probes
    int send_sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    
    // 2. Create a RAW socket for receiving ICMP messages
    int recv_sock = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);

    if (send_sock < 0 || recv_sock < 0) {
        perror("Socket creation failed. Did you forget to use 'sudo'?");
        exit(1);
    }

    // Set a 1-second timeout on the receiving socket to detect dropped packets
    struct timeval tv_timeout;
    tv_timeout.tv_sec = 1;
    tv_timeout.tv_usec = 0;
    setsockopt(recv_sock, SOL_SOCKET, SO_RCVTIMEO, &tv_timeout, sizeof(tv_timeout));

    struct sockaddr_in dest_addr;
    memset(&dest_addr, 0, sizeof(dest_addr));
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port = htons(DEST_PORT);
    dest_addr.sin_addr = *(struct in_addr *)host_info->h_addr_list[0];

    printf("traceroute to %s (%s), %d hops max\n", target, dest_ip, MAX_HOPS);

    int reached_dest = 0;
    char recv_buf[1024];

    // Main Traceroute Loop
    for (int ttl = 1; ttl <= MAX_HOPS && !reached_dest; ttl++) {
        printf("%2d  ", ttl);
        fflush(stdout);

        // Update the IP Time-To-Live (TTL) for this hop
        if (setsockopt(send_sock, IPPROTO_IP, IP_TTL, &ttl, sizeof(ttl)) < 0) {
            perror("setsockopt TTL failed");
            exit(1);
        }

        struct sockaddr_in recv_addr;
        char router_ip[INET_ADDRSTRLEN] = "";
        int printed_ip_this_hop = 0;

        for (int probe = 0; probe < PROBES_PER_HOP; probe++) {
            struct timeval send_time, recv_time;
            
            // Send empty UDP datagram
            gettimeofday(&send_time, NULL);
            sendto(send_sock, NULL, 0, 0, (struct sockaddr*)&dest_addr, sizeof(dest_addr));

            // Wait for ICMP reply 
            socklen_t addr_len = sizeof(recv_addr);
            int n = recvfrom(recv_sock, recv_buf, sizeof(recv_buf), 0, (struct sockaddr*)&recv_addr, &addr_len);
            gettimeofday(&recv_time, NULL);

            if (n < 0) {
                // Timeout occurred
                printf("* ");
            } else {
                // We need to skip the IP header to read the ICMP header
                struct ip *ip_hdr = (struct ip *)recv_buf;
                int ip_hdr_len = ip_hdr->ip_hl * 4; // Header length is in 32-bit words
                struct icmphdr *icmp_hdr = (struct icmphdr *)(recv_buf + ip_hdr_len);

                char router_ip_temp[INET_ADDRSTRLEN];
                inet_ntop(AF_INET, &(recv_addr.sin_addr), router_ip_temp, INET_ADDRSTRLEN);

                // 1. Filter out unrelated ICMP types (we only want Time Exceeded or Destination Unreachable)
                // 2. Filter out local loopback noise (127.0.0.1) unless we are explicitly targeting localhost
                if ((icmp_hdr->type != ICMP_TIME_EXCEEDED && icmp_hdr->type != ICMP_DEST_UNREACH) || 
                    (strcmp(router_ip_temp, "127.0.0.1") == 0 && strcmp(dest_ip, "127.0.0.1") != 0)) {
                    
                    // Treat background noise as a timeout for this specific probe
                    printf("* ");
                } else {
                    // Calculate RTT
                    double rtt = (recv_time.tv_sec - send_time.tv_sec) * 1000.0 +
                                 (recv_time.tv_usec - send_time.tv_usec) / 1000.0;

                    // Extract router IP if we haven't printed it for this hop yet
                    if (!printed_ip_this_hop) {
                        strcpy(router_ip, router_ip_temp);
                        printf("%s  ", router_ip);
                        printed_ip_this_hop = 1;
                    }

                    printf("%.3f ms  ", rtt);

                    // Type 3 = Destination Unreachable means we've reached the destination
                    if (icmp_hdr->type == ICMP_DEST_UNREACH) {
                        reached_dest = 1;
                    }
                }
            }
            fflush(stdout);
        }
        
        printf("\n");
        // Increment the destination port for the next hop, standard practice for traceroute
        dest_addr.sin_port = htons(ntohs(dest_addr.sin_port) + 1); 
    }

    close(send_sock);
    close(recv_sock);
    return 0;
}