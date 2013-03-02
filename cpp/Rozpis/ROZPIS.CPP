#include <stdlib.h>
#include <stdio.h>
#include <conio.h>

long win[] = {100,0,0,0,0,300,1000,2000,50000,1000000,20000000};

int ticket[66][10],much[11];

void setticket()
{
  int a[10],i,j,x;

  for (i=0; i<10; i++)
    a[i]=i+1;

  for (i=0; i<66; i++)
  {
    for (j=0; j<10; j++)
      ticket[i][j] = a[j];

    if (i<65)
    {
      j=10;
      x=0;
      while (x==0)
      {
	j--;
	a[j]=a[j]+1;
	if (a[j] < (j+4)) x=1;
      }
      j++;
      while (j<10)
      {
	a[j]=a[j-1]+1;
	j++;
      }
    }
  }

/*  clrscr();
  for (i=0; i<66; i++)
  {
    for (j=0; j<10; j++)
      printf("%3d",ticket[i][j]);
    printf("\n");
    getch();
  } */
}

void tah()
{
  int a,i,j,k,l;
  long x;

  clrscr();
  for (i=12; i>=0; i--)
  {
    for (j=0; j<11; j++) much[j]=0;
    for (j=0; j<66; j++)
    {
      a=0;
      for (k=1; k<=i; k++)
	for (l=0; l<10; l++)
	  if (ticket[j][l] == k) a++;
      much[a]++;
    }
    printf ("%d - ",i);
    for (j=0; j<11; j++)
      if (much[j] != 0) printf("%d(%d), ",j,much[j]);
    x=0;
    for (j=0; j<11; j++) x = x + (long)much[j]*win[j];
    printf("%ld Kc\n",x);
  }
}

void main()
{
  setticket();
  tah();
}