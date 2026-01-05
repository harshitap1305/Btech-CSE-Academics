
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
   f:	53                   	push   %ebx
  10:	bb 01 00 00 00       	mov    $0x1,%ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 1f                	jle    42 <main+0x42>
  23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  2e:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  31:	e8 ca 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  36:	83 c4 10             	add    $0x10,%esp
  39:	39 de                	cmp    %ebx,%esi
  3b:	75 eb                	jne    28 <main+0x28>
  exit();
  3d:	e8 31 05 00 00       	call   573 <exit>
    ls(".");
  42:	83 ec 0c             	sub    $0xc,%esp
  45:	68 60 0a 00 00       	push   $0xa60
  4a:	e8 b1 00 00 00       	call   100 <ls>
    exit();
  4f:	e8 1f 05 00 00       	call   573 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	56                   	push   %esi
  6c:	e8 4f 03 00 00       	call   3c0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 f0                	add    %esi,%eax
  76:	89 c3                	mov    %eax,%ebx
  78:	73 0f                	jae    89 <fmtname+0x29>
  7a:	eb 12                	jmp    8e <fmtname+0x2e>
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  83:	39 f0                	cmp    %esi,%eax
  85:	72 0a                	jb     91 <fmtname+0x31>
  87:	89 c3                	mov    %eax,%ebx
  89:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  8c:	75 f2                	jne    80 <fmtname+0x20>
  p++;
  8e:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
  91:	83 ec 0c             	sub    $0xc,%esp
  94:	53                   	push   %ebx
  95:	e8 26 03 00 00       	call   3c0 <strlen>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	83 f8 0d             	cmp    $0xd,%eax
  a0:	77 4a                	ja     ec <fmtname+0x8c>
  memmove(buf, p, strlen(p));
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	53                   	push   %ebx
  a6:	e8 15 03 00 00       	call   3c0 <strlen>
  ab:	83 c4 0c             	add    $0xc,%esp
  ae:	50                   	push   %eax
  af:	53                   	push   %ebx
  b0:	68 e8 0d 00 00       	push   $0xde8
  b5:	e8 86 04 00 00       	call   540 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ba:	89 1c 24             	mov    %ebx,(%esp)
  bd:	e8 fe 02 00 00       	call   3c0 <strlen>
  c2:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c5:	bb e8 0d 00 00       	mov    $0xde8,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	89 c6                	mov    %eax,%esi
  cc:	e8 ef 02 00 00       	call   3c0 <strlen>
  d1:	ba 0e 00 00 00       	mov    $0xe,%edx
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	29 f2                	sub    %esi,%edx
  db:	05 e8 0d 00 00       	add    $0xde8,%eax
  e0:	52                   	push   %edx
  e1:	6a 20                	push   $0x20
  e3:	50                   	push   %eax
  e4:	e8 07 03 00 00       	call   3f0 <memset>
  return buf;
  e9:	83 c4 10             	add    $0x10,%esp
}
  ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ef:	89 d8                	mov    %ebx,%eax
  f1:	5b                   	pop    %ebx
  f2:	5e                   	pop    %esi
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret
  f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fc:	00 
  fd:	8d 76 00             	lea    0x0(%esi),%esi

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 9c 04 00 00       	call   5b3 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 88 8e 01 00 00    	js     2b0 <ls+0x1b0>
  if(fstat(fd, &st) < 0){
 122:	83 ec 08             	sub    $0x8,%esp
 125:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12b:	89 c3                	mov    %eax,%ebx
 12d:	56                   	push   %esi
 12e:	50                   	push   %eax
 12f:	e8 97 04 00 00       	call   5cb <fstat>
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	0f 88 b1 01 00 00    	js     2f0 <ls+0x1f0>
  switch(st.type){
 13f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 146:	66 83 f8 01          	cmp    $0x1,%ax
 14a:	74 54                	je     1a0 <ls+0xa0>
 14c:	66 83 f8 02          	cmp    $0x2,%ax
 150:	75 37                	jne    189 <ls+0x89>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 161:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 167:	57                   	push   %edi
 168:	e8 f3 fe ff ff       	call   60 <fmtname>
 16d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 173:	59                   	pop    %ecx
 174:	5f                   	pop    %edi
 175:	52                   	push   %edx
 176:	56                   	push   %esi
 177:	6a 02                	push   $0x2
 179:	50                   	push   %eax
 17a:	68 40 0a 00 00       	push   $0xa40
 17f:	6a 01                	push   $0x1
 181:	e8 8a 05 00 00       	call   710 <printf>
    break;
 186:	83 c4 20             	add    $0x20,%esp
  close(fd);
 189:	83 ec 0c             	sub    $0xc,%esp
 18c:	53                   	push   %ebx
 18d:	e8 09 04 00 00       	call   59b <close>
 192:	83 c4 10             	add    $0x10,%esp
}
 195:	8d 65 f4             	lea    -0xc(%ebp),%esp
 198:	5b                   	pop    %ebx
 199:	5e                   	pop    %esi
 19a:	5f                   	pop    %edi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret
 19d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	83 ec 0c             	sub    $0xc,%esp
 1a3:	57                   	push   %edi
 1a4:	e8 17 02 00 00       	call   3c0 <strlen>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	83 c0 10             	add    $0x10,%eax
 1af:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b4:	0f 87 16 01 00 00    	ja     2d0 <ls+0x1d0>
    strcpy(buf, path);
 1ba:	83 ec 08             	sub    $0x8,%esp
 1bd:	57                   	push   %edi
 1be:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1c4:	57                   	push   %edi
 1c5:	e8 66 01 00 00       	call   330 <strcpy>
    p = buf+strlen(buf);
 1ca:	89 3c 24             	mov    %edi,(%esp)
 1cd:	e8 ee 01 00 00       	call   3c0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d5:	01 f8                	add    %edi,%eax
    *p++ = '/';
 1d7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1da:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1e0:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1e6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 1f9:	6a 10                	push   $0x10
 1fb:	50                   	push   %eax
 1fc:	53                   	push   %ebx
 1fd:	e8 89 03 00 00       	call   58b <read>
 202:	83 c4 10             	add    $0x10,%esp
 205:	83 f8 10             	cmp    $0x10,%eax
 208:	0f 85 7b ff ff ff    	jne    189 <ls+0x89>
      if(de.inum == 0)
 20e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 215:	00 
 216:	74 d8                	je     1f0 <ls+0xf0>
      memmove(p, de.name, DIRSIZ);
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 221:	6a 0e                	push   $0xe
 223:	50                   	push   %eax
 224:	ff b5 a4 fd ff ff    	push   -0x25c(%ebp)
 22a:	e8 11 03 00 00       	call   540 <memmove>
      p[DIRSIZ] = 0;
 22f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 235:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 239:	58                   	pop    %eax
 23a:	5a                   	pop    %edx
 23b:	56                   	push   %esi
 23c:	57                   	push   %edi
 23d:	e8 6e 02 00 00       	call   4b0 <stat>
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	0f 88 cb 00 00 00    	js     318 <ls+0x218>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 24d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 253:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 259:	83 ec 0c             	sub    $0xc,%esp
 25c:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 263:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 269:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 26f:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 275:	57                   	push   %edi
 276:	e8 e5 fd ff ff       	call   60 <fmtname>
 27b:	5a                   	pop    %edx
 27c:	59                   	pop    %ecx
 27d:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 283:	51                   	push   %ecx
 284:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 28a:	52                   	push   %edx
 28b:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 291:	50                   	push   %eax
 292:	68 40 0a 00 00       	push   $0xa40
 297:	6a 01                	push   $0x1
 299:	e8 72 04 00 00       	call   710 <printf>
 29e:	83 c4 20             	add    $0x20,%esp
 2a1:	e9 4a ff ff ff       	jmp    1f0 <ls+0xf0>
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot open %s\n", path);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	57                   	push   %edi
 2b4:	68 18 0a 00 00       	push   $0xa18
 2b9:	6a 02                	push   $0x2
 2bb:	e8 50 04 00 00       	call   710 <printf>
    return;
 2c0:	83 c4 10             	add    $0x10,%esp
}
 2c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret
 2cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	68 4d 0a 00 00       	push   $0xa4d
 2d8:	6a 01                	push   $0x1
 2da:	e8 31 04 00 00       	call   710 <printf>
      break;
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	e9 a2 fe ff ff       	jmp    189 <ls+0x89>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
 2f0:	83 ec 04             	sub    $0x4,%esp
 2f3:	57                   	push   %edi
 2f4:	68 2c 0a 00 00       	push   $0xa2c
 2f9:	6a 02                	push   $0x2
 2fb:	e8 10 04 00 00       	call   710 <printf>
    close(fd);
 300:	89 1c 24             	mov    %ebx,(%esp)
 303:	e8 93 02 00 00       	call   59b <close>
    return;
 308:	83 c4 10             	add    $0x10,%esp
}
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret
 313:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 318:	83 ec 04             	sub    $0x4,%esp
 31b:	57                   	push   %edi
 31c:	68 2c 0a 00 00       	push   $0xa2c
 321:	6a 01                	push   $0x1
 323:	e8 e8 03 00 00       	call   710 <printf>
        continue;
 328:	83 c4 10             	add    $0x10,%esp
 32b:	e9 c0 fe ff ff       	jmp    1f0 <ls+0xf0>

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 331:	31 c0                	xor    %eax,%eax
{
 333:	89 e5                	mov    %esp,%ebp
 335:	53                   	push   %ebx
 336:	8b 4d 08             	mov    0x8(%ebp),%ecx
 339:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 340:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 344:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 347:	83 c0 01             	add    $0x1,%eax
 34a:	84 d2                	test   %dl,%dl
 34c:	75 f2                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 351:	89 c8                	mov    %ecx,%eax
 353:	c9                   	leave
 354:	c3                   	ret
 355:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35c:	00 
 35d:	8d 76 00             	lea    0x0(%esi),%esi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	84 c0                	test   %al,%al
 36f:	75 17                	jne    388 <strcmp+0x28>
 371:	eb 3a                	jmp    3ad <strcmp+0x4d>
 373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 378:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 37c:	83 c2 01             	add    $0x1,%edx
 37f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 382:	84 c0                	test   %al,%al
 384:	74 1a                	je     3a0 <strcmp+0x40>
 386:	89 d9                	mov    %ebx,%ecx
 388:	0f b6 19             	movzbl (%ecx),%ebx
 38b:	38 c3                	cmp    %al,%bl
 38d:	74 e9                	je     378 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 38f:	29 d8                	sub    %ebx,%eax
}
 391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 394:	c9                   	leave
 395:	c3                   	ret
 396:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39d:	00 
 39e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 3a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3a4:	31 c0                	xor    %eax,%eax
 3a6:	29 d8                	sub    %ebx,%eax
}
 3a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ab:	c9                   	leave
 3ac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 3ad:	0f b6 19             	movzbl (%ecx),%ebx
 3b0:	31 c0                	xor    %eax,%eax
 3b2:	eb db                	jmp    38f <strcmp+0x2f>
 3b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bb:	00 
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 3a 00             	cmpb   $0x0,(%edx)
 3c9:	74 15                	je     3e0 <strlen+0x20>
 3cb:	31 c0                	xor    %eax,%eax
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	83 c0 01             	add    $0x1,%eax
 3d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3d7:	89 c1                	mov    %eax,%ecx
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	89 c8                	mov    %ecx,%eax
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret
 3df:	90                   	nop
  for(n = 0; s[n]; n++)
 3e0:	31 c9                	xor    %ecx,%ecx
}
 3e2:	5d                   	pop    %ebp
 3e3:	89 c8                	mov    %ecx,%eax
 3e5:	c3                   	ret
 3e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ed:	00 
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 d7                	mov    %edx,%edi
 3ff:	fc                   	cld
 400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 402:	8b 7d fc             	mov    -0x4(%ebp),%edi
 405:	89 d0                	mov    %edx,%eax
 407:	c9                   	leave
 408:	c3                   	ret
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	75 12                	jne    433 <strchr+0x23>
 421:	eb 1d                	jmp    440 <strchr+0x30>
 423:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 428:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 42c:	83 c0 01             	add    $0x1,%eax
 42f:	84 d2                	test   %dl,%dl
 431:	74 0d                	je     440 <strchr+0x30>
    if(*s == c)
 433:	38 d1                	cmp    %dl,%cl
 435:	75 f1                	jne    428 <strchr+0x18>
      return (char*)s;
  return 0;
}
 437:	5d                   	pop    %ebp
 438:	c3                   	ret
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 440:	31 c0                	xor    %eax,%eax
}
 442:	5d                   	pop    %ebp
 443:	c3                   	ret
 444:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44b:	00 
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 455:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 458:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 459:	31 db                	xor    %ebx,%ebx
{
 45b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 45e:	eb 27                	jmp    487 <gets+0x37>
    cc = read(0, &c, 1);
 460:	83 ec 04             	sub    $0x4,%esp
 463:	6a 01                	push   $0x1
 465:	56                   	push   %esi
 466:	6a 00                	push   $0x0
 468:	e8 1e 01 00 00       	call   58b <read>
    if(cc < 1)
 46d:	83 c4 10             	add    $0x10,%esp
 470:	85 c0                	test   %eax,%eax
 472:	7e 1d                	jle    491 <gets+0x41>
      break;
    buf[i++] = c;
 474:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 478:	8b 55 08             	mov    0x8(%ebp),%edx
 47b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 47f:	3c 0a                	cmp    $0xa,%al
 481:	74 10                	je     493 <gets+0x43>
 483:	3c 0d                	cmp    $0xd,%al
 485:	74 0c                	je     493 <gets+0x43>
  for(i=0; i+1 < max; ){
 487:	89 df                	mov    %ebx,%edi
 489:	83 c3 01             	add    $0x1,%ebx
 48c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 48f:	7c cf                	jl     460 <gets+0x10>
 491:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 49a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49d:	5b                   	pop    %ebx
 49e:	5e                   	pop    %esi
 49f:	5f                   	pop    %edi
 4a0:	5d                   	pop    %ebp
 4a1:	c3                   	ret
 4a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4a9:	00 
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	6a 00                	push   $0x0
 4ba:	ff 75 08             	push   0x8(%ebp)
 4bd:	e8 f1 00 00 00       	call   5b3 <open>
  if(fd < 0)
 4c2:	83 c4 10             	add    $0x10,%esp
 4c5:	85 c0                	test   %eax,%eax
 4c7:	78 27                	js     4f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	ff 75 0c             	push   0xc(%ebp)
 4cf:	89 c3                	mov    %eax,%ebx
 4d1:	50                   	push   %eax
 4d2:	e8 f4 00 00 00       	call   5cb <fstat>
  close(fd);
 4d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4da:	89 c6                	mov    %eax,%esi
  close(fd);
 4dc:	e8 ba 00 00 00       	call   59b <close>
  return r;
 4e1:	83 c4 10             	add    $0x10,%esp
}
 4e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4e7:	89 f0                	mov    %esi,%eax
 4e9:	5b                   	pop    %ebx
 4ea:	5e                   	pop    %esi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4f5:	eb ed                	jmp    4e4 <stat+0x34>
 4f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4fe:	00 
 4ff:	90                   	nop

00000500 <atoi>:

int
atoi(const char *s)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 507:	0f be 02             	movsbl (%edx),%eax
 50a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 50d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 510:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 515:	77 1e                	ja     535 <atoi+0x35>
 517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51e:	00 
 51f:	90                   	nop
    n = n*10 + *s++ - '0';
 520:	83 c2 01             	add    $0x1,%edx
 523:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 526:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 52a:	0f be 02             	movsbl (%edx),%eax
 52d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 530:	80 fb 09             	cmp    $0x9,%bl
 533:	76 eb                	jbe    520 <atoi+0x20>
  return n;
}
 535:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 538:	89 c8                	mov    %ecx,%eax
 53a:	c9                   	leave
 53b:	c3                   	ret
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	8b 45 10             	mov    0x10(%ebp),%eax
 547:	8b 55 08             	mov    0x8(%ebp),%edx
 54a:	56                   	push   %esi
 54b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 54e:	85 c0                	test   %eax,%eax
 550:	7e 13                	jle    565 <memmove+0x25>
 552:	01 d0                	add    %edx,%eax
  dst = vdst;
 554:	89 d7                	mov    %edx,%edi
 556:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55d:	00 
 55e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 560:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 561:	39 f8                	cmp    %edi,%eax
 563:	75 fb                	jne    560 <memmove+0x20>
  return vdst;
}
 565:	5e                   	pop    %esi
 566:	89 d0                	mov    %edx,%eax
 568:	5f                   	pop    %edi
 569:	5d                   	pop    %ebp
 56a:	c3                   	ret

