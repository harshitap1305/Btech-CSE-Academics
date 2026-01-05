
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f 96 00 00 00    	jg     b7 <main+0xb7>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 68 14 00 00       	push   $0x1468
      2b:	e8 e3 0e 00 00       	call   f13 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 2e                	jmp    67 <main+0x67>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 82 1b 00 00 20 	cmpb   $0x20,0x1b82
      47:	0f 84 8d 00 00 00    	je     da <main+0xda>
      4d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 76 0e 00 00       	call   ecb <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 c1 00 00 00    	je     11f <main+0x11f>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	74 63                	je     c5 <main+0xc5>
    wait();
      62:	e8 74 0e 00 00       	call   edb <wait>
  printf(2, "12340920$");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 78 13 00 00       	push   $0x1378
      6f:	6a 02                	push   $0x2
      71:	e8 fa 0f 00 00       	call   1070 <printf>
  memset(buf, 0, nbuf);
      76:	83 c4 0c             	add    $0xc,%esp
      79:	6a 64                	push   $0x64
      7b:	6a 00                	push   $0x0
      7d:	68 80 1b 00 00       	push   $0x1b80
      82:	e8 c9 0c 00 00       	call   d50 <memset>
  gets(buf, nbuf);
      87:	58                   	pop    %eax
      88:	5a                   	pop    %edx
      89:	6a 64                	push   $0x64
      8b:	68 80 1b 00 00       	push   $0x1b80
      90:	e8 1b 0d 00 00       	call   db0 <gets>
  if(buf[0] == 0) // EOF
      95:	0f b6 05 80 1b 00 00 	movzbl 0x1b80,%eax
      9c:	83 c4 10             	add    $0x10,%esp
      9f:	84 c0                	test   %al,%al
      a1:	74 0f                	je     b2 <main+0xb2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a3:	3c 63                	cmp    $0x63,%al
      a5:	75 a9                	jne    50 <main+0x50>
      a7:	80 3d 81 1b 00 00 64 	cmpb   $0x64,0x1b81
      ae:	75 a0                	jne    50 <main+0x50>
      b0:	eb 8e                	jmp    40 <main+0x40>
  exit();
      b2:	e8 1c 0e 00 00       	call   ed3 <exit>
      close(fd);
      b7:	83 ec 0c             	sub    $0xc,%esp
      ba:	50                   	push   %eax
      bb:	e8 3b 0e 00 00       	call   efb <close>
      break;
      c0:	83 c4 10             	add    $0x10,%esp
      c3:	eb a2                	jmp    67 <main+0x67>
      runcmd(parsecmd(buf));
      c5:	83 ec 0c             	sub    $0xc,%esp
      c8:	68 80 1b 00 00       	push   $0x1b80
      cd:	e8 4e 0b 00 00       	call   c20 <parsecmd>
      d2:	89 04 24             	mov    %eax,(%esp)
      d5:	e8 d6 00 00 00       	call   1b0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      da:	83 ec 0c             	sub    $0xc,%esp
      dd:	68 80 1b 00 00       	push   $0x1b80
      e2:	e8 39 0c 00 00       	call   d20 <strlen>
      if(chdir(buf+3) < 0)
      e7:	c7 04 24 83 1b 00 00 	movl   $0x1b83,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ee:	c6 80 7f 1b 00 00 00 	movb   $0x0,0x1b7f(%eax)
      if(chdir(buf+3) < 0)
      f5:	e8 49 0e 00 00       	call   f43 <chdir>
      fa:	83 c4 10             	add    $0x10,%esp
      fd:	85 c0                	test   %eax,%eax
      ff:	0f 89 62 ff ff ff    	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
     105:	51                   	push   %ecx
     106:	68 83 1b 00 00       	push   $0x1b83
     10b:	68 70 14 00 00       	push   $0x1470
     110:	6a 02                	push   $0x2
     112:	e8 59 0f 00 00       	call   1070 <printf>
     117:	83 c4 10             	add    $0x10,%esp
     11a:	e9 48 ff ff ff       	jmp    67 <main+0x67>
    panic("fork");
     11f:	83 ec 0c             	sub    $0xc,%esp
     122:	68 82 13 00 00       	push   $0x1382
     127:	e8 44 00 00 00       	call   170 <panic>
     12c:	66 90                	xchg   %ax,%ax
     12e:	66 90                	xchg   %ax,%ax

00000130 <getcmd>:
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	56                   	push   %esi
     134:	53                   	push   %ebx
     135:	8b 5d 08             	mov    0x8(%ebp),%ebx
     138:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "12340920$");
     13b:	83 ec 08             	sub    $0x8,%esp
     13e:	68 78 13 00 00       	push   $0x1378
     143:	6a 02                	push   $0x2
     145:	e8 26 0f 00 00       	call   1070 <printf>
  memset(buf, 0, nbuf);
     14a:	83 c4 0c             	add    $0xc,%esp
     14d:	56                   	push   %esi
     14e:	6a 00                	push   $0x0
     150:	53                   	push   %ebx
     151:	e8 fa 0b 00 00       	call   d50 <memset>
  gets(buf, nbuf);
     156:	58                   	pop    %eax
     157:	5a                   	pop    %edx
     158:	56                   	push   %esi
     159:	53                   	push   %ebx
     15a:	e8 51 0c 00 00       	call   db0 <gets>
  if(buf[0] == 0) // EOF
     15f:	83 c4 10             	add    $0x10,%esp
     162:	80 3b 01             	cmpb   $0x1,(%ebx)
     165:	19 c0                	sbb    %eax,%eax
}
     167:	8d 65 f8             	lea    -0x8(%ebp),%esp
     16a:	5b                   	pop    %ebx
     16b:	5e                   	pop    %esi
     16c:	5d                   	pop    %ebp
     16d:	c3                   	ret
     16e:	66 90                	xchg   %ax,%ax

00000170 <panic>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     176:	ff 75 08             	push   0x8(%ebp)
     179:	68 64 14 00 00       	push   $0x1464
     17e:	6a 02                	push   $0x2
     180:	e8 eb 0e 00 00       	call   1070 <printf>
  exit();
     185:	e8 49 0d 00 00       	call   ed3 <exit>
     18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <fork1>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     196:	e8 30 0d 00 00       	call   ecb <fork>
  if(pid == -1)
     19b:	83 f8 ff             	cmp    $0xffffffff,%eax
     19e:	74 02                	je     1a2 <fork1+0x12>
  return pid;
}
     1a0:	c9                   	leave
     1a1:	c3                   	ret
    panic("fork");
     1a2:	83 ec 0c             	sub    $0xc,%esp
     1a5:	68 82 13 00 00       	push   $0x1382
     1aa:	e8 c1 ff ff ff       	call   170 <panic>
     1af:	90                   	nop

