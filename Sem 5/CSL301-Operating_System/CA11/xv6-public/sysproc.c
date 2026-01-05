#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "procinfo.h"

extern pte_t* walkpgdir(pde_t *pgdir, const void *va, int alloc);

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

int 
sys_strrev(void) 
{
char *str;
int len, i;
if (argstr(0, &str) < 0 || argint(1, &len) < 0)
return -1;
// Simple in-place reversal
for (i = 0; i < len/2; i++) {
char tmp = str[i];
str[i] = str[len - i - 1];
str[len - i - 1] = tmp;
}
return 0;
}

int
sys_setflag(void)
{
  int val;
  if(argint(0, &val) < 0)
    return -1;

  myproc()->userflag = val;
  return 0;
}

int
sys_getflag(void)
{
  return myproc()->userflag;
}

int 
sys_getstats(void)
{
   int *user_stats_ptr;
   
   if(argptr(0,(void*)&user_stats_ptr, 2*sizeof(int))<0)
   return -1;
   struct proc *p = myproc();
   int kernel_stats[2];
   kernel_stats[0]=p->sched_count;
   kernel_stats[1]=p->run_ticks;
   
   if(copyout(p->pgdir, (uint)user_stats_ptr,(char*)kernel_stats,
         sizeof(kernel_stats))<0)
   return -1;
   return 0;
}

int
sys_get_proc_info(void)
{
  int pid;
  char *uaddr;                // pointer in user space
  struct proc_info info;

  if(argint(0, &pid) < 0)
    return -1;

  if(argptr(1, &uaddr, sizeof(info)) < 0)
    return -1;

  if(get_proc_info_kernel(pid, &info) < 0)
    return -1;

  if(copyout(myproc()->pgdir, (uint)uaddr, (char*)&info, sizeof(info)) < 0)
    return -1;

  return 0;
}

int sys_numvp(void) {
struct proc *p = myproc();
return (p->sz + PGSIZE - 1)/PGSIZE + 1;
}

int sys_numpp(void) {
struct proc *p = myproc();
pte_t *pte;
int count = 0;
for(uint a = 0; a < p->sz; a += PGSIZE){
pte = walkpgdir(p->pgdir, (void*)a, 0);
if(pte && (*pte & PTE_P)) count++;
}
return count;
}

int sys_getptsize(void) {
struct proc *p = myproc();
int count = 1; // outer page directory
for(int i=0;i<NPDENTRIES;i++)
if(p->pgdir[i] & PTE_P) count++;
return count;
}

int
sys_setpriority(void)
{
  int priority;
  if (argint(0, &priority) < 0)
    return -1;

  struct proc *cur = myproc();
  cur->priority = priority;
  return 0;
}

int sys_getpagefaults(void) {
struct proc *p = myproc();
return p->page_faults;
}

int
sys_twostrike(void)
{
  int enabled;
  if(argint(0, &enabled) < 0)
    return -1;

  struct proc *p = myproc();
  if(p == 0)
    return -1;

  if (enabled)
    p->twostrike_mode = 1;
  else {
    p->twostrike_mode = 0;
    p->strike_count = 0; // reset any existing strike count when disabled
  }

  return 0;
}

