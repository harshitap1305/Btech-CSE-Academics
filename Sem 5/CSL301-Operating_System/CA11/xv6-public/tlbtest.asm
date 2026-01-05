
_tlbtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define PAGESIZE 4096
#define MAXPAGES 1024

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  if (argc < 3) {
  14:	83 39 02             	cmpl   $0x2,(%ecx)
int main(int argc, char *argv[]) {
  17:	8b 59 04             	mov    0x4(%ecx),%ebx
  if (argc < 3) {
  1a:	7f 13                	jg     2f <main+0x2f>
    printf(1,"Usage: tlbtest <numpages> <trials>\n");
  1c:	57                   	push   %edi
  1d:	57                   	push   %edi
  1e:	68 38 08 00 00       	push   $0x838
  23:	6a 01                	push   $0x1
  25:	e8 06 05 00 00       	call   530 <printf>
    exit();
  2a:	e8 64 03 00 00       	call   393 <exit>
  }

  int numpages = atoi(argv[1]);
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	ff 73 04             	push   0x4(%ebx)
  35:	e8 e6 02 00 00       	call   320 <atoi>
  int trials = atoi(argv[2]);
  3a:	5e                   	pop    %esi
  3b:	ff 73 08             	push   0x8(%ebx)
  int numpages = atoi(argv[1]);
  3e:	89 c7                	mov    %eax,%edi
  40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int trials = atoi(argv[2]);
  43:	e8 d8 02 00 00       	call   320 <atoi>

  if (numpages < 1 || numpages > MAXPAGES) {
  48:	83 c4 10             	add    $0x10,%esp
  int trials = atoi(argv[2]);
  4b:	89 c6                	mov    %eax,%esi
  if (numpages < 1 || numpages > MAXPAGES) {
  4d:	8d 47 ff             	lea    -0x1(%edi),%eax
  50:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  55:	76 17                	jbe    6e <main+0x6e>
    printf(1,"numpages out of range (1..%d)\n", MAXPAGES);
  57:	53                   	push   %ebx
  58:	68 00 04 00 00       	push   $0x400
  5d:	68 5c 08 00 00       	push   $0x85c
  62:	6a 01                	push   $0x1
  64:	e8 c7 04 00 00       	call   530 <printf>
    exit();
  69:	e8 25 03 00 00       	call   393 <exit>

  int jump = PAGESIZE / sizeof(int);
  int i, t;

  // Dynamically allocate pages using sbrk()
  int *arr = (int *) sbrk(numpages * PAGESIZE);
  6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  71:	83 ec 0c             	sub    $0xc,%esp
  74:	c1 e0 0c             	shl    $0xc,%eax
  77:	50                   	push   %eax
  78:	e8 9e 03 00 00       	call   41b <sbrk>
  if (arr == (void*) -1) {
  7d:	83 c4 10             	add    $0x10,%esp
  int *arr = (int *) sbrk(numpages * PAGESIZE);
  80:	89 c3                	mov    %eax,%ebx
  if (arr == (void*) -1) {
  82:	83 f8 ff             	cmp    $0xffffffff,%eax
  85:	0f 84 ac 00 00 00    	je     137 <main+0x137>
    printf(1,"sbrk failed for %d pages\n", numpages);
    exit();
  }

  // Get page fault count before test
  int pf_before = getpagefaults();
  8b:	e8 eb 03 00 00       	call   47b <getpagefaults>
  90:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // Start timing
  uint start_ticks = uptime();
  93:	e8 93 03 00 00       	call   42b <uptime>
  98:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Access pages to trigger lazy allocation page faults
  for (t = 0; t < trials; t++) {
  9b:	85 f6                	test   %esi,%esi
  9d:	7e 5d                	jle    fc <main+0xfc>
    for (i = 0; i < (numpages / 2) * jump; i += jump) {
  9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for (t = 0; t < trials; t++) {
  a2:	31 ff                	xor    %edi,%edi
    for (i = 0; i < (numpages / 2) * jump; i += jump) {
  a4:	d1 f8                	sar    $1,%eax
  a6:	89 c2                	mov    %eax,%edx
  a8:	c1 e2 0a             	shl    $0xa,%edx
  ab:	85 c0                	test   %eax,%eax
  ad:	74 7f                	je     12e <main+0x12e>
  af:	90                   	nop
  b0:	8d 42 ff             	lea    -0x1(%edx),%eax
      arr[i] += 1;   // first access of each page triggers a page fault
  b3:	83 03 01             	addl   $0x1,(%ebx)
  b6:	c1 e8 0a             	shr    $0xa,%eax
  b9:	83 e0 01             	and    $0x1,%eax
  bc:	89 c1                	mov    %eax,%ecx
    for (i = 0; i < (numpages / 2) * jump; i += jump) {
  be:	b8 00 04 00 00       	mov    $0x400,%eax
  c3:	39 d0                	cmp    %edx,%eax
  c5:	7d 2e                	jge    f5 <main+0xf5>
  c7:	85 c9                	test   %ecx,%ecx
  c9:	74 15                	je     e0 <main+0xe0>
  cb:	b8 00 08 00 00       	mov    $0x800,%eax
      arr[i] += 1;   // first access of each page triggers a page fault
  d0:	83 83 00 10 00 00 01 	addl   $0x1,0x1000(%ebx)
    for (i = 0; i < (numpages / 2) * jump; i += jump) {
  d7:	39 d0                	cmp    %edx,%eax
  d9:	7d 1a                	jge    f5 <main+0xf5>
  db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      arr[i] += 1;   // first access of each page triggers a page fault
  e0:	83 04 83 01          	addl   $0x1,(%ebx,%eax,4)
  e4:	83 84 83 00 10 00 00 	addl   $0x1,0x1000(%ebx,%eax,4)
  eb:	01 
    for (i = 0; i < (numpages / 2) * jump; i += jump) {
  ec:	05 00 08 00 00       	add    $0x800,%eax
  f1:	39 d0                	cmp    %edx,%eax
  f3:	7c eb                	jl     e0 <main+0xe0>
  for (t = 0; t < trials; t++) {
  f5:	83 c7 01             	add    $0x1,%edi
  f8:	39 fe                	cmp    %edi,%esi
  fa:	75 b4                	jne    b0 <main+0xb0>
    }
  }

  // End timing
  uint end_ticks = uptime();
  fc:	e8 2a 03 00 00       	call   42b <uptime>
 101:	89 c3                	mov    %eax,%ebx

  // Get page fault count after test
  int pf_after = getpagefaults();
 103:	e8 73 03 00 00       	call   47b <getpagefaults>

  printf(1,"Pages: %d\tTrials: %d\tTicks: %d\tPageFaults: %d\n",
 108:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 10b:	52                   	push   %edx
 10c:	29 c8                	sub    %ecx,%eax
 10e:	52                   	push   %edx
 10f:	50                   	push   %eax
 110:	8b 45 dc             	mov    -0x24(%ebp),%eax
 113:	29 c3                	sub    %eax,%ebx
 115:	53                   	push   %ebx
 116:	56                   	push   %esi
 117:	ff 75 e4             	push   -0x1c(%ebp)
 11a:	68 7c 08 00 00       	push   $0x87c
 11f:	6a 01                	push   $0x1
 121:	e8 0a 04 00 00       	call   530 <printf>
    numpages, trials, end_ticks - start_ticks, pf_after - pf_before);

  exit();
 126:	83 c4 20             	add    $0x20,%esp
 129:	e8 65 02 00 00       	call   393 <exit>
  for (t = 0; t < trials; t++) {
 12e:	83 c7 01             	add    $0x1,%edi
 131:	39 fe                	cmp    %edi,%esi
 133:	75 f9                	jne    12e <main+0x12e>
 135:	eb c5                	jmp    fc <main+0xfc>
    printf(1,"sbrk failed for %d pages\n", numpages);
 137:	51                   	push   %ecx
 138:	ff 75 e4             	push   -0x1c(%ebp)
 13b:	68 ab 08 00 00       	push   $0x8ab
 140:	6a 01                	push   $0x1
 142:	e8 e9 03 00 00       	call   530 <printf>
    exit();
 147:	e8 47 02 00 00       	call   393 <exit>
 14c:	66 90                	xchg   %ax,%ax
 14e:	66 90                	xchg   %ax,%ax

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 150:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 151:	31 c0                	xor    %eax,%eax
{
 153:	89 e5                	mov    %esp,%ebp
 155:	53                   	push   %ebx
 156:	8b 4d 08             	mov    0x8(%ebp),%ecx
 159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 160:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 164:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 167:	83 c0 01             	add    $0x1,%eax
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 16e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 171:	89 c8                	mov    %ecx,%eax
 173:	c9                   	leave
 174:	c3                   	ret
 175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17c:	00 
 17d:	8d 76 00             	lea    0x0(%esi),%esi

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 55 08             	mov    0x8(%ebp),%edx
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 18a:	0f b6 02             	movzbl (%edx),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 17                	jne    1a8 <strcmp+0x28>
 191:	eb 3a                	jmp    1cd <strcmp+0x4d>
 193:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 198:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 19c:	83 c2 01             	add    $0x1,%edx
 19f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1a2:	84 c0                	test   %al,%al
 1a4:	74 1a                	je     1c0 <strcmp+0x40>
 1a6:	89 d9                	mov    %ebx,%ecx
 1a8:	0f b6 19             	movzbl (%ecx),%ebx
 1ab:	38 c3                	cmp    %al,%bl
 1ad:	74 e9                	je     198 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1af:	29 d8                	sub    %ebx,%eax
}
 1b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1b4:	c9                   	leave
 1b5:	c3                   	ret
 1b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bd:	00 
 1be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1c4:	31 c0                	xor    %eax,%eax
 1c6:	29 d8                	sub    %ebx,%eax
}
 1c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1cb:	c9                   	leave
 1cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1cd:	0f b6 19             	movzbl (%ecx),%ebx
 1d0:	31 c0                	xor    %eax,%eax
 1d2:	eb db                	jmp    1af <strcmp+0x2f>
 1d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1db:	00 
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1e6:	80 3a 00             	cmpb   $0x0,(%edx)
 1e9:	74 15                	je     200 <strlen+0x20>
 1eb:	31 c0                	xor    %eax,%eax
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1f7:	89 c1                	mov    %eax,%ecx
 1f9:	75 f5                	jne    1f0 <strlen+0x10>
    ;
  return n;
}
 1fb:	89 c8                	mov    %ecx,%eax
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret
 1ff:	90                   	nop
  for(n = 0; s[n]; n++)
 200:	31 c9                	xor    %ecx,%ecx
}
 202:	5d                   	pop    %ebp
 203:	89 c8                	mov    %ecx,%eax
 205:	c3                   	ret
 206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20d:	00 
 20e:	66 90                	xchg   %ax,%ax

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	8b 7d fc             	mov    -0x4(%ebp),%edi
 225:	89 d0                	mov    %edx,%eax
 227:	c9                   	leave
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 23a:	0f b6 10             	movzbl (%eax),%edx
 23d:	84 d2                	test   %dl,%dl
 23f:	75 12                	jne    253 <strchr+0x23>
 241:	eb 1d                	jmp    260 <strchr+0x30>
 243:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 248:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 24c:	83 c0 01             	add    $0x1,%eax
 24f:	84 d2                	test   %dl,%dl
 251:	74 0d                	je     260 <strchr+0x30>
    if(*s == c)
 253:	38 d1                	cmp    %dl,%cl
 255:	75 f1                	jne    248 <strchr+0x18>
      return (char*)s;
  return 0;
}
 257:	5d                   	pop    %ebp
 258:	c3                   	ret
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 260:	31 c0                	xor    %eax,%eax
}
 262:	5d                   	pop    %ebp
 263:	c3                   	ret
 264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26b:	00 
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 275:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 278:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 279:	31 db                	xor    %ebx,%ebx
{
 27b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 27e:	eb 27                	jmp    2a7 <gets+0x37>
    cc = read(0, &c, 1);
 280:	83 ec 04             	sub    $0x4,%esp
 283:	6a 01                	push   $0x1
 285:	56                   	push   %esi
 286:	6a 00                	push   $0x0
 288:	e8 1e 01 00 00       	call   3ab <read>
    if(cc < 1)
 28d:	83 c4 10             	add    $0x10,%esp
 290:	85 c0                	test   %eax,%eax
 292:	7e 1d                	jle    2b1 <gets+0x41>
      break;
    buf[i++] = c;
 294:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 29f:	3c 0a                	cmp    $0xa,%al
 2a1:	74 10                	je     2b3 <gets+0x43>
 2a3:	3c 0d                	cmp    $0xd,%al
 2a5:	74 0c                	je     2b3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2a7:	89 df                	mov    %ebx,%edi
 2a9:	83 c3 01             	add    $0x1,%ebx
 2ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2af:	7c cf                	jl     280 <gets+0x10>
 2b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2bd:	5b                   	pop    %ebx
 2be:	5e                   	pop    %esi
 2bf:	5f                   	pop    %edi
 2c0:	5d                   	pop    %ebp
 2c1:	c3                   	ret
 2c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2c9:	00 
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	push   0x8(%ebp)
 2dd:	e8 f1 00 00 00       	call   3d3 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	push   0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f4 00 00 00       	call   3eb <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 ba 00 00 00       	call   3bb <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 02             	movsbl (%edx),%eax
 32a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 32d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 330:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 335:	77 1e                	ja     355 <atoi+0x35>
 337:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33e:	00 
 33f:	90                   	nop
    n = n*10 + *s++ - '0';
 340:	83 c2 01             	add    $0x1,%edx
 343:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 346:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 34a:	0f be 02             	movsbl (%edx),%eax
 34d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 358:	89 c8                	mov    %ecx,%eax
 35a:	c9                   	leave
 35b:	c3                   	ret
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	8b 45 10             	mov    0x10(%ebp),%eax
 367:	8b 55 08             	mov    0x8(%ebp),%edx
 36a:	56                   	push   %esi
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 c0                	test   %eax,%eax
 370:	7e 13                	jle    385 <memmove+0x25>
 372:	01 d0                	add    %edx,%eax
  dst = vdst;
 374:	89 d7                	mov    %edx,%edi
 376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37d:	00 
 37e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 381:	39 f8                	cmp    %edi,%eax
 383:	75 fb                	jne    380 <memmove+0x20>
  return vdst;
}
 385:	5e                   	pop    %esi
 386:	89 d0                	mov    %edx,%eax
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret

0000038b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38b:	b8 01 00 00 00       	mov    $0x1,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <exit>:
SYSCALL(exit)
 393:	b8 02 00 00 00       	mov    $0x2,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <wait>:
SYSCALL(wait)
 39b:	b8 03 00 00 00       	mov    $0x3,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <pipe>:
SYSCALL(pipe)
 3a3:	b8 04 00 00 00       	mov    $0x4,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <read>:
SYSCALL(read)
 3ab:	b8 05 00 00 00       	mov    $0x5,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <write>:
SYSCALL(write)
 3b3:	b8 10 00 00 00       	mov    $0x10,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <close>:
SYSCALL(close)
 3bb:	b8 15 00 00 00       	mov    $0x15,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <kill>:
SYSCALL(kill)
 3c3:	b8 06 00 00 00       	mov    $0x6,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <exec>:
SYSCALL(exec)
 3cb:	b8 07 00 00 00       	mov    $0x7,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <open>:
SYSCALL(open)
 3d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <mknod>:
SYSCALL(mknod)
 3db:	b8 11 00 00 00       	mov    $0x11,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <unlink>:
SYSCALL(unlink)
 3e3:	b8 12 00 00 00       	mov    $0x12,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <fstat>:
SYSCALL(fstat)
 3eb:	b8 08 00 00 00       	mov    $0x8,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <link>:
SYSCALL(link)
 3f3:	b8 13 00 00 00       	mov    $0x13,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <mkdir>:
SYSCALL(mkdir)
 3fb:	b8 14 00 00 00       	mov    $0x14,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <chdir>:
SYSCALL(chdir)
 403:	b8 09 00 00 00       	mov    $0x9,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <dup>:
SYSCALL(dup)
 40b:	b8 0a 00 00 00       	mov    $0xa,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <getpid>:
SYSCALL(getpid)
 413:	b8 0b 00 00 00       	mov    $0xb,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <sbrk>:
SYSCALL(sbrk)
 41b:	b8 0c 00 00 00       	mov    $0xc,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <sleep>:
SYSCALL(sleep)
 423:	b8 0d 00 00 00       	mov    $0xd,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <uptime>:
SYSCALL(uptime)
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <strrev>:
SYSCALL(strrev)
 433:	b8 19 00 00 00       	mov    $0x19,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <setflag>:
SYSCALL(setflag)
 43b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <getflag>:
SYSCALL(getflag)
 443:	b8 1b 00 00 00       	mov    $0x1b,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <getstats>:
SYSCALL(getstats)
 44b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <get_proc_info>:
SYSCALL(get_proc_info)
 453:	b8 1d 00 00 00       	mov    $0x1d,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <numvp>:
SYSCALL(numvp)
 45b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <numpp>:
SYSCALL(numpp)
 463:	b8 1f 00 00 00       	mov    $0x1f,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <getptsize>:
SYSCALL(getptsize)
 46b:	b8 20 00 00 00       	mov    $0x20,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <setpriority>:
SYSCALL(setpriority)
 473:	b8 21 00 00 00       	mov    $0x21,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <getpagefaults>:
SYSCALL(getpagefaults)
 47b:	b8 22 00 00 00       	mov    $0x22,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <twostrike>:
SYSCALL(twostrike)
 483:	b8 23 00 00 00       	mov    $0x23,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 498:	89 d1                	mov    %edx,%ecx
{
 49a:	83 ec 3c             	sub    $0x3c,%esp
 49d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 4a0:	85 d2                	test   %edx,%edx
 4a2:	0f 89 80 00 00 00    	jns    528 <printint+0x98>
 4a8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ac:	74 7a                	je     528 <printint+0x98>
    x = -xx;
 4ae:	f7 d9                	neg    %ecx
    neg = 1;
 4b0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4b5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4b8:	31 f6                	xor    %esi,%esi
 4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 f7                	mov    %esi,%edi
 4c6:	f7 f3                	div    %ebx
 4c8:	8d 76 01             	lea    0x1(%esi),%esi
 4cb:	0f b6 92 24 09 00 00 	movzbl 0x924(%edx),%edx
 4d2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4d6:	89 ca                	mov    %ecx,%edx
 4d8:	89 c1                	mov    %eax,%ecx
 4da:	39 da                	cmp    %ebx,%edx
 4dc:	73 e2                	jae    4c0 <printint+0x30>
  if(neg)
 4de:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4e1:	85 c0                	test   %eax,%eax
 4e3:	74 07                	je     4ec <printint+0x5c>
    buf[i++] = '-';
 4e5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 4ea:	89 f7                	mov    %esi,%edi
 4ec:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4ef:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4f2:	01 df                	add    %ebx,%edi
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4f8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4fb:	83 ec 04             	sub    $0x4,%esp
 4fe:	88 45 d7             	mov    %al,-0x29(%ebp)
 501:	8d 45 d7             	lea    -0x29(%ebp),%eax
 504:	6a 01                	push   $0x1
 506:	50                   	push   %eax
 507:	56                   	push   %esi
 508:	e8 a6 fe ff ff       	call   3b3 <write>
  while(--i >= 0)
 50d:	89 f8                	mov    %edi,%eax
 50f:	83 c4 10             	add    $0x10,%esp
 512:	83 ef 01             	sub    $0x1,%edi
 515:	39 c3                	cmp    %eax,%ebx
 517:	75 df                	jne    4f8 <printint+0x68>
}
 519:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51c:	5b                   	pop    %ebx
 51d:	5e                   	pop    %esi
 51e:	5f                   	pop    %edi
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 528:	31 c0                	xor    %eax,%eax
 52a:	eb 89                	jmp    4b5 <printint+0x25>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 539:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 53c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 53f:	0f b6 1e             	movzbl (%esi),%ebx
 542:	83 c6 01             	add    $0x1,%esi
 545:	84 db                	test   %bl,%bl
 547:	74 67                	je     5b0 <printf+0x80>
 549:	8d 4d 10             	lea    0x10(%ebp),%ecx
 54c:	31 d2                	xor    %edx,%edx
 54e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 551:	eb 34                	jmp    587 <printf+0x57>
 553:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 558:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 55b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 560:	83 f8 25             	cmp    $0x25,%eax
 563:	74 18                	je     57d <printf+0x4d>
  write(fd, &c, 1);
 565:	83 ec 04             	sub    $0x4,%esp
 568:	8d 45 e7             	lea    -0x19(%ebp),%eax
 56b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 56e:	6a 01                	push   $0x1
 570:	50                   	push   %eax
 571:	57                   	push   %edi
 572:	e8 3c fe ff ff       	call   3b3 <write>
 577:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 57a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 57d:	0f b6 1e             	movzbl (%esi),%ebx
 580:	83 c6 01             	add    $0x1,%esi
 583:	84 db                	test   %bl,%bl
 585:	74 29                	je     5b0 <printf+0x80>
    c = fmt[i] & 0xff;
 587:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 58a:	85 d2                	test   %edx,%edx
 58c:	74 ca                	je     558 <printf+0x28>
      }
    } else if(state == '%'){
 58e:	83 fa 25             	cmp    $0x25,%edx
 591:	75 ea                	jne    57d <printf+0x4d>
      if(c == 'd'){
 593:	83 f8 25             	cmp    $0x25,%eax
 596:	0f 84 04 01 00 00    	je     6a0 <printf+0x170>
 59c:	83 e8 63             	sub    $0x63,%eax
 59f:	83 f8 15             	cmp    $0x15,%eax
 5a2:	77 1c                	ja     5c0 <printf+0x90>
 5a4:	ff 24 85 cc 08 00 00 	jmp    *0x8cc(,%eax,4)
 5ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b3:	5b                   	pop    %ebx
 5b4:	5e                   	pop    %esi
 5b5:	5f                   	pop    %edi
 5b6:	5d                   	pop    %ebp
 5b7:	c3                   	ret
 5b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5bf:	00 
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ca:	6a 01                	push   $0x1
 5cc:	52                   	push   %edx
 5cd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5d0:	57                   	push   %edi
 5d1:	e8 dd fd ff ff       	call   3b3 <write>
 5d6:	83 c4 0c             	add    $0xc,%esp
 5d9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5dc:	6a 01                	push   $0x1
 5de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5e1:	52                   	push   %edx
 5e2:	57                   	push   %edi
 5e3:	e8 cb fd ff ff       	call   3b3 <write>
        putc(fd, c);
 5e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5eb:	31 d2                	xor    %edx,%edx
 5ed:	eb 8e                	jmp    57d <printf+0x4d>
 5ef:	90                   	nop
        printint(fd, *ap, 16, 0);
 5f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5f3:	83 ec 0c             	sub    $0xc,%esp
 5f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5fb:	8b 13                	mov    (%ebx),%edx
 5fd:	6a 00                	push   $0x0
 5ff:	89 f8                	mov    %edi,%eax
        ap++;
 601:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 604:	e8 87 fe ff ff       	call   490 <printint>
        ap++;
 609:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 60c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 60f:	31 d2                	xor    %edx,%edx
 611:	e9 67 ff ff ff       	jmp    57d <printf+0x4d>
        s = (char*)*ap;
 616:	8b 45 d0             	mov    -0x30(%ebp),%eax
 619:	8b 18                	mov    (%eax),%ebx
        ap++;
 61b:	83 c0 04             	add    $0x4,%eax
 61e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 621:	85 db                	test   %ebx,%ebx
 623:	0f 84 87 00 00 00    	je     6b0 <printf+0x180>
        while(*s != 0){
 629:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 62c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 62e:	84 c0                	test   %al,%al
 630:	0f 84 47 ff ff ff    	je     57d <printf+0x4d>
 636:	8d 55 e7             	lea    -0x19(%ebp),%edx
 639:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63c:	89 de                	mov    %ebx,%esi
 63e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 640:	83 ec 04             	sub    $0x4,%esp
 643:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 646:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 649:	6a 01                	push   $0x1
 64b:	53                   	push   %ebx
 64c:	57                   	push   %edi
 64d:	e8 61 fd ff ff       	call   3b3 <write>
        while(*s != 0){
 652:	0f b6 06             	movzbl (%esi),%eax
 655:	83 c4 10             	add    $0x10,%esp
 658:	84 c0                	test   %al,%al
 65a:	75 e4                	jne    640 <printf+0x110>
      state = 0;
 65c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 65f:	31 d2                	xor    %edx,%edx
 661:	e9 17 ff ff ff       	jmp    57d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 666:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 669:	83 ec 0c             	sub    $0xc,%esp
 66c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 671:	8b 13                	mov    (%ebx),%edx
 673:	6a 01                	push   $0x1
 675:	eb 88                	jmp    5ff <printf+0xcf>
        putc(fd, *ap);
 677:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 67a:	83 ec 04             	sub    $0x4,%esp
 67d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 680:	8b 03                	mov    (%ebx),%eax
        ap++;
 682:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 685:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 688:	6a 01                	push   $0x1
 68a:	52                   	push   %edx
 68b:	57                   	push   %edi
 68c:	e8 22 fd ff ff       	call   3b3 <write>
        ap++;
 691:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 694:	83 c4 10             	add    $0x10,%esp
      state = 0;
 697:	31 d2                	xor    %edx,%edx
 699:	e9 df fe ff ff       	jmp    57d <printf+0x4d>
 69e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6a6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6a9:	6a 01                	push   $0x1
 6ab:	e9 31 ff ff ff       	jmp    5e1 <printf+0xb1>
 6b0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6b5:	bb c5 08 00 00       	mov    $0x8c5,%ebx
 6ba:	e9 77 ff ff ff       	jmp    636 <printf+0x106>
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 cc 0b 00 00       	mov    0xbcc,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6da:	39 c8                	cmp    %ecx,%eax
 6dc:	73 32                	jae    710 <free+0x50>
 6de:	39 d1                	cmp    %edx,%ecx
 6e0:	72 04                	jb     6e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	39 d0                	cmp    %edx,%eax
 6e4:	72 32                	jb     718 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ec:	39 fa                	cmp    %edi,%edx
 6ee:	74 30                	je     720 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6f3:	8b 50 04             	mov    0x4(%eax),%edx
 6f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f9:	39 f1                	cmp    %esi,%ecx
 6fb:	74 3a                	je     737 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6fd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6ff:	5b                   	pop    %ebx
  freep = p;
 700:	a3 cc 0b 00 00       	mov    %eax,0xbcc
}
 705:	5e                   	pop    %esi
 706:	5f                   	pop    %edi
 707:	5d                   	pop    %ebp
 708:	c3                   	ret
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 710:	39 d0                	cmp    %edx,%eax
 712:	72 04                	jb     718 <free+0x58>
 714:	39 d1                	cmp    %edx,%ecx
 716:	72 ce                	jb     6e6 <free+0x26>
{
 718:	89 d0                	mov    %edx,%eax
 71a:	eb bc                	jmp    6d8 <free+0x18>
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 720:	03 72 04             	add    0x4(%edx),%esi
 723:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 726:	8b 10                	mov    (%eax),%edx
 728:	8b 12                	mov    (%edx),%edx
 72a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72d:	8b 50 04             	mov    0x4(%eax),%edx
 730:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 733:	39 f1                	cmp    %esi,%ecx
 735:	75 c6                	jne    6fd <free+0x3d>
    p->s.size += bp->s.size;
 737:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 73a:	a3 cc 0b 00 00       	mov    %eax,0xbcc
    p->s.size += bp->s.size;
 73f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 742:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 745:	89 08                	mov    %ecx,(%eax)
}
 747:	5b                   	pop    %ebx
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 15 cc 0b 00 00    	mov    0xbcc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 78 07             	lea    0x7(%eax),%edi
 765:	c1 ef 03             	shr    $0x3,%edi
 768:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 76b:	85 d2                	test   %edx,%edx
 76d:	0f 84 8d 00 00 00    	je     800 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 773:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 775:	8b 48 04             	mov    0x4(%eax),%ecx
 778:	39 f9                	cmp    %edi,%ecx
 77a:	73 64                	jae    7e0 <malloc+0x90>
  if(nu < 4096)
 77c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 781:	39 df                	cmp    %ebx,%edi
 783:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 786:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 78d:	eb 0a                	jmp    799 <malloc+0x49>
 78f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 792:	8b 48 04             	mov    0x4(%eax),%ecx
 795:	39 f9                	cmp    %edi,%ecx
 797:	73 47                	jae    7e0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 799:	89 c2                	mov    %eax,%edx
 79b:	3b 05 cc 0b 00 00    	cmp    0xbcc,%eax
 7a1:	75 ed                	jne    790 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7a3:	83 ec 0c             	sub    $0xc,%esp
 7a6:	56                   	push   %esi
 7a7:	e8 6f fc ff ff       	call   41b <sbrk>
  if(p == (char*)-1)
 7ac:	83 c4 10             	add    $0x10,%esp
 7af:	83 f8 ff             	cmp    $0xffffffff,%eax
 7b2:	74 1c                	je     7d0 <malloc+0x80>
  hp->s.size = nu;
 7b4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7b7:	83 ec 0c             	sub    $0xc,%esp
 7ba:	83 c0 08             	add    $0x8,%eax
 7bd:	50                   	push   %eax
 7be:	e8 fd fe ff ff       	call   6c0 <free>
  return freep;
 7c3:	8b 15 cc 0b 00 00    	mov    0xbcc,%edx
      if((p = morecore(nunits)) == 0)
 7c9:	83 c4 10             	add    $0x10,%esp
 7cc:	85 d2                	test   %edx,%edx
 7ce:	75 c0                	jne    790 <malloc+0x40>
        return 0;
  }
}
 7d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7d3:	31 c0                	xor    %eax,%eax
}
 7d5:	5b                   	pop    %ebx
 7d6:	5e                   	pop    %esi
 7d7:	5f                   	pop    %edi
 7d8:	5d                   	pop    %ebp
 7d9:	c3                   	ret
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7e0:	39 cf                	cmp    %ecx,%edi
 7e2:	74 4c                	je     830 <malloc+0xe0>
        p->s.size -= nunits;
 7e4:	29 f9                	sub    %edi,%ecx
 7e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7ec:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7ef:	89 15 cc 0b 00 00    	mov    %edx,0xbcc
}
 7f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7f8:	83 c0 08             	add    $0x8,%eax
}
 7fb:	5b                   	pop    %ebx
 7fc:	5e                   	pop    %esi
 7fd:	5f                   	pop    %edi
 7fe:	5d                   	pop    %ebp
 7ff:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 800:	c7 05 cc 0b 00 00 d0 	movl   $0xbd0,0xbcc
 807:	0b 00 00 
    base.s.size = 0;
 80a:	b8 d0 0b 00 00       	mov    $0xbd0,%eax
    base.s.ptr = freep = prevp = &base;
 80f:	c7 05 d0 0b 00 00 d0 	movl   $0xbd0,0xbd0
 816:	0b 00 00 
    base.s.size = 0;
 819:	c7 05 d4 0b 00 00 00 	movl   $0x0,0xbd4
 820:	00 00 00 
    if(p->s.size >= nunits){
 823:	e9 54 ff ff ff       	jmp    77c <malloc+0x2c>
 828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 82f:	00 
        prevp->s.ptr = p->s.ptr;
 830:	8b 08                	mov    (%eax),%ecx
 832:	89 0a                	mov    %ecx,(%edx)
 834:	eb b9                	jmp    7ef <malloc+0x9f>
