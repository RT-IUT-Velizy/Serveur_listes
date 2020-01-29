//
//  main.c
//  AbsServerV2
//
//  Created by Théo on 06/01/2020.
//  Copyright © 2020 Théo. All rights reserved.
//

/* simpleServerSocket.c */
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int calcul(char ent[]);

int main( int argc, char *argv[] )
{
    printf("Initialisation du serveur d'absence...");
    int sockfd, newsockfd, portno;
    unsigned int clilen;
    char buffer[256];
    struct sockaddr_in serv_addr, cli_addr;
    int  n;
    int i = 0;
    char *list[50];
    
    /* First call to socket() function */
    sockfd = socket(PF_INET, SOCK_STREAM, 0);
    
    /* Initialize socket structure */
    //bzero((char *) &serv_addr, sizeof(serv_addr));
    portno = 5002;
    
    
    
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    
    
    
    /* Now bind the host address using bind() call.*/
    bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    
    
    /* Now start listening for the clients, here process will
     * go in sleep mode and will wait for the incoming connection       */
    listen(sockfd,5);
    
    
    
    clilen = sizeof(cli_addr);
    printf("OK\n\n");
    while (1)
    {
        printf("\nPrêt a recevoir");
        /* Accept actual connection from the client */
        newsockfd = accept(sockfd, (struct sockaddr *)&cli_addr, &clilen);
        /* If connection is established then start communicating */
        n = write(newsockfd,"Connexion réussie",(ssize_t)255);
        
        /* Now read server response */
        bzero(buffer,256); // met le buffer à zéro (identique à memset)
        n = read(newsockfd,buffer,(ssize_t)255 );
        
        printf("\n\nListe d'absent reçue\n\n");
        //printf("Here is the message: %s\n",buffer);
        
        
        printf("Message : \n%s\n\nAbsents :\n",buffer);
        
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
            while (list[i] == "(null)") {
                // i-th cell is "empty"
                i++;
            }
            printf("\nTotal d'élèves : %d\n\n",i);
        }else{
            printf ( "%s\n", buffer );
            printf("\nTotal d'élèves : 1\n\n");
        }
        
        
        
        /*
         printf("\nPremiere case nule : %d",i);
         int nul = i;
         
         
         printf("\nArray-Test :\n");
         for (i = 0; i < nul; i++){
         printf( "%s\n", list[i]) ;
         }
         
         printf("taille list : %lu", sizeof(list));
         printf("\n");
         */
        
        
    }
    
    return 0;
}
