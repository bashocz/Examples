//***************************************************************************
//
// petr (basho) b.
//
//***************************************************************************

#include <stdio.h>

long long asm_sum(int *p, int N);
int asm_findmax(int *p, int N);
void asm_removechar(char *str, char z);
void asm_sort(int *a, int *b, int *c);
int asm_strtoint(char *p);

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

long long c_sum(int *p, int N)
{
  long long sum = 0;
  int i;
  for (i = 0; i < N; i++)
    sum += p[i];
  return sum;
}

void print_sum(long long sum)
{
  printf("Summary = %Ld\n", sum);
}

void sum(int *p, int N)
{
  char header[200];
  sprintf(header, "Function: Summary of array elements (N=%d):", N);
  print_header(header);

  print_c_header();
  print_sum(c_sum(p, N));

  print_asm_header();
  print_sum(asm_sum(p, N));
}

int c_findmax(int *p, int N)
{
  int max = (int)0x80000000; // min 32b int
  int i;
  for (i = 0; i < N; i++)
    if (p[i] > max)
      max = p[i];
  return max;
}

void print_findmax(int max)
{
  printf("Maximum element of array = %d\n", max);
}

void findmax(int *p, int N)
{
  print_header("Function: Maximum element of array:");

  print_c_header();
  print_findmax(c_findmax(p, N));

  print_asm_header();
  print_findmax(asm_findmax(p, N));
}

void c_removechar(char *str, char z)
{
  char *p;

  while ((p = strchr(str, z)) != NULL)
    strcpy(p, p+1);
}

void print_removechar(char *str)
{
  printf("'%s'\n", str);
}

void removechar(char* str, char z)
{
  char header[200];
  sprintf(header, "Function: Remove character '%c' from string '%s':", z, str);
  print_header(header);

  char *c_str = strdup(str);
  c_removechar(c_str, z);
  print_c_header();
  print_removechar(c_str);

  char *asm_str = strdup(str);
  asm_removechar(asm_str, z);
  print_asm_header();
  print_removechar(asm_str);}

void c_sort(int *a, int *b, int *c)
{
  if (*a < *b)
  {
    int d = *a;
    *a = *b;
    *b = d;
  }
  if (*a < *c)
  {
    int d = *a;
    *a = *c;
    *c = d;
  }
  if (*b < *c)
  {
    int d = *b;
    *b = *c;
    *c = d;
  }
}

void print_sort(int *a, int *b, int *c)
{
  printf("%d, %d, %d\n", *a, *b, *c);
}

void sort(int a, int b, int c)
{
  char header[200];
  sprintf(header, "Function: Sort numbers %d, %d, %d:", a, b, c);
  print_header(header);

  int c_a = a, c_b = b, c_c = c;
  c_sort(&c_a, &c_b, &c_c);
  print_c_header();
  print_sort(&c_a, &c_b, &c_c);

  int asm_a = a, asm_b = b, asm_c = c;
  asm_sort(&asm_a, &asm_b, &asm_c);
  print_asm_header();
  print_sort(&asm_a, &asm_b, &asm_c);
}

int c_strtoint(char *p)
{
  int n = 0, i = 0;
  while (p[i])
  {
    n *= 10;
    n += p[i] - '0';
    i++;
  }
  return n;
}

void print_strtoint(int num)
{
  printf("Number = %d\n", num);
}

void strtoint(char *p)
{
  char header[200];
  sprintf(header, "Convert number from string '%s':", p);
  print_header(header);

  print_c_header();
  print_strtoint(c_strtoint(p));

  print_asm_header();
  print_strtoint(asm_strtoint(p));
}

int main()
{
  int pole[] = {2000000000, 1000000000, -2000000000, 1000, 200, 30, -5};
  sum(pole, sizeof(pole) / sizeof(int));

  int pole2[] = {23, -3, 49, 5, -123, 2000000000, 13, 1999999999};
  findmax(pole2, sizeof(pole2) / sizeof(int));

  removechar("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 'a');

  sort(3, -1, 8);

  strtoint("4321");
}
