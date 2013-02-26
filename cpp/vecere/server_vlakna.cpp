//***************************************************************************
//
// Autor: 
//
// Popis: Reseni IPC problemu vecericich filozofu, pomoci socketu jako
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
#include <sys/shm.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <pthread.h>

#define N 3

#define VLEVO  (((zidle - 1) < 0) ? (N - 1) : (zidle - 1))	// levy soused
#define VPRAVO (((zidle + 1) < N) ? (zidle + 1) : 0)				// pravy soused

#define PREMYSLI 0	// filozof premysli
#define HLADOVI 1		// filozof dostal hlad a ceka na vidlicky
#define POJIDA 2 		// filozof ji

#define VOLNA 0			// volna zidle
#define OBSAZENA 1	// obsazena zidle

#define SEM_MUTEX		0	// prvni semafor je cislo mutexu, pro kritickou sekci
#define SEM_FILOZOF	1	// pocet semaforu; poslednich N: pro kazdecho filozofa jeden mutex
int sem_id;

int filozof_data[N];	// stavy jednotlivych filozofu ( PREMYSLI, HLADOVI, POJIDA )
int zidle_data[N];		// stavy zidli ( VOLNA, OBSAZENA )

int klient_cnt = 0;
pthread_t klient_id[100];
int sock_client[100];

//***************************************************************************
// pomocne funkce semafory
//***************************************************************************
int vytvor_semafory()
{
	sem_id = semget(5555, N + 1, IPC_CREAT | 0660);
	
	if (sem_id < 0)
		return -1;
	
	if ((semctl(sem_id, SEM_MUTEX, SETVAL, 1)) < 0)
		return -2;

	for (int i = 0; i < N; i++)
	{
		if ((semctl(sem_id, SEM_FILOZOF + i, SETVAL, 0)) < 0)
			return -3;
	}
	
	return 0;
}

int uvolni_semafory()
{
	if (sem_id > 0)
	{
		if (semctl(sem_id, 0, IPC_RMID, NULL) < 0)
			return 1;
	}
	sem_id = 0;
	return 0;
}

void sem_down(int sem)
{
	sembuf op;
	op.sem_num = sem;
	op.sem_op = -1;
	op.sem_flg = 0;

	semop(sem_id, &op, 1);
}

void sem_up(int sem)
{
	sembuf op;
	op.sem_num = sem;
	op.sem_op = 1;
	op.sem_flg = 0;

	semop(sem_id, &op, 1);
}

//***************************************************************************
// pomocne funkce pro sdilenou pamet
//***************************************************************************
void default_filozof(int zidle)
{
	filozof_data[zidle] = PREMYSLI;
	zidle_data[zidle] = VOLNA;
}

int vytvor_pamet()
{
	for (int i = 0; i < N; i++)
		default_filozof(i);
		
	return 0;
}

int uvolni_pamet()
{
	return 0;
}

void tiskVidlicek(int zidle)
{
	printf("Zidle %d muze jist. Stav vidlicek = {", zidle + 1);
	for (int i = 0; i < N; i++)
	{
		if (i > 0)
			printf (", ");
	  if (i == zidle)
	  {
	  	printf("'JA'");
	  }
	  else
	  {
			int vidlicka = (filozof_data[i] == POJIDA) ? 1 : 0;
			printf("%d", vidlicka);
		}
	}
	printf("}\n");
}

//***************************************************************************
// pomocna funkce pro uklid
//***************************************************************************
void clean()
{
  if (uvolni_semafory() != 0)
  	exit(1);
  if (uvolni_pamet() != 0)
  	exit(1);
}

void catch_sig(int sig)
{
  exit(1);
}

//***************************************************************************
// funkce pro klienta
//***************************************************************************
void posli_zpravu(int socket, int zidle, const char* zprava, int delka)
{
  // vypis zpravy
  printf("pro zidli %d: %s", zidle + 1, zprava);
  
  // odeslani zpravy
  write(socket, zprava, delka);
}

void precti_zpravu(int socket, int zidle, char* zprava, int delka)
{
  // prijeti zpravy  
  read(socket, zprava, delka);
  
  // vypis zpravy
	printf("od  zidle %d: %s", zidle + 1, zprava);
}

int dejZidli() // -1 obsazeno, 0 .. N-1 misto u stolu
{
	sem_down(SEM_MUTEX);
	
	int zidle = -1;
	for (int i = 0; i < N; i++)
	{
		if ((zidle < 0) && (zidle_data[i] == VOLNA))
		{
			zidle_data[i] = OBSAZENA;
			zidle = i;
			break;
		}
	}
	
	sem_up(SEM_MUTEX);
	
	return zidle;
}