000001b0 <runcmd>:
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	53                   	push   %ebx
     1b4:	83 ec 14             	sub    $0x14,%esp
     1b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ba:	85 db                	test   %ebx,%ebx
     1bc:	74 1f                	je     1dd <runcmd+0x2d>
  switch(cmd->type){
     1be:	83 3b 05             	cmpl   $0x5,(%ebx)
     1c1:	0f 87 0d 01 00 00    	ja     2d4 <runcmd+0x124>
     1c7:	8b 03                	mov    (%ebx),%eax
     1c9:	ff 24 85 20 15 00 00 	jmp    *0x1520(,%eax,4)
    if(fork1() == 0)
     1d0:	e8 bb ff ff ff       	call   190 <fork1>
     1d5:	85 c0                	test   %eax,%eax
     1d7:	0f 84 ec 00 00 00    	je     2c9 <runcmd+0x119>
    exit();
     1dd:	e8 f1 0c 00 00       	call   ed3 <exit>
    if(ecmd->argv[0] == 0)
     1e2:	8b 43 04             	mov    0x4(%ebx),%eax
     1e5:	85 c0                	test   %eax,%eax
     1e7:	74 f4                	je     1dd <runcmd+0x2d>
if(strcmp(ecmd->argv[0], "touch") == 0){
     1e9:	52                   	push   %edx
     1ea:	52                   	push   %edx
     1eb:	68 8e 13 00 00       	push   $0x138e
     1f0:	50                   	push   %eax
     1f1:	e8 ca 0a 00 00       	call   cc0 <strcmp>
     1f6:	83 c4 10             	add    $0x10,%esp
     1f9:	85 c0                	test   %eax,%eax
     1fb:	0f 85 43 01 00 00    	jne    344 <runcmd+0x194>
  if(ecmd->argv[1] == 0){
     201:	8b 43 08             	mov    0x8(%ebx),%eax
     204:	85 c0                	test   %eax,%eax
     206:	0f 84 25 01 00 00    	je     331 <runcmd+0x181>
  int fd = open(ecmd->argv[1], O_CREATE|O_WRONLY);
     20c:	52                   	push   %edx
     20d:	52                   	push   %edx
     20e:	68 01 02 00 00       	push   $0x201
     213:	50                   	push   %eax
     214:	e8 fa 0c 00 00       	call   f13 <open>
  if(fd < 0){
     219:	83 c4 10             	add    $0x10,%esp
     21c:	85 c0                	test   %eax,%eax
     21e:	0f 88 99 01 00 00    	js     3bd <runcmd+0x20d>
  close(fd);
     224:	83 ec 0c             	sub    $0xc,%esp
     227:	50                   	push   %eax
     228:	e8 ce 0c 00 00       	call   efb <close>
  exit(); 
     22d:	e8 a1 0c 00 00       	call   ed3 <exit>
    if(pipe(p) < 0)
     232:	83 ec 0c             	sub    $0xc,%esp
     235:	8d 45 f0             	lea    -0x10(%ebp),%eax
     238:	50                   	push   %eax
     239:	e8 a5 0c 00 00       	call   ee3 <pipe>
     23e:	83 c4 10             	add    $0x10,%esp
     241:	85 c0                	test   %eax,%eax
     243:	0f 88 ad 00 00 00    	js     2f6 <runcmd+0x146>
    if(fork1() == 0){
     249:	e8 42 ff ff ff       	call   190 <fork1>
     24e:	85 c0                	test   %eax,%eax
     250:	0f 84 ad 00 00 00    	je     303 <runcmd+0x153>
    if(fork1() == 0){
     256:	e8 35 ff ff ff       	call   190 <fork1>
     25b:	85 c0                	test   %eax,%eax
     25d:	0f 85 34 01 00 00    	jne    397 <runcmd+0x1e7>
      close(0);
     263:	83 ec 0c             	sub    $0xc,%esp
     266:	6a 00                	push   $0x0
     268:	e8 8e 0c 00 00       	call   efb <close>
      dup(p[0]);
     26d:	5a                   	pop    %edx
     26e:	ff 75 f0             	push   -0x10(%ebp)
     271:	e8 d5 0c 00 00       	call   f4b <dup>
      close(p[0]);
     276:	59                   	pop    %ecx
     277:	ff 75 f0             	push   -0x10(%ebp)
     27a:	e8 7c 0c 00 00       	call   efb <close>
      close(p[1]);
     27f:	58                   	pop    %eax
     280:	ff 75 f4             	push   -0xc(%ebp)
     283:	e8 73 0c 00 00       	call   efb <close>
      runcmd(pcmd->right);
     288:	58                   	pop    %eax
     289:	ff 73 08             	push   0x8(%ebx)
     28c:	e8 1f ff ff ff       	call   1b0 <runcmd>
    if(fork1() == 0)
     291:	e8 fa fe ff ff       	call   190 <fork1>
     296:	85 c0                	test   %eax,%eax
     298:	74 2f                	je     2c9 <runcmd+0x119>
    wait();
     29a:	e8 3c 0c 00 00       	call   edb <wait>
    runcmd(lcmd->right);
     29f:	83 ec 0c             	sub    $0xc,%esp
     2a2:	ff 73 08             	push   0x8(%ebx)
     2a5:	e8 06 ff ff ff       	call   1b0 <runcmd>
    close(rcmd->fd);
     2aa:	83 ec 0c             	sub    $0xc,%esp
     2ad:	ff 73 14             	push   0x14(%ebx)
     2b0:	e8 46 0c 00 00       	call   efb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2b5:	58                   	pop    %eax
     2b6:	5a                   	pop    %edx
     2b7:	ff 73 10             	push   0x10(%ebx)
     2ba:	ff 73 08             	push   0x8(%ebx)
     2bd:	e8 51 0c 00 00       	call   f13 <open>
     2c2:	83 c4 10             	add    $0x10,%esp
     2c5:	85 c0                	test   %eax,%eax
     2c7:	78 18                	js     2e1 <runcmd+0x131>
      runcmd(bcmd->cmd);
     2c9:	83 ec 0c             	sub    $0xc,%esp
     2cc:	ff 73 04             	push   0x4(%ebx)
     2cf:	e8 dc fe ff ff       	call   1b0 <runcmd>
    panic("runcmd");
     2d4:	83 ec 0c             	sub    $0xc,%esp
     2d7:	68 87 13 00 00       	push   $0x1387
     2dc:	e8 8f fe ff ff       	call   170 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     2e1:	51                   	push   %ecx
     2e2:	ff 73 08             	push   0x8(%ebx)
     2e5:	68 e6 13 00 00       	push   $0x13e6
     2ea:	6a 02                	push   $0x2
     2ec:	e8 7f 0d 00 00       	call   1070 <printf>
      exit();
     2f1:	e8 dd 0b 00 00       	call   ed3 <exit>
      panic("pipe");
     2f6:	83 ec 0c             	sub    $0xc,%esp
     2f9:	68 f6 13 00 00       	push   $0x13f6
     2fe:	e8 6d fe ff ff       	call   170 <panic>
      close(1);
     303:	83 ec 0c             	sub    $0xc,%esp
     306:	6a 01                	push   $0x1
     308:	e8 ee 0b 00 00       	call   efb <close>
      dup(p[1]);
     30d:	58                   	pop    %eax
     30e:	ff 75 f4             	push   -0xc(%ebp)
     311:	e8 35 0c 00 00       	call   f4b <dup>
      close(p[0]);
     316:	58                   	pop    %eax
     317:	ff 75 f0             	push   -0x10(%ebp)
     31a:	e8 dc 0b 00 00       	call   efb <close>
      close(p[1]);
     31f:	58                   	pop    %eax
     320:	ff 75 f4             	push   -0xc(%ebp)
     323:	e8 d3 0b 00 00       	call   efb <close>
      runcmd(pcmd->left);
     328:	5a                   	pop    %edx
     329:	ff 73 04             	push   0x4(%ebx)
     32c:	e8 7f fe ff ff       	call   1b0 <runcmd>
    printf(2, "touch: missing file operand\n");
     331:	51                   	push   %ecx
     332:	51                   	push   %ecx
     333:	68 94 13 00 00       	push   $0x1394
     338:	6a 02                	push   $0x2
     33a:	e8 31 0d 00 00       	call   1070 <printf>
    exit();
     33f:	e8 8f 0b 00 00       	call   ed3 <exit>
if(strcmp(ecmd->argv[0], "help") == 0){
     344:	51                   	push   %ecx
     345:	51                   	push   %ecx
     346:	68 ca 13 00 00       	push   $0x13ca
     34b:	ff 73 04             	push   0x4(%ebx)
     34e:	e8 6d 09 00 00       	call   cc0 <strcmp>
     353:	83 c4 10             	add    $0x10,%esp
     356:	85 c0                	test   %eax,%eax
     358:	75 78                	jne    3d2 <runcmd+0x222>
  printf(2, "help - show this help\n");
     35a:	53                   	push   %ebx
     35b:	53                   	push   %ebx
     35c:	68 cf 13 00 00       	push   $0x13cf
     361:	6a 02                	push   $0x2
     363:	e8 08 0d 00 00       	call   1070 <printf>
  printf(2, "touch <file> - create new file\n");
     368:	58                   	pop    %eax
     369:	5a                   	pop    %edx
     36a:	68 88 14 00 00       	push   $0x1488
     36f:	6a 02                	push   $0x2
     371:	e8 fa 0c 00 00       	call   1070 <printf>
  printf(2, "press ctrl+A then X - exit xv6 shell\n");
     376:	59                   	pop    %ecx
     377:	5b                   	pop    %ebx
     378:	68 a8 14 00 00       	push   $0x14a8
     37d:	6a 02                	push   $0x2
     37f:	e8 ec 0c 00 00       	call   1070 <printf>
  printf(2, "teststrrev - Prints your name in reverse\n");
     384:	58                   	pop    %eax
     385:	5a                   	pop    %edx
     386:	68 d0 14 00 00       	push   $0x14d0
     38b:	6a 02                	push   $0x2
     38d:	e8 de 0c 00 00       	call   1070 <printf>
  exit();
     392:	e8 3c 0b 00 00       	call   ed3 <exit>
    close(p[0]);
     397:	83 ec 0c             	sub    $0xc,%esp
     39a:	ff 75 f0             	push   -0x10(%ebp)
     39d:	e8 59 0b 00 00       	call   efb <close>
    close(p[1]);
     3a2:	58                   	pop    %eax
     3a3:	ff 75 f4             	push   -0xc(%ebp)
     3a6:	e8 50 0b 00 00       	call   efb <close>
    wait();
     3ab:	e8 2b 0b 00 00       	call   edb <wait>
    wait();
     3b0:	e8 26 0b 00 00       	call   edb <wait>
    break;
     3b5:	83 c4 10             	add    $0x10,%esp
     3b8:	e9 20 fe ff ff       	jmp    1dd <runcmd+0x2d>
    printf(2, "touch: cannot create %s\n", ecmd->argv[1]);
     3bd:	50                   	push   %eax
     3be:	ff 73 08             	push   0x8(%ebx)
     3c1:	68 b1 13 00 00       	push   $0x13b1
     3c6:	6a 02                	push   $0x2
     3c8:	e8 a3 0c 00 00       	call   1070 <printf>
    exit();
     3cd:	e8 01 0b 00 00       	call   ed3 <exit>
    exec(ecmd->argv[0], ecmd->argv);
     3d2:	8d 43 04             	lea    0x4(%ebx),%eax
     3d5:	51                   	push   %ecx
     3d6:	51                   	push   %ecx
     3d7:	50                   	push   %eax
     3d8:	ff 73 04             	push   0x4(%ebx)
     3db:	e8 2b 0b 00 00       	call   f0b <exec>
    printf(2, "Unknown command or exec failed: %s\n", ecmd->argv[0]);
     3e0:	83 c4 0c             	add    $0xc,%esp
     3e3:	ff 73 04             	push   0x4(%ebx)
     3e6:	68 fc 14 00 00       	push   $0x14fc
     3eb:	6a 02                	push   $0x2
     3ed:	e8 7e 0c 00 00       	call   1070 <printf>
    break;
     3f2:	83 c4 10             	add    $0x10,%esp
     3f5:	e9 e3 fd ff ff       	jmp    1dd <runcmd+0x2d>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	6a 54                	push   $0x54
     409:	e8 82 0e 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40e:	83 c4 0c             	add    $0xc,%esp
     411:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     413:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     415:	6a 00                	push   $0x0
     417:	50                   	push   %eax
     418:	e8 33 09 00 00       	call   d50 <memset>
  cmd->type = EXEC;
     41d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     423:	89 d8                	mov    %ebx,%eax
     425:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     428:	c9                   	leave
     429:	c3                   	ret
     42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	6a 18                	push   $0x18
     439:	e8 52 0e 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     43e:	83 c4 0c             	add    $0xc,%esp
     441:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     443:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     445:	6a 00                	push   $0x0
     447:	50                   	push   %eax
     448:	e8 03 09 00 00       	call   d50 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     44d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     450:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     456:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     459:	8b 45 0c             	mov    0xc(%ebp),%eax
     45c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     45f:	8b 45 10             	mov    0x10(%ebp),%eax
     462:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     465:	8b 45 14             	mov    0x14(%ebp),%eax
     468:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     46b:	8b 45 18             	mov    0x18(%ebp),%eax
     46e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     471:	89 d8                	mov    %ebx,%eax
     473:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     476:	c9                   	leave
     477:	c3                   	ret
     478:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     47f:	00 

00000480 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	53                   	push   %ebx
     484:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     487:	6a 0c                	push   $0xc
     489:	e8 02 0e 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     48e:	83 c4 0c             	add    $0xc,%esp
     491:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     493:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     495:	6a 00                	push   $0x0
     497:	50                   	push   %eax
     498:	e8 b3 08 00 00       	call   d50 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     49d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     4a0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     4a6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ac:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4af:	89 d8                	mov    %ebx,%eax
     4b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4b4:	c9                   	leave
     4b5:	c3                   	ret
     4b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4bd:	00 
     4be:	66 90                	xchg   %ax,%ax

000004c0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	53                   	push   %ebx
     4c4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4c7:	6a 0c                	push   $0xc
     4c9:	e8 c2 0d 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4ce:	83 c4 0c             	add    $0xc,%esp
     4d1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     4d3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4d5:	6a 00                	push   $0x0
     4d7:	50                   	push   %eax
     4d8:	e8 73 08 00 00       	call   d50 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4dd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4e0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4e6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ec:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4ef:	89 d8                	mov    %ebx,%eax
     4f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4f4:	c9                   	leave
     4f5:	c3                   	ret
     4f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4fd:	00 
     4fe:	66 90                	xchg   %ax,%ax

00000500 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	53                   	push   %ebx
     504:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     507:	6a 08                	push   $0x8
     509:	e8 82 0d 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     50e:	83 c4 0c             	add    $0xc,%esp
     511:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     513:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     515:	6a 00                	push   $0x0
     517:	50                   	push   %eax
     518:	e8 33 08 00 00       	call   d50 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     51d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     520:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     526:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     529:	89 d8                	mov    %ebx,%eax
     52b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     52e:	c9                   	leave
     52f:	c3                   	ret

00000530 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	57                   	push   %edi
     534:	56                   	push   %esi
     535:	53                   	push   %ebx
     536:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     539:	8b 45 08             	mov    0x8(%ebp),%eax
{
     53c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     53f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     542:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     544:	39 df                	cmp    %ebx,%edi
     546:	72 0f                	jb     557 <gettoken+0x27>
     548:	eb 25                	jmp    56f <gettoken+0x3f>
     54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     550:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     553:	39 fb                	cmp    %edi,%ebx
     555:	74 18                	je     56f <gettoken+0x3f>
     557:	0f be 07             	movsbl (%edi),%eax
     55a:	83 ec 08             	sub    $0x8,%esp
     55d:	50                   	push   %eax
     55e:	68 78 1b 00 00       	push   $0x1b78
     563:	e8 08 08 00 00       	call   d70 <strchr>
     568:	83 c4 10             	add    $0x10,%esp
     56b:	85 c0                	test   %eax,%eax
     56d:	75 e1                	jne    550 <gettoken+0x20>
  if(q)
     56f:	85 f6                	test   %esi,%esi
     571:	74 02                	je     575 <gettoken+0x45>
    *q = s;
     573:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     575:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     578:	3c 3c                	cmp    $0x3c,%al
     57a:	0f 8f c8 00 00 00    	jg     648 <gettoken+0x118>
     580:	3c 3a                	cmp    $0x3a,%al
     582:	7f 5a                	jg     5de <gettoken+0xae>
     584:	84 c0                	test   %al,%al
     586:	75 48                	jne    5d0 <gettoken+0xa0>
     588:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     58a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     58d:	85 c9                	test   %ecx,%ecx
     58f:	74 05                	je     596 <gettoken+0x66>
    *eq = s;
     591:	8b 45 14             	mov    0x14(%ebp),%eax
     594:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     596:	39 df                	cmp    %ebx,%edi
     598:	72 0d                	jb     5a7 <gettoken+0x77>
     59a:	eb 23                	jmp    5bf <gettoken+0x8f>
     59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     5a0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     5a3:	39 fb                	cmp    %edi,%ebx
     5a5:	74 18                	je     5bf <gettoken+0x8f>
     5a7:	0f be 07             	movsbl (%edi),%eax
     5aa:	83 ec 08             	sub    $0x8,%esp
     5ad:	50                   	push   %eax
     5ae:	68 78 1b 00 00       	push   $0x1b78
     5b3:	e8 b8 07 00 00       	call   d70 <strchr>
     5b8:	83 c4 10             	add    $0x10,%esp
     5bb:	85 c0                	test   %eax,%eax
     5bd:	75 e1                	jne    5a0 <gettoken+0x70>
  *ps = s;
     5bf:	8b 45 08             	mov    0x8(%ebp),%eax
     5c2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5c7:	89 f0                	mov    %esi,%eax
     5c9:	5b                   	pop    %ebx
     5ca:	5e                   	pop    %esi
     5cb:	5f                   	pop    %edi
     5cc:	5d                   	pop    %ebp
     5cd:	c3                   	ret
     5ce:	66 90                	xchg   %ax,%ax
  switch(*s){
     5d0:	78 22                	js     5f4 <gettoken+0xc4>
     5d2:	3c 26                	cmp    $0x26,%al
     5d4:	74 08                	je     5de <gettoken+0xae>
     5d6:	8d 48 d8             	lea    -0x28(%eax),%ecx
     5d9:	80 f9 01             	cmp    $0x1,%cl
     5dc:	77 16                	ja     5f4 <gettoken+0xc4>
  ret = *s;
     5de:	0f be f0             	movsbl %al,%esi
    s++;
     5e1:	83 c7 01             	add    $0x1,%edi
    break;
     5e4:	eb a4                	jmp    58a <gettoken+0x5a>
     5e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5ed:	00 
     5ee:	66 90                	xchg   %ax,%ax
  switch(*s){
     5f0:	3c 7c                	cmp    $0x7c,%al
     5f2:	74 ea                	je     5de <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f4:	39 df                	cmp    %ebx,%edi
     5f6:	72 27                	jb     61f <gettoken+0xef>
     5f8:	e9 87 00 00 00       	jmp    684 <gettoken+0x154>
     5fd:	8d 76 00             	lea    0x0(%esi),%esi
     600:	0f be 07             	movsbl (%edi),%eax
     603:	83 ec 08             	sub    $0x8,%esp
     606:	50                   	push   %eax
     607:	68 70 1b 00 00       	push   $0x1b70
     60c:	e8 5f 07 00 00       	call   d70 <strchr>
     611:	83 c4 10             	add    $0x10,%esp
     614:	85 c0                	test   %eax,%eax
     616:	75 1f                	jne    637 <gettoken+0x107>
      s++;
     618:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     61b:	39 fb                	cmp    %edi,%ebx
     61d:	74 4d                	je     66c <gettoken+0x13c>
     61f:	0f be 07             	movsbl (%edi),%eax
     622:	83 ec 08             	sub    $0x8,%esp
     625:	50                   	push   %eax
     626:	68 78 1b 00 00       	push   $0x1b78
     62b:	e8 40 07 00 00       	call   d70 <strchr>
     630:	83 c4 10             	add    $0x10,%esp
     633:	85 c0                	test   %eax,%eax
     635:	74 c9                	je     600 <gettoken+0xd0>
    ret = 'a';
     637:	be 61 00 00 00       	mov    $0x61,%esi
     63c:	e9 49 ff ff ff       	jmp    58a <gettoken+0x5a>
     641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     648:	3c 3e                	cmp    $0x3e,%al
     64a:	75 a4                	jne    5f0 <gettoken+0xc0>
    if(*s == '>'){
     64c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     650:	74 0d                	je     65f <gettoken+0x12f>
    s++;
     652:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     655:	be 3e 00 00 00       	mov    $0x3e,%esi
     65a:	e9 2b ff ff ff       	jmp    58a <gettoken+0x5a>
      s++;
     65f:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     662:	be 2b 00 00 00       	mov    $0x2b,%esi
     667:	e9 1e ff ff ff       	jmp    58a <gettoken+0x5a>
  if(eq)
     66c:	8b 45 14             	mov    0x14(%ebp),%eax
     66f:	85 c0                	test   %eax,%eax
     671:	74 05                	je     678 <gettoken+0x148>
    *eq = s;
     673:	8b 45 14             	mov    0x14(%ebp),%eax
     676:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     678:	89 df                	mov    %ebx,%edi
    ret = 'a';
     67a:	be 61 00 00 00       	mov    $0x61,%esi
     67f:	e9 3b ff ff ff       	jmp    5bf <gettoken+0x8f>
  if(eq)
     684:	8b 55 14             	mov    0x14(%ebp),%edx
     687:	85 d2                	test   %edx,%edx
     689:	74 ef                	je     67a <gettoken+0x14a>
    *eq = s;
     68b:	8b 45 14             	mov    0x14(%ebp),%eax
     68e:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     690:	eb e8                	jmp    67a <gettoken+0x14a>
     692:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     699:	00 
     69a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006a0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	57                   	push   %edi
     6a4:	56                   	push   %esi
     6a5:	53                   	push   %ebx
     6a6:	83 ec 0c             	sub    $0xc,%esp
     6a9:	8b 7d 08             	mov    0x8(%ebp),%edi
     6ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     6af:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     6b1:	39 f3                	cmp    %esi,%ebx
     6b3:	72 12                	jb     6c7 <peek+0x27>
     6b5:	eb 28                	jmp    6df <peek+0x3f>
     6b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6be:	00 
     6bf:	90                   	nop
    s++;
     6c0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     6c3:	39 de                	cmp    %ebx,%esi
     6c5:	74 18                	je     6df <peek+0x3f>
     6c7:	0f be 03             	movsbl (%ebx),%eax
     6ca:	83 ec 08             	sub    $0x8,%esp
     6cd:	50                   	push   %eax
     6ce:	68 78 1b 00 00       	push   $0x1b78
     6d3:	e8 98 06 00 00       	call   d70 <strchr>
     6d8:	83 c4 10             	add    $0x10,%esp
     6db:	85 c0                	test   %eax,%eax
     6dd:	75 e1                	jne    6c0 <peek+0x20>
  *ps = s;
     6df:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6e1:	0f be 03             	movsbl (%ebx),%eax
     6e4:	31 d2                	xor    %edx,%edx
     6e6:	84 c0                	test   %al,%al
     6e8:	75 0e                	jne    6f8 <peek+0x58>
}
     6ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6ed:	89 d0                	mov    %edx,%eax
     6ef:	5b                   	pop    %ebx
     6f0:	5e                   	pop    %esi
     6f1:	5f                   	pop    %edi
     6f2:	5d                   	pop    %ebp
     6f3:	c3                   	ret
     6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     6f8:	83 ec 08             	sub    $0x8,%esp
     6fb:	50                   	push   %eax
     6fc:	ff 75 10             	push   0x10(%ebp)
     6ff:	e8 6c 06 00 00       	call   d70 <strchr>
     704:	83 c4 10             	add    $0x10,%esp
     707:	31 d2                	xor    %edx,%edx
     709:	85 c0                	test   %eax,%eax
     70b:	0f 95 c2             	setne  %dl
}
     70e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     711:	5b                   	pop    %ebx
     712:	89 d0                	mov    %edx,%eax
     714:	5e                   	pop    %esi
     715:	5f                   	pop    %edi
     716:	5d                   	pop    %ebp
     717:	c3                   	ret
     718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     71f:	00 

00000720 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	83 ec 2c             	sub    $0x2c,%esp
     729:	8b 75 0c             	mov    0xc(%ebp),%esi
     72c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     72f:	90                   	nop
     730:	83 ec 04             	sub    $0x4,%esp
     733:	68 18 14 00 00       	push   $0x1418
     738:	53                   	push   %ebx
     739:	56                   	push   %esi
     73a:	e8 61 ff ff ff       	call   6a0 <peek>
     73f:	83 c4 10             	add    $0x10,%esp
     742:	85 c0                	test   %eax,%eax
     744:	0f 84 f6 00 00 00    	je     840 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     74a:	6a 00                	push   $0x0
     74c:	6a 00                	push   $0x0
     74e:	53                   	push   %ebx
     74f:	56                   	push   %esi
     750:	e8 db fd ff ff       	call   530 <gettoken>
     755:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     757:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     75a:	50                   	push   %eax
     75b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     75e:	50                   	push   %eax
     75f:	53                   	push   %ebx
     760:	56                   	push   %esi
     761:	e8 ca fd ff ff       	call   530 <gettoken>
     766:	83 c4 20             	add    $0x20,%esp
     769:	83 f8 61             	cmp    $0x61,%eax
     76c:	0f 85 d9 00 00 00    	jne    84b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     772:	83 ff 3c             	cmp    $0x3c,%edi
     775:	74 69                	je     7e0 <parseredirs+0xc0>
     777:	83 ff 3e             	cmp    $0x3e,%edi
     77a:	74 05                	je     781 <parseredirs+0x61>
     77c:	83 ff 2b             	cmp    $0x2b,%edi
     77f:	75 af                	jne    730 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     781:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     784:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     787:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     78a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     78d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     790:	6a 18                	push   $0x18
     792:	e8 f9 0a 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     797:	83 c4 0c             	add    $0xc,%esp
     79a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     79c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     79e:	6a 00                	push   $0x0
     7a0:	50                   	push   %eax
     7a1:	e8 aa 05 00 00       	call   d50 <memset>
  cmd->type = REDIR;
     7a6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7ac:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     7af:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     7b2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7b5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     7b8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7bb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     7be:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     7c5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     7c8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     7cf:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     7d2:	e9 59 ff ff ff       	jmp    730 <parseredirs+0x10>
     7d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7de:	00 
     7df:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7e3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     7e6:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7e9:	89 55 d0             	mov    %edx,-0x30(%ebp)
     7ec:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7ef:	6a 18                	push   $0x18
     7f1:	e8 9a 0a 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7f6:	83 c4 0c             	add    $0xc,%esp
     7f9:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     7fb:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7fd:	6a 00                	push   $0x0
     7ff:	50                   	push   %eax
     800:	e8 4b 05 00 00       	call   d50 <memset>
  cmd->cmd = subcmd;
     805:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     808:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     80b:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     80e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     811:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     817:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     81a:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     81d:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     820:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     827:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     82e:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     831:	e9 fa fe ff ff       	jmp    730 <parseredirs+0x10>
     836:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     83d:	00 
     83e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     840:	8b 45 08             	mov    0x8(%ebp),%eax
     843:	8d 65 f4             	lea    -0xc(%ebp),%esp
     846:	5b                   	pop    %ebx
     847:	5e                   	pop    %esi
     848:	5f                   	pop    %edi
     849:	5d                   	pop    %ebp
     84a:	c3                   	ret
      panic("missing file for redirection");
     84b:	83 ec 0c             	sub    $0xc,%esp
     84e:	68 fb 13 00 00       	push   $0x13fb
     853:	e8 18 f9 ff ff       	call   170 <panic>
     858:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     85f:	00 

00000860 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
     866:	83 ec 30             	sub    $0x30,%esp
     869:	8b 5d 08             	mov    0x8(%ebp),%ebx
     86c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     86f:	68 1b 14 00 00       	push   $0x141b
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	e8 25 fe ff ff       	call   6a0 <peek>
     87b:	83 c4 10             	add    $0x10,%esp
     87e:	85 c0                	test   %eax,%eax
     880:	0f 85 aa 00 00 00    	jne    930 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     886:	83 ec 0c             	sub    $0xc,%esp
     889:	89 c7                	mov    %eax,%edi
     88b:	6a 54                	push   $0x54
     88d:	e8 fe 09 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     892:	83 c4 0c             	add    $0xc,%esp
     895:	6a 54                	push   $0x54
     897:	6a 00                	push   $0x0
     899:	89 45 d0             	mov    %eax,-0x30(%ebp)
     89c:	50                   	push   %eax
     89d:	e8 ae 04 00 00       	call   d50 <memset>
  cmd->type = EXEC;
     8a2:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     8a5:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     8a8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     8ae:	56                   	push   %esi
     8af:	53                   	push   %ebx
     8b0:	50                   	push   %eax
     8b1:	e8 6a fe ff ff       	call   720 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     8b6:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     8b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8bc:	eb 15                	jmp    8d3 <parseexec+0x73>
     8be:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     8c0:	83 ec 04             	sub    $0x4,%esp
     8c3:	56                   	push   %esi
     8c4:	53                   	push   %ebx
     8c5:	ff 75 d4             	push   -0x2c(%ebp)
     8c8:	e8 53 fe ff ff       	call   720 <parseredirs>
     8cd:	83 c4 10             	add    $0x10,%esp
     8d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8d3:	83 ec 04             	sub    $0x4,%esp
     8d6:	68 32 14 00 00       	push   $0x1432
     8db:	56                   	push   %esi
     8dc:	53                   	push   %ebx
     8dd:	e8 be fd ff ff       	call   6a0 <peek>
     8e2:	83 c4 10             	add    $0x10,%esp
     8e5:	85 c0                	test   %eax,%eax
     8e7:	75 5f                	jne    948 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     8e9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8ec:	50                   	push   %eax
     8ed:	8d 45 e0             	lea    -0x20(%ebp),%eax
     8f0:	50                   	push   %eax
     8f1:	56                   	push   %esi
     8f2:	53                   	push   %ebx
     8f3:	e8 38 fc ff ff       	call   530 <gettoken>
     8f8:	83 c4 10             	add    $0x10,%esp
     8fb:	85 c0                	test   %eax,%eax
     8fd:	74 49                	je     948 <parseexec+0xe8>
    if(tok != 'a')
     8ff:	83 f8 61             	cmp    $0x61,%eax
     902:	75 62                	jne    966 <parseexec+0x106>
    cmd->argv[argc] = q;
     904:	8b 45 e0             	mov    -0x20(%ebp),%eax
     907:	8b 55 d0             	mov    -0x30(%ebp),%edx
     90a:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     90e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     911:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     915:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     918:	83 ff 0a             	cmp    $0xa,%edi
     91b:	75 a3                	jne    8c0 <parseexec+0x60>
      panic("too many args");
     91d:	83 ec 0c             	sub    $0xc,%esp
     920:	68 24 14 00 00       	push   $0x1424
     925:	e8 46 f8 ff ff       	call   170 <panic>
     92a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     930:	89 75 0c             	mov    %esi,0xc(%ebp)
     933:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     936:	8d 65 f4             	lea    -0xc(%ebp),%esp
     939:	5b                   	pop    %ebx
     93a:	5e                   	pop    %esi
     93b:	5f                   	pop    %edi
     93c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     93d:	e9 ae 01 00 00       	jmp    af0 <parseblock>
     942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     948:	8b 45 d0             	mov    -0x30(%ebp),%eax
     94b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     952:	00 
  cmd->eargv[argc] = 0;
     953:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     95a:	00 
}
     95b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     95e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     961:	5b                   	pop    %ebx
     962:	5e                   	pop    %esi
     963:	5f                   	pop    %edi
     964:	5d                   	pop    %ebp
     965:	c3                   	ret
      panic("syntax");
     966:	83 ec 0c             	sub    $0xc,%esp
     969:	68 1d 14 00 00       	push   $0x141d
     96e:	e8 fd f7 ff ff       	call   170 <panic>
     973:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     97a:	00 
     97b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000980 <parsepipe>:
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	57                   	push   %edi
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	83 ec 14             	sub    $0x14,%esp
     989:	8b 75 08             	mov    0x8(%ebp),%esi
     98c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     98f:	57                   	push   %edi
     990:	56                   	push   %esi
     991:	e8 ca fe ff ff       	call   860 <parseexec>
  if(peek(ps, es, "|")){
     996:	83 c4 0c             	add    $0xc,%esp
     999:	68 37 14 00 00       	push   $0x1437
  cmd = parseexec(ps, es);
     99e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     9a0:	57                   	push   %edi
     9a1:	56                   	push   %esi
     9a2:	e8 f9 fc ff ff       	call   6a0 <peek>
     9a7:	83 c4 10             	add    $0x10,%esp
     9aa:	85 c0                	test   %eax,%eax
     9ac:	75 12                	jne    9c0 <parsepipe+0x40>
}
     9ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9b1:	89 d8                	mov    %ebx,%eax
     9b3:	5b                   	pop    %ebx
     9b4:	5e                   	pop    %esi
     9b5:	5f                   	pop    %edi
     9b6:	5d                   	pop    %ebp
     9b7:	c3                   	ret
     9b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9bf:	00 
    gettoken(ps, es, 0, 0);
     9c0:	6a 00                	push   $0x0
     9c2:	6a 00                	push   $0x0
     9c4:	57                   	push   %edi
     9c5:	56                   	push   %esi
     9c6:	e8 65 fb ff ff       	call   530 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9cb:	58                   	pop    %eax
     9cc:	5a                   	pop    %edx
     9cd:	57                   	push   %edi
     9ce:	56                   	push   %esi
     9cf:	e8 ac ff ff ff       	call   980 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     9d4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9db:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     9dd:	e8 ae 08 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9e2:	83 c4 0c             	add    $0xc,%esp
     9e5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     9e7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     9e9:	6a 00                	push   $0x0
     9eb:	50                   	push   %eax
     9ec:	e8 5f 03 00 00       	call   d50 <memset>
  cmd->left = left;
     9f1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     9f4:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9f7:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     9f9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     9ff:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a01:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a07:	5b                   	pop    %ebx
     a08:	5e                   	pop    %esi
     a09:	5f                   	pop    %edi
     a0a:	5d                   	pop    %ebp
     a0b:	c3                   	ret
     a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a10 <parseline>:
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	57                   	push   %edi
     a14:	56                   	push   %esi
     a15:	53                   	push   %ebx
     a16:	83 ec 24             	sub    $0x24,%esp
     a19:	8b 75 08             	mov    0x8(%ebp),%esi
     a1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     a1f:	57                   	push   %edi
     a20:	56                   	push   %esi
     a21:	e8 5a ff ff ff       	call   980 <parsepipe>
  while(peek(ps, es, "&")){
     a26:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     a29:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     a2b:	eb 3b                	jmp    a68 <parseline+0x58>
     a2d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     a30:	6a 00                	push   $0x0
     a32:	6a 00                	push   $0x0
     a34:	57                   	push   %edi
     a35:	56                   	push   %esi
     a36:	e8 f5 fa ff ff       	call   530 <gettoken>
  cmd = malloc(sizeof(*cmd));
     a3b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     a42:	e8 49 08 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a47:	83 c4 0c             	add    $0xc,%esp
     a4a:	6a 08                	push   $0x8
     a4c:	6a 00                	push   $0x0
     a4e:	50                   	push   %eax
     a4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a52:	e8 f9 02 00 00       	call   d50 <memset>
  cmd->type = BACK;
     a57:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     a5a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     a5d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     a63:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     a66:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     a68:	83 ec 04             	sub    $0x4,%esp
     a6b:	68 39 14 00 00       	push   $0x1439
     a70:	57                   	push   %edi
     a71:	56                   	push   %esi
     a72:	e8 29 fc ff ff       	call   6a0 <peek>
     a77:	83 c4 10             	add    $0x10,%esp
     a7a:	85 c0                	test   %eax,%eax
     a7c:	75 b2                	jne    a30 <parseline+0x20>
  if(peek(ps, es, ";")){
     a7e:	83 ec 04             	sub    $0x4,%esp
     a81:	68 35 14 00 00       	push   $0x1435
     a86:	57                   	push   %edi
     a87:	56                   	push   %esi
     a88:	e8 13 fc ff ff       	call   6a0 <peek>
     a8d:	83 c4 10             	add    $0x10,%esp
     a90:	85 c0                	test   %eax,%eax
     a92:	75 0c                	jne    aa0 <parseline+0x90>
}
     a94:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a97:	89 d8                	mov    %ebx,%eax
     a99:	5b                   	pop    %ebx
     a9a:	5e                   	pop    %esi
     a9b:	5f                   	pop    %edi
     a9c:	5d                   	pop    %ebp
     a9d:	c3                   	ret
     a9e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     aa0:	6a 00                	push   $0x0
     aa2:	6a 00                	push   $0x0
     aa4:	57                   	push   %edi
     aa5:	56                   	push   %esi
     aa6:	e8 85 fa ff ff       	call   530 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     aab:	58                   	pop    %eax
     aac:	5a                   	pop    %edx
     aad:	57                   	push   %edi
     aae:	56                   	push   %esi
     aaf:	e8 5c ff ff ff       	call   a10 <parseline>
  cmd = malloc(sizeof(*cmd));
     ab4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     abb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     abd:	e8 ce 07 00 00       	call   1290 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ac2:	83 c4 0c             	add    $0xc,%esp
     ac5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ac7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     ac9:	6a 00                	push   $0x0
     acb:	50                   	push   %eax
     acc:	e8 7f 02 00 00       	call   d50 <memset>
  cmd->left = left;
     ad1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ad4:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     ad7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     ad9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     adf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     ae1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     ae4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ae7:	5b                   	pop    %ebx
     ae8:	5e                   	pop    %esi
     ae9:	5f                   	pop    %edi
     aea:	5d                   	pop    %ebp
     aeb:	c3                   	ret
     aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000af0 <parseblock>:
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	57                   	push   %edi
     af4:	56                   	push   %esi
     af5:	53                   	push   %ebx
     af6:	83 ec 10             	sub    $0x10,%esp
     af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     afc:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     aff:	68 1b 14 00 00       	push   $0x141b
     b04:	56                   	push   %esi
     b05:	53                   	push   %ebx
     b06:	e8 95 fb ff ff       	call   6a0 <peek>
     b0b:	83 c4 10             	add    $0x10,%esp
     b0e:	85 c0                	test   %eax,%eax
     b10:	74 4a                	je     b5c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     b12:	6a 00                	push   $0x0
     b14:	6a 00                	push   $0x0
     b16:	56                   	push   %esi
     b17:	53                   	push   %ebx
     b18:	e8 13 fa ff ff       	call   530 <gettoken>
  cmd = parseline(ps, es);
     b1d:	58                   	pop    %eax
     b1e:	5a                   	pop    %edx
     b1f:	56                   	push   %esi
     b20:	53                   	push   %ebx
     b21:	e8 ea fe ff ff       	call   a10 <parseline>
  if(!peek(ps, es, ")"))
     b26:	83 c4 0c             	add    $0xc,%esp
     b29:	68 57 14 00 00       	push   $0x1457
  cmd = parseline(ps, es);
     b2e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     b30:	56                   	push   %esi
     b31:	53                   	push   %ebx
     b32:	e8 69 fb ff ff       	call   6a0 <peek>
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	85 c0                	test   %eax,%eax
     b3c:	74 2b                	je     b69 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     b3e:	6a 00                	push   $0x0
     b40:	6a 00                	push   $0x0
     b42:	56                   	push   %esi
     b43:	53                   	push   %ebx
     b44:	e8 e7 f9 ff ff       	call   530 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     b49:	83 c4 0c             	add    $0xc,%esp
     b4c:	56                   	push   %esi
     b4d:	53                   	push   %ebx
     b4e:	57                   	push   %edi
     b4f:	e8 cc fb ff ff       	call   720 <parseredirs>
}
     b54:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b57:	5b                   	pop    %ebx
     b58:	5e                   	pop    %esi
     b59:	5f                   	pop    %edi
     b5a:	5d                   	pop    %ebp
     b5b:	c3                   	ret
    panic("parseblock");
     b5c:	83 ec 0c             	sub    $0xc,%esp
     b5f:	68 3b 14 00 00       	push   $0x143b
     b64:	e8 07 f6 ff ff       	call   170 <panic>
    panic("syntax - missing )");
     b69:	83 ec 0c             	sub    $0xc,%esp
     b6c:	68 46 14 00 00       	push   $0x1446
     b71:	e8 fa f5 ff ff       	call   170 <panic>
     b76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b7d:	00 
     b7e:	66 90                	xchg   %ax,%ax

00000b80 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	53                   	push   %ebx
     b84:	83 ec 04             	sub    $0x4,%esp
     b87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b8a:	85 db                	test   %ebx,%ebx
     b8c:	74 29                	je     bb7 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
     b8e:	83 3b 05             	cmpl   $0x5,(%ebx)
     b91:	77 24                	ja     bb7 <nulterminate+0x37>
     b93:	8b 03                	mov    (%ebx),%eax
     b95:	ff 24 85 38 15 00 00 	jmp    *0x1538(,%eax,4)
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     ba0:	83 ec 0c             	sub    $0xc,%esp
     ba3:	ff 73 04             	push   0x4(%ebx)
     ba6:	e8 d5 ff ff ff       	call   b80 <nulterminate>
    nulterminate(lcmd->right);
     bab:	58                   	pop    %eax
     bac:	ff 73 08             	push   0x8(%ebx)
     baf:	e8 cc ff ff ff       	call   b80 <nulterminate>
    break;
     bb4:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     bb7:	89 d8                	mov    %ebx,%eax
     bb9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bbc:	c9                   	leave
     bbd:	c3                   	ret
     bbe:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     bc0:	83 ec 0c             	sub    $0xc,%esp
     bc3:	ff 73 04             	push   0x4(%ebx)
     bc6:	e8 b5 ff ff ff       	call   b80 <nulterminate>
}
     bcb:	89 d8                	mov    %ebx,%eax
    break;
     bcd:	83 c4 10             	add    $0x10,%esp
}
     bd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bd3:	c9                   	leave
     bd4:	c3                   	ret
     bd5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     bd8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     bdb:	85 c9                	test   %ecx,%ecx
     bdd:	74 d8                	je     bb7 <nulterminate+0x37>
     bdf:	8d 43 08             	lea    0x8(%ebx),%eax
     be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     be8:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     beb:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     bee:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     bf1:	8b 50 fc             	mov    -0x4(%eax),%edx
     bf4:	85 d2                	test   %edx,%edx
     bf6:	75 f0                	jne    be8 <nulterminate+0x68>
}
     bf8:	89 d8                	mov    %ebx,%eax
     bfa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bfd:	c9                   	leave
     bfe:	c3                   	ret
     bff:	90                   	nop
    nulterminate(rcmd->cmd);
     c00:	83 ec 0c             	sub    $0xc,%esp
     c03:	ff 73 04             	push   0x4(%ebx)
     c06:	e8 75 ff ff ff       	call   b80 <nulterminate>
    *rcmd->efile = 0;
     c0b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     c0e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     c11:	c6 00 00             	movb   $0x0,(%eax)
}
     c14:	89 d8                	mov    %ebx,%eax
     c16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c19:	c9                   	leave
     c1a:	c3                   	ret
     c1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000c20 <parsecmd>:
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	57                   	push   %edi
     c24:	56                   	push   %esi
  cmd = parseline(&s, es);
     c25:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     c28:	53                   	push   %ebx
     c29:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     c2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c2f:	53                   	push   %ebx
     c30:	e8 eb 00 00 00       	call   d20 <strlen>
  cmd = parseline(&s, es);
     c35:	59                   	pop    %ecx
     c36:	5e                   	pop    %esi
  es = s + strlen(s);
     c37:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     c39:	53                   	push   %ebx
     c3a:	57                   	push   %edi
     c3b:	e8 d0 fd ff ff       	call   a10 <parseline>
  peek(&s, es, "");
     c40:	83 c4 0c             	add    $0xc,%esp
     c43:	68 f5 13 00 00       	push   $0x13f5
  cmd = parseline(&s, es);
     c48:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     c4a:	53                   	push   %ebx
     c4b:	57                   	push   %edi
     c4c:	e8 4f fa ff ff       	call   6a0 <peek>
  if(s != es){
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	83 c4 10             	add    $0x10,%esp
     c57:	39 d8                	cmp    %ebx,%eax
     c59:	75 13                	jne    c6e <parsecmd+0x4e>
  nulterminate(cmd);
     c5b:	83 ec 0c             	sub    $0xc,%esp
     c5e:	56                   	push   %esi
     c5f:	e8 1c ff ff ff       	call   b80 <nulterminate>
}
     c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c67:	89 f0                	mov    %esi,%eax
     c69:	5b                   	pop    %ebx
     c6a:	5e                   	pop    %esi
     c6b:	5f                   	pop    %edi
     c6c:	5d                   	pop    %ebp
     c6d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     c6e:	52                   	push   %edx
     c6f:	50                   	push   %eax
     c70:	68 59 14 00 00       	push   $0x1459
     c75:	6a 02                	push   $0x2
     c77:	e8 f4 03 00 00       	call   1070 <printf>
    panic("syntax");
     c7c:	c7 04 24 1d 14 00 00 	movl   $0x141d,(%esp)
     c83:	e8 e8 f4 ff ff       	call   170 <panic>
     c88:	66 90                	xchg   %ax,%ax
     c8a:	66 90                	xchg   %ax,%ax
     c8c:	66 90                	xchg   %ax,%ax
     c8e:	66 90                	xchg   %ax,%ax

00000c90 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c90:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c91:	31 c0                	xor    %eax,%eax
{
     c93:	89 e5                	mov    %esp,%ebp
     c95:	53                   	push   %ebx
     c96:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     ca0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     ca4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     ca7:	83 c0 01             	add    $0x1,%eax
     caa:	84 d2                	test   %dl,%dl
     cac:	75 f2                	jne    ca0 <strcpy+0x10>
    ;
  return os;
}
     cae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cb1:	89 c8                	mov    %ecx,%eax
     cb3:	c9                   	leave
     cb4:	c3                   	ret
     cb5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cbc:	00 
     cbd:	8d 76 00             	lea    0x0(%esi),%esi

00000cc0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	53                   	push   %ebx
     cc4:	8b 55 08             	mov    0x8(%ebp),%edx
     cc7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     cca:	0f b6 02             	movzbl (%edx),%eax
     ccd:	84 c0                	test   %al,%al
     ccf:	75 17                	jne    ce8 <strcmp+0x28>
     cd1:	eb 3a                	jmp    d0d <strcmp+0x4d>
     cd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     cd8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     cdc:	83 c2 01             	add    $0x1,%edx
     cdf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     ce2:	84 c0                	test   %al,%al
     ce4:	74 1a                	je     d00 <strcmp+0x40>
     ce6:	89 d9                	mov    %ebx,%ecx
     ce8:	0f b6 19             	movzbl (%ecx),%ebx
     ceb:	38 c3                	cmp    %al,%bl
     ced:	74 e9                	je     cd8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     cef:	29 d8                	sub    %ebx,%eax
}
     cf1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cf4:	c9                   	leave
     cf5:	c3                   	ret
     cf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cfd:	00 
     cfe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     d00:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     d04:	31 c0                	xor    %eax,%eax
     d06:	29 d8                	sub    %ebx,%eax
}
     d08:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d0b:	c9                   	leave
     d0c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     d0d:	0f b6 19             	movzbl (%ecx),%ebx
     d10:	31 c0                	xor    %eax,%eax
     d12:	eb db                	jmp    cef <strcmp+0x2f>
     d14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d1b:	00 
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d20 <strlen>:

uint
strlen(const char *s)
{
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     d26:	80 3a 00             	cmpb   $0x0,(%edx)
     d29:	74 15                	je     d40 <strlen+0x20>
     d2b:	31 c0                	xor    %eax,%eax
     d2d:	8d 76 00             	lea    0x0(%esi),%esi
     d30:	83 c0 01             	add    $0x1,%eax
     d33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     d37:	89 c1                	mov    %eax,%ecx
     d39:	75 f5                	jne    d30 <strlen+0x10>
    ;
  return n;
}
     d3b:	89 c8                	mov    %ecx,%eax
     d3d:	5d                   	pop    %ebp
     d3e:	c3                   	ret
     d3f:	90                   	nop
  for(n = 0; s[n]; n++)
     d40:	31 c9                	xor    %ecx,%ecx
}
     d42:	5d                   	pop    %ebp
     d43:	89 c8                	mov    %ecx,%eax
     d45:	c3                   	ret
     d46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d4d:	00 
     d4e:	66 90                	xchg   %ax,%ax

00000d50 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     d57:	8b 4d 10             	mov    0x10(%ebp),%ecx
     d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5d:	89 d7                	mov    %edx,%edi
     d5f:	fc                   	cld
     d60:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     d62:	8b 7d fc             	mov    -0x4(%ebp),%edi
     d65:	89 d0                	mov    %edx,%eax
     d67:	c9                   	leave
     d68:	c3                   	ret
     d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d70 <strchr>:

char*
strchr(const char *s, char c)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d7a:	0f b6 10             	movzbl (%eax),%edx
     d7d:	84 d2                	test   %dl,%dl
     d7f:	75 12                	jne    d93 <strchr+0x23>
     d81:	eb 1d                	jmp    da0 <strchr+0x30>
     d83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     d88:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     d8c:	83 c0 01             	add    $0x1,%eax
     d8f:	84 d2                	test   %dl,%dl
     d91:	74 0d                	je     da0 <strchr+0x30>
    if(*s == c)
     d93:	38 d1                	cmp    %dl,%cl
     d95:	75 f1                	jne    d88 <strchr+0x18>
      return (char*)s;
  return 0;
}
     d97:	5d                   	pop    %ebp
     d98:	c3                   	ret
     d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     da0:	31 c0                	xor    %eax,%eax
}
     da2:	5d                   	pop    %ebp
     da3:	c3                   	ret
     da4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     dab:	00 
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000db0 <gets>:

char*
gets(char *buf, int max)
{
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	57                   	push   %edi
     db4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     db5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     db8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     db9:	31 db                	xor    %ebx,%ebx
{
     dbb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     dbe:	eb 27                	jmp    de7 <gets+0x37>
    cc = read(0, &c, 1);
     dc0:	83 ec 04             	sub    $0x4,%esp
     dc3:	6a 01                	push   $0x1
     dc5:	56                   	push   %esi
     dc6:	6a 00                	push   $0x0
     dc8:	e8 1e 01 00 00       	call   eeb <read>
    if(cc < 1)
     dcd:	83 c4 10             	add    $0x10,%esp
     dd0:	85 c0                	test   %eax,%eax
     dd2:	7e 1d                	jle    df1 <gets+0x41>
      break;
    buf[i++] = c;
     dd4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     dd8:	8b 55 08             	mov    0x8(%ebp),%edx
     ddb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     ddf:	3c 0a                	cmp    $0xa,%al
     de1:	74 10                	je     df3 <gets+0x43>
     de3:	3c 0d                	cmp    $0xd,%al
     de5:	74 0c                	je     df3 <gets+0x43>
  for(i=0; i+1 < max; ){
     de7:	89 df                	mov    %ebx,%edi
     de9:	83 c3 01             	add    $0x1,%ebx
     dec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     def:	7c cf                	jl     dc0 <gets+0x10>
     df1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     df3:	8b 45 08             	mov    0x8(%ebp),%eax
     df6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     dfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dfd:	5b                   	pop    %ebx
     dfe:	5e                   	pop    %esi
     dff:	5f                   	pop    %edi
     e00:	5d                   	pop    %ebp
     e01:	c3                   	ret
     e02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e09:	00 
     e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e10 <stat>:

int
stat(const char *n, struct stat *st)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	56                   	push   %esi
     e14:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e15:	83 ec 08             	sub    $0x8,%esp
     e18:	6a 00                	push   $0x0
     e1a:	ff 75 08             	push   0x8(%ebp)
     e1d:	e8 f1 00 00 00       	call   f13 <open>
  if(fd < 0)
     e22:	83 c4 10             	add    $0x10,%esp
     e25:	85 c0                	test   %eax,%eax
     e27:	78 27                	js     e50 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     e29:	83 ec 08             	sub    $0x8,%esp
     e2c:	ff 75 0c             	push   0xc(%ebp)
     e2f:	89 c3                	mov    %eax,%ebx
     e31:	50                   	push   %eax
     e32:	e8 f4 00 00 00       	call   f2b <fstat>
  close(fd);
     e37:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     e3a:	89 c6                	mov    %eax,%esi
  close(fd);
     e3c:	e8 ba 00 00 00       	call   efb <close>
  return r;
     e41:	83 c4 10             	add    $0x10,%esp
}
     e44:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e47:	89 f0                	mov    %esi,%eax
     e49:	5b                   	pop    %ebx
     e4a:	5e                   	pop    %esi
     e4b:	5d                   	pop    %ebp
     e4c:	c3                   	ret
     e4d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     e50:	be ff ff ff ff       	mov    $0xffffffff,%esi
     e55:	eb ed                	jmp    e44 <stat+0x34>
     e57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e5e:	00 
     e5f:	90                   	nop

00000e60 <atoi>:

int
atoi(const char *s)
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	53                   	push   %ebx
     e64:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e67:	0f be 02             	movsbl (%edx),%eax
     e6a:	8d 48 d0             	lea    -0x30(%eax),%ecx
     e6d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     e70:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     e75:	77 1e                	ja     e95 <atoi+0x35>
     e77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e7e:	00 
     e7f:	90                   	nop
    n = n*10 + *s++ - '0';
     e80:	83 c2 01             	add    $0x1,%edx
     e83:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     e86:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     e8a:	0f be 02             	movsbl (%edx),%eax
     e8d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     e90:	80 fb 09             	cmp    $0x9,%bl
     e93:	76 eb                	jbe    e80 <atoi+0x20>
  return n;
}
     e95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e98:	89 c8                	mov    %ecx,%eax
     e9a:	c9                   	leave
     e9b:	c3                   	ret
     e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ea0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	8b 45 10             	mov    0x10(%ebp),%eax
     ea7:	8b 55 08             	mov    0x8(%ebp),%edx
     eaa:	56                   	push   %esi
     eab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     eae:	85 c0                	test   %eax,%eax
     eb0:	7e 13                	jle    ec5 <memmove+0x25>
     eb2:	01 d0                	add    %edx,%eax
  dst = vdst;
     eb4:	89 d7                	mov    %edx,%edi
     eb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ebd:	00 
     ebe:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
     ec0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     ec1:	39 f8                	cmp    %edi,%eax
     ec3:	75 fb                	jne    ec0 <memmove+0x20>
  return vdst;
}
     ec5:	5e                   	pop    %esi
     ec6:	89 d0                	mov    %edx,%eax
     ec8:	5f                   	pop    %edi
     ec9:	5d                   	pop    %ebp
     eca:	c3                   	ret

