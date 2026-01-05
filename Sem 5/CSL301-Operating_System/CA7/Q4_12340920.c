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

  pthread_t tid;
  int n=10;
  void* result;
  pthread_create(&tid,NULL,func,&n);
  pthread_join(tid,&result);
  printf("Square of n=%d is %d!\n", n, *(int*)result);

  return 0;
  
}
