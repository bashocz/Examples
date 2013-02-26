//***************************************************************************
//
// petr (basho) b.
//
//***************************************************************************

#include <stdio.h>
#include <string.h>
#include <float.h>
#include <math.h>

const float float_min = -FLT_MAX;
const float float_max = FLT_MAX;

void fpuinit();

float asm_sum(float *p, int N);
float asm_findmin(float *p, int N);
float asm_findmax(float *p, int N);
float asm_dev(float *p, int N);
void asm_mulmatrix(float *m, float *m1, float *m2, int N);
float asm_coslaw(float a, float b, float alpha);
float asm_cos(float alpha);
float asm_sqrt(float alpha);

void print_header(const char* header)
{
  printf("--------------------------------------------------\n");
  printf("%s\n", header);
}

void print_c_header()
{
  printf("  C: ");

}

void print_asm_header()
{
  printf("asm: ");
}

float c_sum(float *p, int N)
{
  float sum = 0;
  int i;
  for (i = 0; i < N; i++)
    sum += p[i];
  return sum;
}

void print_sum(float sum)
{
  printf("Summary = %f\n", sum);
}

void sum(float *p, int N)
{
  char header[200];
  sprintf(header, "Function: Summary of array elements (N=%d):", N);
  print_header(header);

  print_c_header();
  print_sum(c_sum(p, N));

  print_asm_header();
  print_sum(asm_sum(p, N));
}

float c_findmin(float *p, int N)
{
  float min = float_max;
  int i;
  for (i = 0; i < N; i++)
    if (p[i] < min)
      min = p[i];
  return min;
}

void print_findmin(float max)
{
  printf("Minimum element of array = %f\n", max);
}

void findmin(float *p, int N)
{
  print_header("Function: Minimum element of array:");

  print_c_header();
  print_findmin(c_findmin(p, N));

  print_asm_header();
  print_findmin(asm_findmin(p, N));
}

float c_findmax(float *p, int N)
{
  float max = float_min;
  int i;
  for (i = 0; i < N; i++)
    if (p[i] > max)
      max = p[i];
  return max;
}

void print_findmax(float max)
{
  printf("Maximum element of array = %f\n", max);
}

void findmax(float *p, int N)
{
  print_header("Function: Maximum element of array:");

  print_c_header();
  print_findmax(c_findmax(p, N));

  print_asm_header();
  print_findmax(asm_findmax(p, N));
}

float c_dev(float *p, int N)
{
  float avg = c_sum(p, N) / N;
  int i;
  for (i = 0; i < N; i++)
    p[i] -= avg;
  return avg;
}

void print_dev(float avg, float *p, float *d, int N)
{
  int i;

  printf("Deviation (avarage = %f)\n", avg);
  for (i = 0; i < N; i++)
    printf("p[%d] = %12.6f, deviation = %12.6f\n", i, p[i], d[i]);
}

void dev(float *p, int N)
{
  char header[200];
  sprintf(header, "Function: Deviation of array elements (N=%d):", N);
  print_header(header);

  float p1[N];
  memcpy(p1, p, sizeof(p1));
  print_c_header();
  float avg1 = c_dev(p1, N);
  print_dev(avg1, p, p1, N);

  float p2[N];
  memcpy(p2, p, sizeof(p2));
  print_asm_header();
  float avg2 = asm_dev(p2, N);
  print_dev(avg2, p, p2, N);
}

void c_mulmatrix(float *m, float *m1, float *m2, int N)
{
  int i, j, k;

  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
    {
      m[i * N + j] = 0;
      for (k = 0; k < N; k++)
        m[i * N + j] += m1[i * N + k] * m2[k * N + j];
    }
}

void print_matrix(float *m, int N)
{
  int i, j;
  printf("Matrix:\n");
  for (i = 0; i < N; i++)
  {
    printf("%12.6f", m[i * N]);
    for (j = 1; j < N; j++)
      printf(", %12.6f", m[i * N + j]);
    printf("\n");
  }
}

void mulmatrix(float *m1, float *m2, int N)
{
  char header[200];
  sprintf(header, "Function: Matrix multiplication (%dx%d):", N, N);
  print_header(header);

  float mr1[N * N];
  print_c_header();
  c_mulmatrix(mr1, m1, m2, N);
  print_matrix(mr1, N);

  float mr2[N * N];
  print_asm_header();
  asm_mulmatrix(mr2, m1, m2, N);
  print_matrix(mr2, N);
}

float c_coslaw(float a, float b, float alpha)
{
  return asm_sqrt(a * a + b * b - 2 * a * b * asm_cos(alpha));
}

void print_coslaw(float max)
{
  printf("Side c = %f\n", max);
}

void coslaw(float a, float b, float alpha)
{
  char header[200];
  sprintf(header, "Function: Cossine law (a = %f, b = %f, aplha = %f):", a, b, alpha);
  print_header(header);

  print_c_header();
  print_coslaw(c_coslaw(a, b, alpha));

  print_asm_header();
  print_coslaw(asm_coslaw(a, b, alpha));
}

int main()
{
  fpuinit();

  float array[] = {-1.2345e-8, 3.33, 1000.987, -210.1, 1.000986e3, -210.2, 9.99e2, 9.87654321e-12};
  int N = sizeof(array) / sizeof(float);
  sum(array, N);
  findmin(array, N);
  findmax(array, N);
  dev(array, N);

  int M = 3;
  float m1[] = {1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9};
  float m2[] = {9.9, 8.8, 7.7, 6.6, 5.5, 4.4, 3.3, 2.2, 1.1};
  float j[] = {1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0};
  mulmatrix(m1, j, M);
  mulmatrix(m1, m2, M);

  coslaw(3, 3, M_PI / 3);
}
