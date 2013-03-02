#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <io.h>
#include "datum.h"

struct Losy
{
  unsigned char cis[20];
  Losy *dalsi;

  Losy();
};

Losy::Losy()
{
  dalsi = NULL;
}

void prognoza (char *d)
{
  FILE *file;
  Losy *los, *prvni, *tmp;
  long ln;
  int i, j, k, l, prav[2][80], tp;
  unsigned char datum[11], cislo[20000], ls[5], prg[20];
  float ap;

  clrscr();
  /*  Nacteni vsech losovani do pameti  */
  for (i = 0; i < 80; i++)
    prav[1][i] = i + 1;
  file = fopen ("win.nbr", "rb");
  ln = filelength (fileno (file)) / 31;
  if (ln > 20000)
  {
    printf ("V databazi je mnoho losovani, nestaci mi pamet\n");
    printf ("\n\nStiskni klavesu\n");
    getch();
    return;
  }
  prvni = los = new Losy;
  for (i = 0; i < ln; i++)
  {
    fread (datum, 11, 1, file);
    if ((d != NULL) && (strcmp (datum, d) == 0))
      i = ln - 1;
    else
      fread (los->cis, 20, 1, file);
    if (i < ln - 1) los->dalsi = new Losy;
    los = los->dalsi;
  }
  fclose (file);
  if (d == NULL)
  {
    printf ("Datum prognozovaneho losovani : ");
    scanf ("%s", datum);
  }
  printf ("\n\n");

  /*  Prognoza 20 moznych losovanych cisel  */
  for (i = 0; i < 80; i++)
  {
    /*  pricteni 7 bodu za kazde vylosovani  */
    prav[0][i] = 0;
    los = prvni;
    k = 0;
    while (los != NULL)
    {
      cislo[k] = 0;
      for (j = 0; j < 20; j++)
       if (los->cis[j] == i+1) cislo[k] = 1;
      if (cislo[k] == 1)
	prav[0][i] += 7;
      los = los->dalsi;
      k++;
    }

    /*  pricteni 40 bodu za nevylosovani od posledniho losovani  */
    k = ln - 1;
    while (cislo[k] == 0) k--;
    prav[0][i] += 40*(ln - 1 - k);

    /*  pricteni bodu podle sance na vylosovani  */
    for (j = 0; j < 5; j++)
      ls[j] = 200;
    tp = 0;
    k = (ln > 100) ? ln - 100 : 0;
    for (j = k; j < ln; j++)
    {
      tp++;
      if (cislo[j] == 1)
      {
	for (k = 0; k < 4; k++)
	  ls[k] = ls[k+1];
	ls[4] = tp;
	tp = 0;
      }
    }
    tp++;
    k = 0;
    while ((ls[k] == 200) && (k < 5)) k++;
    if (k < 5)
    {
      j = 1;
      while ((ls[5-j] == tp) && (5-j >= k))    // s druhou mocninou 60 b.
      {
	prav[0][i] += j*j*60;
	j++;
      }

      for (j = k; j < 4; j++)   // za nekolisani plus l*20 b.
      {
	l = abs (ls[j] - ls[j+1]);
	if (l < 3) prav[0][i] += (3-l)*20;
      }
      l = abs (ls[4] - tp);
      if (l < 3) prav[0][i] += (3-l)*20;

      l = 0;                // za rozdil v aritmetickem prumeru l*70 b.
      for (j = k; j < 5; j++)
	l += ls[j];
      j = l/(5-k);
      l = abs (tp - j);
      if (l < 4) prav[0][i] += (4-l)*70;
    }
    else
      prav[0][i] += ln*1000;
  }

  /*  Smazani vsech losovani z pameti  */
  los = prvni;
  while (los != NULL)
  {
    tmp = los->dalsi;
    delete los;
    los = tmp;
  }

  /*   Serazeni cisel podle jejich pravdepodobnosti   */
  l = 1;
  while (l != 0)
  {
    l = 0;
    for (i = 0; i < 79; i++)
      if (prav[0][i] < prav[0][i+1])
      {
	l = 1;
	tp = prav[0][i];
	prav[0][i] = prav[0][i+1];
	prav[0][i+1] = tp;
	tp = prav[1][i];
	prav[1][i] = prav[1][i+1];
	prav[1][i+1] = tp;
      }
  }

  /*  Prepis dvaceti nejuspesnejsich cisel  */
  for (i = 0; i < 20; i++)
    prg[i] = prav[1][i];

  /*  Serazeni prognozovanych cisel  */
  l = 1;
  while (l != 0)
  {
    l = 0;
    for (i = 0; i < 19; i++)
      if (prg[i] > prg[i+1])
      {
	l = 1;
	tp = prg[i];
	prg[i] = prg[i+1];
	prg[i+1] = tp;
      }
  }

  /*  Tisk prognozovanych cisel  */
  printf ("Prognozovana cisla na den %s jsou tato : \n\n", datum);
  for (i = 0; i < 20; i++)
    if (i == 0)
      printf ("%2d", prg[i]);
    else
      printf (", %2d", prg[i]);
  file = fopen ("prognoza.nbr", "w+b");
  fwrite (datum, 11, 1, file);
  fwrite (prg, 20, 1, file);
  fclose (file);
  printf ("\n\n\nStiskni klavesu\n");
  getch();
}

void prognoza_impact()
{
  FILE *file;
  unsigned char prg[20], los[20];
  char datep[11], datel[11];
  long fl;
  int i, j, k;

  clrscr();
  if ((file = fopen ("prognoza.nbr", "rb")) == NULL)
  {
    printf ("Neexistuje soubor s prognozou\n");
    printf ("\nStiskni klavesu\n");
    getch();
    return;
  }
  fread (datep, 11, 1, file);
  fread (prg, 20, 1, file);
  fclose (file);
  file = fopen ("win.nbr", "rb");
  fl = filelength (fileno (file));
  j = 0;
  for (i = 0; i < fl; i++)
  {
    fread (datel, 11, 1, file);
    fread (los, 20, 1, file);
    if (strcmp (datep, datel) == 0)
    {
      j = 1;
      i = fl;
    }
  }
  fclose (file);
  if (j == 0)
  {
    printf ("Losovani na prognozu, jeste nebylo zapsano\n");
    printf ("\n\nStiskni klavesu\n");
    getch();
    return;
  }
  printf ("Prognoza na den %s vysla takto :\n\n", datep);
  printf ("Shodna cisla :\n");
  k = 0;
  for (i = 0; i < 20; i++)
    for (j = 0; j < 20; j++)
      if (prg[i] == los[j])
      {
	if (k == 0)
	  printf ("%d", prg[i]);
	else
	  printf (" ,%d", prg[i]);
	k++;
      }
  printf ("\n\nCelkem uhodnuto %d cisel coz je %d\%.\n", k, k*5);
  printf ("\n\nStiskni klavesu\n");
  getch();
}

void print_one_day (char *d);

void gradial_prognoza()
{
  date dat;
  char datum[11];
  FILE *file;
  long ln;
  int i;

  dat.da_day = 1;
  dat.da_mon = 2;
  dat.da_year = 18;
  file = fopen ("win.nbr", "rb");
  ln = filelength (fileno (file)) / 31;
  fclose (file);
  for (i = 31; i < ln; i++)
  {
    clrscr();
    date2ascii (datum, dat);
    prognoza (datum);
    print_one_day (datum);
    prognoza_impact();
    dat += 1;
  }
}