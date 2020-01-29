//
//  TableViewController.m
//  TableApp
//
//  Created by Théo on 05/01/2020.
//  Copyright © 2020 Théo. All rights reserved.
//

#import "TableViewController.h"
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

@interface TableViewController ()
{
    NSIndexPath* checkedIndexPath;
    NSMutableArray *choix;
    NSMutableArray *isCheck ;
    NSMutableArray *tmpary ;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Liste par serveur
    
    printf("Lancement de l'application gestion d'absence\n\nConnexion au serveur de liste d'étudiants...\n\n");
    
    
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
    portno = 5003;
    
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
    bzero(buffer,256);
    //fgets(buffer,255,stdin);
    printf("Connecté\n\n");
    /* Send message to the server */
    n = write(sockfd,"Connexion réussie",(ssize_t)255);
    
    /* Now read server response */
    bzero(buffer,256);
    n = read(sockfd,buffer,sizeof(buffer));
    
    
    printf("Message reçu de la part du serveur de liste\n\n");
    
    printf("Message : \n%s\n\nÉlèves :\n",buffer);
    
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
    
    
    while (list[i] == NULL) {
        // i-th cell is "empty"
        i++;
    }
    //printf("\nPremiere case nule : %d",i);
    printf("\nTotal d'élèves : %d\n\n",i);
    int nul = i;
    
    /*
    printf("\nArray-Test :\n");
    for (i = 0; i < nul; i++){
        printf( "%s\n", list[i]) ;
    }
    
    printf("taille list : %lu", sizeof(list));
    printf("\n");
    */
   

    
    //Conversion
    //tmpary = @[[NSValue valueWithPointer:list]];
    
    
    
    choix = [[NSMutableArray alloc] initWithCapacity: 1000];
    for (i = 0; i < nul; i++)
    {
        //NSLog(@"%@", [NSString stringWithUTF8String:list[i]]);
        [choix addObject: [NSString stringWithUTF8String:list[i]]];
    }
    
    
    //NSLog(@"%@", choix);
    //NSLog(@"taille choix : %lu", sizeof(choix));
    
    
    
    //liste Statique
    //choix = @[@"Theo",@"JJ",@"Alex",@"Nive",@"Nihudson",@"Babacar"];
    
    
    isCheck = [NSMutableArray array];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return choix.count;
}




//cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = choix[indexPath.row];
    
    
    
    return cell;
}



//didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Élève %@ coché",[choix objectAtIndex:indexPath.row]);
 
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType==UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType=UITableViewCellAccessoryNone;
        
        if([isCheck containsObject:[choix objectAtIndex:indexPath.row]]){ //Si ça contient le nom, on l'enleve
            [isCheck removeObject:[choix objectAtIndex:indexPath.row]];
            
        }
        
        
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType=UITableViewCellAccessoryCheckmark;
        
        if(![isCheck containsObject:[choix objectAtIndex:indexPath.row]]){ //Si ça contient pas deja le nom, on le met
            [isCheck addObject:[choix objectAtIndex:indexPath.row]];
        }
        
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Envoi:(id)sender {
    printf("\n");
    NSLog(@"Liste d'absents %@", isCheck);
    int num = [isCheck count];
    printf("Total D'absents : %d\n\n", num);
    int i;
    if(num != 0){
        NSString *Message = isCheck[0];
        for (i=1; i<num; i++) {
            Message = [Message stringByAppendingString:@"/"];
            Message = [Message stringByAppendingString:isCheck[i]];
            //NSLog(@"%@\n", isCheck[i]);
        }
        NSLog(@"Message à envoyer au serveur : %@", Message);
        
        printf("\nConnexion au serveur d'absences");
        // C Client Copy
        int sockfd, portno, n;
        struct sockaddr_in serv_addr;
        struct hostent *server;
        
        char buffer[256];
        
        
        portno = 5002;
        
        /* Create a socket point */
        sockfd = socket(PF_INET, SOCK_STREAM, 0);
        
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
        bzero(buffer,256);
        //fgets(buffer,255,stdin);
        strcpy(buffer, [Message UTF8String]);
        
        /* Send message to the server */
        n = write(sockfd,buffer,(ssize_t)strlen(buffer));
        
        bzero(buffer,256); // met le buffer à zéro (identique à memset)
        n = read(sockfd,buffer,(ssize_t)255 );
        printf("\n\nMessage de la part du serveur d'absence : %s\n\nAbsences envoyées",buffer);
        
    }
}
@end
