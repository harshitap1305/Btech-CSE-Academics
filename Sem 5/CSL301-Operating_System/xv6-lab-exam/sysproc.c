#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

char helper(char ch)
{
   if(ch=='a') return 'A';
   if(ch=='b') return 'B';
   if(ch=='c') return 'C';
   if(ch=='d') return 'D';
   if(ch=='e') return 'E';
   if(ch=='f') return 'F';
   if(ch=='g') return 'G';
   if(ch=='h') return 'H';
   if(ch=='i') return 'I';
   if(ch=='j') return 'J';
   if(ch=='k') return 'K';
   if(ch=='l') return 'L';
   if(ch=='m') return 'M';
   if(ch=='n') return 'N';
   if(ch=='o') return 'O';
   if(ch=='p') return 'P';
   if(ch=='q') return 'Q';
   if(ch=='r') return 'R';
   if(ch=='s') return 'S';
   if(ch=='t') return 'T';
   if(ch=='u') return 'U';
   if(ch=='v') return 'V';
   if(ch=='w') return 'W';
   if(ch=='x') return 'X';
   if(ch=='y') return 'Y';
   return 'Z';
}
int
sys_toupper(void)
{
   char *str;
   int len,i;
   if(argstr(0,&str) < 0 || argint(1,&len)<0) 
   return -1;
   
   for(i=0;i<len;i++)
   {
     if((str[i] >= 'A' && str[i] <='Z') || str[i]==' ') continue;
     str[i]=helper(str[i]);
   }
   return 0;
} 
