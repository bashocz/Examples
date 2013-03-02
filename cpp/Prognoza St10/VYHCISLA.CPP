#include <string.h>
#include <conio.h>
#include <stdio.h>
#include <mem.h>
#include <io.h>
#include "st10.h"

#define Max 12
#define MaxTicket 66

void set_day()
{
  char date[11];
  int i, j, err, tmp;
  char cisla[20];
  FILE *file;

  clrscr();
  printf ("Datum losovani : ");
  setmem (date, 11, 0);
  scanf ("%s", date);
  printf ("\nZadej dvacet vylosovanych cisel\n\n");
  for (i = 0; i < 20; i++)
  {
    err = 0;
    printf ("Zadej %d. cislo : ", i+1);
    scanf ("%d", &tmp);
    cisla[i] = (char) tmp;
    if ((cisla[i] < 1) || (cisla[i] > 80))
      err = 1;
    else
    {
      for (j = 0; j < i; j++)
	if (cisla[i] == cisla[j]) err = 1;
    }
    if (err == 1)
    {
      i--;
      printf ("\a");
    }
  }
  file = fopen ("win.nbr", "a+b");
  fwrite (date, 11, 1, file);
  fwrite (cisla, 20, 1, file);
  fclose (file);
}

void print_one_day (char *d = NULL)
{
  long len;
  int i, find, change;
  char date[11], nowdate[11], cisla[20], tmp;
  FILE *file;

  clrscr();
  if (d == NULL)
  {
    printf ("\n\n\nZadej datum losovani : ");
    scanf ("%s", nowdate);
  }
  else
    strcpy (nowdate, d);
  file= fopen ("win.nbr", "rb");
  find = 0;
  len = (filelength (fileno (file))) / 31;
  for (i = 0; i < len; i++)
  {
    fread (date, 11, 1, file);
    fread (cisla, 20, 1, file);
    if (strcmp (date, nowdate) == 0)
    {
      i = len;
      find = 1;
    }
  }
  if (find == 1)
  {
    do
    {
      change = 0;
      for (i = 0; i < 19; i++)
	if (cisla[i] > cisla[i+1])
	{
	  tmp = cisla[i];
	  cisla[i] = cisla[i+1];
	  cisla[i+1] = tmp;
	  change = 1;
	}
    } while (change != 0);
    printf ("\nVylosovana cisla pro den %s jsou :\n\n", nowdate);
    for (i = 0; i < 20; i++)
      if (i == 19)
	printf ("%2d", cisla[i]);
      else
	printf ("%2d, ", cisla[i]);
    printf ("\n");
  }
  else
    printf ("\nLosovani daneho data neni v databazi...\n");
  printf ("\n\nStiskni libovolnou klavesu\n");
  getch();
}

void print_last_day()
{
  long len;
  int i, change;
  char date[11], cisla[20], tmp;
  FILE *file;

  clrscr();
  file= fopen ("win.nbr", "rb");
  len = (filelength (fileno (file))) - 31;
  fseek (file, len, SEEK_SET);
  fread (date, 11, 1, file);
  fread (cisla, 20, 1, file);
  do
  {
    change = 0;
    for (i = 0; i < 19; i++)
      if (cisla[i] > cisla[i+1])
      {
	tmp = cisla[i];
	cisla[i] = cisla[i+1];
	cisla[i+1] = tmp;
	change = 1;
      }
  } while (change != 0);
  printf ("\nVylosovana cisla dne %s jsou :\n\n", date);
  for (i = 0; i < 20; i++)
    if (i == 19)
      printf ("%2d", cisla[i]);
    else
      printf ("%2d, ", cisla[i]);
  printf ("\n\n\nStiskni libovolnou klavesu\n");
  getch();
}

