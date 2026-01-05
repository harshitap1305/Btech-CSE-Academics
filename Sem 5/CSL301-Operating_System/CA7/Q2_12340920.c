#include<pthread.h>
#include<stdio.h>

void *print_id(void* arg){
int id=*(int*)arg;
printf("Thread %d running!\n",id);
return NULL;
}


int main(){
pthread_t tids[10];
pthread_t main_tid;

int ids[10];

for(int i=0;i<10;i++)
{
   ids[i]=i+1;
   pthread_create(&tids[i],NULL,print_id,&ids[i]);
}
for(int i=0;i<10;i++)
{
   pthread_join(tids[i],NULL);
}

printf("ALL THE THREADS ARE DONE!\n");

return 0;
}
