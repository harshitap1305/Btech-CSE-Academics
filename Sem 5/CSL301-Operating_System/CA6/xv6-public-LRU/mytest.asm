
_mytest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define MAX_PAGES 5
#define TOTAL_ACCESSES 15

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi

  printf(1, "Starting LRU page replacement simulation...\n");

  int accesses[TOTAL_ACCESSES] = {0,1,2,3,4,1,5,0,6,1,2,7,3,8,4};

  for (i = 0; i < TOTAL_ACCESSES; i++) {
   f:	31 f6                	xor    %esi,%esi
int main(int argc, char *argv[]) {
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	81 ec 90 00 00 00    	sub    $0x90,%esp
    lru[i] = -1;
  19:	c7 45 84 ff ff ff ff 	movl   $0xffffffff,-0x7c(%ebp)
  printf(1, "Starting LRU page replacement simulation...\n");
  20:	68 d8 08 00 00       	push   $0x8d8
  25:	6a 01                	push   $0x1
    last_used[i] = -1;
  27:	c7 45 98 ff ff ff ff 	movl   $0xffffffff,-0x68(%ebp)
    lru[i] = -1;
  2e:	c7 45 88 ff ff ff ff 	movl   $0xffffffff,-0x78(%ebp)
    last_used[i] = -1;
  35:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%ebp)
    lru[i] = -1;
  3c:	c7 45 8c ff ff ff ff 	movl   $0xffffffff,-0x74(%ebp)
    last_used[i] = -1;
  43:	c7 45 a0 ff ff ff ff 	movl   $0xffffffff,-0x60(%ebp)
    lru[i] = -1;
  4a:	c7 45 90 ff ff ff ff 	movl   $0xffffffff,-0x70(%ebp)
    last_used[i] = -1;
  51:	c7 45 a4 ff ff ff ff 	movl   $0xffffffff,-0x5c(%ebp)
    lru[i] = -1;
  58:	c7 45 94 ff ff ff ff 	movl   $0xffffffff,-0x6c(%ebp)
    last_used[i] = -1;
  5f:	c7 45 a8 ff ff ff ff 	movl   $0xffffffff,-0x58(%ebp)
  printf(1, "Starting LRU page replacement simulation...\n");
  66:	e8 65 05 00 00       	call   5d0 <printf>
  int accesses[TOTAL_ACCESSES] = {0,1,2,3,4,1,5,0,6,1,2,7,3,8,4};
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)
  75:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
  7c:	c7 45 b4 02 00 00 00 	movl   $0x2,-0x4c(%ebp)
  83:	c7 45 b8 03 00 00 00 	movl   $0x3,-0x48(%ebp)
  8a:	c7 45 bc 04 00 00 00 	movl   $0x4,-0x44(%ebp)
  91:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  98:	c7 45 c4 05 00 00 00 	movl   $0x5,-0x3c(%ebp)
  9f:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  a6:	c7 45 cc 06 00 00 00 	movl   $0x6,-0x34(%ebp)
  ad:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  b4:	c7 45 d4 02 00 00 00 	movl   $0x2,-0x2c(%ebp)
  bb:	c7 45 d8 07 00 00 00 	movl   $0x7,-0x28(%ebp)
  c2:	c7 45 dc 03 00 00 00 	movl   $0x3,-0x24(%ebp)
  c9:	c7 45 e0 08 00 00 00 	movl   $0x8,-0x20(%ebp)
  d0:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%ebp)
  int i, j, page, hit = 0, miss = 0, time = 0;
  d7:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
  de:	00 00 00 
  e1:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
  e8:	00 00 00 
  eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    page = accesses[i];
  f0:	8b 5c b5 ac          	mov    -0x54(%ebp,%esi,4),%ebx
    time++;

    int found = 0;
    for (j = 0; j < MAX_PAGES; j++) {
  f4:	31 c0                	xor    %eax,%eax
    time++;
  f6:	83 c6 01             	add    $0x1,%esi
      if (lru[j] == page) {
  f9:	39 5c 85 84          	cmp    %ebx,-0x7c(%ebp,%eax,4)
  fd:	0f 84 c5 00 00 00    	je     1c8 <main+0x1c8>
    for (j = 0; j < MAX_PAGES; j++) {
 103:	83 c0 01             	add    $0x1,%eax
 106:	83 f8 05             	cmp    $0x5,%eax
 109:	75 ee                	jne    f9 <main+0xf9>
      hit++;
      printf(1, "Access page %d: HIT\n", page);
    } else {
      miss++;
      int replaced = -1;
      for (j = 0; j < MAX_PAGES; j++) {
 10b:	31 c0                	xor    %eax,%eax
        if (lru[j] == -1) {
 10d:	83 7c 85 84 ff       	cmpl   $0xffffffff,-0x7c(%ebp,%eax,4)
 112:	0f 84 90 00 00 00    	je     1a8 <main+0x1a8>
      for (j = 0; j < MAX_PAGES; j++) {
 118:	83 c0 01             	add    $0x1,%eax
 11b:	83 f8 05             	cmp    $0x5,%eax
 11e:	75 ed                	jne    10d <main+0x10d>
          replaced = j;
          break;
        }
      }
      if (replaced == -1) {
        int lru_index = 0, min_time = last_used[0];
 120:	8b 4d 98             	mov    -0x68(%ebp),%ecx
 123:	31 ff                	xor    %edi,%edi
        for (j = 1; j < MAX_PAGES; j++) {
 125:	b8 01 00 00 00       	mov    $0x1,%eax
          if (last_used[j] < min_time) {
 12a:	8b 54 85 98          	mov    -0x68(%ebp,%eax,4),%edx
 12e:	39 d1                	cmp    %edx,%ecx
 130:	7e 04                	jle    136 <main+0x136>
            min_time = last_used[j];
 132:	89 d1                	mov    %edx,%ecx
            lru_index = j;
 134:	89 c7                	mov    %eax,%edi
        for (j = 1; j < MAX_PAGES; j++) {
 136:	83 c0 01             	add    $0x1,%eax
 139:	83 f8 05             	cmp    $0x5,%eax
 13c:	75 ec                	jne    12a <main+0x12a>
          }
        }
        printf(1, "Access page %d: MISS, replacing page %d\n", page, lru[lru_index]);
 13e:	ff 74 bd 84          	push   -0x7c(%ebp,%edi,4)
 142:	53                   	push   %ebx
 143:	68 34 09 00 00       	push   $0x934
 148:	6a 01                	push   $0x1
 14a:	e8 81 04 00 00       	call   5d0 <printf>
        lru[lru_index] = page;
 14f:	89 5c bd 84          	mov    %ebx,-0x7c(%ebp,%edi,4)
        last_used[lru_index] = time;
 153:	83 c4 10             	add    $0x10,%esp
 156:	89 74 bd 98          	mov    %esi,-0x68(%ebp,%edi,4)
      miss++;
 15a:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
  for (i = 0; i < TOTAL_ACCESSES; i++) {
 161:	83 fe 0f             	cmp    $0xf,%esi
 164:	75 8a                	jne    f0 <main+0xf0>
        printf(1, "Access page %d: MISS, placed in free frame\n", page);
      }
    }
  }

  printf(1, "LRU simulation completed.\n");
 166:	83 ec 08             	sub    $0x8,%esp
 169:	68 72 09 00 00       	push   $0x972
 16e:	6a 01                	push   $0x1
 170:	e8 5b 04 00 00       	call   5d0 <printf>
  printf(1, "Total hits: %d\n", hit);
 175:	83 c4 0c             	add    $0xc,%esp
 178:	ff b5 70 ff ff ff    	push   -0x90(%ebp)
 17e:	68 8d 09 00 00       	push   $0x98d
 183:	6a 01                	push   $0x1
 185:	e8 46 04 00 00       	call   5d0 <printf>
  printf(1, "Total misses: %d\n", miss);
 18a:	83 c4 0c             	add    $0xc,%esp
 18d:	ff b5 74 ff ff ff    	push   -0x8c(%ebp)
 193:	68 9d 09 00 00       	push   $0x99d
 198:	6a 01                	push   $0x1
 19a:	e8 31 04 00 00       	call   5d0 <printf>

  exit();
 19f:	e8 8f 02 00 00       	call   433 <exit>
 1a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "Access page %d: MISS, placed in free frame\n", page);
 1a8:	83 ec 04             	sub    $0x4,%esp
          lru[j] = page;
 1ab:	89 5c 85 84          	mov    %ebx,-0x7c(%ebp,%eax,4)
        printf(1, "Access page %d: MISS, placed in free frame\n", page);
 1af:	53                   	push   %ebx
 1b0:	68 08 09 00 00       	push   $0x908
 1b5:	6a 01                	push   $0x1
          last_used[j] = time;
 1b7:	89 74 85 98          	mov    %esi,-0x68(%ebp,%eax,4)
        printf(1, "Access page %d: MISS, placed in free frame\n", page);
 1bb:	e8 10 04 00 00       	call   5d0 <printf>
 1c0:	83 c4 10             	add    $0x10,%esp
 1c3:	eb 95                	jmp    15a <main+0x15a>
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "Access page %d: HIT\n", page);
 1c8:	83 ec 04             	sub    $0x4,%esp
      hit++;
 1cb:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
      printf(1, "Access page %d: HIT\n", page);
 1d2:	53                   	push   %ebx
 1d3:	68 5d 09 00 00       	push   $0x95d
 1d8:	6a 01                	push   $0x1
        last_used[j] = time;
 1da:	89 74 85 98          	mov    %esi,-0x68(%ebp,%eax,4)
      printf(1, "Access page %d: HIT\n", page);
 1de:	e8 ed 03 00 00       	call   5d0 <printf>
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	e9 76 ff ff ff       	jmp    161 <main+0x161>
 1eb:	66 90                	xchg   %ax,%ax
 1ed:	66 90                	xchg   %ax,%ax
 1ef:	90                   	nop

000001f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1f1:	31 c0                	xor    %eax,%eax
{
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	53                   	push   %ebx
 1f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 200:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 204:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 207:	83 c0 01             	add    $0x1,%eax
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strcpy+0x10>
    ;
  return os;
}
 20e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 211:	89 c8                	mov    %ecx,%eax
 213:	c9                   	leave
 214:	c3                   	ret
 215:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21c:	00 
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
 227:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 22a:	0f b6 02             	movzbl (%edx),%eax
 22d:	84 c0                	test   %al,%al
 22f:	75 17                	jne    248 <strcmp+0x28>
 231:	eb 3a                	jmp    26d <strcmp+0x4d>
 233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 238:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 23c:	83 c2 01             	add    $0x1,%edx
 23f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 242:	84 c0                	test   %al,%al
 244:	74 1a                	je     260 <strcmp+0x40>
 246:	89 d9                	mov    %ebx,%ecx
 248:	0f b6 19             	movzbl (%ecx),%ebx
 24b:	38 c3                	cmp    %al,%bl
 24d:	74 e9                	je     238 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 24f:	29 d8                	sub    %ebx,%eax
}
 251:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 254:	c9                   	leave
 255:	c3                   	ret
 256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25d:	00 
 25e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 260:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 264:	31 c0                	xor    %eax,%eax
 266:	29 d8                	sub    %ebx,%eax
}
 268:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 26b:	c9                   	leave
 26c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 26d:	0f b6 19             	movzbl (%ecx),%ebx
 270:	31 c0                	xor    %eax,%eax
 272:	eb db                	jmp    24f <strcmp+0x2f>
 274:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27b:	00 
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <strlen>:

