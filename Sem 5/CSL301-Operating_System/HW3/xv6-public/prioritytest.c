// prioritytest.c
#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  int pids[5];
  int priorities[5] = {5, 15, 25, 35, 45}; // assign priorities of your choice

  printf(1, "Starting priority scheduling test with 5 processes...\n");

  for (int i = 0; i < 5; i++) {
    pids[i] = fork();
    if (pids[i] == 0) {
      // Child process
      setpriority(priorities[i]);
      printf(1, "Child %d (pid %d) started with priority %d\n",
             i+1, getpid(), priorities[i]);

      // Busy loop to simulate CPU work
      for (volatile int j = 0; j < 50000000; j++) {}

      printf(1, "Child %d (pid %d) finished.\n", i+1, getpid());
      exit();
    }
  }

  // Parent waits for all children
  for (int i = 0; i < 5; i++) {
    wait();
  }

  printf(1, "Priority scheduling test with 5 processes complete.\n");
  exit();
}

