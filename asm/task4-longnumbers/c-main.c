//***************************************************************************
//
// petr (basho) b.
//
//***************************************************************************

#include <stdio.h>
#include <string.h>
#include <math.h>

#define N_CHAR 50
#define N_INT (((N_CHAR - 2) * 10) / 3 / 32) + 1
#define N2_INT 2 * N_INT

long long add_int64_int64(long long a, long long b);
long long mul_int64_int64(long long a, long long b);
long long div_int64_int32(long long a, int b);

void add_intN_int32(int* n, int N, int y); // x = x + y
int mul_intN_int32(int* n, int N, int y); // x = x * y
int div_intN_int32(int* n, int N, int z); // x = x / z

void shl_intN(int *n, int N);
void shr_intN(int *n, int N);
void shld_intN(int *n, int N, int k);
void shrd_intN(int *n, int N, int k);

void add_intN_intN(int *n1, int *n2, int N);
void sub_intN_intN(int *n1, int *n2, int N);

int is_zero_intN(int *n, int N)
{
  int i;
  for (i = 0; i < N; i++)
    if (n[i])
      return 0;
  return 1;
}

int cmp_intN_intN(int *n1, int *n2, int N)
{
  int i;
  for (i = N - 1; i >= 0; i--)
  {
    if (n1[i] == n2[i])
      continue;
    if ((unsigned int)n1[i] > (unsigned int)n2[i])
      return 1;
    return -1;
  }
  return 0;
}

void intN_to_hex(int *n, int N, char *s)
{
  int i;
  for (i = 0; i < N; i++, s+=9)
    sprintf(s, "%08X ", n[N - i - 1]);
  s = 0;
}

void intN_to_bin(int *n, int N, char *s)
{
  int nn[N], i;
  for (i = 0; i < N; i++)
    nn[i] = n[i];

  i;
  for (i = 0; i < (32 * N); i++)
    s[i] = (char)div_intN_int32(nn, N, 2) + '0';
  s[i] = 0;

  int len, cnt;
  char tmp;

  len = strlen(s);
  cnt = len / 2;
  for (i = 0; i < cnt; i++)
  {
    tmp = s[i];
    s[i] = s[len - 1 - i];
    s[len - 1 - i] = tmp;
  }
}

void intN_to_str(int *n, int N, char *s)
{
  int nn[N], i;
  for (i = 0; i < N; i++)
    nn[i] = n[i];

  i = 0;
  while (!is_zero_intN(nn, N))
  {
    s[i] = (char)div_intN_int32(nn, N, 10) + '0';
    i++;
  }
  if (i == 0)
  {
    s[0] = '0';
    i++;
  }
  s[i] = 0;

  int len, cnt;
  char tmp;

  len = strlen(s);
  cnt = len / 2;
  for (i = 0; i < cnt; i++)
  {
    tmp = s[i];
    s[i] = s[len - 1 - i];
    s[len - 1 - i] = tmp;
  }
}

void str_to_intN(char *s, int *n, int N)
{
  memset(n, 0, N * 4);
  int i = 0;
  while (s[i])
  {
    mul_intN_int32(n, N, 10);
    add_intN_int32(n, N, s[i] - '0');
    i++;
  }
}

void mul_intN_intN(int *n1, int *n2, int N)
{
  int res[N];
  memset(res, 0, sizeof(res));
  
  while (!is_zero_intN(n2, N))
  {
    if (n2[0] & 1)
      add_intN_intN(res, n1, N);
    shl_intN(n1, N);
    shr_intN(n2, N);
  }
  memcpy(n1, res, sizeof(res));
}

void div_intN_intN(int *n1, int *n2, int N)
{
  int d[2 * N];
  int *H = d + N;
  memset(d, 0, 2 * N * 4);
  int i;
  for (i = 0; i < N; i++)
    d[i] = n1[i];

  int res[N];
  memset(res, 0, N * 4);

  for (i = 0; i < (32 * N); i++)
  {
    shl_intN(d, 2 * N);
    shl_intN(res, N);
    if (cmp_intN_intN(H, n2, N) >= 0)
    {
      sub_intN_intN(H, n2, N);
      res[0] = res[0] | 1;
    }
  }
  memcpy(n1, res, sizeof(res));
  memcpy(n2, H, sizeof(res));
}

void sqrt_intN(int *n, int N)
{
  int d[2 * N];
  int *H = d + N;
  memset(d, 0, 2 * N * 4);
  int i;
  for (i = 0; i < N; i++)
    d[i] = n[i];

  int res[N];
  memset(res, 0, N * 4);

  int cmp[N];

  for (i = 0; i < (16 * N); i++)
  {
    shld_intN(d, 2 * N, 2);
    shl_intN(res, N);

    memcpy(cmp, res, sizeof(res));
    shl_intN(cmp, N);
    add_intN_int32(cmp, N, 1);

    if (cmp_intN_intN(H, cmp, N) >= 0)
    {
      sub_intN_intN(H, cmp, N);
      res[0] = res[0] | 1;
    }
  }
  memcpy(n, res, sizeof(res));
}

