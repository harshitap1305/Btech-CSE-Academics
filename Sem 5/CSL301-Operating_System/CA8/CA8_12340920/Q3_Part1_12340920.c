#include <stdio.h>
#include <pthread.h>

int counter = 0;

void* increment(void* arg) 
{
  for(int i = 0; i < 100000; i++) 
  {
    counter = counter + 1;
  }
  return NULL;
}

int main() 
{
  pthread_t t[10];

  for(int i=0;i<10;i++)
  {
    pthread_create(&t[i], NULL, increment, NULL);
  }
  
    for(int i=0;i<10;i++)
    {
      pthread_join(t[i], NULL);
    }
    
    printf("Final value of counter = %d\n",counter);
  
  return 0;
}