00000ecb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ecb:	b8 01 00 00 00       	mov    $0x1,%eax
     ed0:	cd 40                	int    $0x40
     ed2:	c3                   	ret

00000ed3 <exit>:
SYSCALL(exit)
     ed3:	b8 02 00 00 00       	mov    $0x2,%eax
     ed8:	cd 40                	int    $0x40
     eda:	c3                   	ret

00000edb <wait>:
SYSCALL(wait)
     edb:	b8 03 00 00 00       	mov    $0x3,%eax
     ee0:	cd 40                	int    $0x40
     ee2:	c3                   	ret

00000ee3 <pipe>:
SYSCALL(pipe)
     ee3:	b8 04 00 00 00       	mov    $0x4,%eax
     ee8:	cd 40                	int    $0x40
     eea:	c3                   	ret

00000eeb <read>:
SYSCALL(read)
     eeb:	b8 05 00 00 00       	mov    $0x5,%eax
     ef0:	cd 40                	int    $0x40
     ef2:	c3                   	ret

00000ef3 <write>:
SYSCALL(write)
     ef3:	b8 10 00 00 00       	mov    $0x10,%eax
     ef8:	cd 40                	int    $0x40
     efa:	c3                   	ret

00000efb <close>:
SYSCALL(close)
     efb:	b8 15 00 00 00       	mov    $0x15,%eax
     f00:	cd 40                	int    $0x40
     f02:	c3                   	ret

