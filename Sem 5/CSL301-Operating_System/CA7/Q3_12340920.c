#include<pthread.h>
#include<stdio.h>
int counter=0;

void *func(void* arg){
for(int i=0;i<1000000;i++)
{ 
  counter+=1;
}
return NULL;
}


int main(){
pthread_t tids[10];

for(int i=0;i<10;i++)
{
   pthread_create(&tids[i],NULL,func,NULL);
}
for(int i=0;i<10;i++)
{
   pthread_join(tids[i],NULL);
}

printf("FINAL VALUE OF COUNTER IS: %d!\n",counter);

return 0;
}