void printf_intN_bin(char *h, int *n, int N)
{
  if (N > 30)
  {
    printf("Number is too long :-).\n");
    return;
  }

  char str[1000];
  intN_to_bin(n, N, str);
  printf("%s %s\n", h, str);
}

int main()
{
  int x[] = { 0xF847C7D2, 0xF00055AA };
  int X = sizeof(x) / sizeof(int);

  printf("\n");
  printf("ROTATION\n");
  printf("------\n");

// --------- rotation
  printf_intN_bin("Origin:", x, X);
  shl_intN(x, X);
  printf_intN_bin("Left:  ", x, X);
  shr_intN(x, X);
  printf_intN_bin("Right: ", x, X);

  shld_intN(x, X, 5);
  printf_intN_bin("Left5: ", x, X);
  shrd_intN(x, X, 5);
  printf_intN_bin("Right5:", x, X);

// --------- rotation

  printf("\n");
  printf("ADD\n");
  printf("------\n");

// --------- add

  char as1[N_CHAR + 1] = "12345123451234512345123451234512345123451234512345";
  int a1[N_INT];
  str_to_intN(as1, a1, N_INT);

  char as2[N_CHAR + 1] = "54321543215432154321543215432154321543215432154321";
  int a2[N_INT];
  str_to_intN(as2, a2, N_INT);

  add_intN_intN(a1, a2, N_INT);
  char rs1[N_CHAR + 1];
  intN_to_str(a1, N_INT, rs1);
  printf("%s\n", rs1);

// --------- add

  printf("\n");
  printf("SUB\n");
  printf("------\n");

// --------- sub

  sub_intN_intN(a1, a2, N_INT);
  intN_to_str(a1, N_INT, rs1);
  printf("%s\n", rs1);

// --------- sub

  printf("\n");
  printf("MUL\n");
  printf("--------\n");

// --------- mul

  char ns1[N_CHAR + 1] = "12345123451234512345123451234512345123451234512345";
  int n1[N2_INT];
  str_to_intN(ns1, n1, N2_INT);

  char ns2[N_CHAR + 1] = "10000000000000000000000000000000000000000000000000";
  int n2[N2_INT];
  str_to_intN(ns2, n2, N2_INT);

  mul_intN_intN(n1, n2, N2_INT);
  char rs2[2 * N_CHAR + 1];
  intN_to_str(n1, N2_INT, rs2);
  printf("%s\n", rs2);

// --------- mul

  printf("\n");
  printf("DIV FIRST\n");
  printf("-------------\n");

// --------- div1

  char ns3[N_CHAR + 1] = "10000000000000000000000000000000000000000000000000";
  str_to_intN(ns3, n2, N2_INT);

  div_intN_intN(n1, n2, N2_INT);
  intN_to_str(n1, N2_INT, rs2);
  printf("%s\n", rs2);
  intN_to_str(n2, N2_INT, rs2);
  printf("%s\n", rs2);

// --------- div1

  printf("\n");
  printf("DIV SECOND\n");
  printf("--------------\n");

// --------- div2

  char ns4[N_CHAR + 1] = "54321543215432154321543215432154321543215432154321";
  str_to_intN(ns4, n1, N2_INT);

  char ns5[N_CHAR + 1] = "12345123451234512345";
  str_to_intN(ns5, n2, N2_INT);

  div_intN_intN(n1, n2, N2_INT);
  intN_to_str(n1, N2_INT, rs2);
  printf("%s\n", rs2);
  intN_to_str(n2, N2_INT, rs2);
  printf("%s\n", rs2);

// --------- div2

  printf("\n");
  printf("SQRT FIRST\n");
  printf("----------------\n");

// --------- sqrt1

  char os1[N_CHAR + 1] = "123450000000000";
  int o1[N_INT];
  str_to_intN(os1, o1, N_INT);

  sqrt_intN(o1, N_INT);
  intN_to_str(o1, N_INT, rs1);
  printf("%s\n", rs1);

  printf("%f\n", sqrt(12345e10));

// --------- sqrt1

  printf("\n");
  printf("SQR SECOND\n");
  printf("-----------------\n");

// --------- sqrt2

  char os2[N_CHAR + 1] = "123450000000000000000000000000000000000000000";
  int o2[N_INT];
  str_to_intN(os2, o2, N_INT);

  sqrt_intN(o2, N_INT);
  intN_to_str(o2, N_INT, rs1);
  printf("%s\n", rs1);

  printf("%f\n", sqrt(12345e40));

// --------- sqrt2
}
