#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

pthread_mutex_t *forks;   // Array of fork mutexes
int *eatCount;            // Track meals eaten
int n;                    // Number of philosophers

void* philosopher(void* arg) {
    int id = *(int*)arg;
    int left = id;
    int right = (id + 1) % n;

    for (int i = 0; i < 3; i++) {
        printf("Philosopher %d is thinking...\n", id);
        usleep(100000);

        // To avoid deadlock, always pick smaller fork ID first
        int first = left < right ? left : right;
        int second = left < right ? right : left;

        printf("Philosopher %d is hungry and trying forks %d and %d\n",
               id, first, second);

        pthread_mutex_lock(&forks[first]);
        printf("  Philosopher %d picked fork %d\n", id, first);

        usleep(50000);

        pthread_mutex_lock(&forks[second]);
        printf("  Philosopher %d picked fork %d\n", id, second);

        eatCount[id]++;
        printf("Philosopher %d is EATING (meal #%d)\n", id, eatCount[id]);
        usleep(200000);

        pthread_mutex_unlock(&forks[first]);
        pthread_mutex_unlock(&forks[second]);
        printf("  Philosopher %d put down both forks\n\n", id);
    }

    return NULL;
}

int main() {
    printf("Enter number of philosophers (n ≥ 2): ");
    scanf("%d", &n);

    if (n < 2) {
        printf("Number must be ≥ 2\n");
        return 0;
    }

    forks = malloc(n * sizeof(pthread_mutex_t));
    eatCount = malloc(n * sizeof(int));

    pthread_t *philosophers = malloc(n * sizeof(pthread_t));
    int *ids = malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        pthread_mutex_init(&forks[i], NULL);
        eatCount[i] = 0;
        ids[i] = i;
    }

    printf("\n=== DINING PHILOSOPHERS (Deadlock-Free) ===\n\n");

    for (int i = 0; i < n; i++) {
        pthread_create(&philosophers[i], NULL, philosopher, &ids[i]);
    }

    for (int i = 0; i < n; i++) {
        pthread_join(philosophers[i], NULL);
    }

    printf("\n========== MEAL COUNT ==========\n");
    for (int i = 0; i < n; i++) {
        printf("Philosopher %d ate %d times\n", i, eatCount[i]);
    }

    for (int i = 0; i < n; i++) {
        pthread_mutex_destroy(&forks[i]);
    }

    free(forks);
    free(eatCount);
    free(philosophers);
    free(ids);

    return 0;
}

