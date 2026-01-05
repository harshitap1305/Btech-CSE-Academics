
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7f 26                	jg     4f <main+0x4f>
  29:	eb 52                	jmp    7d <main+0x7d>
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  30:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  33:	83 c6 01             	add    $0x1,%esi
  36:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  39:	50                   	push   %eax
  3a:	e8 51 00 00 00       	call   90 <cat>
    close(fd);
  3f:	89 3c 24             	mov    %edi,(%esp)
  42:	e8 34 03 00 00       	call   37b <close>
  for(i = 1; i < argc; i++){
  47:	83 c4 10             	add    $0x10,%esp
  4a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4d:	74 29                	je     78 <main+0x78>
    if((fd = open(argv[i], 0)) < 0){
  4f:	83 ec 08             	sub    $0x8,%esp
  52:	6a 00                	push   $0x0
  54:	ff 33                	push   (%ebx)
  56:	e8 38 03 00 00       	call   393 <open>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	89 c7                	mov    %eax,%edi
  60:	85 c0                	test   %eax,%eax
  62:	79 cc                	jns    30 <main+0x30>
      printf(1, "cat: cannot open %s\n", argv[i]);
  64:	50                   	push   %eax
  65:	ff 33                	push   (%ebx)
  67:	68 1b 08 00 00       	push   $0x81b
  6c:	6a 01                	push   $0x1
  6e:	e8 7d 04 00 00       	call   4f0 <printf>
      exit();
  73:	e8 db 02 00 00       	call   353 <exit>
  }
  exit();
  78:	e8 d6 02 00 00       	call   353 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 c7 02 00 00       	call   353 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 80 0b 00 00       	push   $0xb80
  a9:	6a 01                	push   $0x1
  ab:	e8 c3 02 00 00       	call   373 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 25                	jne    dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 80 0b 00 00       	push   $0xb80
  c4:	56                   	push   %esi
  c5:	e8 a1 02 00 00       	call   36b <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 c3                	mov    %eax,%ebx
  cf:	85 c0                	test   %eax,%eax
  d1:	7f cd                	jg     a0 <cat+0x10>
  if(n < 0){
  d3:	75 1b                	jne    f0 <cat+0x60>
}
  d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d8:	5b                   	pop    %ebx
  d9:	5e                   	pop    %esi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret
      printf(1, "cat: write error\n");
  dc:	83 ec 08             	sub    $0x8,%esp
  df:	68 f8 07 00 00       	push   $0x7f8
  e4:	6a 01                	push   $0x1
  e6:	e8 05 04 00 00       	call   4f0 <printf>
      exit();
  eb:	e8 63 02 00 00       	call   353 <exit>
    printf(1, "cat: read error\n");
  f0:	50                   	push   %eax
  f1:	50                   	push   %eax
  f2:	68 0a 08 00 00       	push   $0x80a
  f7:	6a 01                	push   $0x1
  f9:	e8 f2 03 00 00       	call   4f0 <printf>
    exit();
  fe:	e8 50 02 00 00       	call   353 <exit>
 103:	66 90                	xchg   %ax,%ax
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 111:	31 c0                	xor    %eax,%eax
{
 113:	89 e5                	mov    %esp,%ebp
 115:	53                   	push   %ebx
 116:	8b 4d 08             	mov    0x8(%ebp),%ecx
 119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 127:	83 c0 01             	add    $0x1,%eax
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 131:	89 c8                	mov    %ecx,%eax
 133:	c9                   	leave
 134:	c3                   	ret
 135:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13c:	00 
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 17                	jne    168 <strcmp+0x28>
 151:	eb 3a                	jmp    18d <strcmp+0x4d>
 153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 158:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 15c:	83 c2 01             	add    $0x1,%edx
 15f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 162:	84 c0                	test   %al,%al
 164:	74 1a                	je     180 <strcmp+0x40>
 166:	89 d9                	mov    %ebx,%ecx
 168:	0f b6 19             	movzbl (%ecx),%ebx
 16b:	38 c3                	cmp    %al,%bl
 16d:	74 e9                	je     158 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 16f:	29 d8                	sub    %ebx,%eax
}
 171:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 174:	c9                   	leave
 175:	c3                   	ret
 176:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17d:	00 
 17e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 180:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 184:	31 c0                	xor    %eax,%eax
 186:	29 d8                	sub    %ebx,%eax
}
 188:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18b:	c9                   	leave
 18c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 18d:	0f b6 19             	movzbl (%ecx),%ebx
 190:	31 c0                	xor    %eax,%eax
 192:	eb db                	jmp    16f <strcmp+0x2f>
 194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19b:	00 
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 c0 01             	add    $0x1,%eax
 1b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b7:	89 c1                	mov    %eax,%ecx
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1bb:	89 c8                	mov    %ecx,%eax
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret
 1bf:	90                   	nop
  for(n = 0; s[n]; n++)
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1e5:	89 d0                	mov    %edx,%eax
 1e7:	c9                   	leave
 1e8:	c3                   	ret
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 12                	jne    213 <strchr+0x23>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 20c:	83 c0 01             	add    $0x1,%eax
 20f:	84 d2                	test   %dl,%dl
 211:	74 0d                	je     220 <strchr+0x30>
    if(*s == c)
 213:	38 d1                	cmp    %dl,%cl
 215:	75 f1                	jne    208 <strchr+0x18>
      return (char*)s;
  return 0;
}
 217:	5d                   	pop    %ebp
 218:	c3                   	ret
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret
 224:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22b:	00 
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 235:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 238:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 239:	31 db                	xor    %ebx,%ebx
{
 23b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 23e:	eb 27                	jmp    267 <gets+0x37>
    cc = read(0, &c, 1);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	6a 01                	push   $0x1
 245:	56                   	push   %esi
 246:	6a 00                	push   $0x0
 248:	e8 1e 01 00 00       	call   36b <read>
    if(cc < 1)
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	7e 1d                	jle    271 <gets+0x41>
      break;
    buf[i++] = c;
 254:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 258:	8b 55 08             	mov    0x8(%ebp),%edx
 25b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25f:	3c 0a                	cmp    $0xa,%al
 261:	74 10                	je     273 <gets+0x43>
 263:	3c 0d                	cmp    $0xd,%al
 265:	74 0c                	je     273 <gets+0x43>
  for(i=0; i+1 < max; ){
 267:	89 df                	mov    %ebx,%edi
 269:	83 c3 01             	add    $0x1,%ebx
 26c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 26f:	7c cf                	jl     240 <gets+0x10>
 271:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 27a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27d:	5b                   	pop    %ebx
 27e:	5e                   	pop    %esi
 27f:	5f                   	pop    %edi
 280:	5d                   	pop    %ebp
 281:	c3                   	ret
 282:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 289:	00 
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	push   0x8(%ebp)
 29d:	e8 f1 00 00 00       	call   393 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	push   0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 f4 00 00 00       	call   3ab <fstat>
  close(fd);
 2b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ba:	89 c6                	mov    %eax,%esi
  close(fd);
 2bc:	e8 ba 00 00 00       	call   37b <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2de:	00 
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f5:	77 1e                	ja     315 <atoi+0x35>
 2f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fe:	00 
 2ff:	90                   	nop
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 45 10             	mov    0x10(%ebp),%eax
 327:	8b 55 08             	mov    0x8(%ebp),%edx
 32a:	56                   	push   %esi
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c0                	test   %eax,%eax
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 d0                	add    %edx,%eax
  dst = vdst;
 334:	89 d7                	mov    %edx,%edi
 336:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33d:	00 
 33e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <strrev>:
SYSCALL(strrev)
 3f3:	b8 19 00 00 00       	mov    $0x19,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <setflag>:
SYSCALL(setflag)
 3fb:	b8 1a 00 00 00       	mov    $0x1a,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <getflag>:
SYSCALL(getflag)
 403:	b8 1b 00 00 00       	mov    $0x1b,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <getstats>:
SYSCALL(getstats)
 40b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <get_proc_info>:
SYSCALL(get_proc_info)
 413:	b8 1d 00 00 00       	mov    $0x1d,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <numvp>:
SYSCALL(numvp)
 41b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <numpp>:
SYSCALL(numpp)
 423:	b8 1f 00 00 00       	mov    $0x1f,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <getptsize>:
SYSCALL(getptsize)
 42b:	b8 20 00 00 00       	mov    $0x20,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <setpriority>:
SYSCALL(setpriority)
 433:	b8 21 00 00 00       	mov    $0x21,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <getpagefaults>:
SYSCALL(getpagefaults)
 43b:	b8 22 00 00 00       	mov    $0x22,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret
 443:	66 90                	xchg   %ax,%ax
 445:	66 90                	xchg   %ax,%ax
 447:	66 90                	xchg   %ax,%ax
 449:	66 90                	xchg   %ax,%ax
 44b:	66 90                	xchg   %ax,%ax
 44d:	66 90                	xchg   %ax,%ax
 44f:	90                   	nop

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 458:	89 d1                	mov    %edx,%ecx
{
 45a:	83 ec 3c             	sub    $0x3c,%esp
 45d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 460:	85 d2                	test   %edx,%edx
 462:	0f 89 80 00 00 00    	jns    4e8 <printint+0x98>
 468:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 46c:	74 7a                	je     4e8 <printint+0x98>
    x = -xx;
 46e:	f7 d9                	neg    %ecx
    neg = 1;
 470:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 475:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 478:	31 f6                	xor    %esi,%esi
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 480:	89 c8                	mov    %ecx,%eax
 482:	31 d2                	xor    %edx,%edx
 484:	89 f7                	mov    %esi,%edi
 486:	f7 f3                	div    %ebx
 488:	8d 76 01             	lea    0x1(%esi),%esi
 48b:	0f b6 92 90 08 00 00 	movzbl 0x890(%edx),%edx
 492:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 496:	89 ca                	mov    %ecx,%edx
 498:	89 c1                	mov    %eax,%ecx
 49a:	39 da                	cmp    %ebx,%edx
 49c:	73 e2                	jae    480 <printint+0x30>
  if(neg)
 49e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4a1:	85 c0                	test   %eax,%eax
 4a3:	74 07                	je     4ac <printint+0x5c>
    buf[i++] = '-';
 4a5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 4aa:	89 f7                	mov    %esi,%edi
 4ac:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4af:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4b2:	01 df                	add    %ebx,%edi
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4b8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4bb:	83 ec 04             	sub    $0x4,%esp
 4be:	88 45 d7             	mov    %al,-0x29(%ebp)
 4c1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4c4:	6a 01                	push   $0x1
 4c6:	50                   	push   %eax
 4c7:	56                   	push   %esi
 4c8:	e8 a6 fe ff ff       	call   373 <write>
  while(--i >= 0)
 4cd:	89 f8                	mov    %edi,%eax
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	83 ef 01             	sub    $0x1,%edi
 4d5:	39 c3                	cmp    %eax,%ebx
 4d7:	75 df                	jne    4b8 <printint+0x68>
}
 4d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4dc:	5b                   	pop    %ebx
 4dd:	5e                   	pop    %esi
 4de:	5f                   	pop    %edi
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4e8:	31 c0                	xor    %eax,%eax
 4ea:	eb 89                	jmp    475 <printint+0x25>
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4ff:	0f b6 1e             	movzbl (%esi),%ebx
 502:	83 c6 01             	add    $0x1,%esi
 505:	84 db                	test   %bl,%bl
 507:	74 67                	je     570 <printf+0x80>
 509:	8d 4d 10             	lea    0x10(%ebp),%ecx
 50c:	31 d2                	xor    %edx,%edx
 50e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 511:	eb 34                	jmp    547 <printf+0x57>
 513:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 518:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 51b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 520:	83 f8 25             	cmp    $0x25,%eax
 523:	74 18                	je     53d <printf+0x4d>
  write(fd, &c, 1);
 525:	83 ec 04             	sub    $0x4,%esp
 528:	8d 45 e7             	lea    -0x19(%ebp),%eax
 52b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 52e:	6a 01                	push   $0x1
 530:	50                   	push   %eax
 531:	57                   	push   %edi
 532:	e8 3c fe ff ff       	call   373 <write>
 537:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 53a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 53d:	0f b6 1e             	movzbl (%esi),%ebx
 540:	83 c6 01             	add    $0x1,%esi
 543:	84 db                	test   %bl,%bl
 545:	74 29                	je     570 <printf+0x80>
    c = fmt[i] & 0xff;
 547:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 54a:	85 d2                	test   %edx,%edx
 54c:	74 ca                	je     518 <printf+0x28>
      }
    } else if(state == '%'){
 54e:	83 fa 25             	cmp    $0x25,%edx
 551:	75 ea                	jne    53d <printf+0x4d>
      if(c == 'd'){
 553:	83 f8 25             	cmp    $0x25,%eax
 556:	0f 84 04 01 00 00    	je     660 <printf+0x170>
 55c:	83 e8 63             	sub    $0x63,%eax
 55f:	83 f8 15             	cmp    $0x15,%eax
 562:	77 1c                	ja     580 <printf+0x90>
 564:	ff 24 85 38 08 00 00 	jmp    *0x838(,%eax,4)
 56b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 570:	8d 65 f4             	lea    -0xc(%ebp),%esp
 573:	5b                   	pop    %ebx
 574:	5e                   	pop    %esi
 575:	5f                   	pop    %edi
 576:	5d                   	pop    %ebp
 577:	c3                   	ret
 578:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57f:	00 
  write(fd, &c, 1);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	8d 55 e7             	lea    -0x19(%ebp),%edx
 586:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 58a:	6a 01                	push   $0x1
 58c:	52                   	push   %edx
 58d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 590:	57                   	push   %edi
 591:	e8 dd fd ff ff       	call   373 <write>
 596:	83 c4 0c             	add    $0xc,%esp
 599:	88 5d e7             	mov    %bl,-0x19(%ebp)
 59c:	6a 01                	push   $0x1
 59e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5a1:	52                   	push   %edx
 5a2:	57                   	push   %edi
 5a3:	e8 cb fd ff ff       	call   373 <write>
        putc(fd, c);
 5a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ab:	31 d2                	xor    %edx,%edx
 5ad:	eb 8e                	jmp    53d <printf+0x4d>
 5af:	90                   	nop
        printint(fd, *ap, 16, 0);
 5b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5b3:	83 ec 0c             	sub    $0xc,%esp
 5b6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5bb:	8b 13                	mov    (%ebx),%edx
 5bd:	6a 00                	push   $0x0
 5bf:	89 f8                	mov    %edi,%eax
        ap++;
 5c1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5c4:	e8 87 fe ff ff       	call   450 <printint>
        ap++;
 5c9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cf:	31 d2                	xor    %edx,%edx
 5d1:	e9 67 ff ff ff       	jmp    53d <printf+0x4d>
        s = (char*)*ap;
 5d6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5d9:	8b 18                	mov    (%eax),%ebx
        ap++;
 5db:	83 c0 04             	add    $0x4,%eax
 5de:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5e1:	85 db                	test   %ebx,%ebx
 5e3:	0f 84 87 00 00 00    	je     670 <printf+0x180>
        while(*s != 0){
 5e9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5ec:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5ee:	84 c0                	test   %al,%al
 5f0:	0f 84 47 ff ff ff    	je     53d <printf+0x4d>
 5f6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5f9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5fc:	89 de                	mov    %ebx,%esi
 5fe:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 606:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 609:	6a 01                	push   $0x1
 60b:	53                   	push   %ebx
 60c:	57                   	push   %edi
 60d:	e8 61 fd ff ff       	call   373 <write>
        while(*s != 0){
 612:	0f b6 06             	movzbl (%esi),%eax
 615:	83 c4 10             	add    $0x10,%esp
 618:	84 c0                	test   %al,%al
 61a:	75 e4                	jne    600 <printf+0x110>
      state = 0;
 61c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 61f:	31 d2                	xor    %edx,%edx
 621:	e9 17 ff ff ff       	jmp    53d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 626:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 629:	83 ec 0c             	sub    $0xc,%esp
 62c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 631:	8b 13                	mov    (%ebx),%edx
 633:	6a 01                	push   $0x1
 635:	eb 88                	jmp    5bf <printf+0xcf>
        putc(fd, *ap);
 637:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 63a:	83 ec 04             	sub    $0x4,%esp
 63d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 640:	8b 03                	mov    (%ebx),%eax
        ap++;
 642:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 645:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 648:	6a 01                	push   $0x1
 64a:	52                   	push   %edx
 64b:	57                   	push   %edi
 64c:	e8 22 fd ff ff       	call   373 <write>
        ap++;
 651:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 654:	83 c4 10             	add    $0x10,%esp
      state = 0;
 657:	31 d2                	xor    %edx,%edx
 659:	e9 df fe ff ff       	jmp    53d <printf+0x4d>
 65e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	88 5d e7             	mov    %bl,-0x19(%ebp)
 666:	8d 55 e7             	lea    -0x19(%ebp),%edx
 669:	6a 01                	push   $0x1
 66b:	e9 31 ff ff ff       	jmp    5a1 <printf+0xb1>
 670:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 675:	bb 30 08 00 00       	mov    $0x830,%ebx
 67a:	e9 77 ff ff ff       	jmp    5f6 <printf+0x106>
 67f:	90                   	nop

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 80 0d 00 00       	mov    0xd80,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 698:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69a:	39 c8                	cmp    %ecx,%eax
 69c:	73 32                	jae    6d0 <free+0x50>
 69e:	39 d1                	cmp    %edx,%ecx
 6a0:	72 04                	jb     6a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	39 d0                	cmp    %edx,%eax
 6a4:	72 32                	jb     6d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ac:	39 fa                	cmp    %edi,%edx
 6ae:	74 30                	je     6e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6b3:	8b 50 04             	mov    0x4(%eax),%edx
 6b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b9:	39 f1                	cmp    %esi,%ecx
 6bb:	74 3a                	je     6f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6bd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6bf:	5b                   	pop    %ebx
  freep = p;
 6c0:	a3 80 0d 00 00       	mov    %eax,0xd80
}
 6c5:	5e                   	pop    %esi
 6c6:	5f                   	pop    %edi
 6c7:	5d                   	pop    %ebp
 6c8:	c3                   	ret
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d0:	39 d0                	cmp    %edx,%eax
 6d2:	72 04                	jb     6d8 <free+0x58>
 6d4:	39 d1                	cmp    %edx,%ecx
 6d6:	72 ce                	jb     6a6 <free+0x26>
{
 6d8:	89 d0                	mov    %edx,%eax
 6da:	eb bc                	jmp    698 <free+0x18>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 c6                	jne    6bd <free+0x3d>
    p->s.size += bp->s.size;
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6fa:	a3 80 0d 00 00       	mov    %eax,0xd80
    p->s.size += bp->s.size;
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 702:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 705:	89 08                	mov    %ecx,(%eax)
}
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 71c:	8b 15 80 0d 00 00    	mov    0xd80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	8d 78 07             	lea    0x7(%eax),%edi
 725:	c1 ef 03             	shr    $0x3,%edi
 728:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 72b:	85 d2                	test   %edx,%edx
 72d:	0f 84 8d 00 00 00    	je     7c0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 733:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 735:	8b 48 04             	mov    0x4(%eax),%ecx
 738:	39 f9                	cmp    %edi,%ecx
 73a:	73 64                	jae    7a0 <malloc+0x90>
  if(nu < 4096)
 73c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 741:	39 df                	cmp    %ebx,%edi
 743:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 746:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 74d:	eb 0a                	jmp    759 <malloc+0x49>
 74f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 750:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 752:	8b 48 04             	mov    0x4(%eax),%ecx
 755:	39 f9                	cmp    %edi,%ecx
 757:	73 47                	jae    7a0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 759:	89 c2                	mov    %eax,%edx
 75b:	3b 05 80 0d 00 00    	cmp    0xd80,%eax
 761:	75 ed                	jne    750 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 763:	83 ec 0c             	sub    $0xc,%esp
 766:	56                   	push   %esi
 767:	e8 6f fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 76c:	83 c4 10             	add    $0x10,%esp
 76f:	83 f8 ff             	cmp    $0xffffffff,%eax
 772:	74 1c                	je     790 <malloc+0x80>
  hp->s.size = nu;
 774:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 777:	83 ec 0c             	sub    $0xc,%esp
 77a:	83 c0 08             	add    $0x8,%eax
 77d:	50                   	push   %eax
 77e:	e8 fd fe ff ff       	call   680 <free>
  return freep;
 783:	8b 15 80 0d 00 00    	mov    0xd80,%edx
      if((p = morecore(nunits)) == 0)
 789:	83 c4 10             	add    $0x10,%esp
 78c:	85 d2                	test   %edx,%edx
 78e:	75 c0                	jne    750 <malloc+0x40>
        return 0;
  }
}
 790:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 793:	31 c0                	xor    %eax,%eax
}
 795:	5b                   	pop    %ebx
 796:	5e                   	pop    %esi
 797:	5f                   	pop    %edi
 798:	5d                   	pop    %ebp
 799:	c3                   	ret
 79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7a0:	39 cf                	cmp    %ecx,%edi
 7a2:	74 4c                	je     7f0 <malloc+0xe0>
        p->s.size -= nunits;
 7a4:	29 f9                	sub    %edi,%ecx
 7a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7ac:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7af:	89 15 80 0d 00 00    	mov    %edx,0xd80
}
 7b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7b8:	83 c0 08             	add    $0x8,%eax
}
 7bb:	5b                   	pop    %ebx
 7bc:	5e                   	pop    %esi
 7bd:	5f                   	pop    %edi
 7be:	5d                   	pop    %ebp
 7bf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7c0:	c7 05 80 0d 00 00 84 	movl   $0xd84,0xd80
 7c7:	0d 00 00 
    base.s.size = 0;
 7ca:	b8 84 0d 00 00       	mov    $0xd84,%eax
    base.s.ptr = freep = prevp = &base;
 7cf:	c7 05 84 0d 00 00 84 	movl   $0xd84,0xd84
 7d6:	0d 00 00 
    base.s.size = 0;
 7d9:	c7 05 88 0d 00 00 00 	movl   $0x0,0xd88
 7e0:	00 00 00 
    if(p->s.size >= nunits){
 7e3:	e9 54 ff ff ff       	jmp    73c <malloc+0x2c>
 7e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ef:	00 
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 08                	mov    (%eax),%ecx
 7f2:	89 0a                	mov    %ecx,(%edx)
 7f4:	eb b9                	jmp    7af <malloc+0x9f>