00000f03 <kill>:
SYSCALL(kill)
     f03:	b8 06 00 00 00       	mov    $0x6,%eax
     f08:	cd 40                	int    $0x40
     f0a:	c3                   	ret

00000f0b <exec>:
SYSCALL(exec)
     f0b:	b8 07 00 00 00       	mov    $0x7,%eax
     f10:	cd 40                	int    $0x40
     f12:	c3                   	ret

00000f13 <open>:
SYSCALL(open)
     f13:	b8 0f 00 00 00       	mov    $0xf,%eax
     f18:	cd 40                	int    $0x40
     f1a:	c3                   	ret

00000f1b <mknod>:
SYSCALL(mknod)
     f1b:	b8 11 00 00 00       	mov    $0x11,%eax
     f20:	cd 40                	int    $0x40
     f22:	c3                   	ret

00000f23 <unlink>:
SYSCALL(unlink)
     f23:	b8 12 00 00 00       	mov    $0x12,%eax
     f28:	cd 40                	int    $0x40
     f2a:	c3                   	ret

00000f2b <fstat>:
SYSCALL(fstat)
     f2b:	b8 08 00 00 00       	mov    $0x8,%eax
     f30:	cd 40                	int    $0x40
     f32:	c3                   	ret

00000f33 <link>:
SYSCALL(link)
     f33:	b8 13 00 00 00       	mov    $0x13,%eax
     f38:	cd 40                	int    $0x40
     f3a:	c3                   	ret

