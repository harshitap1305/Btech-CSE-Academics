#include<stdio.h>
#include<string.h>
#include<ctype.h>
#include <stdlib.h>
#include<stdbool.h>
bool isKey(char* s)
{
  if(strcmp(s,"foreach")==0 || strcmp(s,"echo")==0 || strcmp(s,"read")==0) return true;
  return false;
}
 
bool isIdentifier(char *s)
{
   int size=strlen(s);
   if(size<2) return false;
   
   if(s[0]!='_') return false;
   if(!isdigit(s[size-1])) return false;
   
   for(int i=1;i<size-1;i++)
   {
      if(!islower(s[i])) return false;
   }
   return true;
}

int main(int argc,char* argv[])
{
  if(argc!=2)
  {
    printf("Number of arguments not equal to two");
    return -1;
  }
  FILE *fp=fopen(argv[1],"r");
  if(!fp)
  {
    perror("Error opening file");
    return -1;
  }
  
  char word[100];
  printf("ALL THE KEYWORDS ARE: \n");
  while (fscanf(fp,"%s",word)==1)
  {
    if(isKey(word))
    {
      printf("%s\n", word); 
      
    }
  }
  rewind(fp);
   printf("ALL THE IDETIFIERS ARE: \n");
  while (fscanf(fp,"%s",word)==1)
  {
    if(isIdentifier(word))
    {
      printf("%s\n", word); 
    
    }
  }
  
  fclose(fp);
}
