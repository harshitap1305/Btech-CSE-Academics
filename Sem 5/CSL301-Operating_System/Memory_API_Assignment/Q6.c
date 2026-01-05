#include<stdio.h>
#include<stdlib.h>

int main(){
 int *arr=(int*) malloc(10*sizeof(int));
 free(arr);
 printf("Value: %d\n",arr[0]);
 return 0;
}
