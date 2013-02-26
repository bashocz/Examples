// relation.cpp : Defines the entry point for the console application.
//
// author: bashocz
//

#include "stdafx.h"

struct Element
{
	int a;
	int b;

	Element(int _a, int _b)
	{
		a = _a;
		b = _b;
	}
};

bool isElement(Element element, Element relation[], int length)
{
	for (int i = 0; i < length; i++)
	{
		if ((relation[i].a == element.a) && (relation[i].b == element.b))
			return true;
	}
	return false;
}

bool isTransitive(Element relation[], int count)
{
	for (int i = 0; i < count; i++)
	{
		for (int j = 0; j < count; j++)
		{
			if ((i != j) && (relation[i].b == relation[j].a))
			{
				if (!isElement(Element(relation[i].a, relation[j].b), relation, count))
					return false;
			}
		}
	}
	return true;
}

int _tmain(int argc, _TCHAR* argv[])
{
	Element relationR[] = {Element(0,0), Element(0,1), Element(0,2), Element(1,0), Element(1,1), Element(1,2)};
	printf("Relation R is ");
	printf(isTransitive(relationR, 6)? "" : "not");
	printf(" tranzitive.\n");

	Element relationQ[] = {Element(0,1), Element(0,2), Element(1,0), Element(1,1), Element(1,2)};
	printf("Relation Q is ");
	printf(isTransitive(relationQ, 5)? "" : "not");
	printf(" tranzitive.\n");

	getchar();
	return 0;
}

