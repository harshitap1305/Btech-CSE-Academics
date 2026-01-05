#include<pthread.h>
#include<stdio.h>

int global_var;

void *print_add(void* arg){
int thread_local;
int id=*(int*)arg;
printf("Thread ID: %d and it's local address: %p, global add = %p\n",id,(void*)&thread_local, (void*)&global_var);
return NULL;
}

int main(){
int main_local;
pthread_t tid1;
pthread_t tid2;
int id1=1,id2=2;

pthread_create(&tid1,NULL,print_add,&id1);
pthread_create(&tid2,NULL,print_add,&id2);

pthread_join(tid1,NULL);
pthread_join(tid2,NULL);

printf("Main: Local add=%p, global add =%p\n",(void*)&main_local, (void*)&global_var);

return 0;
}
