//***************************************************************************
//
// petr (basho) b.
//
//***************************************************************************

#include <stdio.h>

#define N_CHAR 50
#define N_INT (((N_CHAR - 2) * 10) / 3 / 32) + 1

long long add_int64_int64(long long a, long long b);
long long mul_int64_int64(long long a, long long b);
long long div_int64_int32(long long a, int b);

void add_intN_int32(int* x, int N, int y); // x = x + y
void mul_intN_int32(int* x, int N, int y); // x = x * y
int div_intN_int32(int* x, int N, int z); // x = x / z

void zero_intN(int *n, int N)
{
  int i;
  for (i = 0; i < N; i++)
    n[i] = 0;
}

int is_zero_intN(int *n, int N)
{
  int i;
  for (i = 0; i < N; i++)
    if (n[i])
      return 0;
  return 1;
}

void intN_to_hex(int *n, int N, char *s)
{
  int i;
  for (i = 0; i < N; i++, s+=8)
    sprintf(s, "%08X", n[N - i - 1]);
  s = 0;
}

void str_to_intN(char *s, int *n, int N)
{
  zero_intN(n, N);
  int i = 0;
  while (s[i])
  {
    mul_intN_int32(n, N, 10);
    add_intN_int32(n, N, s[i] - '0');
    i++;
  }
}

void intN_to_str(int *n, int N, char *s)
{
  int nn[N_INT], i;
  for (i = 0; i < N; i++)
    nn[i] = n[i];

  i = 0;
  while (!is_zero_intN(nn, N))
  {
    s[i] = (char)div_intN_int32(nn, N, 10) + '0';
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

int main()
{
  // number with 50 digits
  char numChr[N_CHAR + 1] = "12345678901234567890123456789012345678901234567890";
  int numInt[N_INT];
  char numStr[N_CHAR + 1];

  str_to_intN(numChr, numInt, N_INT);

  intN_to_hex(numInt, N_INT, numStr);
  printf("Number in hexadecimal system:\n%s\n\n", numStr);

  intN_to_str(numInt, N_INT, numStr);
  printf("Number in decimal system:\n%s\n\n", numStr);

  printf("Number in binary system (low first):\n");
  int i;
  for (i = 0; i < N_INT; i++)
    printf("%d, ", numInt[i]);
  printf("\n");
}
