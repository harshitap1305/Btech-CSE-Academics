#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t child1, child2;

    child1 = fork();
    if (child1 < 0) {
        perror("fork #1 failed");
        exit(1);
    }
    if (child1 == 0) {
        printf("First Child: PID=%d, PPID=%d, I am first child.\n", getpid(), getppid());
        exit(0);
    }
    wait(NULL);
    child2 = fork();
    if (child2 < 0) {
        perror("fork #2 failed");
        exit(1);
    }
    if (child2 == 0) {
        printf("Second Child: PID=%d, PPID=%d, I am second child.\n", getpid(), getppid());
        exit(0);
    }
    wait(NULL);

    printf("Parent: PID=%d, PPID=%d, I am Harshita Patidar.\n", getpid(), getppid());
    printf("Total number of processes: 3 (1 parent + 2 children)\n");

    return 0;
}


