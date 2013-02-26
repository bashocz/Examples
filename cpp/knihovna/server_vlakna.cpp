//***************************************************************************
//
// Autor: petr baros, BAR118
//
// Popis: Reseni IPC problemu ctenaru a spisovatelu, pomoci socketu jako
// 	  aplikace klient/server umoznujici pripojeni vice klientu.
//
// 	  Server implementovany pomoci procesu.
//
//***************************************************************************

#include <stdio.h> 
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <signal.h>
#include <stdarg.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <pthread.h>

#define POCET 0
#define DATABAZE 1
#define SPISOVATEL 2
#define POCET_CTENARU 3

int idsem = 0;

int ctenar_id = 0;
int spisovatel_id = 0;

int klient_cnt = 0;
pthread_t klient_id[100];
int sock_client[100];

//***************************************************************************
// pomocne funkce semafory
//***************************************************************************
int vytvor_semafory()
{
	idsem = semget(666, 4, IPC_CREAT | 0660);
	
	if (idsem < 0)
		return -1;
	
	if ((semctl(idsem, POCET, SETVAL, 1)) < 0)
		return -2;
	
	if ((semctl(idsem, DATABAZE, SETVAL, 1)) < 0)
		return -3;
	
	if ((semctl(idsem, SPISOVATEL, SETVAL, 1)) < 0)
		return -4;
	
	if ((semctl(idsem, POCET_CTENARU, SETVAL, 0)) < 0)
		return -5;
	
	return 0;
}

int uvolni_semafory()
{
	if (idsem > 0)
	{
		if (semctl(idsem, 0, IPC_RMID, NULL) < 0)
			return 1;
	}
	idsem = 0;
	return 0;
}

void nastav_semafor(int id, int smer)
{
	sembuf buf = {id, smer, 0};
	semop(idsem, &buf, 1);
}

void vyhradit_pocet()
{
	nastav_semafor(POCET, -1);
}

void uvolnit_pocet()
{
	nastav_semafor(POCET, 1);
}

void vyhradit_db()
{
	nastav_semafor(DATABAZE, -1);
}

void uvolnit_db()
{
	nastav_semafor(DATABAZE, 1);
}

void vyhradit_psani()
{
	nastav_semafor(SPISOVATEL, -1);
}

void uvolnit_psani()
{
	nastav_semafor(SPISOVATEL, 1);
}

void odeber_ctenare()
{
	nastav_semafor(POCET_CTENARU, -1);
}

void pridej_ctenare()
{
	nastav_semafor(POCET_CTENARU, 1);
}

int pocet_ctenaru()
{
	return semctl(idsem, POCET_CTENARU, GETVAL);
}

void clean( void )
{
	uvolni_semafory();
}

void catch_sig( int sig )
{
  exit( 1 );
}

//***************************************************************************
// pomocne funkce komunikace
//***************************************************************************
void posli_zpravu(int socket, const char* id, char typ, int kod, const char* zprava)
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
  printf("pro %s: %s", id, msg);
  
  // odeslani zpravy
  write(socket, msg, sizeof(msg));
}

int precti_zpravu(int socket, const char* id, char* zprava)
{
  // prijeti zpravy  
  char msg[128];
  read(socket, msg, sizeof(msg));
  
  // vypis zpravy
	printf("od  %s: %s", id, msg);
	
	// rozklad zpravy
	strncpy(zprava, msg + 4, strlen(msg) - 5);
	zprava[strlen(msg) - 5] = '\0';
	msg[3] = '\0';
	return atoi(msg + 1); 
}

//***************************************************************************
// funkce pro klienta
//***************************************************************************
void cekej(int sekundy)
{
  sleep(sekundy);
}

int chce_cist(int socket, const char* id)
{
  char zprava[128];
  if (precti_zpravu(socket, id, zprava) == 1)
  	return 1;

 	posli_zpravu(socket, id, 'A', 8, "Nashledanou priste");
	return 0;
}

void cti_data(int socket, const char* id)
{
  posli_zpravu(socket, id, 'A', 4, "Muzes cist");
  
  char zprava[128];
  if (precti_zpravu(socket, id, zprava) == 5)
  {
    // zprava "Chci cist xxx", kde xxx = sekundy  	
  	int sekundy = atoi(zprava + 10);
  	cekej(sekundy);
  }
  
  posli_zpravu(socket, id, 'A', 6, "Data");
}

void zpracuj_data(int socket, const char* id)
{
}

int chce_psat(int socket, const char* id)
{
  char zprava[128];
  if (precti_zpravu(socket, id, zprava) == 9)
  	return 1;

 	posli_zpravu(socket, id, 'A', 16, "Nashledanou priste");
	return 0;
}

void priprav_data(int socket, const char* id)
{
}

