#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>

extern int asm_bash(int argc, const char* argv[]);

int main(int argc, const char* argv[])
{
  printf("overwritten asm function\n");
  printf("-------------------\n");
  asm_bash(argc, argv);
  printf("\n");
}
