#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>

int SEGMENT_SIZE;
int N;

typedef struct  {
   int *arr;
   int start;
} args;

int max(int a, int b) {
    return (a > b) ? a : b;
}


void* segment_max(void* arg)
{
    args* a=(args*) arg;
    int maxi=a->arr[a->start];
    
    for(int i=a->start+1; i<a->start + SEGMENT_SIZE; i++)
    {
       maxi=max(maxi,a->arr[i]);
    }
    
    int *result=malloc(sizeof(int));
    *result=maxi;
    return result;
}

void *overall_max(void* arg)
{
   int **segmentMax=(int**)arg;
   int maxi=*segmentMax[0];
  
   for(int i=1;i<N;i++)
    {
      maxi=max(maxi,*segmentMax[i]);
    }
  
   int *result=malloc(sizeof(int));
   *result=maxi;
   return result;
}

int main() {
   int arr[] = { 3, 5 ,232, 2, 32, 48, 9, 12, 34, 56, 34, 89, 21, 7, 51, 17};
   N=4;
   int SIZE=sizeof(arr)/sizeof(arr[0]);
   SEGMENT_SIZE=SIZE/N;
   
  
   pthread_t threads[N+1];
   args arguments[N];
   int *segmentMax[N];
  
   for(int i=0;i<N;i++)
   {
      arguments[i].arr=arr;
      arguments[i].start=i*SEGMENT_SIZE;
      pthread_create(&threads[i],NULL,segment_max,&arguments[i]);
   }
  
   for(int i=0;i<N;i++)
   {
      pthread_join(threads[i],(void**)&segmentMax[i]);
      printf("Thread %d max: %d\n", i+1, *segmentMax[i]);
   }
  
   pthread_create(&threads[N],NULL,overall_max,segmentMax);
   
   int *maxi;
   pthread_join(threads[N],(void**)&maxi);
   
   printf("Overall Max: %d\n", *maxi);
   
   for(int i=0;i<N;i++)
   {
      free(segmentMax[i]);
   }
   
   free(maxi);
  

    return 0;
}