uint
strlen(const char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 286:	80 3a 00             	cmpb   $0x0,(%edx)
 289:	74 15                	je     2a0 <strlen+0x20>
 28b:	31 c0                	xor    %eax,%eax
 28d:	8d 76 00             	lea    0x0(%esi),%esi
 290:	83 c0 01             	add    $0x1,%eax
 293:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 297:	89 c1                	mov    %eax,%ecx
 299:	75 f5                	jne    290 <strlen+0x10>
    ;
  return n;
}
 29b:	89 c8                	mov    %ecx,%eax
 29d:	5d                   	pop    %ebp
 29e:	c3                   	ret
 29f:	90                   	nop
  for(n = 0; s[n]; n++)
 2a0:	31 c9                	xor    %ecx,%ecx
}
 2a2:	5d                   	pop    %ebp
 2a3:	89 c8                	mov    %ecx,%eax
 2a5:	c3                   	ret
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bd:	89 d7                	mov    %edx,%edi
 2bf:	fc                   	cld
 2c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2c5:	89 d0                	mov    %edx,%eax
 2c7:	c9                   	leave
 2c8:	c3                   	ret
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 45 08             	mov    0x8(%ebp),%eax
 2d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2da:	0f b6 10             	movzbl (%eax),%edx
 2dd:	84 d2                	test   %dl,%dl
 2df:	75 12                	jne    2f3 <strchr+0x23>
 2e1:	eb 1d                	jmp    300 <strchr+0x30>
 2e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2ec:	83 c0 01             	add    $0x1,%eax
 2ef:	84 d2                	test   %dl,%dl
 2f1:	74 0d                	je     300 <strchr+0x30>
    if(*s == c)
 2f3:	38 d1                	cmp    %dl,%cl
 2f5:	75 f1                	jne    2e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2f7:	5d                   	pop    %ebp
 2f8:	c3                   	ret
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 300:	31 c0                	xor    %eax,%eax
}
 302:	5d                   	pop    %ebp
 303:	c3                   	ret
 304:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30b:	00 
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <gets>:

char*
gets(char *buf, int max)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 315:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 318:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 319:	31 db                	xor    %ebx,%ebx
{
 31b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 31e:	eb 27                	jmp    347 <gets+0x37>
    cc = read(0, &c, 1);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	6a 01                	push   $0x1
 325:	56                   	push   %esi
 326:	6a 00                	push   $0x0
 328:	e8 1e 01 00 00       	call   44b <read>
    if(cc < 1)
 32d:	83 c4 10             	add    $0x10,%esp
 330:	85 c0                	test   %eax,%eax
 332:	7e 1d                	jle    351 <gets+0x41>
      break;
    buf[i++] = c;
 334:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 33f:	3c 0a                	cmp    $0xa,%al
 341:	74 10                	je     353 <gets+0x43>
 343:	3c 0d                	cmp    $0xd,%al
 345:	74 0c                	je     353 <gets+0x43>
  for(i=0; i+1 < max; ){
 347:	89 df                	mov    %ebx,%edi
 349:	83 c3 01             	add    $0x1,%ebx
 34c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 34f:	7c cf                	jl     320 <gets+0x10>
 351:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 35a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35d:	5b                   	pop    %ebx
 35e:	5e                   	pop    %esi
 35f:	5f                   	pop    %edi
 360:	5d                   	pop    %ebp
 361:	c3                   	ret
 362:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 369:	00 
 36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000370 <stat>:

int
stat(const char *n, struct stat *st)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 375:	83 ec 08             	sub    $0x8,%esp
 378:	6a 00                	push   $0x0
 37a:	ff 75 08             	push   0x8(%ebp)
 37d:	e8 f1 00 00 00       	call   473 <open>
  if(fd < 0)
 382:	83 c4 10             	add    $0x10,%esp
 385:	85 c0                	test   %eax,%eax
 387:	78 27                	js     3b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 389:	83 ec 08             	sub    $0x8,%esp
 38c:	ff 75 0c             	push   0xc(%ebp)
 38f:	89 c3                	mov    %eax,%ebx
 391:	50                   	push   %eax
 392:	e8 f4 00 00 00       	call   48b <fstat>
  close(fd);
 397:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 39a:	89 c6                	mov    %eax,%esi
  close(fd);
 39c:	e8 ba 00 00 00       	call   45b <close>
  return r;
 3a1:	83 c4 10             	add    $0x10,%esp
}
 3a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3a7:	89 f0                	mov    %esi,%eax
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3b5:	eb ed                	jmp    3a4 <stat+0x34>
 3b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3be:	00 
 3bf:	90                   	nop

000003c0 <atoi>:

int
atoi(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	0f be 02             	movsbl (%edx),%eax
 3ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3cd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3d5:	77 1e                	ja     3f5 <atoi+0x35>
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop
    n = n*10 + *s++ - '0';
 3e0:	83 c2 01             	add    $0x1,%edx
 3e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3ea:	0f be 02             	movsbl (%edx),%eax
 3ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3f0:	80 fb 09             	cmp    $0x9,%bl
 3f3:	76 eb                	jbe    3e0 <atoi+0x20>
  return n;
}
 3f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f8:	89 c8                	mov    %ecx,%eax
 3fa:	c9                   	leave
 3fb:	c3                   	ret
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000400 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	8b 45 10             	mov    0x10(%ebp),%eax
 407:	8b 55 08             	mov    0x8(%ebp),%edx
 40a:	56                   	push   %esi
 40b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40e:	85 c0                	test   %eax,%eax
 410:	7e 13                	jle    425 <memmove+0x25>
 412:	01 d0                	add    %edx,%eax
  dst = vdst;
 414:	89 d7                	mov    %edx,%edi
 416:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41d:	00 
 41e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 420:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 421:	39 f8                	cmp    %edi,%eax
 423:	75 fb                	jne    420 <memmove+0x20>
  return vdst;
}
 425:	5e                   	pop    %esi
 426:	89 d0                	mov    %edx,%eax
 428:	5f                   	pop    %edi
 429:	5d                   	pop    %ebp
 42a:	c3                   	ret