void zapis_data(int socket, const char* id)
{
  posli_zpravu(socket, id, 'A', 12, "Muzes psat");
  
  char zprava[128];
  if (precti_zpravu(socket, id, zprava) == 13)
  {  	
    // zprava "Chci psat xxx", kde xxx = sekundy  	
  	int sekundy = atoi(zprava + 10);
  	cekej(sekundy);
  }
  
  posli_zpravu(socket, id, 'A', 14, "Hotovo");
}

void *ctenar(void *arg)
{
	int *param = (int*)arg;
	int socket = param[0];
	int ctenar_id2 = param[1];
	
	char id[4];
	id[0] = 'C';
	if (ctenar_id2 < 10)
	{
  	id[1] = '0';
  	id[2] = 48 + ctenar_id2;
	}
	else
	{
  	id[1] = 48 + (ctenar_id2 / 10);
  	id[2] = 48 + (ctenar_id2 % 10);
	}
	id[3] = '\0';
	printf("sys %s: Prisel novy ctenar a chce cist.\n", id);
	
	while (1)
	{
		// zastavi pokud je nejaky spisovatel; pokracuje pokud neni
		vyhradit_psani();
		uvolnit_psani();
		
		// zvysi pocet ctenaru, pripadne vyhradi databazi pro cteni
		vyhradit_pocet();
		if (pocet_ctenaru() == 0)
		{
			vyhradit_db();
			printf("Databaze vyhrazena pro cteni ...\n");
		}
		pridej_ctenare();		
		uvolnit_pocet();
		
		// cte data z databaze
		cti_data(socket, id);
		
		// snizi pocet ctenaru, pripadne uvolni databazi
		vyhradit_pocet();
		odeber_ctenare();		
		if (pocet_ctenaru() == 0)
		{
			uvolnit_db();
			printf("Databaze uvolnena z cteni ...\n");
		}
		uvolnit_pocet();
		
		// pracuje s daty
		zpracuj_data(socket, id);
		
	  // ceka na pokyn od klienta, zda bude cist (kod 1), nebo konci (kod 7)
	  if (!chce_cist(socket, id))
	  	break;
	}
}

void *spisovatel(void *arg)
{
	int *param = (int*)arg;
	int socket = param[0];
	int spisovatel_id2 = param[1];
	
	char id[5];
	id[0] = 'S';
	id[1] = 'P';
	if (spisovatel_id2 < 10)
	{
  	id[2] = '0';
  	id[3] = 48 + spisovatel_id2;
	}
	else
	{
  	id[2] = 48 + (spisovatel_id2 / 10);
  	id[3] = 48 + (spisovatel_id2 % 10);
	}
	id[4] = '\0';
	printf("sys %s: Prisel novy spisovatel a chce psat.\n", id);
	
	while (1)
	{
		// pripravuje data
		priprav_data(socket, id);
		
		// vyhrazuje psani a db pro zapis
		vyhradit_psani();
		vyhradit_db();		
		printf("Databaze vyhrazena pro zapis ...\n");
		
		// zapisuje data
		zapis_data(socket, id);
		
		// uvolnuje psani a db
		uvolnit_db();
		printf("Databaze uvolnena ze zapisu ...\n");
		uvolnit_psani();
		
	  // ceka na pokyn od klienta, zda bude psat (kod 9), nebo konci (kod 15)
	  if (!chce_psat(socket, id))
	  	break;
	}
}

int klient(int socket)
{
  char zprava[128];
	int kod = precti_zpravu(socket, "U00", zprava);
	switch (kod)
	{
		case 1:
			ctenar_id++;
			return kod;
		case 9:
			spisovatel_id++;
			return kod;
		default:
			return -1;
	}
	return 0;
}

