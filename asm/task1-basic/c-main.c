//***************************************************************************
//
// petr (basho) b.
//
//***************************************************************************

#include <stdio.h>

extern int asm_disc_a, asm_disc_b, asm_disc_c, asm_disc_d;

char c_strlen_str[200];
extern int asm_strlen_len;

char c_strrev1_str1[200];
char c_strrev1_str2[200];

char c_strrev2_str1[200];

extern int asm_multab_num;
extern int asm_multab_tab[];

extern int asm_divtwo_num;
extern int asm_divtwo_tab[];

extern int asm_faclist_tab[];

void print_header(const char* header)
{
  printf("--------------------------------------------------\n");
  printf("%s\n", header);
}

void print_c_header()
{
  printf("  C: ");extern int asm_multab_tab[];

}

void print_asm_header()
{
  printf("asm: ");
}

int c_disc(int a, int b, int c)
{
  return (b * b) - (4 * a * c);  
}

void print_discriminant(int a, int b, int c, int d)
{
  printf("D = %d*%d - 4*%d*%d = %d\n", b, b, a, c, d);
}

void discriminant(int a, int b, int c)
{
  int d;

  print_header("Function: Discriminant: D = b^2 - 4ac");
  
  d = c_disc(a, b, c);
  print_c_header();
  print_discriminant(a, b, c, d);

  asm_disc_a = a;
  asm_disc_b = b;
  asm_disc_c = c;
  asm_disc();
  print_asm_header();
  print_discriminant(asm_disc_a, asm_disc_b, asm_disc_c, asm_disc_d);
}

int c_strlen(char* str)
{
  return (int)strlen((const char*)str);
}

void print_strlen(char *str, int len)
{
  printf("String length '%s' = %d\n", str, len);
}

void stringlength(char* str)
{
  int len;

  print_header("Function: String length:");
  
  len = c_strlen(str);
  print_c_header();
  print_strlen(str, len);

  strcpy(c_strlen_str, str);
  asm_strlen();
  print_asm_header();
  print_strlen(c_strlen_str, asm_strlen_len);
}

void c_strrev1(char* desc, char* src)
{
  int len, i;

  len = c_strlen(src);
  for (i = 0; i < len; i++)
    desc[i] = src[len - 1 - i];
  desc[len] = 0;
}

void print_strrev1(char *str, char *str2)
{
  printf("Origin = '%s', Reverse = '%s'\n", str, str2);
}

void stringrevert1(char* str)
{
  char str2[200];

  print_header("Function: Reverse string to new string:");
  
  c_strrev1(str2, str);
  print_c_header();
  print_strrev1(str, str2);

  strcpy(c_strrev1_str1, str);
  asm_strrev1();
  print_asm_header();
  print_strrev1(c_strrev1_str1, c_strrev1_str2);
}

void c_strrev2(char* src)
{
  int len, cnt, i;
  char tmp;

  len = c_strlen(src);
  cnt = len / 2;
  for (i = 0; i < cnt; i++)
  {
    tmp = src[i];
    src[i] = src[len - 1 - i];
    src[len - 1 - i] = tmp;
  }
}

void print_strrev2(char *label, char *str)
{
  printf("%s = '%s'", label, str);
}

void stringrevert2(char* str)
{
  char c_str[200];

  print_header("Function: Reverse string to same string:");
  
  strcpy(c_str, str);
  print_c_header();
  print_strrev2("Origin", c_str);
  c_strrev2(c_str);
  print_strrev2(", Reverse", c_str);
  printf("\n");

  strcpy(c_strrev2_str1, str);
  print_asm_header();
  print_strrev2("Origin", c_strrev2_str1);
  asm_strrev2();
  print_strrev2(", Reverse", c_strrev2_str1);
  printf("\n");
}

void c_multab(int* table, int number)
{
  int i;

  for (i = 0; i < 10; i++)
    table[i] = (i + 1) * number;
}

void print_multab(int* table)
{
  int i;

  printf("%d", table[0]);
  for (i = 1; i < 10; i++)
    printf(", %d", table[i]);
  printf("\n");
}

void multab(int number)
{
  int tab[10];

  char header[200];
  sprintf(header, "Multiple of number [%d]:", number);
  print_header(header);
  
  c_multab(tab, number);
  print_c_header();
  print_multab(tab);

  asm_multab_num = number;
  asm_multab();
  print_asm_header();
  print_multab(asm_multab_tab);
}

void c_divtwo(int* table, int number)
{
  int i;

  for (i = 0; i < 32; i++)
    table[i] = 0;

  i = 0;
  while (number > 0)
  {
    table[i] = number;
    number = number / 2;
    i++;
  }
}

void print_divtwo(int* table)
{
  int i;

  printf("%d", table[0]);
  i = 1;
  while ((i < 32) && (table[i] > 0))
  {
    printf(", %d", table[i]);
    i++;
  }
  printf("\n");
}

void divtwo(int number)
{
  int tab[32];

  char header[200];
  sprintf(header, "Dividing number [%d] by 2:", number);
  print_header(header);
  
  c_divtwo(tab, number);
  print_c_header();
  print_divtwo(tab);

  asm_divtwo_num = number;
  asm_divtwo();
  print_asm_header();
  print_divtwo(asm_divtwo_tab);
}

void c_faclist(int* table)
{
  int i, n = 1;

  for (i = 0; i < 10; i++)
  {
    n = n * (i + 1);
    table[i] = n;
  }
}

void print_faclist(int* table)
{
  int i;

  printf("%d", table[0]);
  for (i = 1; i < 10; i++)
    printf(", %d", table[i]);
  printf("\n");
}

void faclist()
{
  int tab[10];

  print_header("Array of n!:");
  
  c_faclist(tab);
  print_c_header();
  print_faclist(tab);

  asm_faclist();
  print_asm_header();
  print_faclist(asm_faclist_tab);
}

int main()
{
  discriminant(2, 3, 4);
  stringlength("Assembler first");
  stringrevert1("Assembler second");
  stringrevert2("Assembler third");
  multab(3);
  divtwo(555555);
  faclist();
}