0000042b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42b:	b8 01 00 00 00       	mov    $0x1,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <exit>:
SYSCALL(exit)
 433:	b8 02 00 00 00       	mov    $0x2,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <wait>:
SYSCALL(wait)
 43b:	b8 03 00 00 00       	mov    $0x3,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <pipe>:
SYSCALL(pipe)
 443:	b8 04 00 00 00       	mov    $0x4,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <read>:
SYSCALL(read)
 44b:	b8 05 00 00 00       	mov    $0x5,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <write>:
SYSCALL(write)
 453:	b8 10 00 00 00       	mov    $0x10,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <close>:
SYSCALL(close)
 45b:	b8 15 00 00 00       	mov    $0x15,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <kill>:
SYSCALL(kill)
 463:	b8 06 00 00 00       	mov    $0x6,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <exec>:
SYSCALL(exec)
 46b:	b8 07 00 00 00       	mov    $0x7,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <open>:
SYSCALL(open)
 473:	b8 0f 00 00 00       	mov    $0xf,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <mknod>:
SYSCALL(mknod)
 47b:	b8 11 00 00 00       	mov    $0x11,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <unlink>:
SYSCALL(unlink)
 483:	b8 12 00 00 00       	mov    $0x12,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <fstat>:
SYSCALL(fstat)
 48b:	b8 08 00 00 00       	mov    $0x8,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <link>:
SYSCALL(link)
 493:	b8 13 00 00 00       	mov    $0x13,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <mkdir>:
SYSCALL(mkdir)
 49b:	b8 14 00 00 00       	mov    $0x14,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <chdir>:
SYSCALL(chdir)
 4a3:	b8 09 00 00 00       	mov    $0x9,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <dup>:
SYSCALL(dup)
 4ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <getpid>:
SYSCALL(getpid)
 4b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <sbrk>:
SYSCALL(sbrk)
 4bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <sleep>:
SYSCALL(sleep)
 4c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

000004cb <uptime>:
SYSCALL(uptime)
 4cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret

000004d3 <strrev>:
SYSCALL(strrev)
 4d3:	b8 19 00 00 00       	mov    $0x19,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret

000004db <setflag>:
SYSCALL(setflag)
 4db:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret

000004e3 <getflag>:
SYSCALL(getflag)
 4e3:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret

000004eb <getstats>:
SYSCALL(getstats)
 4eb:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret

000004f3 <get_proc_info>:
SYSCALL(get_proc_info)
 4f3:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret

000004fb <numvp>:
SYSCALL(numvp)
 4fb:	b8 1e 00 00 00       	mov    $0x1e,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret

00000503 <numpp>:
SYSCALL(numpp)
 503:	b8 1f 00 00 00       	mov    $0x1f,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret

0000050b <getptsize>:
SYSCALL(getptsize)
 50b:	b8 20 00 00 00       	mov    $0x20,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret

00000513 <setpriority>:
SYSCALL(setpriority)
 513:	b8 21 00 00 00       	mov    $0x21,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret

0000051b <getpagefaults>:
SYSCALL(getpagefaults)
 51b:	b8 22 00 00 00       	mov    $0x22,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret
 523:	66 90                	xchg   %ax,%ax
 525:	66 90                	xchg   %ax,%ax
 527:	66 90                	xchg   %ax,%ax
 529:	66 90                	xchg   %ax,%ax
 52b:	66 90                	xchg   %ax,%ax
 52d:	66 90                	xchg   %ax,%ax
 52f:	90                   	nop

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 538:	89 d1                	mov    %edx,%ecx
{
 53a:	83 ec 3c             	sub    $0x3c,%esp
 53d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 540:	85 d2                	test   %edx,%edx
 542:	0f 89 80 00 00 00    	jns    5c8 <printint+0x98>
 548:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 54c:	74 7a                	je     5c8 <printint+0x98>
    x = -xx;
 54e:	f7 d9                	neg    %ecx
    neg = 1;
 550:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 555:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 558:	31 f6                	xor    %esi,%esi
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 560:	89 c8                	mov    %ecx,%eax
 562:	31 d2                	xor    %edx,%edx
 564:	89 f7                	mov    %esi,%edi
 566:	f7 f3                	div    %ebx
 568:	8d 76 01             	lea    0x1(%esi),%esi
 56b:	0f b6 92 10 0a 00 00 	movzbl 0xa10(%edx),%edx
 572:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 576:	89 ca                	mov    %ecx,%edx
 578:	89 c1                	mov    %eax,%ecx
 57a:	39 da                	cmp    %ebx,%edx
 57c:	73 e2                	jae    560 <printint+0x30>
  if(neg)
 57e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 581:	85 c0                	test   %eax,%eax
 583:	74 07                	je     58c <printint+0x5c>
    buf[i++] = '-';
 585:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 58a:	89 f7                	mov    %esi,%edi
 58c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 58f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 592:	01 df                	add    %ebx,%edi
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 598:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 59b:	83 ec 04             	sub    $0x4,%esp
 59e:	88 45 d7             	mov    %al,-0x29(%ebp)
 5a1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 5a4:	6a 01                	push   $0x1
 5a6:	50                   	push   %eax
 5a7:	56                   	push   %esi
 5a8:	e8 a6 fe ff ff       	call   453 <write>
  while(--i >= 0)
 5ad:	89 f8                	mov    %edi,%eax
 5af:	83 c4 10             	add    $0x10,%esp
 5b2:	83 ef 01             	sub    $0x1,%edi
 5b5:	39 c3                	cmp    %eax,%ebx
 5b7:	75 df                	jne    598 <printint+0x68>
}
 5b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bc:	5b                   	pop    %ebx
 5bd:	5e                   	pop    %esi
 5be:	5f                   	pop    %edi
 5bf:	5d                   	pop    %ebp
 5c0:	c3                   	ret
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5c8:	31 c0                	xor    %eax,%eax
 5ca:	eb 89                	jmp    555 <printint+0x25>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 5dc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 1e             	movzbl (%esi),%ebx
 5e2:	83 c6 01             	add    $0x1,%esi
 5e5:	84 db                	test   %bl,%bl
 5e7:	74 67                	je     650 <printf+0x80>
 5e9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5ec:	31 d2                	xor    %edx,%edx
 5ee:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5f1:	eb 34                	jmp    627 <printf+0x57>
 5f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 5f8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5fb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 600:	83 f8 25             	cmp    $0x25,%eax
 603:	74 18                	je     61d <printf+0x4d>
  write(fd, &c, 1);
 605:	83 ec 04             	sub    $0x4,%esp
 608:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 60e:	6a 01                	push   $0x1
 610:	50                   	push   %eax
 611:	57                   	push   %edi
 612:	e8 3c fe ff ff       	call   453 <write>
 617:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 61a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 61d:	0f b6 1e             	movzbl (%esi),%ebx
 620:	83 c6 01             	add    $0x1,%esi
 623:	84 db                	test   %bl,%bl
 625:	74 29                	je     650 <printf+0x80>
    c = fmt[i] & 0xff;
 627:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 62a:	85 d2                	test   %edx,%edx
 62c:	74 ca                	je     5f8 <printf+0x28>
      }
    } else if(state == '%'){
 62e:	83 fa 25             	cmp    $0x25,%edx
 631:	75 ea                	jne    61d <printf+0x4d>
      if(c == 'd'){
 633:	83 f8 25             	cmp    $0x25,%eax
 636:	0f 84 04 01 00 00    	je     740 <printf+0x170>
 63c:	83 e8 63             	sub    $0x63,%eax
 63f:	83 f8 15             	cmp    $0x15,%eax
 642:	77 1c                	ja     660 <printf+0x90>
 644:	ff 24 85 b8 09 00 00 	jmp    *0x9b8(,%eax,4)
 64b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 650:	8d 65 f4             	lea    -0xc(%ebp),%esp
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret
 658:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65f:	00 
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	8d 55 e7             	lea    -0x19(%ebp),%edx
 666:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 66a:	6a 01                	push   $0x1
 66c:	52                   	push   %edx
 66d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 670:	57                   	push   %edi
 671:	e8 dd fd ff ff       	call   453 <write>
 676:	83 c4 0c             	add    $0xc,%esp
 679:	88 5d e7             	mov    %bl,-0x19(%ebp)
 67c:	6a 01                	push   $0x1
 67e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 681:	52                   	push   %edx
 682:	57                   	push   %edi
 683:	e8 cb fd ff ff       	call   453 <write>
        putc(fd, c);
 688:	83 c4 10             	add    $0x10,%esp
      state = 0;
 68b:	31 d2                	xor    %edx,%edx
 68d:	eb 8e                	jmp    61d <printf+0x4d>
 68f:	90                   	nop
        printint(fd, *ap, 16, 0);
 690:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	b9 10 00 00 00       	mov    $0x10,%ecx
 69b:	8b 13                	mov    (%ebx),%edx
 69d:	6a 00                	push   $0x0
 69f:	89 f8                	mov    %edi,%eax
        ap++;
 6a1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 6a4:	e8 87 fe ff ff       	call   530 <printint>
        ap++;
 6a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 67 ff ff ff       	jmp    61d <printf+0x4d>
        s = (char*)*ap;
 6b6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6b9:	8b 18                	mov    (%eax),%ebx
        ap++;
 6bb:	83 c0 04             	add    $0x4,%eax
 6be:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6c1:	85 db                	test   %ebx,%ebx
 6c3:	0f 84 87 00 00 00    	je     750 <printf+0x180>
        while(*s != 0){
 6c9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6cc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6ce:	84 c0                	test   %al,%al
 6d0:	0f 84 47 ff ff ff    	je     61d <printf+0x4d>
 6d6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6dc:	89 de                	mov    %ebx,%esi
 6de:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 6e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	53                   	push   %ebx
 6ec:	57                   	push   %edi
 6ed:	e8 61 fd ff ff       	call   453 <write>
        while(*s != 0){
 6f2:	0f b6 06             	movzbl (%esi),%eax
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	84 c0                	test   %al,%al
 6fa:	75 e4                	jne    6e0 <printf+0x110>
      state = 0;
 6fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6ff:	31 d2                	xor    %edx,%edx
 701:	e9 17 ff ff ff       	jmp    61d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 706:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 709:	83 ec 0c             	sub    $0xc,%esp
 70c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 711:	8b 13                	mov    (%ebx),%edx
 713:	6a 01                	push   $0x1
 715:	eb 88                	jmp    69f <printf+0xcf>
        putc(fd, *ap);
 717:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 71a:	83 ec 04             	sub    $0x4,%esp
 71d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 720:	8b 03                	mov    (%ebx),%eax
        ap++;
 722:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 725:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 728:	6a 01                	push   $0x1
 72a:	52                   	push   %edx
 72b:	57                   	push   %edi
 72c:	e8 22 fd ff ff       	call   453 <write>
        ap++;
 731:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 734:	83 c4 10             	add    $0x10,%esp
      state = 0;
 737:	31 d2                	xor    %edx,%edx
 739:	e9 df fe ff ff       	jmp    61d <printf+0x4d>
 73e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
 743:	88 5d e7             	mov    %bl,-0x19(%ebp)
 746:	8d 55 e7             	lea    -0x19(%ebp),%edx
 749:	6a 01                	push   $0x1
 74b:	e9 31 ff ff ff       	jmp    681 <printf+0xb1>
 750:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 755:	bb af 09 00 00       	mov    $0x9af,%ebx
 75a:	e9 77 ff ff ff       	jmp    6d6 <printf+0x106>
 75f:	90                   	nop

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	a1 bc 0c 00 00       	mov    0xcbc,%eax
{
 766:	89 e5                	mov    %esp,%ebp
 768:	57                   	push   %edi
 769:	56                   	push   %esi
 76a:	53                   	push   %ebx
 76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 76e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77a:	39 c8                	cmp    %ecx,%eax
 77c:	73 32                	jae    7b0 <free+0x50>
 77e:	39 d1                	cmp    %edx,%ecx
 780:	72 04                	jb     786 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	39 d0                	cmp    %edx,%eax
 784:	72 32                	jb     7b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 786:	8b 73 fc             	mov    -0x4(%ebx),%esi
 789:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78c:	39 fa                	cmp    %edi,%edx
 78e:	74 30                	je     7c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 790:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 793:	8b 50 04             	mov    0x4(%eax),%edx
 796:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 799:	39 f1                	cmp    %esi,%ecx
 79b:	74 3a                	je     7d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 79d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 79f:	5b                   	pop    %ebx
  freep = p;
 7a0:	a3 bc 0c 00 00       	mov    %eax,0xcbc
}
 7a5:	5e                   	pop    %esi
 7a6:	5f                   	pop    %edi
 7a7:	5d                   	pop    %ebp
 7a8:	c3                   	ret
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b0:	39 d0                	cmp    %edx,%eax
 7b2:	72 04                	jb     7b8 <free+0x58>
 7b4:	39 d1                	cmp    %edx,%ecx
 7b6:	72 ce                	jb     786 <free+0x26>
{
 7b8:	89 d0                	mov    %edx,%eax
 7ba:	eb bc                	jmp    778 <free+0x18>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7c0:	03 72 04             	add    0x4(%edx),%esi
 7c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8b 12                	mov    (%edx),%edx
 7ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7cd:	8b 50 04             	mov    0x4(%eax),%edx
 7d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d3:	39 f1                	cmp    %esi,%ecx
 7d5:	75 c6                	jne    79d <free+0x3d>
    p->s.size += bp->s.size;
 7d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7da:	a3 bc 0c 00 00       	mov    %eax,0xcbc
    p->s.size += bp->s.size;
 7df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7e2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7e5:	89 08                	mov    %ecx,(%eax)
}
 7e7:	5b                   	pop    %ebx
 7e8:	5e                   	pop    %esi
 7e9:	5f                   	pop    %edi
 7ea:	5d                   	pop    %ebp
 7eb:	c3                   	ret
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 15 bc 0c 00 00    	mov    0xcbc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8d 78 07             	lea    0x7(%eax),%edi
 805:	c1 ef 03             	shr    $0x3,%edi
 808:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 80b:	85 d2                	test   %edx,%edx
 80d:	0f 84 8d 00 00 00    	je     8a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 813:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 815:	8b 48 04             	mov    0x4(%eax),%ecx
 818:	39 f9                	cmp    %edi,%ecx
 81a:	73 64                	jae    880 <malloc+0x90>
  if(nu < 4096)
 81c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 821:	39 df                	cmp    %ebx,%edi
 823:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 826:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 82d:	eb 0a                	jmp    839 <malloc+0x49>
 82f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 832:	8b 48 04             	mov    0x4(%eax),%ecx
 835:	39 f9                	cmp    %edi,%ecx
 837:	73 47                	jae    880 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 839:	89 c2                	mov    %eax,%edx
 83b:	3b 05 bc 0c 00 00    	cmp    0xcbc,%eax
 841:	75 ed                	jne    830 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 843:	83 ec 0c             	sub    $0xc,%esp
 846:	56                   	push   %esi
 847:	e8 6f fc ff ff       	call   4bb <sbrk>
  if(p == (char*)-1)
 84c:	83 c4 10             	add    $0x10,%esp
 84f:	83 f8 ff             	cmp    $0xffffffff,%eax
 852:	74 1c                	je     870 <malloc+0x80>
  hp->s.size = nu;
 854:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 857:	83 ec 0c             	sub    $0xc,%esp
 85a:	83 c0 08             	add    $0x8,%eax
 85d:	50                   	push   %eax
 85e:	e8 fd fe ff ff       	call   760 <free>
  return freep;
 863:	8b 15 bc 0c 00 00    	mov    0xcbc,%edx
      if((p = morecore(nunits)) == 0)
 869:	83 c4 10             	add    $0x10,%esp
 86c:	85 d2                	test   %edx,%edx
 86e:	75 c0                	jne    830 <malloc+0x40>
        return 0;
  }
}
 870:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 873:	31 c0                	xor    %eax,%eax
}
 875:	5b                   	pop    %ebx
 876:	5e                   	pop    %esi
 877:	5f                   	pop    %edi
 878:	5d                   	pop    %ebp
 879:	c3                   	ret
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 880:	39 cf                	cmp    %ecx,%edi
 882:	74 4c                	je     8d0 <malloc+0xe0>
        p->s.size -= nunits;
 884:	29 f9                	sub    %edi,%ecx
 886:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 889:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 88c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 88f:	89 15 bc 0c 00 00    	mov    %edx,0xcbc
}
 895:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 898:	83 c0 08             	add    $0x8,%eax
}
 89b:	5b                   	pop    %ebx
 89c:	5e                   	pop    %esi
 89d:	5f                   	pop    %edi
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 8a0:	c7 05 bc 0c 00 00 c0 	movl   $0xcc0,0xcbc
 8a7:	0c 00 00 
    base.s.size = 0;
 8aa:	b8 c0 0c 00 00       	mov    $0xcc0,%eax
    base.s.ptr = freep = prevp = &base;
 8af:	c7 05 c0 0c 00 00 c0 	movl   $0xcc0,0xcc0
 8b6:	0c 00 00 
    base.s.size = 0;
 8b9:	c7 05 c4 0c 00 00 00 	movl   $0x0,0xcc4
 8c0:	00 00 00 
    if(p->s.size >= nunits){
 8c3:	e9 54 ff ff ff       	jmp    81c <malloc+0x2c>
 8c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8cf:	00 
        prevp->s.ptr = p->s.ptr;
 8d0:	8b 08                	mov    (%eax),%ecx
 8d2:	89 0a                	mov    %ecx,(%edx)
 8d4:	eb b9                	jmp    88f <malloc+0x9f>
