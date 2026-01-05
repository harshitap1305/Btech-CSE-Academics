#include <stdio.h>

int main() {
    int *ptr = NULL;
    printf("Trying to dereference NULL...\n");
    int value = *ptr;   // Invalid access
    printf("Value: %d\n", value);
    return 0;
}

