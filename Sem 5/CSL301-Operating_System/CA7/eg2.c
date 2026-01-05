#include<pthread.h>
#include<stdio.h>

void *print_id(void* arg){
int id=*(int*)arg;
printf("Thread ID: %d\n",id);
return NULL;
}

int main(){
pthread_t tid;
int myid=92;
pthread_create(&tid,NULL,print_id,&myid);
pthread_join(tid,NULL);
printf("Thread finished!\n");
//pthread_join(tid,NULL);
return 0;
}
