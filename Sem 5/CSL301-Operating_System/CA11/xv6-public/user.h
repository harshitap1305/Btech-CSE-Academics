struct stat;
struct rtcdate;
struct procstats{
  int sched_count;
  int run_ticks;
};
struct proc_info {
  int    pid;
  char   name[16];
  char   state[16];
  uint sz;
};
// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int strrev(char *, int);
int setflag(int);
int getflag(void);
int getstats(int *stats_array);
int get_proc_info(int pid, struct proc_info *info);
int numvp(void);
int numpp(void);
int getptsize(void);
int setpriority(int);
int getpagefaults(void);
int twostrike(int enabled);

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