void print_all_days()
{
  char date[11], cisla[20];
  long len;
  int i, j;
  FILE *file;

  clrscr();
  file = fopen ("win.nbr", "rb");
  len = filelength (fileno (file)) / 31;
  for (i = 0; i < len; i++)
  {
    fread (date, 11, 1, file);
    fread (cisla, 20, 1, file);
    printf ("Vylosovana cisla ze dne %s\n", date);
    for (j = 0; j < 20; j++)
      if (j == 19)
	printf ("%2d", cisla[j]);
      else
	printf ("%2d, ", cisla[j]);
    printf("\n\n");
    if ((((i*3)%21) == 0) && (i != 0))
    {
      printf ("\n\nStiskni libovolnou klavesu...\n");
      getch();
      printf ("\n");
    }
  }
  fclose (file);
  printf ("\n\nStiskni libovolnou klavesu...\n");
  getch();
}

void stats()
{
  long len;
  int count[80][2], i, j, change, tmp, num, lines;
  char date[11], cisla[20];
  FILE *file;

  clrscr();
  for (i = 0; i < 80; i++)
  {
    count[i][0] = 0;
    count[i][1] = i+1;
  }
  file = fopen ("win.nbr", "rb");
  len = (filelength (fileno (file))) / (31);
  for (i = 0; i < len; i++)
  {
    fread (date, 11, 1, file);
    fread (cisla, 20, 1, file);
    for (j = 0; j < 20; j++)
      count[(cisla[j])-1][0] += 1;
  }
  fclose (file);
  do
  {
    change = 0;
    for (i = 0; i < 79; i++)
      if (count[i][0] > count[i+1][0])
      {
	tmp = count[i][0];
	count[i][0] = count[i+1][0];
	count[i+1][0] = tmp;
	tmp = count[i][1];
	count[i][1] = count[i+1][1];
	count[i+1][1] = tmp;
	change = 1;
      }
  } while (change != 0);
  printf ("\n\n\nCetnost losovanych cisel do %s :\n", date);
  tmp = -1;
  lines = 2;
  for (i = 0; i < 80; i++)
  {
    if (tmp < count[i][0])
    {
      tmp = count[i][0];
      num = 1;
      if (lines == 22)
      {
	printf ("\n\nStiskni libovolnou klavesu...\n");
	lines = 1;
	getch();
      }
      printf ("\n(%4d) ", tmp);
      printf ("%2d", count[i][1]);
      lines++;
    }
    else
    {
      if (num == 18)
      {
	if (lines == 22)
	{
	  printf ("\n\nStiskni libovolnou klavesu...\n");
	  lines = 1;
	  getch();
	  printf("\n(%4d) ", count[i][0]);
	}
	else
	  printf ("\n       ");
	printf ("%2d", count[i][1]);
	num = 1;
	lines++;
      }
      else
      {
	num++;
	printf (", %2d", count[i][1]);
      }
    }
  }
  printf ("\n\n\nStiskni libovolnou klavesu...");
  getch();
}

void print_tickets()
{
  unsigned char tikety[MaxTicket][10], number[Max];
  int i, j, k, l, tmp;
  long penize;

  clrscr();
  for (j = 0; j < 10; j++)
    number[j] = j + 1;
  for (i = 0; i < MaxTicket; i++)
  {
    for (j = 0; j < 10; j++)
      tikety[i][j] = number[j];
    number[9] += 1;
    tmp = 10;
    while (number[tmp-1] > Max - 10 + tmp)
    {
      tmp--;
      number[tmp-1]++;
    }
    for (j = tmp; j < 10; j++)
      number[j] = number[j-1] + 1;
  }
  printf ("Zadej %d cisel do rozpisu\n\n", Max);
  for (i = 0; i < Max; i++)
  {
    printf ("%d. cislo : ", i+1);
    scanf ("%d", &tmp);
    number[i] = tmp;
  }
  for (i = 0; i < MaxTicket; i++)
  {
    for (j = 0; j < 10; j++)
    {
      tmp = number[(tikety[i][j])-1];
      tikety[i][j] = tmp;
    }
    printf ("%d. tiket : ", i+1);
    for (j = 0; j < 10; j++)
      if (j == 0)
	printf ("%2d", tikety[i][j]);
      else
	printf (", %2d", tikety[i][j]);
    printf ("\n\n");
    getch();
  }
}

