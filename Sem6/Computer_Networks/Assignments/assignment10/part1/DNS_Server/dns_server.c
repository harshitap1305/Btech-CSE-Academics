#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT 8080 // Standardizing the DNS server port to 8080

// Define the DNS Request Structure 
typedef struct {
    int transaction_id;
    char qname[256];
} DNS_Request;

// Define the DNS Response Structure
typedef struct {
    int transaction_id;
    char ip_address[INET_ADDRSTRLEN]; // Standard length for IPv4 (16 bytes)
} DNS_Response;

// Function to handle errors
void error(const char *msg) {
    perror(msg);
    exit(1);
}

char* resolve_domain(const char* target_domain) {
    static char ip[INET_ADDRSTRLEN];
    FILE *file = fopen("records.txt", "r");
    
    if (!file) {
        perror("ERROR: Could not open records.txt");
        strcpy(ip, "ERR_NO_FILE");
        return ip;
    }

    char line[512];
    char file_domain[256], file_ip[INET_ADDRSTRLEN];
    

    strcpy(ip, "NOT_FOUND"); 

    while (fgets(line, sizeof(line), file)) {
        // Parse the domain and IP from the current line
        if (sscanf(line, "%255s %15s", file_domain, file_ip) == 2) {
    
            if (strcmp(target_domain, file_domain) == 0) {
                strcpy(ip, file_ip); // Found it!
                break;
            }
        }
    }
    
    fclose(file);
    return ip;
}

int main() {
    int sockfd, newsockfd;
    struct sockaddr_in serv_addr, cli_addr;
    socklen_t clilen;

    // 1. Create a TCP socket
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) 
        error("ERROR opening socket");

    // Allow reuse of port to prevent "Address already in use" errors during testing
    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(PORT);

    // 2. Bind the socket to the port
    if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
        error("ERROR on binding");

    // 3. Listen for incoming connections
    listen(sockfd, 5);
    printf("TCP DNS Server is running and listening on port %d...\n", PORT);

    // 4. Accept loop
    while (1) {
        clilen = sizeof(cli_addr);
        newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
        
        if (newsockfd < 0) {
            perror("ERROR on accept");
            continue;
        }

        printf("\n[+] New connection from %s:%d\n", inet_ntoa(cli_addr.sin_addr), ntohs(cli_addr.sin_port));

        DNS_Request req;
        DNS_Response res;
        
        // Read the custom DNS request from the client via TCP
        int n = read(newsockfd, &req, sizeof(req));
        if (n <= 0) {
            perror("ERROR reading from socket");
            close(newsockfd);
            continue;
        }

        printf("--- Received DNS Request ---\n");
        printf("  Transaction ID: %d\n", req.transaction_id);
        printf("  Domain Name (QNAME): %s\n", req.qname);

        // Resolve the domain
        char* resolved_ip = resolve_domain(req.qname);
        printf("  -> Resolved IP: %s\n", resolved_ip);

        // Prepare and send the response back
        res.transaction_id = req.transaction_id;
        strcpy(res.ip_address, resolved_ip);

        n = write(newsockfd, &res, sizeof(res));
        if (n < 0) {
            perror("ERROR writing to socket");
        }

        // Close the connection 
        close(newsockfd);
        printf("[-] Connection closed.\n");
    }
    
    close(sockfd);
    return 0;
}