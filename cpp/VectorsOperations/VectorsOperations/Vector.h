#pragma once

class Vector
{
private:
	double *values;
	int size;

	void newValues(int dimesion);
public:
	Vector(int dimension);
	Vector(double numbers[], int dimension);
	~Vector();
	int getDimension() const;
	double getLength() const;
	Vector normalize() const;
	double cosinus(const Vector& vector) const;
	Vector operator+ (const Vector& vector) const;
	Vector operator- (const Vector& vector) const;
	bool operator== (const Vector& vector) const;
	bool operator!= (const Vector& vector) const;
	double& operator[] (int index) const;
	Vector operator*(const double scalar) const;
	double operator*(const Vector& vector) const;
};