0000056b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 56b:	b8 01 00 00 00       	mov    $0x1,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret

00000573 <exit>:
SYSCALL(exit)
 573:	b8 02 00 00 00       	mov    $0x2,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret

0000057b <wait>:
SYSCALL(wait)
 57b:	b8 03 00 00 00       	mov    $0x3,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret

00000583 <pipe>:
SYSCALL(pipe)
 583:	b8 04 00 00 00       	mov    $0x4,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret

0000058b <read>:
SYSCALL(read)
 58b:	b8 05 00 00 00       	mov    $0x5,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret

00000593 <write>:
SYSCALL(write)
 593:	b8 10 00 00 00       	mov    $0x10,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret

0000059b <close>:
SYSCALL(close)
 59b:	b8 15 00 00 00       	mov    $0x15,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret

000005a3 <kill>:
SYSCALL(kill)
 5a3:	b8 06 00 00 00       	mov    $0x6,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret

000005ab <exec>:
SYSCALL(exec)
 5ab:	b8 07 00 00 00       	mov    $0x7,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <open>:
SYSCALL(open)
 5b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <mknod>:
SYSCALL(mknod)
 5bb:	b8 11 00 00 00       	mov    $0x11,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <unlink>:
SYSCALL(unlink)
 5c3:	b8 12 00 00 00       	mov    $0x12,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <fstat>:
SYSCALL(fstat)
 5cb:	b8 08 00 00 00       	mov    $0x8,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <link>:
SYSCALL(link)
 5d3:	b8 13 00 00 00       	mov    $0x13,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <mkdir>:
SYSCALL(mkdir)
 5db:	b8 14 00 00 00       	mov    $0x14,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret

000005e3 <chdir>:
SYSCALL(chdir)
 5e3:	b8 09 00 00 00       	mov    $0x9,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret

000005eb <dup>:
SYSCALL(dup)
 5eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <getpid>:
SYSCALL(getpid)
 5f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <sbrk>:
SYSCALL(sbrk)
 5fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <sleep>:
SYSCALL(sleep)
 603:	b8 0d 00 00 00       	mov    $0xd,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <uptime>:
SYSCALL(uptime)
 60b:	b8 0e 00 00 00       	mov    $0xe,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <strrev>:
SYSCALL(strrev)
 613:	b8 19 00 00 00       	mov    $0x19,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <setflag>:
SYSCALL(setflag)
 61b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <getflag>:
SYSCALL(getflag)
 623:	b8 1b 00 00 00       	mov    $0x1b,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <getstats>:
SYSCALL(getstats)
 62b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <get_proc_info>:
SYSCALL(get_proc_info)
 633:	b8 1d 00 00 00       	mov    $0x1d,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <numvp>:
