#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>

#define SIZE 100
#define SEGMENT_SIZE 10
#define NUM_THREADS 11

typedef struct  {
   int *arr;
   int start;
} args;

void* partial_sum(void* arg)
{
    args* a=(args*) arg;
    int sum=0;
    
    for(int i=a->start; i<a->start + SEGMENT_SIZE; i++)
    {
       sum+=a->arr[i];
    }
    
    int *result=malloc(sizeof(int));
    *result=sum;
    return result;
}

void *final_sum(void* arg)
{
   int **partial=(int**)arg;
   int total=0;
  
   for(int i=0;i<10;i++)
      total+=*partial[i];
  
   int *result=malloc(sizeof(int));
   *result=total;
   return result;
}

int main() {
   int arr[SIZE];
   for(int i=0;i<SIZE;i++)
   {
      arr[i]=i+1;
   }
  
   pthread_t threads[NUM_THREADS];
   args arguments[10];
   int *partial_res[10];
  
   for(int i=0;i<10;i++)
   {
      arguments[i].arr=arr;
      arguments[i].start=i*SEGMENT_SIZE;
      pthread_create(&threads[i],NULL,partial_sum,&arguments[i]);
   }
  
   for(int i=0;i<10;i++)
   {
      pthread_join(threads[i],(void**)&partial_res[i]);
      printf("Thread %d partial sum: %d\n", i+1, *partial_res[i]);
   }
  
   pthread_create(&threads[10],NULL,final_sum,partial_res);
   
   int *total_sum;
   pthread_join(threads[10],(void**)&total_sum);
   
   printf("Total sum: %d\n", *total_sum);
   
   double avg=(double)(*total_sum)/SIZE;
   printf("Average: %.1f\n",avg);
   
   for(int i=0;i<10;i++)
   {
      free(partial_res[i]);
   }
   
   free(total_sum);
  

    return 0;
}
