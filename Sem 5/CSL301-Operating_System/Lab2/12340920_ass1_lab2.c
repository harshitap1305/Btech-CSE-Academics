#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
int main(){
 pid_t rc=fork();
 if(rc<0){
  fprintf(stderr, "fork failed\n");
  exit(1);
 }
 if(rc==0){
  //child process
  printf("Child process running 'ls':\n");
  execl("/bin/ls","ls","-l",NULL);
  perror("execl failed");
  exit(1);
 } else {
   wait(NULL);
   printf("Parent finished \n");
}
return 0;
}
