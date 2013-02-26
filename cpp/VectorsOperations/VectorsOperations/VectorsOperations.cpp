// VectorsOperations.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <math.h>
#include <iostream>

using namespace std;

class Vector
{
	double *values;
	int size;

	void init(int dimension);
	void init(double numbers[], int dimension);
	void init(const Vector& vector);
	void deinit();

public:
	Vector(int dimension);				
	Vector(double numbers[], int dimension);
	Vector(Vector& vector);
	~Vector();

	int getDimension()const;
	double getLength()const;
	Vector normalize()const;
	double cosinus(const Vector& vector) const;
	void print() const;

	Vector& operator=(const Vector& vector);
	Vector operator+(const Vector& vector) const;
	Vector operator-(const Vector& vector) const;
	bool operator==(const Vector& vector) const;
	bool operator!=(const Vector& vector) const;
	double& operator[](int index) const;
	double operator*(const Vector& vector) const;
	Vector operator*(const double scalar) const;
};

void Vector::init(int dimension)
{
	size = dimension;
	if(size <= 0)
	{
		size = 1;					//misto nastaveni velikosti lze i vyvolat vyjimku
	}
	values = new double [size];
}

void Vector::init(double numbers[], int dimension)
{
	init(dimension);
	for(int i = 0; i < size; i++)
	{
		values[i] = numbers[i];
	}
}

void Vector::init(const Vector& vector)
{
	init(vector.getDimension());
	for(int i = 0; i < size; i++)
	{
		values[i] = vector[i];
	}
}

void Vector::deinit()					
{
	if(values != NULL)
	{
		delete[] values;
	}
	values = NULL;
}

//konstruktor, vytvori vektor dimenze dimension
Vector::Vector(int dimension)		
{
	init(dimension);
	for(int i = 0; i < size; i++)
	{
		values[i] = 0;
	}
}

//konstruktor, vytvori vektor dimenze dimension a naplni ho hodnotami z pole numbers
Vector::Vector(double numbers[], int dimension) 
{
	init(numbers, dimension);
}

//kopirovaci konstruktor
Vector::Vector(Vector& vector) 
{
	init(vector);
}

Vector::~Vector ()					
{
	deinit();
}

//urceni dimense vektoru
int Vector::getDimension() const			
{
	return size;
}

//vypocet delky vektoru (|v| = x1^2 + x2^2 + ... +xi^2)
double Vector::getLength() const			
{
	double sum = 0;
	for (int i = 0; i < size; i++)
	{
		sum += pow(values[i], 2);
	}
	return sqrt(sum);
}

//normaliazace vektoru - norma = sqrt(x1^2 + x2^2 + ... + xi^2)
//normalizovany vektor ziskame vydelenim kazde slozky vektoru normou (x1/norma, x2/norma, ..., xi/norma)
Vector Vector::normalize() const
{
	Vector normalizeVector = Vector(size);
	double norm = getLength();
	for (int i = 0; i < size; i++)
	{
		normalizeVector[i] = values[i] / norm;
	}
	return normalizeVector;
}

//vypocet kosinu odchylky dvou vektoru 
//cosinus = (u*v)/(|u|*|v|)
double Vector::cosinus(const Vector& vector) const    
{ 
	double cosinus = -1;
	if(size == vector.getDimension())				//pokud neni jedna z podminek splnena, vraci metoda -1, ale lze 
	{												//vyvolat i vyjimku
		double denominator = getLength() * vector.getLength();
		if (denominator != 0)
		{
			cosinus = (*this * vector) / denominator;
		}
	}
	return cosinus;
}

//metoda k vypsani vektoru
void Vector::print() const
{
	cout << "[";
	for(int i = 0; i < size; i++)
	{
		if(i == (size - 1))
		{
			cout << values[i] << "]" << endl;
		}
		else
		{
			cout << values[i] << ", ";
		}
	}
}

Vector& Vector::operator=(const Vector& vector)
{
	if (this == &vector)
	{
		return *this;
	}
	deinit();
	init(vector);
	return *this;
}

