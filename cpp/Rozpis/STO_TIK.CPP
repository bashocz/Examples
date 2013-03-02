#include <time.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

long win[] = {6600,1100,100,0,0,6300,25800,61300,39200,4422000,42250000,275000000,1320000000};

int ticket[1000][12],los[20],wins[13];

void setticket()
{
  int i,j,k,x,y;

  for (i=0; i<1000; i++)
    for (j=0; j<12; j++)
      ticket[i][j] = 0;

  for(i=0; i<20; i++)
  {
    y=1;
    while (y == 1)
    {
      y=0;
      x=random(80)+1;
      for(j=0; j<i-1; j++)
	if (los[j] == x) y=1;
    }
    los[i]=x;
  }

  for(j=0; j<12; j++)
    for(i=0; i<1000; i++)
    {
      y=1;
      while (y == 1)
      {
	y=0;
	x=los[random(20)];
	for(k=0; k<j; k++)
	  if (ticket[i][k] == x) y=1;
      }
      ticket[i][j]=x;
    }
}

void tah()
{
  int i,j,k,x,y,a;
  int b[13];
  long z;

  for(i=0; i<20; i++)
  {
    y=1;
    while (y == 1)
    {
      y=0;
      x=random(80)+1;
      for(j=0; j<i-1; j++)
	if (los[j] == x) y=1;
    }
    los[i]=x;
  }
  clrscr();
  z=0;
  for (i=0; i<13; i++) b[i]=0;
  for (i=0; i<1000; i++)
  {
    a=0;
    for (j=0; j<12; j++)
      for (k=0; k<20; k++)
	if (ticket[i][j] == los[k]) a++;
    z = z + win[a];
    b[a]++;
    wins[a]++;
  }
  for (i=0; i<13; i++)
    printf("%2d - %2dx (celkove %6dx)\n",i,b[i],wins[i]);
  printf("\ncelkova vyhra - %ld Kc",z);
}

void main()
{
  char ch;
  int i;

  for (i=0; i<13; i++) wins[i]=0;
  randomize();
  do
  {
    setticket();
    tah();
    ch = getch();
  } while ((ch != 'e') && (ch != 'E'));
}