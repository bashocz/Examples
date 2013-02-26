#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>

int cpp_bash(int argc, const char* argv[])
{
  if (argc == 0) // no argument
    return 0;

  pid_t pid;
  int status;
  
  int input_pipe[2];
  int output_pipe[2];

  int args = 1; // argument start index
  int arge = 1; // argument end index
  int cmdi = 0; // command index
  bool last_cmd = false; // flag if it is last command
  for (int i = 1; i < argc; i++)
  {
    if ((strcmp(argv[i], "I") == 0) || (i >= (argc - 1))) // pipe, or last argument
    {
      if (i >= (argc - 1))
	last_cmd = true;
		
      input_pipe[0] = output_pipe[0]; // output pipe of previous command is input pipe of next command
      input_pipe[1] = output_pipe[1]; // output pipe of previous command is input pipe of next command
      if (!last_cmd) // if it is not last command create output pipe
      {
        if (pipe(output_pipe) == -1)
        {
          perror("Error pipe()");
        }
      }
	  
      pid = fork(); // fork
      if (pid == -1)
      {
	perror("Error fork()");
      }
      else if (pid == 0) // it is child
      {
	arge = i; // argument end index
	if (!last_cmd) // if it is not last command connect to output pipe
	{
          close(output_pipe[0]);
	  dup2(output_pipe[1], 1);
	  close(output_pipe[1]);
	}
	else
	{
	  arge = argc; // argument end index
        }
		
	if (cmdi > 0) // if it is not first command connect to input pipe
	{
	  close(input_pipe[1]);
	  dup2(input_pipe[0], 0);
	  close(input_pipe[0]);
	}

	char* cmdv[arge - args + 1]; // command arguments
	for (int j = args; j < arge; j++)
	  cmdv[j - args] = (char*)argv[j];
	cmdv[arge - args] = NULL;
        execvp(cmdv[0], cmdv);

	exit(1);
      }
	  
      if (cmdi > 0) // if it is not first command close pipe
      {
        close(input_pipe[0]);
        close(input_pipe[1]);
      }
      cmdi++; // increment command index
      args = i + 1; // argument start index for next command
    }
  }  
  for (int i = 0; i < cmdi; i++)
  {
    wait(&status);
  }
}

int main(int argc, const char* argv[])
{
  printf("original c++ function\n");
  printf("-------------------\n");
  cpp_bash(argc, argv);
  printf("\n");
}
