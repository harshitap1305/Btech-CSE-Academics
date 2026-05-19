#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>

#define MAXLINE 65535 // Max UDP packet size

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <port>\n", argv[0]);
        exit(1);
    }

    int port = atoi(argv[1]);
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) {
        perror("Socket creation failed");
        exit(1);
    }

    struct sockaddr_in server_addr, client_addr;
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(port);

    if (bind(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Bind failed");
        exit(1);
    }

    printf("RTT Echo Server listening on port %d...\n", port);

    char buffer[MAXLINE];
    socklen_t addr_len = sizeof(client_addr);

    while (1) {
        // Receive packet from client
        int n = recvfrom(sockfd, buffer, MAXLINE, 0, (struct sockaddr*)&client_addr, &addr_len);
        if (n < 0) {
            perror("Receive failed");
            continue;
        }

        // Echo the exact packet back to the client immediately
        sendto(sockfd, buffer, n, 0, (struct sockaddr*)&client_addr, addr_len);
    }

    close(sockfd);
    return 0;
}