00000f3b <mkdir>:
SYSCALL(mkdir)
     f3b:	b8 14 00 00 00       	mov    $0x14,%eax
     f40:	cd 40                	int    $0x40
     f42:	c3                   	ret

00000f43 <chdir>:
SYSCALL(chdir)
     f43:	b8 09 00 00 00       	mov    $0x9,%eax
     f48:	cd 40                	int    $0x40
     f4a:	c3                   	ret

00000f4b <dup>:
SYSCALL(dup)
     f4b:	b8 0a 00 00 00       	mov    $0xa,%eax
     f50:	cd 40                	int    $0x40
     f52:	c3                   	ret

00000f53 <getpid>:
SYSCALL(getpid)
     f53:	b8 0b 00 00 00       	mov    $0xb,%eax
     f58:	cd 40                	int    $0x40
     f5a:	c3                   	ret

00000f5b <sbrk>:
SYSCALL(sbrk)
     f5b:	b8 0c 00 00 00       	mov    $0xc,%eax
     f60:	cd 40                	int    $0x40
     f62:	c3                   	ret

00000f63 <sleep>:
SYSCALL(sleep)
     f63:	b8 0d 00 00 00       	mov    $0xd,%eax
     f68:	cd 40                	int    $0x40
     f6a:	c3                   	ret

