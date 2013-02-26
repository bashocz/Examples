//***************************************************************************
//
// Autor: petr baros, BAR118
//
// Popis: Reseni IPC problemu ctenaru a spisovatelu, pomoci socketu jako
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
// pomocne funkce komunikace
//***************************************************************************
void posli_zpravu(int socket, char typ, int kod, const char* zprava)
{
  // slozeni zpravy
  char msg[128];
  msg[0] = typ;
  if (kod < 0)
    kod = 0;
  if (kod < 10)
  {
  	msg[1] = '0';
  	msg[2] = 48 + kod;
  }
  else
  {
  	msg[1] = 48 + (kod / 10);
  	msg[2] = 48 + (kod % 10);
  }
  msg[3] = ':';
  strncpy(msg + 4, zprava, strlen(zprava));
  msg[strlen(zprava) + 4] = '\n';
  msg[strlen(zprava) + 5] = '\0';
   
  // vypis zpravy
  printf("pro SRV: %s", msg);
  
  // odeslani zpravy
  write(socket, msg, sizeof(msg));
}

int precti_zpravu(int socket, char* zprava)
{
  // prijeti zpravy  
  char msg[128];
  read(socket, msg, sizeof(msg));
  
  // vypis zpravy
	printf("od  SRV: %s", msg);
	
	// rozklad zpravy
	strncpy(zprava, msg + 4, strlen(msg) - 5);
	zprava[strlen(msg) - 5] = '\0';
	msg[3] = '\0';
	return atoi(msg + 1); 
}

//***************************************************************************
// funkce pro klienta
//***************************************************************************
void ctenar(int socket)
{
	char zprava[128];
	
	posli_zpravu(socket, 'C', 1, "Chci cist");
	precti_zpravu(socket, zprava);
	
	// 3 - 12s
	int delka = (rand() % 9) + 3;
	sprintf(zprava, "Budu cist %d", delka);
	posli_zpravu(socket, 'C', 5, zprava);
	precti_zpravu(socket, zprava);
}

void spisovatel(int socket)
{
	char zprava[128];

	// 5 - 20s
	int delka = (rand() % 15) + 5;
	printf("klient : Pockam %ds a pak budu zapisovat ...\n", delka);
	sleep(delka);
	
	posli_zpravu(socket, 'C', 9, "Chci psat");
	precti_zpravu(socket, zprava);
	
	// 3 - 12s
	delka = (rand() % 9) + 3;
	sprintf(zprava, "Budu psat %d", delka);
	posli_zpravu(socket, 'C', 13, zprava);
	precti_zpravu(socket, zprava);
}

//***************************************************************************
// pomocny vypis
//***************************************************************************
void pomoc(char *name)
{
	printf("\n");
	printf("  Program: %s\n", name);
	printf("\n");
	printf("  Kient pro pripojeni pres socket k serveru resici IPC problem ctenaru a spisovatelu.\n");
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

	char *cl_typ = NULL;
	char *host = NULL;
	int port = 6666;

  // zpracovani vstupnich argumentu
	if ((argc > 1) && (!strcmp(argv[1], "/h")))
		pomoc(argv[0]);

	for (int i = 1; i < argc; i++)
	{
		if (!cl_typ)
			cl_typ = argv[i];
		else if (!host)
			host = argv[i];
		else
			port = atoi(argv[i]);
	}
	
	if (!cl_typ || !host || !port)
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
	printf("Zadejte 'quit' pokud se chcete odpojit od serveru.\n");
	
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
	  int konec = 1;
	  while (konec)
	  {
	  	if (strcmp(cl_typ, "spisovatel") == 0)
	  		spisovatel(sock_server);
	  	else
	  		ctenar(sock_server);
	  		
			// zjisteni zda uzivatel neco nezadal z klavesnice
			// mnozina pro stdin
			fd_set pro_stdin;
			
			// vynuluju mnozinu
			FD_ZERO(&pro_stdin);

			// pridam do mnoziny descriptor stdin
			FD_SET(STDIN_FILENO, &pro_stdin);

			// definuji si cas jak dlouho bude cekat select na data
			struct timeval t_out;
			t_out.tv_sec = 0;
			t_out.tv_usec = 100000; //100ms

			int retsel = select(STDIN_FILENO + 1, &pro_stdin, 0, 0, &t_out);

			// pokud select vrati nulu znamena to ze zadne data nejsou
			// a nema smysl kontrolovat dalsi podminky
			if (retsel == 0)
				continue; 
			// nastaneli nejaka chyba
			else if (retsel < 0)
			{
				printf("Select pro stdin.");
				break;
			}

			// je li neco na stdin
			if (FD_ISSET(STDIN_FILENO, &pro_stdin))
			{
				// buffer pro data ze stdin
				char buf_stdin[128];

				int l = read(STDIN_FILENO, buf_stdin, sizeof(buf_stdin));

				// kontrola, zda nebyl pozadavek na ukonceni spojeni
	 			if (!strncasecmp(buf_stdin, "quit", 4))
				{
				  konec = 0;
				  
					if (strcmp(cl_typ, "spisovatel") == 0)
						posli_zpravu(sock_server, 'C', 15, "Konec");
					else
						posli_zpravu(sock_server, 'C', 7, "Konec");
					char zprava[128];
					precti_zpravu(sock_server, zprava);
	  		
					printf("Konec ...");
				}
			}	  	
	  }
	}
	
	close(sock_server);
	return 0;
}
