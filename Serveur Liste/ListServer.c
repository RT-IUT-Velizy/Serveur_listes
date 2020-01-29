//
//  main.c
//  ListServerV2
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

int main(int argc, const char * argv[]) {
    printf("Initialisation du serveur de liste..");
    // insert code here...
    int sockfd, newsockfd, portno;
    unsigned int clilen;
    char buffer[256];
    struct sockaddr_in serv_addr, cli_addr;
    int  n;
    
    char names[255]; // = "theo/nihudson/jj/nive/alex/babacar";
    printf("OK");
    
    printf("\n\nEntrez une Liste d'élèves en séparant les nom par des slash : (Exemple : Eleve1/Eleve2/Eleve3)\n");
    fgets(names,255,stdin);
    //int count = 2;
    
    /* First call to sock’et() function */
    sockfd = socket(PF_INET, SOCK_STREAM, 0);
    
    /* Initialize socket structure */
    //bzero((char *) &serv_addr, sizeof(serv_addr));
    portno = 5003;
    
    
    
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    
    
    
    /* Now bind the host address using bind() call.*/
    bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    
    
    /* Now start listening for the clients, here process will
     * go in sleep mode and will wait for the incoming connection       */
    listen(sockfd,5);
    
    
    clilen = sizeof(cli_addr);
    
    printf("\n\nListe d'élève : %s\n", names);
    while (1)
    {
        printf("\n\nPrêt a envoyer");
        /* Accept actual connection from the client */
        newsockfd = accept(sockfd, (struct sockaddr *)&cli_addr, &clilen);
        /* If connection is established then start communicating */
        bzero(buffer,256); // met le buffer à zéro (identique à memset)
        n = read( newsockfd,buffer,(ssize_t)255 );
        
        printf("\n\nHere is the message: %s\n",buffer);
        
        /* Write a response to the client */
        //n = write(newsockfd,"I got your message",(ssize_t)18);
        //n = write(newsockfd, &count, sizeof(count));
        
        n = write(newsockfd, names, sizeof(names));
        printf("\nListe Envoyée\n\n");
        
    }
    
    
    return 0;
}