void print_win()
{
  unsigned char tikety[MaxTicket][10], number[Max];
  unsigned int vyhra[11];
  int i, j, k, l, tmp;
  long penize;

  clrscr();
  for (j = 0; j < 10; j++)
    number[j] = j + 1;
  for (i = 0; i < MaxTicket; i++)
  {
    for (j = 0; j < 10; j++)
      tikety[i][j] = number[j];
    number[9] += 1;
    tmp = 10;
    while (number[tmp-1] > Max - 10 + tmp)
    {
      tmp--;
      number[tmp-1]++;
    }
    for (j = tmp; j < 10; j++)
      number[j] = number[j-1] + 1;
  }
  for (j = 0; j < Max; j++)
    number[j] = j + 1;
  for (i = Max; i > 4; i--)
  {
    for (j = 0; j < 11; j++)
      vyhra[j] = 0;
    for (j = 0; j < MaxTicket; j++)
    {
      tmp = 0;
      for (k = 0; k < i; k++)
	for (l = 0; l < 10; l++)
	  if (tikety[j][l] == number[k])
	    tmp++;
      vyhra[tmp]++;
    }
    printf ("Pocet uhodnutych cisel : %d\n\n", i);
    for (j = 10; j > 4; j--)
      printf ("Pocet tiketu s %d uhodnutymi cisly : %d\n", j, vyhra[j]);
    penize = (long)10 * (long)200000 * (long)vyhra[10];
    penize += ((long)10 * (long)10000 * (long)vyhra[9]);
    penize += ((long)10 * (long)500 * (long)vyhra[8]);
    penize += ((long)10 * (long)20 * (long)vyhra[7]);
    penize += ((long)10 * (long)10 * (long)vyhra[6]);
    penize += ((long)10 * (long)3 * (long)vyhra[5]);
    printf ("\nPri sazce %d Kc za tikety cini vyhra : %ld", 10*MaxTicket, penize);
    getch();
    clrscr();
  }
}

void main()
{
  int end = 0;
  char key;

  while (end == 0)
  {
    clrscr();
    printf ("\n\n\n1.   Zapis vyhernich cisel\n");
    printf ("2.   Vypis vyhernich cisel\n");
    printf ("3.   Statistika\n");
    printf ("4.   System\n");
    printf ("5.   Konec\n");
    printf ("\nVolba : ");
    key = getche();
    if (key == '1')
      set_day();
    if (key == '2')
    {
      printf ("\n\n\n1.   Vypis posledniho losovani\n");
      printf ("2.   Vypis jednoho losovani podle zadaneho data\n");
      printf ("3.   Vypis vsech losovani v databazi\n");
      printf ("\nVolba : ");
      key = getche();
      if (key == '1')
	print_last_day();
      if (key == '2')
	print_one_day();
      if (key == '3')
	print_all_days();
    }
    if (key == '3')
    {
      printf ("\n\n\n1.   Statistika vsech losovani\n");
      printf ("2.   Prognoza na dalsi losovani\n");
      printf ("3.   Vysledek predesle prognozy\n");
      printf ("4.   Postupne vysledky prognoz od 1.2.1998\n");
      printf ("\nVolba : ");
      key = getche();
      if (key == '1')
	stats();
      if (key == '2')
	prognoza();
      if (key == '3')
	prognoza_impact();
      if (key == '4')
	gradial_prognoza();
    }
    if (key == '4')
    {
      printf ("\n\n\n1.   Rozpis tiketu\n");
      printf ("2.   Vypis vsech moznych vyher\n");
      printf ("\nVolba : ");
      key = getche();
      if (key == '1')
	print_tickets();
      if (key == '2')
	print_win();
    }
    if (key == '5')
      end = 1;
  }
  clrscr();
  printf ("Program ukoncen...\n");
}