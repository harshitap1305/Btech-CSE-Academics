// user/twostriketest.c
#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  printf(1, "Enabling two-strike mode. Spinning... try killing me with Ctrl+C\n");

  // Call the system call to enable the feature
  twostrike(1);

  // Busy loop forever
  while(1) {
    // busy wait
  }

  exit();
}

