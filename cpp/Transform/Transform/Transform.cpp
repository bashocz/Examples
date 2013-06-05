// Transform.cpp : Defines the entry point for the console application.
//
// author: BAR118 - Petr Baros
//

#include "stdafx.h"

struct Prvek
{
	int a;
	int b;

	Prvek(int _a, int _b)
	{
		a = _a;
		b = _b;
	}
};

bool jePrvek(Prvek prvek, Prvek pole[], int delka)
{
	for (int i = 0; i < delka; i++)
	{
		if ((pole[i].a == prvek.a) && (pole[i].b == prvek.b))
			return true;
	}
	return false;
}

bool jeTranzitivni(Prvek pole[], int delka)
{
	for (int i = 0; i < delka; i++)
	{
		for (int j = 0; j < delka; j++)
		{
			if ((i != j) && (pole[i].b == pole[j].a))
			{
				if (!jePrvek(Prvek(pole[i].a, pole[j].b), pole, delka))
					return false;
			}
		}
	}
	return true;
}

int _tmain(int argc, _TCHAR* argv[])
{
	// Tento zdrojak snad nepotrebuje zadny komentar
	Prvek poleR[] = {Prvek(0,0), Prvek(0,1), Prvek(0,2), Prvek(1,0), Prvek(1,1), Prvek(1,2)};
	printf("Relace R ");
	printf(jeTranzitivni(poleR, 6)? "je" : "neni");
	printf(" tranzitivni\n");

	Prvek poleQ[] = {Prvek(0,1), Prvek(0,2), Prvek(1,0), Prvek(1,1), Prvek(1,2)};
	printf("Relace Q ");
	printf(jeTranzitivni(poleQ, 5)? "je" : "neni");
	printf(" tranzitivni\n");

	getchar();
	return 0;
}