//***************************************************************************
// pomocny vypis
//***************************************************************************
void pomoc(char *name)
{
	printf("\n");
	printf("  Program: %s\n", name);
	printf("\n");
	printf("  Server - implementace pomoci procesu resici IPC problem ctenaru a spisovatelu.\n");
	printf("	Server reprezentuje databazi, ktera povoluje vsem klientum (ctenarum) cist data,\n");
	printf("	pokud zadny klient (spisovatel) nezapisuje data. Knihovna povoluje jednomu klientovi\n");
	printf("	(spisovatel) zapisovat data, pokud zadny jiny klient (ctenar/spisovatel) necte/nezapisuje.\n");
	printf("\n");
	printf("  Pouziti: [/h] [cislo-portu]\n");
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
  // zpracovani vstupnich argumentu
	if (((argc > 1) && (!strcmp(argv[1], "/h"))) || (argc > 2))
		pomoc(argv[0]);

	int port = 0;
	port = (argc > 1) ? atoi(argv[1]) : 6666;
	
	if (port == 0)
	{
		printf("Spatny format portu\n");
		pomoc(argv[0]);
	}
	
	// zachyceni <CTRL-C>
	signal( SIGINT, catch_sig );

	// pri ukonceni programu se zavola clean
	atexit( clean );

	// vytvoreni socketu
	int sock_listen = socket(AF_INET, SOCK_STREAM, 0);
	if (sock_listen == -1)
	{
		printf("Nepodarilo se vytvorit socket.\n");
		exit(1);
	}

	in_addr addr_any = { INADDR_ANY };
	sockaddr_in server_addr;
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(port);
	server_addr.sin_addr = addr_any;
	
	// smi socket pouzit cislo portu
	int opt = 1;
	if (setsockopt(sock_listen, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0)
		printf("Nelze nastavit vlastnosti socketu.\n");

	// prirazeni adresy a portu socketu	
	if (bind(sock_listen, (const sockaddr*) &server_addr, sizeof(server_addr)) < 0)
	{
		printf("Prirazeni adresy selhalo.\n");
		close(sock_listen);
		exit(1);
	}

	// server bude naslouchat na zadanem portu
	if (listen(sock_listen, 1) < 0)
	{
		printf("Nelze naslouchat na zadanem portu.\n");
		close(sock_listen);
		exit(1);
	}

	// vytvoreni semaforu
	int sem = 0;
	if ((sem = vytvor_semafory()) < 0)
	{
		printf("Nelze vytvorit a inicializovat semafory (%d).\n", sem);
		close(sock_listen);
		exit(1);
	}
	
	printf("Server spusten a nastaven ...\n");
	printf("Zadejte 'quit' pro ukonceni procesu serveru.\n");
	
	int konec = 1;
	while (konec)
	{
		char buf[128];

		// mnozina handlu
		fd_set pro_in;

		// vynulovani mnoziny
		FD_ZERO(&pro_in);
		
		FD_SET(STDIN_FILENO, &pro_in);

    // pridani handlu
    FD_SET(sock_listen, &pro_in);

		// vybrani handl, na kterem jsou data
		if (select(sock_listen + 1, &pro_in, NULL, NULL, NULL) < 0)
			break;

		// jsou data na stdin?
		if (FD_ISSET(STDIN_FILENO, &pro_in))
		{
			// nacist je do bufferu
			read(STDIN_FILENO, buf, sizeof(buf));
		}
		// ceka nejaky kleint na obslouzeni?
		else if (FD_ISSET(sock_listen, &pro_in))
		{
			sockaddr_in rsa;
			int rsa_size = sizeof(rsa);

			// prijmuti noveho spojeni
			sock_client[klient_cnt] = accept(sock_listen, (sockaddr*)&rsa, (socklen_t*)&rsa_size);
			if ( sock_client[klient_cnt] == -1 )
			{
				printf("Spojeni se nezdarilo...\n");
				close(sock_listen);
				exit(1);
			}
			
			// delka adresy serveru
			int lsa = sizeof(server_addr);

			// ziskani vlastni ip
			getsockname(sock_client[klient_cnt], (sockaddr*)&server_addr, (socklen_t*)&lsa); 

			printf("Server sidli na: '%s:%d'\n", inet_ntoa(server_addr.sin_addr), ntohs(server_addr.sin_port));

			// ziskani ip klienta
			getpeername(sock_client[klient_cnt], (sockaddr*)&server_addr, (socklen_t*)&lsa);

			printf("Novy klient prichazi z: '%s:%d'\n",	inet_ntoa(server_addr.sin_addr), ntohs(server_addr.sin_port));

			char zprava[128];
			sprintf(zprava, "Spojeni navazano ...\n");
			write(sock_client[klient_cnt], zprava, sizeof(zprava));
			
			int kod = klient(sock_client[klient_cnt]);
			
			// nadefinuji si pole s argumenty pro vlakno
			int argr[2] = { sock_client[klient_cnt], ctenar_id };
			int argw[2] = { sock_client[klient_cnt], spisovatel_id };
			
			switch (kod)
			{
				case 1:
					if (pthread_create(&klient_id[klient_cnt], NULL, ctenar, (void*)&argr) == 0) // pokracuje klient
					{
					}
					break;
				case 9:
					if (pthread_create(&klient_id[klient_cnt], NULL, spisovatel, (void*)&argw) == 0) // pokracuje klient
					{
					}
					break;
				default:
					close(sock_client[klient_cnt]);
					sock_client[klient_cnt] = 0;
					break;
			}
				
			klient_cnt++;
		}
		
    // byl pozadavek na ukonceni prace serveru?
    if (!strncasecmp(buf, "quit", 4))
    {
			printf("Server bude ukoncen ...\n");

			konec = 0;

			printf("Cekani na ukonceni prace vsech ctenaru a spisovatelu.\n");
			// cekani nez se ukonci vsichni klienti
			for (int i = 0; i < klient_cnt; i++)
			{
				void *s;
				if (klient_id[i] > 0)
				 	pthread_join(klient_id[i], &s); 
				if (sock_client[i] > 0)
					close(sock_client[i]);
			}

			break;
    }		
	}
	
	close(sock_listen);
	if (uvolni_semafory() < 0)
	{
		printf("Nelze rusit semafory.\n");
		exit(1);
	}
	exit(0);
}
