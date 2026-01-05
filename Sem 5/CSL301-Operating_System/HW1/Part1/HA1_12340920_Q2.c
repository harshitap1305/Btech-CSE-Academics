#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
int main() {
    pid_t pid1, pid2;
    pid1 = fork();  //First
    pid2 = fork();  //Second

    printf("PID: %d, Parent PID: %d\n", getpid(), getppid());
    while (wait(NULL) > 0);
  return 0;
}