Vector Vector::operator+(const Vector& vector) const
{
	if(size == vector.getDimension())	//pokud neni podminka splnena, vraci metoda 0, ale lze vyvolat i vyjimku
	{
		Vector result = Vector(size);
		for (int i = 0; i < size; i++)
		{
			result[i] = values[i] + vector[i];
		}
		return result;
	}
	return Vector(1);
}

Vector Vector::operator-(const Vector& vector) const
{
	if(size == vector.getDimension())	//pokud neni podminka splnena, vraci metoda 0, ale lze vyvolat i vyjimku
	{
		Vector result = Vector(size);
		for (int i = 0; i < size; i++)
		{
			result[i] = values[i] - vector[i];
		}
		return result;
	}
	return Vector(1);
}

bool Vector::operator==(const Vector& vector) const
{
	if(size == vector.getDimension())
	{
		for (int i = 0; i < size; i++)
		{
			if(values[i] != vector[i])
			{
				return false;
			}
		}
		return true;
	}
	return false;
}

bool Vector::operator!=(const Vector& vector) const 
{
	return !(*this == vector);
}

double& Vector::operator[](const int index) const
{
	return values[index];
}

double Vector::operator*(const Vector& vector) const
{
	double scalarProduct = 0;
	if(size == vector.getDimension())  //pokud neni podminka splnena, vraci metoda 0, ale lze vyvolat i vyjimku
	{
		for (int i = 0; i < size; i++)   
		{
			scalarProduct += values[i] * vector[i];
		}
	}
	return scalarProduct;
}

Vector Vector::operator*(const double scalar) const 
{
	Vector result = Vector(size);
	for (int i = 0; i < size; i++)
	{
		result[i] = values[i] * scalar;
	}
	return result;
}

Vector operator*(const double scalar, const Vector& vector)
{
	return vector * scalar;
}

int _tmain(int argc, _TCHAR* argv[])
{
	double numbers[5] = {3.0, 5.0, 9.0, 8.0, 4.0};
	double numbersA[5] = {1.0, 5.0, 6.0, 3.0, 2.0};
	double numbersB[3] = {2.0, 5.0, 8.0};
	int index = 2;
	Vector x = Vector (numbers, 5);
	Vector y = Vector (numbersA, 5);
	Vector z = Vector (numbersB, 3);
	cout << "x = ";
	x.print();
	cout << "y = ";
	y.print();
	cout << "z = ";
	z.print();

	cout << "Dimenze vektoru x: " << x.getDimension() << endl;
	cout << "Delka vektoru x: " << x.getLength() << endl;
	cout << "Normalizovany vektor x: ";
	Vector &normVector = x.normalize();
	normVector.print();
	cout << "Delka normalizovaneho vektoru x: " << (x.normalize()).getLength() << endl;
	cout << "Kosinus odchylky vektoru x a y: " << x.cosinus(y) << endl;

	Vector a = x + y;
	cout << "Soucet vektoru x + y = ";
	a.print();

	a = x + z;
	cout << "Soucet vektoru x + z = ";
	z.print();

	a = x - y;
	cout << "Rozdil vektoru x - y = ";
	a.print();

	a = x - z;
	cout << "Rozdil vektoru x - z = ";
	a.print();

	a = x * 5;
	cout << "Soucin vektoru x * 5 = ";
	a.print();

	a = 5 * x;
	cout << "Soucin 5 * x = ";
	a.print();

	double scalProduct = x * y;
	cout << "Skalarni soucin vektoru x * y = " << scalProduct << endl;

	if (x == y)
	{
		cout << "Porovnavane vektory jsou shodne." << endl;
	}
	else
	{
		cout << "Porovnavane vektory nejsou shodne." << endl;
	}

	a = Vector(x);
	if (x == a)
	{
		cout << "Porovnavane vektory jsou shodne." << endl;
	}
	else
	{
		cout << "Porovnavane vektory nejsou shodne." << endl;
	}

	cout << "x[" << index << "] = " << x[index] << endl;

	getchar();
	return 0;
}