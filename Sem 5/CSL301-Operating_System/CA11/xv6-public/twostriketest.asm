
_twostriketest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "Enabling two-strike mode. Spinning... try killing me with Ctrl+C\n");
  11:	68 18 07 00 00       	push   $0x718
  16:	6a 01                	push   $0x1
  18:	e8 f3 03 00 00       	call   410 <printf>

  // Call the system call to enable the feature
  twostrike(1);
  1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  24:	e8 3a 03 00 00       	call   363 <twostrike>
  29:	83 c4 10             	add    $0x10,%esp

  // Busy loop forever
  while(1) {
  2c:	eb fe                	jmp    2c <main+0x2c>
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 c0                	xor    %eax,%eax
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	83 c0 01             	add    $0x1,%eax
  4a:	84 d2                	test   %dl,%dl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  51:	89 c8                	mov    %ecx,%eax
  53:	c9                   	leave
  54:	c3                   	ret
  55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  5c:	00 
  5d:	8d 76 00             	lea    0x0(%esi),%esi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 17                	jne    88 <strcmp+0x28>
  71:	eb 3a                	jmp    ad <strcmp+0x4d>
  73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  7c:	83 c2 01             	add    $0x1,%edx
  7f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  82:	84 c0                	test   %al,%al
  84:	74 1a                	je     a0 <strcmp+0x40>
  86:	89 d9                	mov    %ebx,%ecx
  88:	0f b6 19             	movzbl (%ecx),%ebx
  8b:	38 c3                	cmp    %al,%bl
  8d:	74 e9                	je     78 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  8f:	29 d8                	sub    %ebx,%eax
}
  91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  94:	c9                   	leave
  95:	c3                   	ret
  96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9d:	00 
  9e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  a4:	31 c0                	xor    %eax,%eax
  a6:	29 d8                	sub    %ebx,%eax
}
  a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ab:	c9                   	leave
  ac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	31 c0                	xor    %eax,%eax
  b2:	eb db                	jmp    8f <strcmp+0x2f>
  b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bb:	00 
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000c0 <strlen>:

uint
strlen(const char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  c6:	80 3a 00             	cmpb   $0x0,(%edx)
  c9:	74 15                	je     e0 <strlen+0x20>
  cb:	31 c0                	xor    %eax,%eax
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	83 c0 01             	add    $0x1,%eax
  d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  d7:	89 c1                	mov    %eax,%ecx
  d9:	75 f5                	jne    d0 <strlen+0x10>
    ;
  return n;
}
  db:	89 c8                	mov    %ecx,%eax
  dd:	5d                   	pop    %ebp
  de:	c3                   	ret
  df:	90                   	nop
  for(n = 0; s[n]; n++)
  e0:	31 c9                	xor    %ecx,%ecx
}
  e2:	5d                   	pop    %ebp
  e3:	89 c8                	mov    %ecx,%eax
  e5:	c3                   	ret
  e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ed:	00 
  ee:	66 90                	xchg   %ax,%ax

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	8b 7d fc             	mov    -0x4(%ebp),%edi
 105:	89 d0                	mov    %edx,%eax
 107:	c9                   	leave
 108:	c3                   	ret
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	75 12                	jne    133 <strchr+0x23>
 121:	eb 1d                	jmp    140 <strchr+0x30>
 123:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 128:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 12c:	83 c0 01             	add    $0x1,%eax
 12f:	84 d2                	test   %dl,%dl
 131:	74 0d                	je     140 <strchr+0x30>
    if(*s == c)
 133:	38 d1                	cmp    %dl,%cl
 135:	75 f1                	jne    128 <strchr+0x18>
      return (char*)s;
  return 0;
}
 137:	5d                   	pop    %ebp
 138:	c3                   	ret
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 140:	31 c0                	xor    %eax,%eax
}
 142:	5d                   	pop    %ebp
 143:	c3                   	ret
 144:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14b:	00 
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 155:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 158:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 159:	31 db                	xor    %ebx,%ebx
{
 15b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 15e:	eb 27                	jmp    187 <gets+0x37>
    cc = read(0, &c, 1);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	56                   	push   %esi
 166:	6a 00                	push   $0x0
 168:	e8 1e 01 00 00       	call   28b <read>
    if(cc < 1)
 16d:	83 c4 10             	add    $0x10,%esp
 170:	85 c0                	test   %eax,%eax
 172:	7e 1d                	jle    191 <gets+0x41>
      break;
    buf[i++] = c;
 174:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 178:	8b 55 08             	mov    0x8(%ebp),%edx
 17b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 17f:	3c 0a                	cmp    $0xa,%al
 181:	74 10                	je     193 <gets+0x43>
 183:	3c 0d                	cmp    $0xd,%al
 185:	74 0c                	je     193 <gets+0x43>
  for(i=0; i+1 < max; ){
 187:	89 df                	mov    %ebx,%edi
 189:	83 c3 01             	add    $0x1,%ebx
 18c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 18f:	7c cf                	jl     160 <gets+0x10>
 191:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 19a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19d:	5b                   	pop    %ebx
 19e:	5e                   	pop    %esi
 19f:	5f                   	pop    %edi
 1a0:	5d                   	pop    %ebp
 1a1:	c3                   	ret
 1a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a9:	00 
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	push   0x8(%ebp)
 1bd:	e8 f1 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	push   0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 f4 00 00 00       	call   2cb <fstat>
  close(fd);
 1d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1da:	89 c6                	mov    %eax,%esi
  close(fd);
 1dc:	e8 ba 00 00 00       	call   29b <close>
  return r;
 1e1:	83 c4 10             	add    $0x10,%esp
}
 1e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e7:	89 f0                	mov    %esi,%eax
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb ed                	jmp    1e4 <stat+0x34>
 1f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fe:	00 
 1ff:	90                   	nop

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 20d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 210:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 215:	77 1e                	ja     235 <atoi+0x35>
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop
    n = n*10 + *s++ - '0';
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 226:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 22a:	0f be 02             	movsbl (%edx),%eax
 22d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 238:	89 c8                	mov    %ecx,%eax
 23a:	c9                   	leave
 23b:	c3                   	ret
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	8b 55 08             	mov    0x8(%ebp),%edx
 24a:	56                   	push   %esi
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25d:	00 
 25e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <strrev>:
SYSCALL(strrev)
 313:	b8 19 00 00 00       	mov    $0x19,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <setflag>:
SYSCALL(setflag)
 31b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <getflag>:
SYSCALL(getflag)
 323:	b8 1b 00 00 00       	mov    $0x1b,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <getstats>:
SYSCALL(getstats)
 32b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <get_proc_info>:
SYSCALL(get_proc_info)
 333:	b8 1d 00 00 00       	mov    $0x1d,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <numvp>:
SYSCALL(numvp)
 33b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <numpp>:
SYSCALL(numpp)
 343:	b8 1f 00 00 00       	mov    $0x1f,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <getptsize>:
SYSCALL(getptsize)
 34b:	b8 20 00 00 00       	mov    $0x20,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <setpriority>:
SYSCALL(setpriority)
 353:	b8 21 00 00 00       	mov    $0x21,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <getpagefaults>:
SYSCALL(getpagefaults)
 35b:	b8 22 00 00 00       	mov    $0x22,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <twostrike>:
SYSCALL(twostrike)
 363:	b8 23 00 00 00       	mov    $0x23,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	90                   	nop

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 378:	89 d1                	mov    %edx,%ecx
{
 37a:	83 ec 3c             	sub    $0x3c,%esp
 37d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 380:	85 d2                	test   %edx,%edx
 382:	0f 89 80 00 00 00    	jns    408 <printint+0x98>
 388:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 38c:	74 7a                	je     408 <printint+0x98>
    x = -xx;
 38e:	f7 d9                	neg    %ecx
    neg = 1;
 390:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 395:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 398:	31 f6                	xor    %esi,%esi
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3a0:	89 c8                	mov    %ecx,%eax
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	89 f7                	mov    %esi,%edi
 3a6:	f7 f3                	div    %ebx
 3a8:	8d 76 01             	lea    0x1(%esi),%esi
 3ab:	0f b6 92 bc 07 00 00 	movzbl 0x7bc(%edx),%edx
 3b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3b6:	89 ca                	mov    %ecx,%edx
 3b8:	89 c1                	mov    %eax,%ecx
 3ba:	39 da                	cmp    %ebx,%edx
 3bc:	73 e2                	jae    3a0 <printint+0x30>
  if(neg)
 3be:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c1:	85 c0                	test   %eax,%eax
 3c3:	74 07                	je     3cc <printint+0x5c>
    buf[i++] = '-';
 3c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 3ca:	89 f7                	mov    %esi,%edi
 3cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3cf:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3d2:	01 df                	add    %ebx,%edi
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 3d8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 3db:	83 ec 04             	sub    $0x4,%esp
 3de:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 3e4:	6a 01                	push   $0x1
 3e6:	50                   	push   %eax
 3e7:	56                   	push   %esi
 3e8:	e8 a6 fe ff ff       	call   293 <write>
  while(--i >= 0)
 3ed:	89 f8                	mov    %edi,%eax
 3ef:	83 c4 10             	add    $0x10,%esp
 3f2:	83 ef 01             	sub    $0x1,%edi
 3f5:	39 c3                	cmp    %eax,%ebx
 3f7:	75 df                	jne    3d8 <printint+0x68>
}
 3f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fc:	5b                   	pop    %ebx
 3fd:	5e                   	pop    %esi
 3fe:	5f                   	pop    %edi
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 408:	31 c0                	xor    %eax,%eax
 40a:	eb 89                	jmp    395 <printint+0x25>
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 41c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 41f:	0f b6 1e             	movzbl (%esi),%ebx
 422:	83 c6 01             	add    $0x1,%esi
 425:	84 db                	test   %bl,%bl
 427:	74 67                	je     490 <printf+0x80>
 429:	8d 4d 10             	lea    0x10(%ebp),%ecx
 42c:	31 d2                	xor    %edx,%edx
 42e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 431:	eb 34                	jmp    467 <printf+0x57>
 433:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 438:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 43b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 440:	83 f8 25             	cmp    $0x25,%eax
 443:	74 18                	je     45d <printf+0x4d>
  write(fd, &c, 1);
 445:	83 ec 04             	sub    $0x4,%esp
 448:	8d 45 e7             	lea    -0x19(%ebp),%eax
 44b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 44e:	6a 01                	push   $0x1
 450:	50                   	push   %eax
 451:	57                   	push   %edi
 452:	e8 3c fe ff ff       	call   293 <write>
 457:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 45a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 45d:	0f b6 1e             	movzbl (%esi),%ebx
 460:	83 c6 01             	add    $0x1,%esi
 463:	84 db                	test   %bl,%bl
 465:	74 29                	je     490 <printf+0x80>
    c = fmt[i] & 0xff;
 467:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 46a:	85 d2                	test   %edx,%edx
 46c:	74 ca                	je     438 <printf+0x28>
      }
    } else if(state == '%'){
 46e:	83 fa 25             	cmp    $0x25,%edx
 471:	75 ea                	jne    45d <printf+0x4d>
      if(c == 'd'){
 473:	83 f8 25             	cmp    $0x25,%eax
 476:	0f 84 04 01 00 00    	je     580 <printf+0x170>
 47c:	83 e8 63             	sub    $0x63,%eax
 47f:	83 f8 15             	cmp    $0x15,%eax
 482:	77 1c                	ja     4a0 <printf+0x90>
 484:	ff 24 85 64 07 00 00 	jmp    *0x764(,%eax,4)
 48b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 490:	8d 65 f4             	lea    -0xc(%ebp),%esp
 493:	5b                   	pop    %ebx
 494:	5e                   	pop    %esi
 495:	5f                   	pop    %edi
 496:	5d                   	pop    %ebp
 497:	c3                   	ret
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 
  write(fd, &c, 1);
 4a0:	83 ec 04             	sub    $0x4,%esp
 4a3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4aa:	6a 01                	push   $0x1
 4ac:	52                   	push   %edx
 4ad:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4b0:	57                   	push   %edi
 4b1:	e8 dd fd ff ff       	call   293 <write>
 4b6:	83 c4 0c             	add    $0xc,%esp
 4b9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4bc:	6a 01                	push   $0x1
 4be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4c1:	52                   	push   %edx
 4c2:	57                   	push   %edi
 4c3:	e8 cb fd ff ff       	call   293 <write>
        putc(fd, c);
 4c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4cb:	31 d2                	xor    %edx,%edx
 4cd:	eb 8e                	jmp    45d <printf+0x4d>
 4cf:	90                   	nop
        printint(fd, *ap, 16, 0);
 4d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4d3:	83 ec 0c             	sub    $0xc,%esp
 4d6:	b9 10 00 00 00       	mov    $0x10,%ecx
 4db:	8b 13                	mov    (%ebx),%edx
 4dd:	6a 00                	push   $0x0
 4df:	89 f8                	mov    %edi,%eax
        ap++;
 4e1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 4e4:	e8 87 fe ff ff       	call   370 <printint>
        ap++;
 4e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 4ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4ef:	31 d2                	xor    %edx,%edx
 4f1:	e9 67 ff ff ff       	jmp    45d <printf+0x4d>
        s = (char*)*ap;
 4f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4f9:	8b 18                	mov    (%eax),%ebx
        ap++;
 4fb:	83 c0 04             	add    $0x4,%eax
 4fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 501:	85 db                	test   %ebx,%ebx
 503:	0f 84 87 00 00 00    	je     590 <printf+0x180>
        while(*s != 0){
 509:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 50c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 50e:	84 c0                	test   %al,%al
 510:	0f 84 47 ff ff ff    	je     45d <printf+0x4d>
 516:	8d 55 e7             	lea    -0x19(%ebp),%edx
 519:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 51c:	89 de                	mov    %ebx,%esi
 51e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 526:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 529:	6a 01                	push   $0x1
 52b:	53                   	push   %ebx
 52c:	57                   	push   %edi
 52d:	e8 61 fd ff ff       	call   293 <write>
        while(*s != 0){
 532:	0f b6 06             	movzbl (%esi),%eax
 535:	83 c4 10             	add    $0x10,%esp
 538:	84 c0                	test   %al,%al
 53a:	75 e4                	jne    520 <printf+0x110>
      state = 0;
 53c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 53f:	31 d2                	xor    %edx,%edx
 541:	e9 17 ff ff ff       	jmp    45d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 546:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 549:	83 ec 0c             	sub    $0xc,%esp
 54c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 551:	8b 13                	mov    (%ebx),%edx
 553:	6a 01                	push   $0x1
 555:	eb 88                	jmp    4df <printf+0xcf>
        putc(fd, *ap);
 557:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 55a:	83 ec 04             	sub    $0x4,%esp
 55d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 560:	8b 03                	mov    (%ebx),%eax
        ap++;
 562:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 565:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 568:	6a 01                	push   $0x1
 56a:	52                   	push   %edx
 56b:	57                   	push   %edi
 56c:	e8 22 fd ff ff       	call   293 <write>
        ap++;
 571:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 574:	83 c4 10             	add    $0x10,%esp
      state = 0;
 577:	31 d2                	xor    %edx,%edx
 579:	e9 df fe ff ff       	jmp    45d <printf+0x4d>
 57e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	88 5d e7             	mov    %bl,-0x19(%ebp)
 586:	8d 55 e7             	lea    -0x19(%ebp),%edx
 589:	6a 01                	push   $0x1
 58b:	e9 31 ff ff ff       	jmp    4c1 <printf+0xb1>
 590:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 595:	bb 5a 07 00 00       	mov    $0x75a,%ebx
 59a:	e9 77 ff ff ff       	jmp    516 <printf+0x106>
 59f:	90                   	nop

000005a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a1:	a1 58 0a 00 00       	mov    0xa58,%eax
{
 5a6:	89 e5                	mov    %esp,%ebp
 5a8:	57                   	push   %edi
 5a9:	56                   	push   %esi
 5aa:	53                   	push   %ebx
 5ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ba:	39 c8                	cmp    %ecx,%eax
 5bc:	73 32                	jae    5f0 <free+0x50>
 5be:	39 d1                	cmp    %edx,%ecx
 5c0:	72 04                	jb     5c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c2:	39 d0                	cmp    %edx,%eax
 5c4:	72 32                	jb     5f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5cc:	39 fa                	cmp    %edi,%edx
 5ce:	74 30                	je     600 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5d3:	8b 50 04             	mov    0x4(%eax),%edx
 5d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5d9:	39 f1                	cmp    %esi,%ecx
 5db:	74 3a                	je     617 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5dd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5df:	5b                   	pop    %ebx
  freep = p;
 5e0:	a3 58 0a 00 00       	mov    %eax,0xa58
}
 5e5:	5e                   	pop    %esi
 5e6:	5f                   	pop    %edi
 5e7:	5d                   	pop    %ebp
 5e8:	c3                   	ret
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f0:	39 d0                	cmp    %edx,%eax
 5f2:	72 04                	jb     5f8 <free+0x58>
 5f4:	39 d1                	cmp    %edx,%ecx
 5f6:	72 ce                	jb     5c6 <free+0x26>
{
 5f8:	89 d0                	mov    %edx,%eax
 5fa:	eb bc                	jmp    5b8 <free+0x18>
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 600:	03 72 04             	add    0x4(%edx),%esi
 603:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 606:	8b 10                	mov    (%eax),%edx
 608:	8b 12                	mov    (%edx),%edx
 60a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 60d:	8b 50 04             	mov    0x4(%eax),%edx
 610:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 613:	39 f1                	cmp    %esi,%ecx
 615:	75 c6                	jne    5dd <free+0x3d>
    p->s.size += bp->s.size;
 617:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 61a:	a3 58 0a 00 00       	mov    %eax,0xa58
    p->s.size += bp->s.size;
 61f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 622:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 625:	89 08                	mov    %ecx,(%eax)
}
 627:	5b                   	pop    %ebx
 628:	5e                   	pop    %esi
 629:	5f                   	pop    %edi
 62a:	5d                   	pop    %ebp
 62b:	c3                   	ret
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 639:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 63c:	8b 15 58 0a 00 00    	mov    0xa58,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 642:	8d 78 07             	lea    0x7(%eax),%edi
 645:	c1 ef 03             	shr    $0x3,%edi
 648:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 64b:	85 d2                	test   %edx,%edx
 64d:	0f 84 8d 00 00 00    	je     6e0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 653:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 655:	8b 48 04             	mov    0x4(%eax),%ecx
 658:	39 f9                	cmp    %edi,%ecx
 65a:	73 64                	jae    6c0 <malloc+0x90>
  if(nu < 4096)
 65c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 661:	39 df                	cmp    %ebx,%edi
 663:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 666:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 66d:	eb 0a                	jmp    679 <malloc+0x49>
 66f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 670:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 672:	8b 48 04             	mov    0x4(%eax),%ecx
 675:	39 f9                	cmp    %edi,%ecx
 677:	73 47                	jae    6c0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 679:	89 c2                	mov    %eax,%edx
 67b:	3b 05 58 0a 00 00    	cmp    0xa58,%eax
 681:	75 ed                	jne    670 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 683:	83 ec 0c             	sub    $0xc,%esp
 686:	56                   	push   %esi
 687:	e8 6f fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 68c:	83 c4 10             	add    $0x10,%esp
 68f:	83 f8 ff             	cmp    $0xffffffff,%eax
 692:	74 1c                	je     6b0 <malloc+0x80>
  hp->s.size = nu;
 694:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 697:	83 ec 0c             	sub    $0xc,%esp
 69a:	83 c0 08             	add    $0x8,%eax
 69d:	50                   	push   %eax
 69e:	e8 fd fe ff ff       	call   5a0 <free>
  return freep;
 6a3:	8b 15 58 0a 00 00    	mov    0xa58,%edx
      if((p = morecore(nunits)) == 0)
 6a9:	83 c4 10             	add    $0x10,%esp
 6ac:	85 d2                	test   %edx,%edx
 6ae:	75 c0                	jne    670 <malloc+0x40>
        return 0;
  }
}
 6b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6b3:	31 c0                	xor    %eax,%eax
}
 6b5:	5b                   	pop    %ebx
 6b6:	5e                   	pop    %esi
 6b7:	5f                   	pop    %edi
 6b8:	5d                   	pop    %ebp
 6b9:	c3                   	ret
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 6c0:	39 cf                	cmp    %ecx,%edi
 6c2:	74 4c                	je     710 <malloc+0xe0>
        p->s.size -= nunits;
 6c4:	29 f9                	sub    %edi,%ecx
 6c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6cc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 6cf:	89 15 58 0a 00 00    	mov    %edx,0xa58
}
 6d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 6d8:	83 c0 08             	add    $0x8,%eax
}
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 6e0:	c7 05 58 0a 00 00 5c 	movl   $0xa5c,0xa58
 6e7:	0a 00 00 
    base.s.size = 0;
 6ea:	b8 5c 0a 00 00       	mov    $0xa5c,%eax
    base.s.ptr = freep = prevp = &base;
 6ef:	c7 05 5c 0a 00 00 5c 	movl   $0xa5c,0xa5c
 6f6:	0a 00 00 
    base.s.size = 0;
 6f9:	c7 05 60 0a 00 00 00 	movl   $0x0,0xa60
 700:	00 00 00 
    if(p->s.size >= nunits){
 703:	e9 54 ff ff ff       	jmp    65c <malloc+0x2c>
 708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 70f:	00 
        prevp->s.ptr = p->s.ptr;
 710:	8b 08                	mov    (%eax),%ecx
 712:	89 0a                	mov    %ecx,(%edx)
 714:	eb b9                	jmp    6cf <malloc+0x9f>
