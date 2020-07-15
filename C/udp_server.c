#include <asm-generic/socket.h>
#include <stdlib.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <strings.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <sys/types.h>
#define BUFSIZE 1024

int main() {
    int sockfd;
    int optval;
    int clientlen;
    u_int16_t portno = 8080;
    struct sockaddr_in serveraddr;
    struct sockaddr_in clientaddr;
    struct hostnet *hostp;
    char *buf;
    char *hostaddrp;
    int n;

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0)
        perror("Could not open scoket"); 
    optval = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
            (const void*)&optval, sizeof(int));
    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family       = AF_INET;
    serveraddr.sin_addr.s_addr  = htonl(INADDR_ANY);
    serveraddr.sin_port         = htons(portno);
    if (bind(sockfd, (struct sockaddr *)&serveraddr,
                sizeof(serveraddr)) < 0)
        perror("Could not bind the socket");
    clientlen = sizeof(clientaddr);
    while (1) {
        buf = malloc(BUFSIZE);
        n = recvfrom(sockfd, buf, BUFSIZE, 0,
                (struct sockaddr *)&clientaddr, &clientlen);
        if (n < 0)
            perror("Could not recive file");
        hostp = gethostbyaddr((const char *)&clientaddr.sin_addr.s_addr,
                  sizeof(clientaddr.sin_addr.s_addr),
                  AF_INET);
		if (hostp == NULL)
			perror("ERROR on gethostbyaddr");
		hostaddrp = inet_ntoa(clientaddr.sin_addr);
		if (hostaddrp == NULL)
			perror("ERROR on inet_ntoa\n");
		/*printf("server received %d bytes\n", n); */

		/* 
		 * sendto: echo the input back to the client 
		 */
		n = sendto(sockfd, buf, n, 0,
			   (struct sockaddr *)&clientaddr, clientlen);
		if (n < 0)
            perror("could not recive");
    }
}
