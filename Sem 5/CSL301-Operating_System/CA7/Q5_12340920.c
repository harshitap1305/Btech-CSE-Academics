#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>
void *func(void* arg){
   int val=*(int*)arg;
   int* sq=malloc(sizeof(int));
   *sq=val*val;
   return sq;
}

int main(){

  int n;
  printf("Enter no. of threads:");
  scanf("%d",&n);
  pthread_t tids[n];
  int vals[n];
  printf("Enter the values for each thread:\n");
  
  for(int i=0;i<n;i++)
  {scanf("%d",&vals[i]);}
  
  for(int i=0;i<n;i++)
  {
    pthread_create(&tids[i],NULL,func,&vals[i]);
  }
   void* result;
   int ans[n];
    for(int i=0;i<n;i++)
  {
    pthread_join(tids[i],&result);
    ans[i]=*(int*)result;
    printf("Thread %d returned %d\n",i+1,ans[i]);
  }
  int sum=0;
  for(int i=0;i<n;i++)
  { sum+=ans[i];}
  
  printf("Sum is %d!\n", sum);

  return 0;
  
}
