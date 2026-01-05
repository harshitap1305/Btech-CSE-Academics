#include<stdio.h>
#include<stdlib.h>

int main(){
 int *arr=(int*) malloc(10*sizeof(int));
 free(arr+5);
 return 0;
}