SYSCALL(numvp)
 63b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <numpp>:
SYSCALL(numpp)
 643:	b8 1f 00 00 00       	mov    $0x1f,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <getptsize>:
SYSCALL(getptsize)
 64b:	b8 20 00 00 00       	mov    $0x20,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <setpriority>:
SYSCALL(setpriority)
 653:	b8 21 00 00 00       	mov    $0x21,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <getpagefaults>:
SYSCALL(getpagefaults)
 65b:	b8 22 00 00 00       	mov    $0x22,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <twostrike>:
SYSCALL(twostrike)
 663:	b8 23 00 00 00       	mov    $0x23,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret
 66b:	66 90                	xchg   %ax,%ax
 66d:	66 90                	xchg   %ax,%ax
 66f:	90                   	nop

00000670 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 678:	89 d1                	mov    %edx,%ecx
{
 67a:	83 ec 3c             	sub    $0x3c,%esp
 67d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 680:	85 d2                	test   %edx,%edx
 682:	0f 89 80 00 00 00    	jns    708 <printint+0x98>
 688:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 68c:	74 7a                	je     708 <printint+0x98>
    x = -xx;
 68e:	f7 d9                	neg    %ecx
    neg = 1;
 690:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 695:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 698:	31 f6                	xor    %esi,%esi
 69a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6a0:	89 c8                	mov    %ecx,%eax
 6a2:	31 d2                	xor    %edx,%edx
 6a4:	89 f7                	mov    %esi,%edi
 6a6:	f7 f3                	div    %ebx
 6a8:	8d 76 01             	lea    0x1(%esi),%esi
 6ab:	0f b6 92 c4 0a 00 00 	movzbl 0xac4(%edx),%edx
 6b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 6b6:	89 ca                	mov    %ecx,%edx
 6b8:	89 c1                	mov    %eax,%ecx
 6ba:	39 da                	cmp    %ebx,%edx
 6bc:	73 e2                	jae    6a0 <printint+0x30>
  if(neg)
 6be:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6c1:	85 c0                	test   %eax,%eax
 6c3:	74 07                	je     6cc <printint+0x5c>
    buf[i++] = '-';
 6c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 6ca:	89 f7                	mov    %esi,%edi
 6cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 6cf:	8b 75 c0             	mov    -0x40(%ebp),%esi
 6d2:	01 df                	add    %ebx,%edi
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 6d8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 6db:	83 ec 04             	sub    $0x4,%esp
 6de:	88 45 d7             	mov    %al,-0x29(%ebp)
 6e1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 6e4:	6a 01                	push   $0x1
 6e6:	50                   	push   %eax
 6e7:	56                   	push   %esi
 6e8:	e8 a6 fe ff ff       	call   593 <write>
  while(--i >= 0)
 6ed:	89 f8                	mov    %edi,%eax
 6ef:	83 c4 10             	add    $0x10,%esp
 6f2:	83 ef 01             	sub    $0x1,%edi
 6f5:	39 c3                	cmp    %eax,%ebx
 6f7:	75 df                	jne    6d8 <printint+0x68>
}
 6f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6fc:	5b                   	pop    %ebx
 6fd:	5e                   	pop    %esi
 6fe:	5f                   	pop    %edi
 6ff:	5d                   	pop    %ebp
 700:	c3                   	ret
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 708:	31 c0                	xor    %eax,%eax
 70a:	eb 89                	jmp    695 <printint+0x25>
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 719:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 71c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 71f:	0f b6 1e             	movzbl (%esi),%ebx
 722:	83 c6 01             	add    $0x1,%esi
 725:	84 db                	test   %bl,%bl
 727:	74 67                	je     790 <printf+0x80>
 729:	8d 4d 10             	lea    0x10(%ebp),%ecx
 72c:	31 d2                	xor    %edx,%edx
 72e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 731:	eb 34                	jmp    767 <printf+0x57>
 733:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 738:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 73b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 740:	83 f8 25             	cmp    $0x25,%eax
 743:	74 18                	je     75d <printf+0x4d>
  write(fd, &c, 1);
 745:	83 ec 04             	sub    $0x4,%esp
 748:	8d 45 e7             	lea    -0x19(%ebp),%eax
 74b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 74e:	6a 01                	push   $0x1
 750:	50                   	push   %eax
 751:	57                   	push   %edi
 752:	e8 3c fe ff ff       	call   593 <write>
 757:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 75a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 75d:	0f b6 1e             	movzbl (%esi),%ebx
 760:	83 c6 01             	add    $0x1,%esi
 763:	84 db                	test   %bl,%bl
 765:	74 29                	je     790 <printf+0x80>
    c = fmt[i] & 0xff;
 767:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 76a:	85 d2                	test   %edx,%edx
 76c:	74 ca                	je     738 <printf+0x28>
      }
    } else if(state == '%'){
 76e:	83 fa 25             	cmp    $0x25,%edx
 771:	75 ea                	jne    75d <printf+0x4d>
      if(c == 'd'){
 773:	83 f8 25             	cmp    $0x25,%eax
 776:	0f 84 04 01 00 00    	je     880 <printf+0x170>
 77c:	83 e8 63             	sub    $0x63,%eax
 77f:	83 f8 15             	cmp    $0x15,%eax
 782:	77 1c                	ja     7a0 <printf+0x90>
 784:	ff 24 85 6c 0a 00 00 	jmp    *0xa6c(,%eax,4)
 78b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 790:	8d 65 f4             	lea    -0xc(%ebp),%esp
 793:	5b                   	pop    %ebx
 794:	5e                   	pop    %esi
 795:	5f                   	pop    %edi
 796:	5d                   	pop    %ebp
 797:	c3                   	ret
 798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79f:	00 
  write(fd, &c, 1);
 7a0:	83 ec 04             	sub    $0x4,%esp
 7a3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 7a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7aa:	6a 01                	push   $0x1
 7ac:	52                   	push   %edx
 7ad:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 7b0:	57                   	push   %edi
 7b1:	e8 dd fd ff ff       	call   593 <write>
 7b6:	83 c4 0c             	add    $0xc,%esp
 7b9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 7bc:	6a 01                	push   $0x1
 7be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7c1:	52                   	push   %edx
 7c2:	57                   	push   %edi
 7c3:	e8 cb fd ff ff       	call   593 <write>
        putc(fd, c);
 7c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7cb:	31 d2                	xor    %edx,%edx
 7cd:	eb 8e                	jmp    75d <printf+0x4d>
 7cf:	90                   	nop
        printint(fd, *ap, 16, 0);
 7d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7d3:	83 ec 0c             	sub    $0xc,%esp
 7d6:	b9 10 00 00 00       	mov    $0x10,%ecx
 7db:	8b 13                	mov    (%ebx),%edx
 7dd:	6a 00                	push   $0x0
 7df:	89 f8                	mov    %edi,%eax
        ap++;
 7e1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 7e4:	e8 87 fe ff ff       	call   670 <printint>
        ap++;
 7e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 7ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7ef:	31 d2                	xor    %edx,%edx
 7f1:	e9 67 ff ff ff       	jmp    75d <printf+0x4d>
        s = (char*)*ap;
 7f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7f9:	8b 18                	mov    (%eax),%ebx
        ap++;
 7fb:	83 c0 04             	add    $0x4,%eax
 7fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 801:	85 db                	test   %ebx,%ebx
 803:	0f 84 87 00 00 00    	je     890 <printf+0x180>
        while(*s != 0){
 809:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 80c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 80e:	84 c0                	test   %al,%al
 810:	0f 84 47 ff ff ff    	je     75d <printf+0x4d>
 816:	8d 55 e7             	lea    -0x19(%ebp),%edx
 819:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 81c:	89 de                	mov    %ebx,%esi
 81e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 820:	83 ec 04             	sub    $0x4,%esp
 823:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 826:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 829:	6a 01                	push   $0x1
 82b:	53                   	push   %ebx
 82c:	57                   	push   %edi
 82d:	e8 61 fd ff ff       	call   593 <write>
        while(*s != 0){
 832:	0f b6 06             	movzbl (%esi),%eax
 835:	83 c4 10             	add    $0x10,%esp
 838:	84 c0                	test   %al,%al
 83a:	75 e4                	jne    820 <printf+0x110>
      state = 0;
 83c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 83f:	31 d2                	xor    %edx,%edx
 841:	e9 17 ff ff ff       	jmp    75d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 846:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 849:	83 ec 0c             	sub    $0xc,%esp
 84c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 851:	8b 13                	mov    (%ebx),%edx
 853:	6a 01                	push   $0x1
 855:	eb 88                	jmp    7df <printf+0xcf>
        putc(fd, *ap);
 857:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 85a:	83 ec 04             	sub    $0x4,%esp
 85d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 860:	8b 03                	mov    (%ebx),%eax
        ap++;
 862:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 865:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 868:	6a 01                	push   $0x1
 86a:	52                   	push   %edx
 86b:	57                   	push   %edi
 86c:	e8 22 fd ff ff       	call   593 <write>
        ap++;
 871:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 874:	83 c4 10             	add    $0x10,%esp
      state = 0;
 877:	31 d2                	xor    %edx,%edx
 879:	e9 df fe ff ff       	jmp    75d <printf+0x4d>
 87e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 880:	83 ec 04             	sub    $0x4,%esp
 883:	88 5d e7             	mov    %bl,-0x19(%ebp)
 886:	8d 55 e7             	lea    -0x19(%ebp),%edx
 889:	6a 01                	push   $0x1
 88b:	e9 31 ff ff ff       	jmp    7c1 <printf+0xb1>
 890:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 895:	bb 62 0a 00 00       	mov    $0xa62,%ebx
 89a:	e9 77 ff ff ff       	jmp    816 <printf+0x106>
 89f:	90                   	nop

000008a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a1:	a1 f8 0d 00 00       	mov    0xdf8,%eax
{
 8a6:	89 e5                	mov    %esp,%ebp
 8a8:	57                   	push   %edi
 8a9:	56                   	push   %esi
 8aa:	53                   	push   %ebx
 8ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 8ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ba:	39 c8                	cmp    %ecx,%eax
 8bc:	73 32                	jae    8f0 <free+0x50>
 8be:	39 d1                	cmp    %edx,%ecx
 8c0:	72 04                	jb     8c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c2:	39 d0                	cmp    %edx,%eax
 8c4:	72 32                	jb     8f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8cc:	39 fa                	cmp    %edi,%edx
 8ce:	74 30                	je     900 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8d3:	8b 50 04             	mov    0x4(%eax),%edx
 8d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8d9:	39 f1                	cmp    %esi,%ecx
 8db:	74 3a                	je     917 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8dd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8df:	5b                   	pop    %ebx
  freep = p;
 8e0:	a3 f8 0d 00 00       	mov    %eax,0xdf8
}
 8e5:	5e                   	pop    %esi
 8e6:	5f                   	pop    %edi
 8e7:	5d                   	pop    %ebp
 8e8:	c3                   	ret
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f0:	39 d0                	cmp    %edx,%eax
 8f2:	72 04                	jb     8f8 <free+0x58>
 8f4:	39 d1                	cmp    %edx,%ecx
 8f6:	72 ce                	jb     8c6 <free+0x26>
{
 8f8:	89 d0                	mov    %edx,%eax
 8fa:	eb bc                	jmp    8b8 <free+0x18>
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 900:	03 72 04             	add    0x4(%edx),%esi
 903:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 906:	8b 10                	mov    (%eax),%edx
 908:	8b 12                	mov    (%edx),%edx
 90a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 90d:	8b 50 04             	mov    0x4(%eax),%edx
 910:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 913:	39 f1                	cmp    %esi,%ecx
 915:	75 c6                	jne    8dd <free+0x3d>
    p->s.size += bp->s.size;
 917:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 91a:	a3 f8 0d 00 00       	mov    %eax,0xdf8
    p->s.size += bp->s.size;
 91f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 922:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 925:	89 08                	mov    %ecx,(%eax)
}
 927:	5b                   	pop    %ebx
 928:	5e                   	pop    %esi
 929:	5f                   	pop    %edi
 92a:	5d                   	pop    %ebp
 92b:	c3                   	ret
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000930 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 939:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 93c:	8b 15 f8 0d 00 00    	mov    0xdf8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 942:	8d 78 07             	lea    0x7(%eax),%edi
 945:	c1 ef 03             	shr    $0x3,%edi
 948:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 94b:	85 d2                	test   %edx,%edx
 94d:	0f 84 8d 00 00 00    	je     9e0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 953:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 955:	8b 48 04             	mov    0x4(%eax),%ecx
 958:	39 f9                	cmp    %edi,%ecx
 95a:	73 64                	jae    9c0 <malloc+0x90>
  if(nu < 4096)
 95c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 961:	39 df                	cmp    %ebx,%edi
 963:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 966:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 96d:	eb 0a                	jmp    979 <malloc+0x49>
 96f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 970:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 972:	8b 48 04             	mov    0x4(%eax),%ecx
 975:	39 f9                	cmp    %edi,%ecx
 977:	73 47                	jae    9c0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 979:	89 c2                	mov    %eax,%edx
 97b:	3b 05 f8 0d 00 00    	cmp    0xdf8,%eax
 981:	75 ed                	jne    970 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 983:	83 ec 0c             	sub    $0xc,%esp
 986:	56                   	push   %esi
 987:	e8 6f fc ff ff       	call   5fb <sbrk>
  if(p == (char*)-1)
 98c:	83 c4 10             	add    $0x10,%esp
 98f:	83 f8 ff             	cmp    $0xffffffff,%eax
 992:	74 1c                	je     9b0 <malloc+0x80>
  hp->s.size = nu;
 994:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 997:	83 ec 0c             	sub    $0xc,%esp
 99a:	83 c0 08             	add    $0x8,%eax
 99d:	50                   	push   %eax
 99e:	e8 fd fe ff ff       	call   8a0 <free>
  return freep;
 9a3:	8b 15 f8 0d 00 00    	mov    0xdf8,%edx
      if((p = morecore(nunits)) == 0)
 9a9:	83 c4 10             	add    $0x10,%esp
 9ac:	85 d2                	test   %edx,%edx
 9ae:	75 c0                	jne    970 <malloc+0x40>
        return 0;
  }
}
 9b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9b3:	31 c0                	xor    %eax,%eax
}
 9b5:	5b                   	pop    %ebx
 9b6:	5e                   	pop    %esi
 9b7:	5f                   	pop    %edi
 9b8:	5d                   	pop    %ebp
 9b9:	c3                   	ret
 9ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9c0:	39 cf                	cmp    %ecx,%edi
 9c2:	74 4c                	je     a10 <malloc+0xe0>
        p->s.size -= nunits;
 9c4:	29 f9                	sub    %edi,%ecx
 9c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9cc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 9cf:	89 15 f8 0d 00 00    	mov    %edx,0xdf8
}
 9d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9d8:	83 c0 08             	add    $0x8,%eax
}
 9db:	5b                   	pop    %ebx
 9dc:	5e                   	pop    %esi
 9dd:	5f                   	pop    %edi
 9de:	5d                   	pop    %ebp
 9df:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 9e0:	c7 05 f8 0d 00 00 fc 	movl   $0xdfc,0xdf8
 9e7:	0d 00 00 
    base.s.size = 0;
 9ea:	b8 fc 0d 00 00       	mov    $0xdfc,%eax
    base.s.ptr = freep = prevp = &base;
 9ef:	c7 05 fc 0d 00 00 fc 	movl   $0xdfc,0xdfc
 9f6:	0d 00 00 
    base.s.size = 0;
 9f9:	c7 05 00 0e 00 00 00 	movl   $0x0,0xe00
 a00:	00 00 00 
    if(p->s.size >= nunits){
 a03:	e9 54 ff ff ff       	jmp    95c <malloc+0x2c>
 a08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a0f:	00 
        prevp->s.ptr = p->s.ptr;
 a10:	8b 08                	mov    (%eax),%ecx
 a12:	89 0a                	mov    %ecx,(%edx)
 a14:	eb b9                	jmp    9cf <malloc+0x9f>
