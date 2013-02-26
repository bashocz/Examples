//***************************************************************************
//
// Autor: michala candova, CAN021
//
// Popis: Reseni IPC problemu holice, pomoci socketu jako
// 	  aplikace klient/server umoznujici pripojeni vice klientu.
//
// 	  Server implementovany pomoci procesu.
//
//***************************************************************************

#include <stdio.h> 
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <pthread.h>

#define N 2

#define ZAKAZNIK 0
#define HOLIC 1
#define STRIHANI 2
#define CEKAJICI 3
#define POCET_CEKAJICI 4
#define POCET_SEMAFORU 5

int idsem = 0;

int cekajici = 0;

int klient_cnt = 0;
pthread_t klient_id[100];
int sock_client[100];

int komunikace[2];

//***************************************************************************
// pomocne funkce semafory
//***************************************************************************
int vytvor_semafory()
{
	idsem = semget(666, POCET_SEMAFORU, IPC_CREAT | 0660);
	
	if (idsem < 0)
		return -1;
	
	if ((semctl(idsem, ZAKAZNIK, SETVAL, 0)) < 0)
		return -2;

	if ((semctl(idsem, HOLIC, SETVAL, 0)) < 0)
		return -3;
	
	if ((semctl(idsem, STRIHANI, SETVAL, 0)) < 0)
		return -4;
	
	if ((semctl(idsem, CEKAJICI, SETVAL, 1)) < 0)
		return -5;
	
	if ((semctl(idsem, POCET_CEKAJICI, SETVAL, 0)) < 0)
		return -6;
	
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

void zakaznik_down()
{
	nastav_semafor(ZAKAZNIK, -1);
}

void zakaznik_up()
{
	nastav_semafor(ZAKAZNIK, 1);
}

void holic_down()
{
	nastav_semafor(HOLIC, -1);
}

void holic_up()
{
	nastav_semafor(HOLIC, 1);
}

void strihani_down()
{
	nastav_semafor(STRIHANI, -1);
}

void strihani_up()
{
	nastav_semafor(STRIHANI, 1);
}

void cekajici_down()
{
	nastav_semafor(CEKAJICI, -1);
}

void cekajici_up()
{
	nastav_semafor(CEKAJICI, 1);
}

void zvys_cekajici()
{
	nastav_semafor(POCET_CEKAJICI, 1);
}

void sniz_cekajici()
{
	nastav_semafor(POCET_CEKAJICI, -1);
}

int pocet_cekajici()
{
	return semctl(idsem, POCET_CEKAJICI, GETVAL);
}

void clean( void )
{
	uvolni_semafory();
	
	// zavreni komunikacni pipe
  close(komunikace[0]);
  close(komunikace[1]);
  
}

void catch_sig( int sig )
{
  exit( 1 );
}

//***************************************************************************
// funkce pro klienta
//***************************************************************************
void posli_zpravu(int socket, int id, const char* zprava, int delka)
{
  // vypis zpravy
  printf("pro Z%d: %s", id, zprava);
  
  // odeslani zpravy
  write(socket, zprava, delka);
}

int precti_zpravu(int socket, int id, char* zprava, int delka)
{
  // prijeti zpravy  
  read(socket, zprava, delka);
  
  // vypis zpravy
	printf("od  Z%d: %s", id, zprava);
	
	// rozklad kodu zpravy
	char kod[3];
	strncpy(kod, zprava + 1, 2);
	kod[2] = '\0';
	return atoi(kod); 
}

void predej_delku_strihani(const char* zprava)
{
  // rozkodovani zpravy
  int delka = atoi(zprava + 25);
	printf("dbg: zakaznik rika 'delka strihani' = %d\n", delka);
  
  // predani delky strihani na komunikacni pipe
  char buf[128];
	sprintf(buf, "%d\n", delka);
  write(komunikace[1], buf, strlen(buf));
}

void strihani(int socket, int index)
{
	char zprava[128];
	
	sprintf(zprava, "C04:Pojd se strihat\n");
	posli_zpravu(socket, index, zprava, sizeof(zprava));
	
	precti_zpravu(socket, index, zprava, sizeof(zprava)); // jak dlouho strihat
	
  // preda delku strihani holici
	predej_delku_strihani(zprava);
	
	// ceka az holic dostriha
	strihani_down();
	
	sprintf(zprava, "C08:Hotovo\n");
	posli_zpravu(socket, index, zprava, sizeof(zprava));
}

void *zakaznik(void *arg)
{
	int *param = (int*)arg;
	int socket = param[0];
	int index = param[1];

	char zprava[128];
	precti_zpravu(socket, index, zprava, sizeof(zprava)); // dobry den
	
	// zamkne cekajici
	cekajici_down();
	
	if (pocet_cekajici() < N)
	{
	  sprintf(zprava, "A02:Misto v cekarne je volne\n");
		posli_zpravu(socket, index, zprava, sizeof(zprava));
		
		// zvysi pocet cekajicich zakazniku
		zvys_cekajici();
	  
		// probouzi holice
		zakaznik_up();
		
		// odemkne cekajici
		cekajici_up();
		
		// usina, pokud neni holic
		holic_down();
		
		strihani(socket, index);
	}
	else
	{
		// odemkne cekajici
		cekajici_up();
		
	  sprintf(zprava, "A03:Holicstvi je plne obsazeno\n");
		posli_zpravu(socket, index, zprava, sizeof(zprava));
	}
	
	precti_zpravu(socket, index, zprava, sizeof(zprava)); // na shledanou
}

//***************************************************************************
// holic
//***************************************************************************
void cekej(int sekundy)
{
  sleep(sekundy);
}

void strihej()
{
  char buf[128];
  read(komunikace[0], buf, sizeof(buf));
  
  int delka = atoi(buf);
	printf("dbg: holic slysel 'delka strihani' = %d\n", delka);
	cekej(delka);
	
	// probudi spiciho zakaznika na kresle
	strihani_up();
}

void *holic(void *arg)
{
	while (1)
	{
		// usina, pokud neni zakaznik
		zakaznik_down();
				
		// zamkne cekajici
		cekajici_down();
		
		// ukonci, pokud je konec (je probuzen, ale zadny zakaznik)
	  if (pocet_cekajici() == 0)
	  {
			cekajici_up();		
	  	break;	  	
	  }
	  	
		// snizi pocet cekajicich zakazniku
		sniz_cekajici();
		// holic je pripraven strihat
		holic_up();		
		// odemkne cekajici
		cekajici_up();
		
		strihej();
	}
}

//***************************************************************************
// pomocny vypis
//***************************************************************************
void pomoc(char *name)
{
	printf("\n");
	printf("  Program: %s\n", name);
	printf("\n");
	printf("  Server - implementace pomoci procesu resici IPC problem holice.\n");
	printf("	Server reprezentuje holicstvi, ktere ma N kresel v cekarne a M kresel pro strihani\n");
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
	port = (argc > 1) ? atoi(argv[1]) : 9999;
	
	if (port == 0)
	{
		printf("Spatny format portu\n");
		pomoc(argv[0]);
	}
	
	// zachyceni <CTRL-C>
	signal( SIGINT, catch_sig );

	// pri ukonceni programu se zavola clean
	atexit( clean );

	// vytvoreni semaforu
	int sem = 0;
	if ((sem = vytvor_semafory()) < 0)
	{
		printf("Nelze vytvorit a inicializovat semafory (%d).\n", sem);
		exit(1);
	}
	
	// vytvoreni komunikacni pipe
  if (pipe(komunikace) == -1)
  {
    printf("Nelze vytvorit komunikacni pipe.\n");
    exit(1);
  }
	
	// spusteni holice
	if (pthread_create(&klient_id[klient_cnt], NULL, holic, NULL) != 0)
	{
	  printf("Nelze vytvorit nove vlakno holice ...\n");
	  exit(1);
	}
  // jedno vedlejsi vlakno spusten (holic)
	klient_cnt++;
	
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
			
			// nadefinuji si pole s argumenty pro vlakno
			int argument[2] = { sock_client[klient_cnt], klient_cnt };

			if (pthread_create(&klient_id[klient_cnt], NULL, zakaznik, (void*)&argument) != 0)
			{
			  printf("Nelze vytvorit nove vlakno zakaznika ...\n");
			}
			// zavreni spojeni klienta
			klient_cnt++;
		}
		
    // byl pozadavek na ukonceni prace serveru?
    if (!strncasecmp(buf, "quit", 4))
    {
			printf("Server bude ukoncen ...\n");

			konec = 0;

			printf("Cekani na ukonceni prace vsech holicu.\n");
			// jakoze novy zakaznik => ukonceni procesu holic
			zakaznik_up();

			// cekani nez se ukonci vsichni klienti (procesy)
			for (int i = 0; i < klient_cnt; i++)
			{
				void *s;
				if (klient_id[i] > 0)
				 	pthread_join(klient_id[i], &s); 
				if (i > 0)
			    close(sock_client[i]);								
			}

			break;
    }		
	}
	
	// zavreni komunikacni pipe
  close(komunikace[0]);
  close(komunikace[1]);
  
	close(sock_listen);
	if (uvolni_semafory() < 0)
	{
		printf("Nelze rusit semafory.\n");
		exit(1);
	}
	
	exit(0);
}