00000f6b <uptime>:
SYSCALL(uptime)
     f6b:	b8 0e 00 00 00       	mov    $0xe,%eax
     f70:	cd 40                	int    $0x40
     f72:	c3                   	ret

00000f73 <strrev>:
SYSCALL(strrev)
     f73:	b8 19 00 00 00       	mov    $0x19,%eax
     f78:	cd 40                	int    $0x40
     f7a:	c3                   	ret

00000f7b <setflag>:
SYSCALL(setflag)
     f7b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     f80:	cd 40                	int    $0x40
     f82:	c3                   	ret

00000f83 <getflag>:
SYSCALL(getflag)
     f83:	b8 1b 00 00 00       	mov    $0x1b,%eax
     f88:	cd 40                	int    $0x40
     f8a:	c3                   	ret

00000f8b <getstats>:
SYSCALL(getstats)
     f8b:	b8 1c 00 00 00       	mov    $0x1c,%eax
     f90:	cd 40                	int    $0x40
     f92:	c3                   	ret

00000f93 <get_proc_info>:
SYSCALL(get_proc_info)
     f93:	b8 1d 00 00 00       	mov    $0x1d,%eax
     f98:	cd 40                	int    $0x40
     f9a:	c3                   	ret

00000f9b <numvp>:
SYSCALL(numvp)
     f9b:	b8 1e 00 00 00       	mov    $0x1e,%eax
     fa0:	cd 40                	int    $0x40
     fa2:	c3                   	ret

00000fa3 <numpp>:
SYSCALL(numpp)
     fa3:	b8 1f 00 00 00       	mov    $0x1f,%eax
     fa8:	cd 40                	int    $0x40
     faa:	c3                   	ret

00000fab <getptsize>:
SYSCALL(getptsize)
     fab:	b8 20 00 00 00       	mov    $0x20,%eax
     fb0:	cd 40                	int    $0x40
     fb2:	c3                   	ret

00000fb3 <setpriority>:
SYSCALL(setpriority)
     fb3:	b8 21 00 00 00       	mov    $0x21,%eax
     fb8:	cd 40                	int    $0x40
     fba:	c3                   	ret

00000fbb <getpagefaults>:
SYSCALL(getpagefaults)
     fbb:	b8 22 00 00 00       	mov    $0x22,%eax
     fc0:	cd 40                	int    $0x40
     fc2:	c3                   	ret

00000fc3 <twostrike>:
SYSCALL(twostrike)
     fc3:	b8 23 00 00 00       	mov    $0x23,%eax
     fc8:	cd 40                	int    $0x40
     fca:	c3                   	ret
     fcb:	66 90                	xchg   %ax,%ax
     fcd:	66 90                	xchg   %ax,%ax
     fcf:	90                   	nop

