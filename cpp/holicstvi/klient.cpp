//***************************************************************************
//
// Autor: michala candova, CAN021
//
// Popis: Reseni IPC problemu holice, pomoci socketu jako
// 	  aplikace klient/server umoznujici pripojeni vice klientu.
//
// 	  Klient.
//
//***************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

//***************************************************************************
// funkce pro klienta
//***************************************************************************
void posli_zpravu(int socket, const char* zprava, int delka)
{
  // vypis zpravy
  printf("pro SRV: %s", zprava);
  
  // odeslani zpravy
  write(socket, zprava, delka);
}

int precti_zpravu(int socket, char* zprava, int delka)
{
  // prijeti zpravy  
  read(socket, zprava, delka);
  
  // vypis zpravy
	printf("od  SRV: %s", zprava);
	
	// rozklad kodu zpravy
	char kod[3];
	strncpy(kod, zprava + 1, 2);
	kod[2] = '\0';
	return atoi(kod); 
}

void zakaznik(int socket)
{
	char zprava[128];
	
	sprintf(zprava, "C01:Dobry den\n");
	posli_zpravu(socket, zprava, sizeof(zprava));
	
	int kod = precti_zpravu(socket, zprava, sizeof(zprava)); // odpoved - je volno, nebo ne
	if (kod == 2)
	{
		precti_zpravu(socket, zprava, sizeof(zprava)); // pojd se strihat
		
		// 15 - 30s
		int delka = (rand() % 16) + 15;
		sprintf(zprava, "A05:Chci strihat po dobu %d\n", delka);
		posli_zpravu(socket, zprava, sizeof(zprava));
				
		precti_zpravu(socket, zprava, sizeof(zprava)); // hotovo
	}
	
	sprintf(zprava, "C09:Na shledanou\n");
	posli_zpravu(socket, zprava, sizeof(zprava));
}

//***************************************************************************
// pomocny vypis
//***************************************************************************
void pomoc(char *name)
{
	printf("\n");
	printf("  Program: %s\n", name);
	printf("\n");
	printf("  Kient pro pripojeni pres socket k serveru resici IPC problem holice.\n");
	printf("\n");
	printf("  Pouziti: [/h] typ-klienta jmeno-nebo-ip [cislo-portu]\n");
	printf("\n");
	printf("      %s 666\n", name);
	printf("\n");

	exit(0);
}

//***************************************************************************
// main
//***************************************************************************
int main(int argc, char *argv[])
{
	srand(getpid() % 300); // 0 - 300

	char *host = NULL;
	int port = 9999;

  // zpracovani vstupnich argumentu
	if ((argc > 1) && (!strcmp(argv[1], "/h")))
		pomoc(argv[0]);

	for (int i = 1; i < argc; i++)
	{
		if (!host)
			host = argv[i];
		else
			port = atoi(argv[i]);
	}
	
	if (!host || !port)
	{
		printf("Nebyl zadan cil pripojeni nebo port!\n");
		pomoc(argv[0]);
	}

	// vytvoreni socketu
	int sock_server = socket(AF_INET, SOCK_STREAM, 0);
	if (sock_server == -1)
	{
		printf("Nelze vytvorit socket.\n");
		exit(1);
	}

	// preklad DNS jmena na IP adresu
	hostent *hostip = gethostbyname(host);
	if (!hostip)
	{
		printf("Nelze prelozit jmeno serveru na IP adresu.\n");
		exit(1);
	}

	sockaddr_in cl_addr;
	cl_addr.sin_family = AF_INET;
	cl_addr.sin_port = htons(port);
	cl_addr.sin_addr = *(in_addr*)hostip->h_addr_list[0]; // struktura

	// navazani spojeni se serverem
	if (connect(sock_server, (sockaddr*)&cl_addr, sizeof(cl_addr)) < 0)
	{
		printf("Nelze navazat spojeni se serverem.\n");
		exit(1);
	}

	uint lsa = sizeof(cl_addr);

	// ziskani vlastni identifikace
	getsockname(sock_server, (sockaddr*)&cl_addr, &lsa);

	printf("Klient je na: '%s:%d'\n",	inet_ntoa(cl_addr.sin_addr), ntohs(cl_addr.sin_port));

	// ziskani informaci o serveru
	getpeername(sock_server, (sockaddr*)& cl_addr, &lsa);

	printf("Server je na: '%s:%d'\n",	inet_ntoa(cl_addr.sin_addr), ntohs(cl_addr.sin_port));

	printf("Spojeni se serverem navazano ...\n");
	
	// mnozina handlu pro server
	fd_set pro_srv;

	// vynulovani mnoziny
	FD_ZERO(&pro_srv);

	// pridame server
	FD_SET(sock_server, &pro_srv);

	if (select(sock_server + 1, &pro_srv, NULL, NULL, NULL) < 0)
	{
		printf("Select pro socket serveru.\n");
		exit(1);
	}
	
	char buf_sock[128];
	int l = read(sock_server, buf_sock, sizeof(buf_sock));
	printf("%s\n", buf_sock);

	// data ze serveru?
	if (FD_ISSET(sock_server, &pro_srv))
	{
 		zakaznik(sock_server);
	}
	
	close(sock_server);
	return 0;
}
