//
//  main.c
//  ClientTest
//
//  Created by Théo on 06/01/2020.
//  Copyright © 2020 Théo. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

int main(int argc, const char * argv[]) {
    int sockfd, portno, n;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int i = 0;
    //char *buffer[256];
    char buffer[1024];
    char *list[50];
    
    /*if (argc <  3) {
        fprintf(stderr,"usage %s hostname port\n", argv[0]);
        exit(0);
    }*/
    
    
    //portno = atoi(argv[2]);
    portno = 5001;
    
    /* Create a socket point */
    sockfd = socket(PF_INET, SOCK_STREAM, 0);
    
    //server = gethostbyname(argv[1]);
    server = gethostbyname("127.0.0.1");
    
    //bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, // identique à memcpy
          (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    
    serv_addr.sin_port = htons(portno);
    
    /* Now connect to the server */
    connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr));
    /* Now ask for a message from the user, this message
     * will be read by server
     */
    //printf("Please enter the message: ");
    //bzero(buffer,256);
    //fgets(buffer,255,stdin);
    printf("Connecté\n\n");
    /* Send message to the server */
    //n = write(sockfd,buffer,(ssize_t)strlen(buffer));
    
    /* Now read server response */
    bzero(buffer,256);
    n = read(sockfd,buffer,sizeof(buffer));
    
    
    printf("reçu\n\n");
    
    printf("Message : \n%s\n\nSeparation :\n",buffer);
    
    if(strstr(buffer, "/") != NULL){
        char delim[] = "/";
        char *ptr = strtok(buffer, delim);
        while ( ptr != NULL ) {
            printf ( "%s\n", ptr );
            // On demande le token suivant.
            list[i] = ptr;
            i++;
            ptr = strtok ( NULL, delim );
            
            
        }
    }

    printf("\nArray-Test :\n");
    
    for (i = 0; i < 2; i++){
        printf( "%s\n", list[i]) ;
    }

    printf("\n");
    return 0;
}
