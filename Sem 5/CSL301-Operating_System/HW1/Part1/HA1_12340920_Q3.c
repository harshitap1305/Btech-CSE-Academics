#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <string.h>
int main() {
    int fd = open("output.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        perror("open failed");
        return 1;
    }
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork failed");
        return 1;
    } else if (pid == 0) {
        const char *msg="Roll Number: 12340920\n";
        write(fd, msg, strlen(msg));
        printf("Child: wrote roll number to file output.txt.\n");
    } else {
        const char *msg="Name: Harshita Patidar\n";
        write(fd, msg,strlen(msg));
        printf("Parent: wrote name to file.\n");
        wait(NULL);
    }

    close(fd);
    return 0;
}

