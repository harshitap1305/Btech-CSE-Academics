#include<pthread.h>
#include<stdio.h>

void *myfunc(void* arg){
   printf("Hello from thread!\n");
   return NULL;
}

int main(){

  pthread_t tid;
  pthread_create(&tid,NULL,myfunc,NULL);
  pthread_join(tid,NULL);
  printf("Thread finished!\n");
  //pthread_join(tid,NULL);
  return 0;
  
}
