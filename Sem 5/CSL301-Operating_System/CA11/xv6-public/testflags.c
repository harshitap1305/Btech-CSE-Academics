#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
  // First set
  setflag(12340920);
  printf(1, "After first set: %d\n", getflag());

  // Second set
  setflag(12904321);
  printf(1, "After second set: %d\n", getflag());

  exit();
}