void uvolniZidli(int zidle)
{
	sem_down(SEM_MUTEX);

	default_filozof(zidle);	
	
	sem_up(SEM_MUTEX);
}

int jeVolno(int socket, int index)
{
	char zprava[128];
	
	precti_zpravu(socket, -1, zprava, sizeof(zprava)); // dobry den
	
	int zidle = dejZidli();
	
	if (zidle < 0)
	{
  	sprintf(zprava, "A03:Neni misto\n");
	  posli_zpravu(socket, -1, zprava, sizeof(zprava));
	  
  	precti_zpravu(socket, -1, zprava, sizeof(zprava)); // na shledanou, odchazim
	
  	sprintf(zprava, "A09:Na shledanou\n");
	  posli_zpravu(socket, -1, zprava, sizeof(zprava));
	}
	else
	{
  	sprintf(zprava, "A02:Sedis na zidli %d\n", zidle + 1);
	  posli_zpravu(socket, -1, zprava, sizeof(zprava));
	}
	
	return zidle;
}

void testVidlicek(int zidle)
{
	if ((filozof_data[zidle] == HLADOVI) &&
		  (filozof_data[VLEVO] != POJIDA) &&
		  (filozof_data[VPRAVO] != POJIDA))
	{
		filozof_data[zidle] = POJIDA;
		sem_up(SEM_FILOZOF + zidle);
	}
}

void vezmiVidlicky(int zidle)
{
	sem_down(SEM_MUTEX);
	filozof_data[zidle] = HLADOVI;	// filozof zjistil, ze je hladovy
	testVidlicek(zidle); // pokus o ziskani dvou vidlicek
	sem_up(SEM_MUTEX);
	sem_down(SEM_FILOZOF + zidle);	// zablokovani pokud nejsou vidlicky
	tiskVidlicek(zidle);
}

void polozVidlicky(int zidle)
{
	sem_down(SEM_MUTEX);
	filozof_data[zidle] = PREMYSLI;	// filozof premysli
	testVidlicek(VLEVO);	// muze jist levy soused ?
	testVidlicek(VPRAVO);	// muze jist pravy soused ?
	sem_up(SEM_MUTEX);
}

void *filozof(void *arg)
{	
	int *param = (int*)arg;
	int socket = param[0];
	int zidle = param[1];
	
	char zprava[128];
	
	int konec = 1;
	while(konec)
	{
		precti_zpravu(socket, zidle, zprava, sizeof(zprava)); // chci jist | na shledanou
	
		if (strncmp(zprava, "C08", 3) == 0)
		{
  	  sprintf(zprava, "A09:Na shledanou\n");
	    posli_zpravu(socket, zidle, zprava, sizeof(zprava));
	    
	    uvolniZidli(zidle);
	    
	    break;
		}
		
		vezmiVidlicky(zidle);
		
 	  sprintf(zprava, "A05:Muzes jist\n");
    posli_zpravu(socket, zidle, zprava, sizeof(zprava));
    
		precti_zpravu(socket, zidle, zprava, sizeof(zprava)); // dojedl jsem
	
	  polozVidlicky(zidle);
		
 	  sprintf(zprava, "A07:Vidlicky uvolneny\n");
    posli_zpravu(socket, zidle, zprava, sizeof(zprava));
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
	printf("  Server - implementace pomoci procesu resici IPC problem vecericich filozofu.\n");
	printf("	Server reprezentuje stul, ktere ma N zidli\n");
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
	port = (argc > 1) ? atoi(argv[1]) : 5555;
	
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
			
			int zidle = jeVolno(sock_client[klient_cnt], 0);
			
			if (zidle < 0) // obsazeno
			{
					// zavreni spojeni klienta
					close(sock_client[klient_cnt]);				
					sock_client[klient_cnt] = 0;
			}
			else
			{
				// nadefinuji si pole s argumenty pro vlakno
				int arg[] = { sock_client[klient_cnt], zidle };

				if (pthread_create(&klient_id[klient_cnt], NULL, filozof, (void*)&arg) == 0) // pokracuje klient
				{
				}
				klient_cnt++;
			}
		}
		
    // byl pozadavek na ukonceni prace serveru?
    if (!strncasecmp(buf, "quit", 4))
    {
			printf("Server bude ukoncen ...\n");

			konec = 0;

			printf("Cekani na ukonceni vecere vsech filozofu.\n");

			// cekani nez se ukonci vsichni klienti (procesy)
			for (int i = 0; i < klient_cnt; i++)
			{
				void *s;
				if (klient_id[i] > 0)
				 	pthread_join(klient_id[i], &s); 
				close(sock_client[klient_cnt]);
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