00000fd0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	57                   	push   %edi
     fd4:	56                   	push   %esi
     fd5:	53                   	push   %ebx
     fd6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     fd8:	89 d1                	mov    %edx,%ecx
{
     fda:	83 ec 3c             	sub    $0x3c,%esp
     fdd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
     fe0:	85 d2                	test   %edx,%edx
     fe2:	0f 89 80 00 00 00    	jns    1068 <printint+0x98>
     fe8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     fec:	74 7a                	je     1068 <printint+0x98>
    x = -xx;
     fee:	f7 d9                	neg    %ecx
    neg = 1;
     ff0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
     ff5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     ff8:	31 f6                	xor    %esi,%esi
     ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1000:	89 c8                	mov    %ecx,%eax
    1002:	31 d2                	xor    %edx,%edx
    1004:	89 f7                	mov    %esi,%edi
    1006:	f7 f3                	div    %ebx
    1008:	8d 76 01             	lea    0x1(%esi),%esi
    100b:	0f b6 92 a8 15 00 00 	movzbl 0x15a8(%edx),%edx
    1012:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    1016:	89 ca                	mov    %ecx,%edx
    1018:	89 c1                	mov    %eax,%ecx
    101a:	39 da                	cmp    %ebx,%edx
    101c:	73 e2                	jae    1000 <printint+0x30>
  if(neg)
    101e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1021:	85 c0                	test   %eax,%eax
    1023:	74 07                	je     102c <printint+0x5c>
    buf[i++] = '-';
    1025:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
    102a:	89 f7                	mov    %esi,%edi
    102c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    102f:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1032:	01 df                	add    %ebx,%edi
    1034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    1038:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    103b:	83 ec 04             	sub    $0x4,%esp
    103e:	88 45 d7             	mov    %al,-0x29(%ebp)
    1041:	8d 45 d7             	lea    -0x29(%ebp),%eax
    1044:	6a 01                	push   $0x1
    1046:	50                   	push   %eax
    1047:	56                   	push   %esi
    1048:	e8 a6 fe ff ff       	call   ef3 <write>
  while(--i >= 0)
    104d:	89 f8                	mov    %edi,%eax
    104f:	83 c4 10             	add    $0x10,%esp
    1052:	83 ef 01             	sub    $0x1,%edi
    1055:	39 c3                	cmp    %eax,%ebx
    1057:	75 df                	jne    1038 <printint+0x68>
}
    1059:	8d 65 f4             	lea    -0xc(%ebp),%esp
    105c:	5b                   	pop    %ebx
    105d:	5e                   	pop    %esi
    105e:	5f                   	pop    %edi
    105f:	5d                   	pop    %ebp
    1060:	c3                   	ret
    1061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1068:	31 c0                	xor    %eax,%eax
    106a:	eb 89                	jmp    ff5 <printint+0x25>
    106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001070 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	57                   	push   %edi
    1074:	56                   	push   %esi
    1075:	53                   	push   %ebx
    1076:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1079:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    107c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    107f:	0f b6 1e             	movzbl (%esi),%ebx
    1082:	83 c6 01             	add    $0x1,%esi
    1085:	84 db                	test   %bl,%bl
    1087:	74 67                	je     10f0 <printf+0x80>
    1089:	8d 4d 10             	lea    0x10(%ebp),%ecx
    108c:	31 d2                	xor    %edx,%edx
    108e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1091:	eb 34                	jmp    10c7 <printf+0x57>
    1093:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1098:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    109b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    10a0:	83 f8 25             	cmp    $0x25,%eax
    10a3:	74 18                	je     10bd <printf+0x4d>
  write(fd, &c, 1);
    10a5:	83 ec 04             	sub    $0x4,%esp
    10a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    10ab:	88 5d e7             	mov    %bl,-0x19(%ebp)
    10ae:	6a 01                	push   $0x1
    10b0:	50                   	push   %eax
    10b1:	57                   	push   %edi
    10b2:	e8 3c fe ff ff       	call   ef3 <write>
    10b7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    10ba:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    10bd:	0f b6 1e             	movzbl (%esi),%ebx
    10c0:	83 c6 01             	add    $0x1,%esi
    10c3:	84 db                	test   %bl,%bl
    10c5:	74 29                	je     10f0 <printf+0x80>
    c = fmt[i] & 0xff;
    10c7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    10ca:	85 d2                	test   %edx,%edx
    10cc:	74 ca                	je     1098 <printf+0x28>
      }
    } else if(state == '%'){
    10ce:	83 fa 25             	cmp    $0x25,%edx
    10d1:	75 ea                	jne    10bd <printf+0x4d>
      if(c == 'd'){
    10d3:	83 f8 25             	cmp    $0x25,%eax
    10d6:	0f 84 04 01 00 00    	je     11e0 <printf+0x170>
    10dc:	83 e8 63             	sub    $0x63,%eax
    10df:	83 f8 15             	cmp    $0x15,%eax
    10e2:	77 1c                	ja     1100 <printf+0x90>
    10e4:	ff 24 85 50 15 00 00 	jmp    *0x1550(,%eax,4)
    10eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    10f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10f3:	5b                   	pop    %ebx
    10f4:	5e                   	pop    %esi
    10f5:	5f                   	pop    %edi
    10f6:	5d                   	pop    %ebp
    10f7:	c3                   	ret
    10f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10ff:	00 
  write(fd, &c, 1);
    1100:	83 ec 04             	sub    $0x4,%esp
    1103:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1106:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    110a:	6a 01                	push   $0x1
    110c:	52                   	push   %edx
    110d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1110:	57                   	push   %edi
    1111:	e8 dd fd ff ff       	call   ef3 <write>
    1116:	83 c4 0c             	add    $0xc,%esp
    1119:	88 5d e7             	mov    %bl,-0x19(%ebp)
    111c:	6a 01                	push   $0x1
    111e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1121:	52                   	push   %edx
    1122:	57                   	push   %edi
    1123:	e8 cb fd ff ff       	call   ef3 <write>
        putc(fd, c);
    1128:	83 c4 10             	add    $0x10,%esp
      state = 0;
    112b:	31 d2                	xor    %edx,%edx
    112d:	eb 8e                	jmp    10bd <printf+0x4d>
    112f:	90                   	nop
        printint(fd, *ap, 16, 0);
    1130:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1133:	83 ec 0c             	sub    $0xc,%esp
    1136:	b9 10 00 00 00       	mov    $0x10,%ecx
    113b:	8b 13                	mov    (%ebx),%edx
    113d:	6a 00                	push   $0x0
    113f:	89 f8                	mov    %edi,%eax
        ap++;
    1141:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    1144:	e8 87 fe ff ff       	call   fd0 <printint>
        ap++;
    1149:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    114c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    114f:	31 d2                	xor    %edx,%edx
    1151:	e9 67 ff ff ff       	jmp    10bd <printf+0x4d>
        s = (char*)*ap;
    1156:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1159:	8b 18                	mov    (%eax),%ebx
        ap++;
    115b:	83 c0 04             	add    $0x4,%eax
    115e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    1161:	85 db                	test   %ebx,%ebx
    1163:	0f 84 87 00 00 00    	je     11f0 <printf+0x180>
        while(*s != 0){
    1169:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    116c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    116e:	84 c0                	test   %al,%al
    1170:	0f 84 47 ff ff ff    	je     10bd <printf+0x4d>
    1176:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1179:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    117c:	89 de                	mov    %ebx,%esi
    117e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    1180:	83 ec 04             	sub    $0x4,%esp
    1183:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1186:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1189:	6a 01                	push   $0x1
    118b:	53                   	push   %ebx
    118c:	57                   	push   %edi
    118d:	e8 61 fd ff ff       	call   ef3 <write>
        while(*s != 0){
    1192:	0f b6 06             	movzbl (%esi),%eax
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	84 c0                	test   %al,%al
    119a:	75 e4                	jne    1180 <printf+0x110>
      state = 0;
    119c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    119f:	31 d2                	xor    %edx,%edx
    11a1:	e9 17 ff ff ff       	jmp    10bd <printf+0x4d>
        printint(fd, *ap, 10, 1);
    11a6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    11a9:	83 ec 0c             	sub    $0xc,%esp
    11ac:	b9 0a 00 00 00       	mov    $0xa,%ecx
    11b1:	8b 13                	mov    (%ebx),%edx
    11b3:	6a 01                	push   $0x1
    11b5:	eb 88                	jmp    113f <printf+0xcf>
        putc(fd, *ap);
    11b7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    11ba:	83 ec 04             	sub    $0x4,%esp
    11bd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    11c0:	8b 03                	mov    (%ebx),%eax
        ap++;
    11c2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    11c5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    11c8:	6a 01                	push   $0x1
    11ca:	52                   	push   %edx
    11cb:	57                   	push   %edi
    11cc:	e8 22 fd ff ff       	call   ef3 <write>
        ap++;
    11d1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    11d4:	83 c4 10             	add    $0x10,%esp
      state = 0;
    11d7:	31 d2                	xor    %edx,%edx
    11d9:	e9 df fe ff ff       	jmp    10bd <printf+0x4d>
    11de:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    11e0:	83 ec 04             	sub    $0x4,%esp
    11e3:	88 5d e7             	mov    %bl,-0x19(%ebp)
    11e6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    11e9:	6a 01                	push   $0x1
    11eb:	e9 31 ff ff ff       	jmp    1121 <printf+0xb1>
    11f0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    11f5:	bb 7e 14 00 00       	mov    $0x147e,%ebx
    11fa:	e9 77 ff ff ff       	jmp    1176 <printf+0x106>
    11ff:	90                   	nop

00001200 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1200:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1201:	a1 e4 1b 00 00       	mov    0x1be4,%eax
{
    1206:	89 e5                	mov    %esp,%ebp
    1208:	57                   	push   %edi
    1209:	56                   	push   %esi
    120a:	53                   	push   %ebx
    120b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    120e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1218:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    121a:	39 c8                	cmp    %ecx,%eax
    121c:	73 32                	jae    1250 <free+0x50>
    121e:	39 d1                	cmp    %edx,%ecx
    1220:	72 04                	jb     1226 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1222:	39 d0                	cmp    %edx,%eax
    1224:	72 32                	jb     1258 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1226:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1229:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    122c:	39 fa                	cmp    %edi,%edx
    122e:	74 30                	je     1260 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1230:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1233:	8b 50 04             	mov    0x4(%eax),%edx
    1236:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1239:	39 f1                	cmp    %esi,%ecx
    123b:	74 3a                	je     1277 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    123d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    123f:	5b                   	pop    %ebx
  freep = p;
    1240:	a3 e4 1b 00 00       	mov    %eax,0x1be4
}
    1245:	5e                   	pop    %esi
    1246:	5f                   	pop    %edi
    1247:	5d                   	pop    %ebp
    1248:	c3                   	ret
    1249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1250:	39 d0                	cmp    %edx,%eax
    1252:	72 04                	jb     1258 <free+0x58>
    1254:	39 d1                	cmp    %edx,%ecx
    1256:	72 ce                	jb     1226 <free+0x26>
{
    1258:	89 d0                	mov    %edx,%eax
    125a:	eb bc                	jmp    1218 <free+0x18>
    125c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1260:	03 72 04             	add    0x4(%edx),%esi
    1263:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1266:	8b 10                	mov    (%eax),%edx
    1268:	8b 12                	mov    (%edx),%edx
    126a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    126d:	8b 50 04             	mov    0x4(%eax),%edx
    1270:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1273:	39 f1                	cmp    %esi,%ecx
    1275:	75 c6                	jne    123d <free+0x3d>
    p->s.size += bp->s.size;
    1277:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    127a:	a3 e4 1b 00 00       	mov    %eax,0x1be4
    p->s.size += bp->s.size;
    127f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1282:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1285:	89 08                	mov    %ecx,(%eax)
}
    1287:	5b                   	pop    %ebx
    1288:	5e                   	pop    %esi
    1289:	5f                   	pop    %edi
    128a:	5d                   	pop    %ebp
    128b:	c3                   	ret
    128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001290 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	57                   	push   %edi
    1294:	56                   	push   %esi
    1295:	53                   	push   %ebx
    1296:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1299:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    129c:	8b 15 e4 1b 00 00    	mov    0x1be4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12a2:	8d 78 07             	lea    0x7(%eax),%edi
    12a5:	c1 ef 03             	shr    $0x3,%edi
    12a8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    12ab:	85 d2                	test   %edx,%edx
    12ad:	0f 84 8d 00 00 00    	je     1340 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12b3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    12b5:	8b 48 04             	mov    0x4(%eax),%ecx
    12b8:	39 f9                	cmp    %edi,%ecx
    12ba:	73 64                	jae    1320 <malloc+0x90>
  if(nu < 4096)
    12bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    12c1:	39 df                	cmp    %ebx,%edi
    12c3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    12c6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    12cd:	eb 0a                	jmp    12d9 <malloc+0x49>
    12cf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    12d2:	8b 48 04             	mov    0x4(%eax),%ecx
    12d5:	39 f9                	cmp    %edi,%ecx
    12d7:	73 47                	jae    1320 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12d9:	89 c2                	mov    %eax,%edx
    12db:	3b 05 e4 1b 00 00    	cmp    0x1be4,%eax
    12e1:	75 ed                	jne    12d0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    12e3:	83 ec 0c             	sub    $0xc,%esp
    12e6:	56                   	push   %esi
    12e7:	e8 6f fc ff ff       	call   f5b <sbrk>
  if(p == (char*)-1)
    12ec:	83 c4 10             	add    $0x10,%esp
    12ef:	83 f8 ff             	cmp    $0xffffffff,%eax
    12f2:	74 1c                	je     1310 <malloc+0x80>
  hp->s.size = nu;
    12f4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    12f7:	83 ec 0c             	sub    $0xc,%esp
    12fa:	83 c0 08             	add    $0x8,%eax
    12fd:	50                   	push   %eax
    12fe:	e8 fd fe ff ff       	call   1200 <free>
  return freep;
    1303:	8b 15 e4 1b 00 00    	mov    0x1be4,%edx
      if((p = morecore(nunits)) == 0)
    1309:	83 c4 10             	add    $0x10,%esp
    130c:	85 d2                	test   %edx,%edx
    130e:	75 c0                	jne    12d0 <malloc+0x40>
        return 0;
  }
}
    1310:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1313:	31 c0                	xor    %eax,%eax
}
    1315:	5b                   	pop    %ebx
    1316:	5e                   	pop    %esi
    1317:	5f                   	pop    %edi
    1318:	5d                   	pop    %ebp
    1319:	c3                   	ret
    131a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1320:	39 cf                	cmp    %ecx,%edi
    1322:	74 4c                	je     1370 <malloc+0xe0>
        p->s.size -= nunits;
    1324:	29 f9                	sub    %edi,%ecx
    1326:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1329:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    132c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    132f:	89 15 e4 1b 00 00    	mov    %edx,0x1be4
}
    1335:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1338:	83 c0 08             	add    $0x8,%eax
}
    133b:	5b                   	pop    %ebx
    133c:	5e                   	pop    %esi
    133d:	5f                   	pop    %edi
    133e:	5d                   	pop    %ebp
    133f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    1340:	c7 05 e4 1b 00 00 e8 	movl   $0x1be8,0x1be4
    1347:	1b 00 00 
    base.s.size = 0;
    134a:	b8 e8 1b 00 00       	mov    $0x1be8,%eax
    base.s.ptr = freep = prevp = &base;
    134f:	c7 05 e8 1b 00 00 e8 	movl   $0x1be8,0x1be8
    1356:	1b 00 00 
    base.s.size = 0;
    1359:	c7 05 ec 1b 00 00 00 	movl   $0x0,0x1bec
    1360:	00 00 00 
    if(p->s.size >= nunits){
    1363:	e9 54 ff ff ff       	jmp    12bc <malloc+0x2c>
    1368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    136f:	00 
        prevp->s.ptr = p->s.ptr;
    1370:	8b 08                	mov    (%eax),%ecx
    1372:	89 0a                	mov    %ecx,(%edx)
    1374:	eb b9                	jmp    132f <malloc+0x9f>
