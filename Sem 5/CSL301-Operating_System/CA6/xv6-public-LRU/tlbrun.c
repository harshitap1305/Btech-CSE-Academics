#include "types.h"
#include "user.h"

#define PAGESIZE 4096
#define MAXPAGES 1024

int main(int argc, char *argv[]) {
  int jump = PAGESIZE / sizeof(int);   // stride so that each access jumps a page
  int i, t;

  printf(1,"PageCount\tTrials\tTicks\tPageFaults\n");

  // test with 1, 2, 4, 8, ..., MAXPAGES
  for (int numpages = 1; numpages <= MAXPAGES; numpages *= 2) {
    int trials = 5000000;

    // page faults before run
    int faults_before = getpagefaults();
    uint start = uptime();

    // allocate numpages * 4096 bytes
    int *arr = (int *) sbrk(numpages * PAGESIZE);
    if (arr == (void *) -1) {
      printf(1,"sbrk failed for %d pages\n", numpages);
      exit();
    }

    // access half of the allocated pages repeatedly
    for (t = 0; t < trials; t++) {
      for (i = 0; i < (numpages / 2) * jump; i += jump) {
        arr[i] += 1;   // this "touch" causes page faults on first access
      }
    }

    uint end = uptime();
    int faults_after = getpagefaults();

    // report results
    printf(1,"%d\t\t%d\t%d\t%d\n",
      numpages,
      trials,
      end - start,
      faults_after - faults_before
    );
  }

  exit();
}

