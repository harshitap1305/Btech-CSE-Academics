
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 c1 11 80       	mov    $0x8011c1d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 f0 30 10 80       	mov    $0x801030f0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 79 10 80       	push   $0x801079a0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 25 45 00 00       	call   80104580 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 79 10 80       	push   $0x801079a7
80100097:	50                   	push   %eax
80100098:	e8 b3 43 00 00       	call   80104450 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 87 46 00 00       	call   80104770 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 a9 45 00 00       	call   80104710 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 43 00 00       	call   80104490 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 ff 21 00 00       	call   80102390 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ae 79 10 80       	push   $0x801079ae
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 6d 43 00 00       	call   80104530 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 b7 21 00 00       	jmp    80102390 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 bf 79 10 80       	push   $0x801079bf
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 43 00 00       	call   80104530 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 42 00 00       	call   801044f0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 50 45 00 00       	call   80104770 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 a2 44 00 00       	jmp    80104710 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 c6 79 10 80       	push   $0x801079c6
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 a7 16 00 00       	call   80101940 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 cb 44 00 00       	call   80104770 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 5e 3e 00 00       	call   80104130 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 99 37 00 00       	call   80103a80 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 15 44 00 00       	call   80104710 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 5c 15 00 00       	call   80101860 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 bf 43 00 00       	call   80104710 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 06 15 00 00       	call   80101860 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 f2 25 00 00       	call   80102990 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 cd 79 10 80       	push   $0x801079cd
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 eb 7d 10 80 	movl   $0x80107deb,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 d3 41 00 00       	call   801045a0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 e1 79 10 80       	push   $0x801079e1
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 5c 5e 00 00       	call   80106280 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004c8:	0f b6 db             	movzbl %bl,%ebx
801004cb:	8d 70 01             	lea    0x1(%eax),%esi
801004ce:	80 cf 07             	or     $0x7,%bh
801004d1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004d8:	80 
801004d9:	eb 8a                	jmp    80100465 <consputc.part.0+0x65>
801004db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 91 5d 00 00       	call   80106280 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 85 5d 00 00       	call   80106280 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 79 5d 00 00       	call   80106280 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 9a 43 00 00       	call   80104900 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 f5 42 00 00       	call   80104870 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010058d:	00 
8010058e:	66 90                	xchg   %ax,%ax
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 e5 79 10 80       	push   $0x801079e5
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 7c 13 00 00       	call   80101940 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005cb:	e8 a0 41 00 00       	call   80104770 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 fb                	cmp    %edi,%ebx
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 20 ff 10 80       	push   $0x8010ff20
80100604:	e8 07 41 00 00       	call   80104710 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 4e 12 00 00       	call   80101860 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	89 d3                	mov    %edx,%ebx
80100628:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062b:	85 c0                	test   %eax,%eax
8010062d:	79 05                	jns    80100634 <printint+0x14>
8010062f:	83 e1 01             	and    $0x1,%ecx
80100632:	75 64                	jne    80100698 <printint+0x78>
    x = xx;
80100634:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010063b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010063d:	31 f6                	xor    %esi,%esi
8010063f:	90                   	nop
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 18 81 10 80 	movzbl -0x7fef7ee8(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80100661:	85 c9                	test   %ecx,%ecx
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 11                	je     801006a5 <printint+0x85>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
    x = -xx;
80100698:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010069a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006a1:	89 c1                	mov    %eax,%ecx
801006a3:	eb 98                	jmp    8010063d <printint+0x1d>
}
801006a5:	83 c4 2c             	add    $0x2c,%esp
801006a8:	5b                   	pop    %ebx
801006a9:	5e                   	pop    %esi
801006aa:	5f                   	pop    %edi
801006ab:	5d                   	pop    %ebp
801006ac:	c3                   	ret
801006ad:	8d 76 00             	lea    0x0(%esi),%esi

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 06 01 00 00    	jne    801007d0 <cprintf+0x120>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 b7 01 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 5f                	je     80100738 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	75 58                	jne    80100740 <cprintf+0x90>
    c = fmt[++i] & 0xff;
801006e8:	83 c3 01             	add    $0x1,%ebx
801006eb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006ef:	85 c9                	test   %ecx,%ecx
801006f1:	74 3a                	je     8010072d <cprintf+0x7d>
    switch(c){
801006f3:	83 f9 70             	cmp    $0x70,%ecx
801006f6:	0f 84 b4 00 00 00    	je     801007b0 <cprintf+0x100>
801006fc:	7f 72                	jg     80100770 <cprintf+0xc0>
801006fe:	83 f9 25             	cmp    $0x25,%ecx
80100701:	74 4d                	je     80100750 <cprintf+0xa0>
80100703:	83 f9 64             	cmp    $0x64,%ecx
80100706:	75 76                	jne    8010077e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100708:	8d 47 04             	lea    0x4(%edi),%eax
8010070b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100710:	ba 0a 00 00 00       	mov    $0xa,%edx
80100715:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100718:	8b 07                	mov    (%edi),%eax
8010071a:	e8 01 ff ff ff       	call   80100620 <printint>
8010071f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100722:	83 c3 01             	add    $0x1,%ebx
80100725:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	75 b6                	jne    801006e3 <cprintf+0x33>
8010072d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100730:	85 ff                	test   %edi,%edi
80100732:	0f 85 bb 00 00 00    	jne    801007f3 <cprintf+0x143>
}
80100738:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010073b:	5b                   	pop    %ebx
8010073c:	5e                   	pop    %esi
8010073d:	5f                   	pop    %edi
8010073e:	5d                   	pop    %ebp
8010073f:	c3                   	ret
  if(panicked){
80100740:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100746:	85 c9                	test   %ecx,%ecx
80100748:	74 19                	je     80100763 <cprintf+0xb3>
8010074a:	fa                   	cli
    for(;;)
8010074b:	eb fe                	jmp    8010074b <cprintf+0x9b>
8010074d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100750:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100756:	85 c9                	test   %ecx,%ecx
80100758:	0f 85 f2 00 00 00    	jne    80100850 <cprintf+0x1a0>
8010075e:	b8 25 00 00 00       	mov    $0x25,%eax
80100763:	e8 98 fc ff ff       	call   80100400 <consputc.part.0>
      break;
80100768:	eb b8                	jmp    80100722 <cprintf+0x72>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100770:	83 f9 73             	cmp    $0x73,%ecx
80100773:	0f 84 8f 00 00 00    	je     80100808 <cprintf+0x158>
80100779:	83 f9 78             	cmp    $0x78,%ecx
8010077c:	74 32                	je     801007b0 <cprintf+0x100>
  if(panicked){
8010077e:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100784:	85 d2                	test   %edx,%edx
80100786:	0f 85 b8 00 00 00    	jne    80100844 <cprintf+0x194>
8010078c:	b8 25 00 00 00       	mov    $0x25,%eax
80100791:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100794:	e8 67 fc ff ff       	call   80100400 <consputc.part.0>
80100799:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010079e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801007a1:	85 c0                	test   %eax,%eax
801007a3:	0f 84 cd 00 00 00    	je     80100876 <cprintf+0x1c6>
801007a9:	fa                   	cli
    for(;;)
801007aa:	eb fe                	jmp    801007aa <cprintf+0xfa>
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007b0:	8d 47 04             	lea    0x4(%edi),%eax
801007b3:	31 c9                	xor    %ecx,%ecx
801007b5:	ba 10 00 00 00       	mov    $0x10,%edx
801007ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007bd:	8b 07                	mov    (%edi),%eax
801007bf:	e8 5c fe ff ff       	call   80100620 <printint>
801007c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007c7:	e9 56 ff ff ff       	jmp    80100722 <cprintf+0x72>
801007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 ff 10 80       	push   $0x8010ff20
801007d8:	e8 93 3f 00 00       	call   80104770 <acquire>
  if (fmt == 0)
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	85 f6                	test   %esi,%esi
801007e2:	0f 84 a1 00 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007e8:	0f b6 06             	movzbl (%esi),%eax
801007eb:	85 c0                	test   %eax,%eax
801007ed:	0f 85 e6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
801007f3:	83 ec 0c             	sub    $0xc,%esp
801007f6:	68 20 ff 10 80       	push   $0x8010ff20
801007fb:	e8 10 3f 00 00       	call   80104710 <release>
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	e9 30 ff ff ff       	jmp    80100738 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100808:	8b 17                	mov    (%edi),%edx
8010080a:	8d 47 04             	lea    0x4(%edi),%eax
8010080d:	85 d2                	test   %edx,%edx
8010080f:	74 27                	je     80100838 <cprintf+0x188>
      for(; *s; s++)
80100811:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100814:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100816:	84 c9                	test   %cl,%cl
80100818:	74 68                	je     80100882 <cprintf+0x1d2>
8010081a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010081d:	89 fb                	mov    %edi,%ebx
8010081f:	89 f7                	mov    %esi,%edi
80100821:	89 c6                	mov    %eax,%esi
80100823:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100826:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010082c:	85 d2                	test   %edx,%edx
8010082e:	74 28                	je     80100858 <cprintf+0x1a8>
80100830:	fa                   	cli
    for(;;)
80100831:	eb fe                	jmp    80100831 <cprintf+0x181>
80100833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100838:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010083d:	bf f8 79 10 80       	mov    $0x801079f8,%edi
80100842:	eb d6                	jmp    8010081a <cprintf+0x16a>
80100844:	fa                   	cli
    for(;;)
80100845:	eb fe                	jmp    80100845 <cprintf+0x195>
80100847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010084e:	00 
8010084f:	90                   	nop
80100850:	fa                   	cli
80100851:	eb fe                	jmp    80100851 <cprintf+0x1a1>
80100853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100858:	e8 a3 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
8010085d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100861:	83 c3 01             	add    $0x1,%ebx
80100864:	84 c0                	test   %al,%al
80100866:	75 be                	jne    80100826 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
80100868:	89 f0                	mov    %esi,%eax
8010086a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010086d:	89 fe                	mov    %edi,%esi
8010086f:	89 c7                	mov    %eax,%edi
80100871:	e9 ac fe ff ff       	jmp    80100722 <cprintf+0x72>
80100876:	89 c8                	mov    %ecx,%eax
80100878:	e8 83 fb ff ff       	call   80100400 <consputc.part.0>
      break;
8010087d:	e9 a0 fe ff ff       	jmp    80100722 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
80100882:	89 c7                	mov    %eax,%edi
80100884:	e9 99 fe ff ff       	jmp    80100722 <cprintf+0x72>
    panic("null fmt");
80100889:	83 ec 0c             	sub    $0xc,%esp
8010088c:	68 ff 79 10 80       	push   $0x801079ff
80100891:	e8 ea fa ff ff       	call   80100380 <panic>
80100896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010089d:	00 
8010089e:	66 90                	xchg   %ax,%ax

801008a0 <consoleintr>:
{
801008a0:	55                   	push   %ebp
801008a1:	89 e5                	mov    %esp,%ebp
801008a3:	57                   	push   %edi
  int c, doprocdump = 0,do_twostrike=0;
801008a4:	31 ff                	xor    %edi,%edi
{
801008a6:	56                   	push   %esi
801008a7:	53                   	push   %ebx
801008a8:	83 ec 28             	sub    $0x28,%esp
801008ab:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008ae:	68 20 ff 10 80       	push   $0x8010ff20
801008b3:	e8 b8 3e 00 00       	call   80104770 <acquire>
  while((c = getc()) >= 0){
801008b8:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0,do_twostrike=0;
801008bb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((c = getc()) >= 0){
801008c2:	ff d6                	call   *%esi
801008c4:	89 c3                	mov    %eax,%ebx
801008c6:	85 c0                	test   %eax,%eax
801008c8:	0f 88 1d 01 00 00    	js     801009eb <consoleintr+0x14b>
    switch(c){
801008ce:	83 fb 10             	cmp    $0x10,%ebx
801008d1:	0f 84 49 01 00 00    	je     80100a20 <consoleintr+0x180>
801008d7:	7f 77                	jg     80100950 <consoleintr+0xb0>
801008d9:	83 fb 03             	cmp    $0x3,%ebx
801008dc:	0f 84 f6 00 00 00    	je     801009d8 <consoleintr+0x138>
801008e2:	83 fb 08             	cmp    $0x8,%ebx
801008e5:	74 77                	je     8010095e <consoleintr+0xbe>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008e7:	85 db                	test   %ebx,%ebx
801008e9:	74 d7                	je     801008c2 <consoleintr+0x22>
801008eb:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008f0:	89 c2                	mov    %eax,%edx
801008f2:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008f8:	83 fa 7f             	cmp    $0x7f,%edx
801008fb:	77 c5                	ja     801008c2 <consoleintr+0x22>
        input.buf[input.e++ % INPUT_BUF] = c;
801008fd:	8d 50 01             	lea    0x1(%eax),%edx
  if(panicked){
80100900:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
80100906:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100909:	83 fb 0d             	cmp    $0xd,%ebx
8010090c:	0f 85 3a 01 00 00    	jne    80100a4c <consoleintr+0x1ac>
        input.buf[input.e++ % INPUT_BUF] = c;
80100912:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100918:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
8010091f:	85 c9                	test   %ecx,%ecx
80100921:	0f 85 76 01 00 00    	jne    80100a9d <consoleintr+0x1fd>
80100927:	b8 0a 00 00 00       	mov    $0xa,%eax
8010092c:	e8 cf fa ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100931:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100936:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100939:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
8010093e:	68 00 ff 10 80       	push   $0x8010ff00
80100943:	e8 a8 38 00 00       	call   801041f0 <wakeup>
80100948:	83 c4 10             	add    $0x10,%esp
8010094b:	e9 72 ff ff ff       	jmp    801008c2 <consoleintr+0x22>
    switch(c){
80100950:	83 fb 15             	cmp    $0x15,%ebx
80100953:	74 45                	je     8010099a <consoleintr+0xfa>
80100955:	83 fb 7f             	cmp    $0x7f,%ebx
80100958:	0f 85 cc 00 00 00    	jne    80100a2a <consoleintr+0x18a>
      if(input.e != input.w){
8010095e:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100963:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100969:	0f 84 53 ff ff ff    	je     801008c2 <consoleintr+0x22>
  if(panicked){
8010096f:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.e--;
80100975:	83 e8 01             	sub    $0x1,%eax
80100978:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
8010097d:	85 c9                	test   %ecx,%ecx
8010097f:	0f 84 09 01 00 00    	je     80100a8e <consoleintr+0x1ee>
80100985:	fa                   	cli
    for(;;)
80100986:	eb fe                	jmp    80100986 <consoleintr+0xe6>
80100988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010098f:	00 
80100990:	b8 00 01 00 00       	mov    $0x100,%eax
80100995:	e8 66 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010099a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010099f:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009a5:	0f 84 17 ff ff ff    	je     801008c2 <consoleintr+0x22>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801009ab:	83 e8 01             	sub    $0x1,%eax
801009ae:	89 c2                	mov    %eax,%edx
801009b0:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801009b3:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
801009ba:	0f 84 02 ff ff ff    	je     801008c2 <consoleintr+0x22>
  if(panicked){
801009c0:	8b 1d 58 ff 10 80    	mov    0x8010ff58,%ebx
        input.e--;
801009c6:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
801009cb:	85 db                	test   %ebx,%ebx
801009cd:	74 c1                	je     80100990 <consoleintr+0xf0>
801009cf:	fa                   	cli
    for(;;)
801009d0:	eb fe                	jmp    801009d0 <consoleintr+0x130>
801009d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      do_twostrike = 1;
801009d8:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  while((c = getc()) >= 0){
801009df:	ff d6                	call   *%esi
801009e1:	89 c3                	mov    %eax,%ebx
801009e3:	85 c0                	test   %eax,%eax
801009e5:	0f 89 e3 fe ff ff    	jns    801008ce <consoleintr+0x2e>
  release(&cons.lock);
801009eb:	83 ec 0c             	sub    $0xc,%esp
801009ee:	68 20 ff 10 80       	push   $0x8010ff20
801009f3:	e8 18 3d 00 00       	call   80104710 <release>
  if(doprocdump) {
801009f8:	83 c4 10             	add    $0x10,%esp
801009fb:	85 ff                	test   %edi,%edi
801009fd:	0f 85 cb 00 00 00    	jne    80100ace <consoleintr+0x22e>
  if(do_twostrike) {
80100a03:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100a06:	85 d2                	test   %edx,%edx
80100a08:	0f 85 92 00 00 00    	jne    80100aa0 <consoleintr+0x200>
}
80100a0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a11:	5b                   	pop    %ebx
80100a12:	5e                   	pop    %esi
80100a13:	5f                   	pop    %edi
80100a14:	5d                   	pop    %ebp
80100a15:	c3                   	ret
80100a16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a1d:	00 
80100a1e:	66 90                	xchg   %ax,%ax
    switch(c){
80100a20:	bf 01 00 00 00       	mov    $0x1,%edi
80100a25:	e9 98 fe ff ff       	jmp    801008c2 <consoleintr+0x22>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a2a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a2f:	89 c2                	mov    %eax,%edx
80100a31:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
80100a37:	83 fa 7f             	cmp    $0x7f,%edx
80100a3a:	0f 87 82 fe ff ff    	ja     801008c2 <consoleintr+0x22>
  if(panicked){
80100a40:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a46:	8d 50 01             	lea    0x1(%eax),%edx
80100a49:	83 e0 7f             	and    $0x7f,%eax
80100a4c:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100a52:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
80100a58:	85 c9                	test   %ecx,%ecx
80100a5a:	75 41                	jne    80100a9d <consoleintr+0x1fd>
80100a5c:	89 d8                	mov    %ebx,%eax
80100a5e:	e8 9d f9 ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a63:	83 fb 0a             	cmp    $0xa,%ebx
80100a66:	0f 84 c5 fe ff ff    	je     80100931 <consoleintr+0x91>
80100a6c:	83 fb 04             	cmp    $0x4,%ebx
80100a6f:	0f 84 bc fe ff ff    	je     80100931 <consoleintr+0x91>
80100a75:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100a7a:	83 e8 80             	sub    $0xffffff80,%eax
80100a7d:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100a83:	0f 85 39 fe ff ff    	jne    801008c2 <consoleintr+0x22>
80100a89:	e9 a8 fe ff ff       	jmp    80100936 <consoleintr+0x96>
80100a8e:	b8 00 01 00 00       	mov    $0x100,%eax
80100a93:	e8 68 f9 ff ff       	call   80100400 <consputc.part.0>
80100a98:	e9 25 fe ff ff       	jmp    801008c2 <consoleintr+0x22>
80100a9d:	fa                   	cli
    for(;;)
80100a9e:	eb fe                	jmp    80100a9e <consoleintr+0x1fe>
    struct proc *p = myproc();
80100aa0:	e8 db 2f 00 00       	call   80103a80 <myproc>
80100aa5:	89 c3                	mov    %eax,%ebx
    if(p != 0 && p->state == RUNNING) {
80100aa7:	85 c0                	test   %eax,%eax
80100aa9:	0f 84 5f ff ff ff    	je     80100a0e <consoleintr+0x16e>
80100aaf:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80100ab3:	0f 85 55 ff ff ff    	jne    80100a0e <consoleintr+0x16e>
      if(p->twostrike_mode == 1) {
80100ab9:	83 b8 e8 01 00 00 01 	cmpl   $0x1,0x1e8(%eax)
80100ac0:	74 16                	je     80100ad8 <consoleintr+0x238>
        p->killed = 1;
80100ac2:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
}
80100ac9:	e9 40 ff ff ff       	jmp    80100a0e <consoleintr+0x16e>
    procdump();  // now call procdump() wo. cons.lock held
80100ace:	e8 fd 37 00 00       	call   801042d0 <procdump>
80100ad3:	e9 2b ff ff ff       	jmp    80100a03 <consoleintr+0x163>
        if(p->strike_count == 0) {
80100ad8:	8b 80 ec 01 00 00    	mov    0x1ec(%eax),%eax
80100ade:	85 c0                	test   %eax,%eax
80100ae0:	75 1d                	jne    80100aff <consoleintr+0x25f>
          p->strike_count = 1;
80100ae2:	c7 83 ec 01 00 00 01 	movl   $0x1,0x1ec(%ebx)
80100ae9:	00 00 00 
          cprintf("\n[Strike 1] Press Ctrl+C again to exit.\n");
80100aec:	c7 45 08 d4 7e 10 80 	movl   $0x80107ed4,0x8(%ebp)
}
80100af3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100af6:	5b                   	pop    %ebx
80100af7:	5e                   	pop    %esi
80100af8:	5f                   	pop    %edi
80100af9:	5d                   	pop    %ebp
          cprintf("\n[Strike 1] Press Ctrl+C again to exit.\n");
80100afa:	e9 b1 fb ff ff       	jmp    801006b0 <cprintf>
          cprintf("\n[Strike 2] Exiting.\n");
80100aff:	83 ec 0c             	sub    $0xc,%esp
80100b02:	68 08 7a 10 80       	push   $0x80107a08
80100b07:	e8 a4 fb ff ff       	call   801006b0 <cprintf>
          p->killed = 1;
80100b0c:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
80100b13:	83 c4 10             	add    $0x10,%esp
80100b16:	e9 f3 fe ff ff       	jmp    80100a0e <consoleintr+0x16e>
80100b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100b20 <consoleinit>:

void
consoleinit(void)
{
80100b20:	55                   	push   %ebp
80100b21:	89 e5                	mov    %esp,%ebp
80100b23:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b26:	68 1e 7a 10 80       	push   $0x80107a1e
80100b2b:	68 20 ff 10 80       	push   $0x8010ff20
80100b30:	e8 4b 3a 00 00       	call   80104580 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b35:	58                   	pop    %eax
80100b36:	5a                   	pop    %edx
80100b37:	6a 00                	push   $0x0
80100b39:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100b3b:	c7 05 0c 09 11 80 b0 	movl   $0x801005b0,0x8011090c
80100b42:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100b45:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100b4c:	02 10 80 
  cons.locking = 1;
80100b4f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100b56:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100b59:	e8 c2 19 00 00       	call   80102520 <ioapicenable>
}
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	c9                   	leave
80100b62:	c3                   	ret
80100b63:	66 90                	xchg   %ax,%ax
80100b65:	66 90                	xchg   %ax,%ax
80100b67:	66 90                	xchg   %ax,%ax
80100b69:	66 90                	xchg   %ax,%ax
80100b6b:	66 90                	xchg   %ax,%ax
80100b6d:	66 90                	xchg   %ax,%ax
80100b6f:	90                   	nop

80100b70 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b70:	55                   	push   %ebp
80100b71:	89 e5                	mov    %esp,%ebp
80100b73:	57                   	push   %edi
80100b74:	56                   	push   %esi
80100b75:	53                   	push   %ebx
80100b76:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b7c:	e8 ff 2e 00 00       	call   80103a80 <myproc>
80100b81:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b87:	e8 74 22 00 00       	call   80102e00 <begin_op>

  if((ip = namei(path)) == 0){
80100b8c:	83 ec 0c             	sub    $0xc,%esp
80100b8f:	ff 75 08             	push   0x8(%ebp)
80100b92:	e8 a9 15 00 00       	call   80102140 <namei>
80100b97:	83 c4 10             	add    $0x10,%esp
80100b9a:	85 c0                	test   %eax,%eax
80100b9c:	0f 84 30 03 00 00    	je     80100ed2 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ba2:	83 ec 0c             	sub    $0xc,%esp
80100ba5:	89 c7                	mov    %eax,%edi
80100ba7:	50                   	push   %eax
80100ba8:	e8 b3 0c 00 00       	call   80101860 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100bad:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100bb3:	6a 34                	push   $0x34
80100bb5:	6a 00                	push   $0x0
80100bb7:	50                   	push   %eax
80100bb8:	57                   	push   %edi
80100bb9:	e8 b2 0f 00 00       	call   80101b70 <readi>
80100bbe:	83 c4 20             	add    $0x20,%esp
80100bc1:	83 f8 34             	cmp    $0x34,%eax
80100bc4:	0f 85 01 01 00 00    	jne    80100ccb <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bca:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100bd1:	45 4c 46 
80100bd4:	0f 85 f1 00 00 00    	jne    80100ccb <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bda:	e8 71 69 00 00       	call   80107550 <setupkvm>
80100bdf:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100be5:	85 c0                	test   %eax,%eax
80100be7:	0f 84 de 00 00 00    	je     80100ccb <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bed:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100bf4:	00 
80100bf5:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100bfb:	0f 84 a1 02 00 00    	je     80100ea2 <exec+0x332>
  sz = 0;
80100c01:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100c08:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c0b:	31 db                	xor    %ebx,%ebx
80100c0d:	e9 8c 00 00 00       	jmp    80100c9e <exec+0x12e>
80100c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c18:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c1f:	75 6c                	jne    80100c8d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100c21:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c27:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c2d:	0f 82 87 00 00 00    	jb     80100cba <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c33:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100c39:	72 7f                	jb     80100cba <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c3b:	83 ec 04             	sub    $0x4,%esp
80100c3e:	50                   	push   %eax
80100c3f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100c45:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c4b:	e8 60 66 00 00       	call   801072b0 <allocuvm>
80100c50:	83 c4 10             	add    $0x10,%esp
80100c53:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	74 5d                	je     80100cba <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100c5d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c63:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100c68:	75 50                	jne    80100cba <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c6a:	83 ec 0c             	sub    $0xc,%esp
80100c6d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100c73:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100c79:	57                   	push   %edi
80100c7a:	50                   	push   %eax
80100c7b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c81:	e8 5a 65 00 00       	call   801071e0 <loaduvm>
80100c86:	83 c4 20             	add    $0x20,%esp
80100c89:	85 c0                	test   %eax,%eax
80100c8b:	78 2d                	js     80100cba <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c8d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c94:	83 c3 01             	add    $0x1,%ebx
80100c97:	83 c6 20             	add    $0x20,%esi
80100c9a:	39 d8                	cmp    %ebx,%eax
80100c9c:	7e 52                	jle    80100cf0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c9e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ca4:	6a 20                	push   $0x20
80100ca6:	56                   	push   %esi
80100ca7:	50                   	push   %eax
80100ca8:	57                   	push   %edi
80100ca9:	e8 c2 0e 00 00       	call   80101b70 <readi>
80100cae:	83 c4 10             	add    $0x10,%esp
80100cb1:	83 f8 20             	cmp    $0x20,%eax
80100cb4:	0f 84 5e ff ff ff    	je     80100c18 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100cba:	83 ec 0c             	sub    $0xc,%esp
80100cbd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cc3:	e8 08 68 00 00       	call   801074d0 <freevm>
  if(ip){
80100cc8:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100ccb:	83 ec 0c             	sub    $0xc,%esp
80100cce:	57                   	push   %edi
80100ccf:	e8 1c 0e 00 00       	call   80101af0 <iunlockput>
    end_op();
80100cd4:	e8 97 21 00 00       	call   80102e70 <end_op>
80100cd9:	83 c4 10             	add    $0x10,%esp
    return -1;
80100cdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100ce1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ce4:	5b                   	pop    %ebx
80100ce5:	5e                   	pop    %esi
80100ce6:	5f                   	pop    %edi
80100ce7:	5d                   	pop    %ebp
80100ce8:	c3                   	ret
80100ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100cf0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100cf6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100cfc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d02:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	57                   	push   %edi
80100d0c:	e8 df 0d 00 00       	call   80101af0 <iunlockput>
  end_op();
80100d11:	e8 5a 21 00 00       	call   80102e70 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d16:	83 c4 0c             	add    $0xc,%esp
80100d19:	53                   	push   %ebx
80100d1a:	56                   	push   %esi
80100d1b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100d21:	56                   	push   %esi
80100d22:	e8 89 65 00 00       	call   801072b0 <allocuvm>
80100d27:	83 c4 10             	add    $0x10,%esp
80100d2a:	89 c7                	mov    %eax,%edi
80100d2c:	85 c0                	test   %eax,%eax
80100d2e:	0f 84 86 00 00 00    	je     80100dba <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d34:	83 ec 08             	sub    $0x8,%esp
80100d37:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100d3d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d3f:	50                   	push   %eax
80100d40:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100d41:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d43:	e8 a8 68 00 00       	call   801075f0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d48:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d4b:	83 c4 10             	add    $0x10,%esp
80100d4e:	8b 10                	mov    (%eax),%edx
80100d50:	85 d2                	test   %edx,%edx
80100d52:	0f 84 56 01 00 00    	je     80100eae <exec+0x33e>
80100d58:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100d5e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100d61:	eb 23                	jmp    80100d86 <exec+0x216>
80100d63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d68:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100d6b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100d72:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100d78:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100d7b:	85 d2                	test   %edx,%edx
80100d7d:	74 51                	je     80100dd0 <exec+0x260>
    if(argc >= MAXARG)
80100d7f:	83 f8 20             	cmp    $0x20,%eax
80100d82:	74 36                	je     80100dba <exec+0x24a>
80100d84:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d86:	83 ec 0c             	sub    $0xc,%esp
80100d89:	52                   	push   %edx
80100d8a:	e8 d1 3c 00 00       	call   80104a60 <strlen>
80100d8f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d91:	58                   	pop    %eax
80100d92:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d95:	83 eb 01             	sub    $0x1,%ebx
80100d98:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d9b:	e8 c0 3c 00 00       	call   80104a60 <strlen>
80100da0:	83 c0 01             	add    $0x1,%eax
80100da3:	50                   	push   %eax
80100da4:	ff 34 b7             	push   (%edi,%esi,4)
80100da7:	53                   	push   %ebx
80100da8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dae:	e8 0d 6a 00 00       	call   801077c0 <copyout>
80100db3:	83 c4 20             	add    $0x20,%esp
80100db6:	85 c0                	test   %eax,%eax
80100db8:	79 ae                	jns    80100d68 <exec+0x1f8>
    freevm(pgdir);
80100dba:	83 ec 0c             	sub    $0xc,%esp
80100dbd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dc3:	e8 08 67 00 00       	call   801074d0 <freevm>
80100dc8:	83 c4 10             	add    $0x10,%esp
80100dcb:	e9 0c ff ff ff       	jmp    80100cdc <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dd0:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100dd7:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100ddd:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100de3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100de6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100de9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100df0:	00 00 00 00 
  ustack[1] = argc;
80100df4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100dfa:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e01:	ff ff ff 
  ustack[1] = argc;
80100e04:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e0a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100e0c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e0e:	29 d0                	sub    %edx,%eax
80100e10:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e16:	56                   	push   %esi
80100e17:	51                   	push   %ecx
80100e18:	53                   	push   %ebx
80100e19:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e1f:	e8 9c 69 00 00       	call   801077c0 <copyout>
80100e24:	83 c4 10             	add    $0x10,%esp
80100e27:	85 c0                	test   %eax,%eax
80100e29:	78 8f                	js     80100dba <exec+0x24a>
  for(last=s=path; *s; s++)
80100e2b:	8b 45 08             	mov    0x8(%ebp),%eax
80100e2e:	8b 55 08             	mov    0x8(%ebp),%edx
80100e31:	0f b6 00             	movzbl (%eax),%eax
80100e34:	84 c0                	test   %al,%al
80100e36:	74 17                	je     80100e4f <exec+0x2df>
80100e38:	89 d1                	mov    %edx,%ecx
80100e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100e40:	83 c1 01             	add    $0x1,%ecx
80100e43:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100e45:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100e48:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100e4b:	84 c0                	test   %al,%al
80100e4d:	75 f1                	jne    80100e40 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e4f:	83 ec 04             	sub    $0x4,%esp
80100e52:	6a 10                	push   $0x10
80100e54:	52                   	push   %edx
80100e55:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100e5b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100e5e:	50                   	push   %eax
80100e5f:	e8 bc 3b 00 00       	call   80104a20 <safestrcpy>
  curproc->pgdir = pgdir;
80100e64:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e6a:	89 f0                	mov    %esi,%eax
80100e6c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100e6f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100e71:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100e74:	89 c1                	mov    %eax,%ecx
80100e76:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e7c:	8b 40 18             	mov    0x18(%eax),%eax
80100e7f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e82:	8b 41 18             	mov    0x18(%ecx),%eax
80100e85:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e88:	89 0c 24             	mov    %ecx,(%esp)
80100e8b:	e8 c0 61 00 00       	call   80107050 <switchuvm>
  freevm(oldpgdir);
80100e90:	89 34 24             	mov    %esi,(%esp)
80100e93:	e8 38 66 00 00       	call   801074d0 <freevm>
  return 0;
80100e98:	83 c4 10             	add    $0x10,%esp
80100e9b:	31 c0                	xor    %eax,%eax
80100e9d:	e9 3f fe ff ff       	jmp    80100ce1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ea2:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100ea7:	31 f6                	xor    %esi,%esi
80100ea9:	e9 5a fe ff ff       	jmp    80100d08 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100eae:	be 10 00 00 00       	mov    $0x10,%esi
80100eb3:	ba 04 00 00 00       	mov    $0x4,%edx
80100eb8:	b8 03 00 00 00       	mov    $0x3,%eax
80100ebd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ec4:	00 00 00 
80100ec7:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100ecd:	e9 17 ff ff ff       	jmp    80100de9 <exec+0x279>
    end_op();
80100ed2:	e8 99 1f 00 00       	call   80102e70 <end_op>
    cprintf("exec: fail\n");
80100ed7:	83 ec 0c             	sub    $0xc,%esp
80100eda:	68 26 7a 10 80       	push   $0x80107a26
80100edf:	e8 cc f7 ff ff       	call   801006b0 <cprintf>
    return -1;
80100ee4:	83 c4 10             	add    $0x10,%esp
80100ee7:	e9 f0 fd ff ff       	jmp    80100cdc <exec+0x16c>
80100eec:	66 90                	xchg   %ax,%ax
80100eee:	66 90                	xchg   %ax,%ax

80100ef0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100ef6:	68 32 7a 10 80       	push   $0x80107a32
80100efb:	68 60 ff 10 80       	push   $0x8010ff60
80100f00:	e8 7b 36 00 00       	call   80104580 <initlock>
}
80100f05:	83 c4 10             	add    $0x10,%esp
80100f08:	c9                   	leave
80100f09:	c3                   	ret
80100f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f10 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f14:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100f19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f1c:	68 60 ff 10 80       	push   $0x8010ff60
80100f21:	e8 4a 38 00 00       	call   80104770 <acquire>
80100f26:	83 c4 10             	add    $0x10,%esp
80100f29:	eb 10                	jmp    80100f3b <filealloc+0x2b>
80100f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f30:	83 c3 18             	add    $0x18,%ebx
80100f33:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100f39:	74 25                	je     80100f60 <filealloc+0x50>
    if(f->ref == 0){
80100f3b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f3e:	85 c0                	test   %eax,%eax
80100f40:	75 ee                	jne    80100f30 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f42:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f45:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f4c:	68 60 ff 10 80       	push   $0x8010ff60
80100f51:	e8 ba 37 00 00       	call   80104710 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f56:	89 d8                	mov    %ebx,%eax
      return f;
80100f58:	83 c4 10             	add    $0x10,%esp
}
80100f5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f5e:	c9                   	leave
80100f5f:	c3                   	ret
  release(&ftable.lock);
80100f60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f63:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f65:	68 60 ff 10 80       	push   $0x8010ff60
80100f6a:	e8 a1 37 00 00       	call   80104710 <release>
}
80100f6f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f71:	83 c4 10             	add    $0x10,%esp
}
80100f74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f77:	c9                   	leave
80100f78:	c3                   	ret
80100f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f80 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f80:	55                   	push   %ebp
80100f81:	89 e5                	mov    %esp,%ebp
80100f83:	53                   	push   %ebx
80100f84:	83 ec 10             	sub    $0x10,%esp
80100f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f8a:	68 60 ff 10 80       	push   $0x8010ff60
80100f8f:	e8 dc 37 00 00       	call   80104770 <acquire>
  if(f->ref < 1)
80100f94:	8b 43 04             	mov    0x4(%ebx),%eax
80100f97:	83 c4 10             	add    $0x10,%esp
80100f9a:	85 c0                	test   %eax,%eax
80100f9c:	7e 1a                	jle    80100fb8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f9e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100fa1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100fa4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100fa7:	68 60 ff 10 80       	push   $0x8010ff60
80100fac:	e8 5f 37 00 00       	call   80104710 <release>
  return f;
}
80100fb1:	89 d8                	mov    %ebx,%eax
80100fb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fb6:	c9                   	leave
80100fb7:	c3                   	ret
    panic("filedup");
80100fb8:	83 ec 0c             	sub    $0xc,%esp
80100fbb:	68 39 7a 10 80       	push   $0x80107a39
80100fc0:	e8 bb f3 ff ff       	call   80100380 <panic>
80100fc5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fcc:	00 
80100fcd:	8d 76 00             	lea    0x0(%esi),%esi

80100fd0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	57                   	push   %edi
80100fd4:	56                   	push   %esi
80100fd5:	53                   	push   %ebx
80100fd6:	83 ec 28             	sub    $0x28,%esp
80100fd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100fdc:	68 60 ff 10 80       	push   $0x8010ff60
80100fe1:	e8 8a 37 00 00       	call   80104770 <acquire>
  if(f->ref < 1)
80100fe6:	8b 53 04             	mov    0x4(%ebx),%edx
80100fe9:	83 c4 10             	add    $0x10,%esp
80100fec:	85 d2                	test   %edx,%edx
80100fee:	0f 8e a5 00 00 00    	jle    80101099 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100ff4:	83 ea 01             	sub    $0x1,%edx
80100ff7:	89 53 04             	mov    %edx,0x4(%ebx)
80100ffa:	75 44                	jne    80101040 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ffc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101000:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101003:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101005:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010100b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010100e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101011:	8b 43 10             	mov    0x10(%ebx),%eax
80101014:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101017:	68 60 ff 10 80       	push   $0x8010ff60
8010101c:	e8 ef 36 00 00       	call   80104710 <release>

  if(ff.type == FD_PIPE)
80101021:	83 c4 10             	add    $0x10,%esp
80101024:	83 ff 01             	cmp    $0x1,%edi
80101027:	74 57                	je     80101080 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101029:	83 ff 02             	cmp    $0x2,%edi
8010102c:	74 2a                	je     80101058 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010102e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101031:	5b                   	pop    %ebx
80101032:	5e                   	pop    %esi
80101033:	5f                   	pop    %edi
80101034:	5d                   	pop    %ebp
80101035:	c3                   	ret
80101036:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010103d:	00 
8010103e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101040:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101047:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010104a:	5b                   	pop    %ebx
8010104b:	5e                   	pop    %esi
8010104c:	5f                   	pop    %edi
8010104d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010104e:	e9 bd 36 00 00       	jmp    80104710 <release>
80101053:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101058:	e8 a3 1d 00 00       	call   80102e00 <begin_op>
    iput(ff.ip);
8010105d:	83 ec 0c             	sub    $0xc,%esp
80101060:	ff 75 e0             	push   -0x20(%ebp)
80101063:	e8 28 09 00 00       	call   80101990 <iput>
    end_op();
80101068:	83 c4 10             	add    $0x10,%esp
}
8010106b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010106e:	5b                   	pop    %ebx
8010106f:	5e                   	pop    %esi
80101070:	5f                   	pop    %edi
80101071:	5d                   	pop    %ebp
    end_op();
80101072:	e9 f9 1d 00 00       	jmp    80102e70 <end_op>
80101077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010107e:	00 
8010107f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101080:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101084:	83 ec 08             	sub    $0x8,%esp
80101087:	53                   	push   %ebx
80101088:	56                   	push   %esi
80101089:	e8 42 25 00 00       	call   801035d0 <pipeclose>
8010108e:	83 c4 10             	add    $0x10,%esp
}
80101091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101094:	5b                   	pop    %ebx
80101095:	5e                   	pop    %esi
80101096:	5f                   	pop    %edi
80101097:	5d                   	pop    %ebp
80101098:	c3                   	ret
    panic("fileclose");
80101099:	83 ec 0c             	sub    $0xc,%esp
8010109c:	68 41 7a 10 80       	push   $0x80107a41
801010a1:	e8 da f2 ff ff       	call   80100380 <panic>
801010a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010ad:	00 
801010ae:	66 90                	xchg   %ax,%ax

801010b0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	53                   	push   %ebx
801010b4:	83 ec 04             	sub    $0x4,%esp
801010b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801010ba:	83 3b 02             	cmpl   $0x2,(%ebx)
801010bd:	75 31                	jne    801010f0 <filestat+0x40>
    ilock(f->ip);
801010bf:	83 ec 0c             	sub    $0xc,%esp
801010c2:	ff 73 10             	push   0x10(%ebx)
801010c5:	e8 96 07 00 00       	call   80101860 <ilock>
    stati(f->ip, st);
801010ca:	58                   	pop    %eax
801010cb:	5a                   	pop    %edx
801010cc:	ff 75 0c             	push   0xc(%ebp)
801010cf:	ff 73 10             	push   0x10(%ebx)
801010d2:	e8 69 0a 00 00       	call   80101b40 <stati>
    iunlock(f->ip);
801010d7:	59                   	pop    %ecx
801010d8:	ff 73 10             	push   0x10(%ebx)
801010db:	e8 60 08 00 00       	call   80101940 <iunlock>
    return 0;
  }
  return -1;
}
801010e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801010e3:	83 c4 10             	add    $0x10,%esp
801010e6:	31 c0                	xor    %eax,%eax
}
801010e8:	c9                   	leave
801010e9:	c3                   	ret
801010ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801010f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010f8:	c9                   	leave
801010f9:	c3                   	ret
801010fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101100 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 0c             	sub    $0xc,%esp
80101109:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010110c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010110f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101112:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101116:	74 60                	je     80101178 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101118:	8b 03                	mov    (%ebx),%eax
8010111a:	83 f8 01             	cmp    $0x1,%eax
8010111d:	74 41                	je     80101160 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010111f:	83 f8 02             	cmp    $0x2,%eax
80101122:	75 5b                	jne    8010117f <fileread+0x7f>
    ilock(f->ip);
80101124:	83 ec 0c             	sub    $0xc,%esp
80101127:	ff 73 10             	push   0x10(%ebx)
8010112a:	e8 31 07 00 00       	call   80101860 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010112f:	57                   	push   %edi
80101130:	ff 73 14             	push   0x14(%ebx)
80101133:	56                   	push   %esi
80101134:	ff 73 10             	push   0x10(%ebx)
80101137:	e8 34 0a 00 00       	call   80101b70 <readi>
8010113c:	83 c4 20             	add    $0x20,%esp
8010113f:	89 c6                	mov    %eax,%esi
80101141:	85 c0                	test   %eax,%eax
80101143:	7e 03                	jle    80101148 <fileread+0x48>
      f->off += r;
80101145:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101148:	83 ec 0c             	sub    $0xc,%esp
8010114b:	ff 73 10             	push   0x10(%ebx)
8010114e:	e8 ed 07 00 00       	call   80101940 <iunlock>
    return r;
80101153:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101156:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101159:	89 f0                	mov    %esi,%eax
8010115b:	5b                   	pop    %ebx
8010115c:	5e                   	pop    %esi
8010115d:	5f                   	pop    %edi
8010115e:	5d                   	pop    %ebp
8010115f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101160:	8b 43 0c             	mov    0xc(%ebx),%eax
80101163:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101169:	5b                   	pop    %ebx
8010116a:	5e                   	pop    %esi
8010116b:	5f                   	pop    %edi
8010116c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010116d:	e9 1e 26 00 00       	jmp    80103790 <piperead>
80101172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101178:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010117d:	eb d7                	jmp    80101156 <fileread+0x56>
  panic("fileread");
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	68 4b 7a 10 80       	push   $0x80107a4b
80101187:	e8 f4 f1 ff ff       	call   80100380 <panic>
8010118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101190 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	57                   	push   %edi
80101194:	56                   	push   %esi
80101195:	53                   	push   %ebx
80101196:	83 ec 1c             	sub    $0x1c,%esp
80101199:	8b 45 0c             	mov    0xc(%ebp),%eax
8010119c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010119f:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011a2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801011a5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801011a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801011ac:	0f 84 bb 00 00 00    	je     8010126d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801011b2:	8b 03                	mov    (%ebx),%eax
801011b4:	83 f8 01             	cmp    $0x1,%eax
801011b7:	0f 84 bf 00 00 00    	je     8010127c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801011bd:	83 f8 02             	cmp    $0x2,%eax
801011c0:	0f 85 c8 00 00 00    	jne    8010128e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801011c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801011c9:	31 f6                	xor    %esi,%esi
    while(i < n){
801011cb:	85 c0                	test   %eax,%eax
801011cd:	7f 30                	jg     801011ff <filewrite+0x6f>
801011cf:	e9 94 00 00 00       	jmp    80101268 <filewrite+0xd8>
801011d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801011d8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801011db:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
801011de:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011e1:	ff 73 10             	push   0x10(%ebx)
801011e4:	e8 57 07 00 00       	call   80101940 <iunlock>
      end_op();
801011e9:	e8 82 1c 00 00       	call   80102e70 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801011ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011f1:	83 c4 10             	add    $0x10,%esp
801011f4:	39 c7                	cmp    %eax,%edi
801011f6:	75 5c                	jne    80101254 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801011f8:	01 fe                	add    %edi,%esi
    while(i < n){
801011fa:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011fd:	7e 69                	jle    80101268 <filewrite+0xd8>
      int n1 = n - i;
801011ff:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101202:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101207:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101209:	39 c7                	cmp    %eax,%edi
8010120b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010120e:	e8 ed 1b 00 00       	call   80102e00 <begin_op>
      ilock(f->ip);
80101213:	83 ec 0c             	sub    $0xc,%esp
80101216:	ff 73 10             	push   0x10(%ebx)
80101219:	e8 42 06 00 00       	call   80101860 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010121e:	57                   	push   %edi
8010121f:	ff 73 14             	push   0x14(%ebx)
80101222:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101225:	01 f0                	add    %esi,%eax
80101227:	50                   	push   %eax
80101228:	ff 73 10             	push   0x10(%ebx)
8010122b:	e8 40 0a 00 00       	call   80101c70 <writei>
80101230:	83 c4 20             	add    $0x20,%esp
80101233:	85 c0                	test   %eax,%eax
80101235:	7f a1                	jg     801011d8 <filewrite+0x48>
80101237:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010123a:	83 ec 0c             	sub    $0xc,%esp
8010123d:	ff 73 10             	push   0x10(%ebx)
80101240:	e8 fb 06 00 00       	call   80101940 <iunlock>
      end_op();
80101245:	e8 26 1c 00 00       	call   80102e70 <end_op>
      if(r < 0)
8010124a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010124d:	83 c4 10             	add    $0x10,%esp
80101250:	85 c0                	test   %eax,%eax
80101252:	75 14                	jne    80101268 <filewrite+0xd8>
        panic("short filewrite");
80101254:	83 ec 0c             	sub    $0xc,%esp
80101257:	68 54 7a 10 80       	push   $0x80107a54
8010125c:	e8 1f f1 ff ff       	call   80100380 <panic>
80101261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101268:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010126b:	74 05                	je     80101272 <filewrite+0xe2>
8010126d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101272:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101275:	89 f0                	mov    %esi,%eax
80101277:	5b                   	pop    %ebx
80101278:	5e                   	pop    %esi
80101279:	5f                   	pop    %edi
8010127a:	5d                   	pop    %ebp
8010127b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010127c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010127f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101282:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101285:	5b                   	pop    %ebx
80101286:	5e                   	pop    %esi
80101287:	5f                   	pop    %edi
80101288:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101289:	e9 e2 23 00 00       	jmp    80103670 <pipewrite>
  panic("filewrite");
8010128e:	83 ec 0c             	sub    $0xc,%esp
80101291:	68 5a 7a 10 80       	push   $0x80107a5a
80101296:	e8 e5 f0 ff ff       	call   80100380 <panic>
8010129b:	66 90                	xchg   %ax,%ax
8010129d:	66 90                	xchg   %ax,%ax
8010129f:	90                   	nop

801012a0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	56                   	push   %esi
801012a5:	53                   	push   %ebx
801012a6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012a9:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
801012af:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012b2:	85 c9                	test   %ecx,%ecx
801012b4:	0f 84 8c 00 00 00    	je     80101346 <balloc+0xa6>
801012ba:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
801012bc:	89 f8                	mov    %edi,%eax
801012be:	83 ec 08             	sub    $0x8,%esp
801012c1:	89 fe                	mov    %edi,%esi
801012c3:	c1 f8 0c             	sar    $0xc,%eax
801012c6:	03 05 cc 25 11 80    	add    0x801125cc,%eax
801012cc:	50                   	push   %eax
801012cd:	ff 75 dc             	push   -0x24(%ebp)
801012d0:	e8 fb ed ff ff       	call   801000d0 <bread>
801012d5:	83 c4 10             	add    $0x10,%esp
801012d8:	89 7d d8             	mov    %edi,-0x28(%ebp)
801012db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012de:	a1 b4 25 11 80       	mov    0x801125b4,%eax
801012e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012e6:	31 c0                	xor    %eax,%eax
801012e8:	eb 32                	jmp    8010131c <balloc+0x7c>
801012ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801012f0:	89 c1                	mov    %eax,%ecx
801012f2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012f7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
801012fa:	83 e1 07             	and    $0x7,%ecx
801012fd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012ff:	89 c1                	mov    %eax,%ecx
80101301:	c1 f9 03             	sar    $0x3,%ecx
80101304:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101309:	89 fa                	mov    %edi,%edx
8010130b:	85 df                	test   %ebx,%edi
8010130d:	74 49                	je     80101358 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010130f:	83 c0 01             	add    $0x1,%eax
80101312:	83 c6 01             	add    $0x1,%esi
80101315:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010131a:	74 07                	je     80101323 <balloc+0x83>
8010131c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010131f:	39 d6                	cmp    %edx,%esi
80101321:	72 cd                	jb     801012f0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101323:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101326:	83 ec 0c             	sub    $0xc,%esp
80101329:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010132c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101332:	e8 b9 ee ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101337:	83 c4 10             	add    $0x10,%esp
8010133a:	3b 3d b4 25 11 80    	cmp    0x801125b4,%edi
80101340:	0f 82 76 ff ff ff    	jb     801012bc <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101346:	83 ec 0c             	sub    $0xc,%esp
80101349:	68 64 7a 10 80       	push   $0x80107a64
8010134e:	e8 2d f0 ff ff       	call   80100380 <panic>
80101353:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101358:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010135b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010135e:	09 da                	or     %ebx,%edx
80101360:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101364:	57                   	push   %edi
80101365:	e8 76 1c 00 00       	call   80102fe0 <log_write>
        brelse(bp);
8010136a:	89 3c 24             	mov    %edi,(%esp)
8010136d:	e8 7e ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101372:	58                   	pop    %eax
80101373:	5a                   	pop    %edx
80101374:	56                   	push   %esi
80101375:	ff 75 dc             	push   -0x24(%ebp)
80101378:	e8 53 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010137d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101380:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101382:	8d 40 5c             	lea    0x5c(%eax),%eax
80101385:	68 00 02 00 00       	push   $0x200
8010138a:	6a 00                	push   $0x0
8010138c:	50                   	push   %eax
8010138d:	e8 de 34 00 00       	call   80104870 <memset>
  log_write(bp);
80101392:	89 1c 24             	mov    %ebx,(%esp)
80101395:	e8 46 1c 00 00       	call   80102fe0 <log_write>
  brelse(bp);
8010139a:	89 1c 24             	mov    %ebx,(%esp)
8010139d:	e8 4e ee ff ff       	call   801001f0 <brelse>
}
801013a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013a5:	89 f0                	mov    %esi,%eax
801013a7:	5b                   	pop    %ebx
801013a8:	5e                   	pop    %esi
801013a9:	5f                   	pop    %edi
801013aa:	5d                   	pop    %ebp
801013ab:	c3                   	ret
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013b0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013b4:	31 ff                	xor    %edi,%edi
{
801013b6:	56                   	push   %esi
801013b7:	89 c6                	mov    %eax,%esi
801013b9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ba:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
801013bf:	83 ec 28             	sub    $0x28,%esp
801013c2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013c5:	68 60 09 11 80       	push   $0x80110960
801013ca:	e8 a1 33 00 00       	call   80104770 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801013d2:	83 c4 10             	add    $0x10,%esp
801013d5:	eb 1b                	jmp    801013f2 <iget+0x42>
801013d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013de:	00 
801013df:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013e0:	39 33                	cmp    %esi,(%ebx)
801013e2:	74 6c                	je     80101450 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013ea:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013f0:	74 26                	je     80101418 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f2:	8b 43 08             	mov    0x8(%ebx),%eax
801013f5:	85 c0                	test   %eax,%eax
801013f7:	7f e7                	jg     801013e0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013f9:	85 ff                	test   %edi,%edi
801013fb:	75 e7                	jne    801013e4 <iget+0x34>
801013fd:	85 c0                	test   %eax,%eax
801013ff:	75 76                	jne    80101477 <iget+0xc7>
      empty = ip;
80101401:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101403:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101409:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010140f:	75 e1                	jne    801013f2 <iget+0x42>
80101411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101418:	85 ff                	test   %edi,%edi
8010141a:	74 79                	je     80101495 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010141c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010141f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101421:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101424:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010142b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101432:	68 60 09 11 80       	push   $0x80110960
80101437:	e8 d4 32 00 00       	call   80104710 <release>

  return ip;
8010143c:	83 c4 10             	add    $0x10,%esp
}
8010143f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101442:	89 f8                	mov    %edi,%eax
80101444:	5b                   	pop    %ebx
80101445:	5e                   	pop    %esi
80101446:	5f                   	pop    %edi
80101447:	5d                   	pop    %ebp
80101448:	c3                   	ret
80101449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101450:	39 53 04             	cmp    %edx,0x4(%ebx)
80101453:	75 8f                	jne    801013e4 <iget+0x34>
      ip->ref++;
80101455:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101458:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010145b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010145d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101460:	68 60 09 11 80       	push   $0x80110960
80101465:	e8 a6 32 00 00       	call   80104710 <release>
      return ip;
8010146a:	83 c4 10             	add    $0x10,%esp
}
8010146d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101470:	89 f8                	mov    %edi,%eax
80101472:	5b                   	pop    %ebx
80101473:	5e                   	pop    %esi
80101474:	5f                   	pop    %edi
80101475:	5d                   	pop    %ebp
80101476:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101477:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010147d:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101483:	74 10                	je     80101495 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101485:	8b 43 08             	mov    0x8(%ebx),%eax
80101488:	85 c0                	test   %eax,%eax
8010148a:	0f 8f 50 ff ff ff    	jg     801013e0 <iget+0x30>
80101490:	e9 68 ff ff ff       	jmp    801013fd <iget+0x4d>
    panic("iget: no inodes");
80101495:	83 ec 0c             	sub    $0xc,%esp
80101498:	68 7a 7a 10 80       	push   $0x80107a7a
8010149d:	e8 de ee ff ff       	call   80100380 <panic>
801014a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014a9:	00 
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014b0 <bfree>:
{
801014b0:	55                   	push   %ebp
801014b1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
801014b3:	89 d0                	mov    %edx,%eax
801014b5:	c1 e8 0c             	shr    $0xc,%eax
{
801014b8:	89 e5                	mov    %esp,%ebp
801014ba:	56                   	push   %esi
801014bb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
801014bc:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801014c2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801014c4:	83 ec 08             	sub    $0x8,%esp
801014c7:	50                   	push   %eax
801014c8:	51                   	push   %ecx
801014c9:	e8 02 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014ce:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014d0:	c1 fb 03             	sar    $0x3,%ebx
801014d3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801014d6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801014d8:	83 e1 07             	and    $0x7,%ecx
801014db:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801014e0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801014e6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801014e8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801014ed:	85 c1                	test   %eax,%ecx
801014ef:	74 23                	je     80101514 <bfree+0x64>
  bp->data[bi/8] &= ~m;
801014f1:	f7 d0                	not    %eax
  log_write(bp);
801014f3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801014f6:	21 c8                	and    %ecx,%eax
801014f8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801014fc:	56                   	push   %esi
801014fd:	e8 de 1a 00 00       	call   80102fe0 <log_write>
  brelse(bp);
80101502:	89 34 24             	mov    %esi,(%esp)
80101505:	e8 e6 ec ff ff       	call   801001f0 <brelse>
}
8010150a:	83 c4 10             	add    $0x10,%esp
8010150d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101510:	5b                   	pop    %ebx
80101511:	5e                   	pop    %esi
80101512:	5d                   	pop    %ebp
80101513:	c3                   	ret
    panic("freeing free block");
80101514:	83 ec 0c             	sub    $0xc,%esp
80101517:	68 8a 7a 10 80       	push   $0x80107a8a
8010151c:	e8 5f ee ff ff       	call   80100380 <panic>
80101521:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101528:	00 
80101529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101530 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	57                   	push   %edi
80101534:	56                   	push   %esi
80101535:	89 c6                	mov    %eax,%esi
80101537:	53                   	push   %ebx
80101538:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010153b:	83 fa 0b             	cmp    $0xb,%edx
8010153e:	0f 86 8c 00 00 00    	jbe    801015d0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101544:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101547:	83 fb 7f             	cmp    $0x7f,%ebx
8010154a:	0f 87 a2 00 00 00    	ja     801015f2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101550:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101556:	85 c0                	test   %eax,%eax
80101558:	74 5e                	je     801015b8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010155a:	83 ec 08             	sub    $0x8,%esp
8010155d:	50                   	push   %eax
8010155e:	ff 36                	push   (%esi)
80101560:	e8 6b eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101565:	83 c4 10             	add    $0x10,%esp
80101568:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010156c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010156e:	8b 3b                	mov    (%ebx),%edi
80101570:	85 ff                	test   %edi,%edi
80101572:	74 1c                	je     80101590 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101574:	83 ec 0c             	sub    $0xc,%esp
80101577:	52                   	push   %edx
80101578:	e8 73 ec ff ff       	call   801001f0 <brelse>
8010157d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101580:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101583:	89 f8                	mov    %edi,%eax
80101585:	5b                   	pop    %ebx
80101586:	5e                   	pop    %esi
80101587:	5f                   	pop    %edi
80101588:	5d                   	pop    %ebp
80101589:	c3                   	ret
8010158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101590:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101593:	8b 06                	mov    (%esi),%eax
80101595:	e8 06 fd ff ff       	call   801012a0 <balloc>
      log_write(bp);
8010159a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010159d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801015a0:	89 03                	mov    %eax,(%ebx)
801015a2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801015a4:	52                   	push   %edx
801015a5:	e8 36 1a 00 00       	call   80102fe0 <log_write>
801015aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015ad:	83 c4 10             	add    $0x10,%esp
801015b0:	eb c2                	jmp    80101574 <bmap+0x44>
801015b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801015b8:	8b 06                	mov    (%esi),%eax
801015ba:	e8 e1 fc ff ff       	call   801012a0 <balloc>
801015bf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801015c5:	eb 93                	jmp    8010155a <bmap+0x2a>
801015c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801015ce:	00 
801015cf:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
801015d0:	8d 5a 14             	lea    0x14(%edx),%ebx
801015d3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801015d7:	85 ff                	test   %edi,%edi
801015d9:	75 a5                	jne    80101580 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801015db:	8b 00                	mov    (%eax),%eax
801015dd:	e8 be fc ff ff       	call   801012a0 <balloc>
801015e2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801015e6:	89 c7                	mov    %eax,%edi
}
801015e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015eb:	5b                   	pop    %ebx
801015ec:	89 f8                	mov    %edi,%eax
801015ee:	5e                   	pop    %esi
801015ef:	5f                   	pop    %edi
801015f0:	5d                   	pop    %ebp
801015f1:	c3                   	ret
  panic("bmap: out of range");
801015f2:	83 ec 0c             	sub    $0xc,%esp
801015f5:	68 9d 7a 10 80       	push   $0x80107a9d
801015fa:	e8 81 ed ff ff       	call   80100380 <panic>
801015ff:	90                   	nop

80101600 <readsb>:
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	56                   	push   %esi
80101604:	53                   	push   %ebx
80101605:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101608:	83 ec 08             	sub    $0x8,%esp
8010160b:	6a 01                	push   $0x1
8010160d:	ff 75 08             	push   0x8(%ebp)
80101610:	e8 bb ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101615:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101618:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010161a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010161d:	6a 1c                	push   $0x1c
8010161f:	50                   	push   %eax
80101620:	56                   	push   %esi
80101621:	e8 da 32 00 00       	call   80104900 <memmove>
  brelse(bp);
80101626:	83 c4 10             	add    $0x10,%esp
80101629:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010162c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010162f:	5b                   	pop    %ebx
80101630:	5e                   	pop    %esi
80101631:	5d                   	pop    %ebp
  brelse(bp);
80101632:	e9 b9 eb ff ff       	jmp    801001f0 <brelse>
80101637:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010163e:	00 
8010163f:	90                   	nop

80101640 <iinit>:
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101649:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010164c:	68 b0 7a 10 80       	push   $0x80107ab0
80101651:	68 60 09 11 80       	push   $0x80110960
80101656:	e8 25 2f 00 00       	call   80104580 <initlock>
  for(i = 0; i < NINODE; i++) {
8010165b:	83 c4 10             	add    $0x10,%esp
8010165e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101660:	83 ec 08             	sub    $0x8,%esp
80101663:	68 b7 7a 10 80       	push   $0x80107ab7
80101668:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101669:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010166f:	e8 dc 2d 00 00       	call   80104450 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101674:	83 c4 10             	add    $0x10,%esp
80101677:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010167d:	75 e1                	jne    80101660 <iinit+0x20>
  bp = bread(dev, 1);
8010167f:	83 ec 08             	sub    $0x8,%esp
80101682:	6a 01                	push   $0x1
80101684:	ff 75 08             	push   0x8(%ebp)
80101687:	e8 44 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010168c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010168f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101691:	8d 40 5c             	lea    0x5c(%eax),%eax
80101694:	6a 1c                	push   $0x1c
80101696:	50                   	push   %eax
80101697:	68 b4 25 11 80       	push   $0x801125b4
8010169c:	e8 5f 32 00 00       	call   80104900 <memmove>
  brelse(bp);
801016a1:	89 1c 24             	mov    %ebx,(%esp)
801016a4:	e8 47 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016a9:	ff 35 cc 25 11 80    	push   0x801125cc
801016af:	ff 35 c8 25 11 80    	push   0x801125c8
801016b5:	ff 35 c4 25 11 80    	push   0x801125c4
801016bb:	ff 35 c0 25 11 80    	push   0x801125c0
801016c1:	ff 35 bc 25 11 80    	push   0x801125bc
801016c7:	ff 35 b8 25 11 80    	push   0x801125b8
801016cd:	ff 35 b4 25 11 80    	push   0x801125b4
801016d3:	68 00 7f 10 80       	push   $0x80107f00
801016d8:	e8 d3 ef ff ff       	call   801006b0 <cprintf>
}
801016dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016e0:	83 c4 30             	add    $0x30,%esp
801016e3:	c9                   	leave
801016e4:	c3                   	ret
801016e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016ec:	00 
801016ed:	8d 76 00             	lea    0x0(%esi),%esi

801016f0 <ialloc>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	57                   	push   %edi
801016f4:	56                   	push   %esi
801016f5:	53                   	push   %ebx
801016f6:	83 ec 1c             	sub    $0x1c,%esp
801016f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801016fc:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101703:	8b 75 08             	mov    0x8(%ebp),%esi
80101706:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101709:	0f 86 91 00 00 00    	jbe    801017a0 <ialloc+0xb0>
8010170f:	bf 01 00 00 00       	mov    $0x1,%edi
80101714:	eb 21                	jmp    80101737 <ialloc+0x47>
80101716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010171d:	00 
8010171e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101720:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101723:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101726:	53                   	push   %ebx
80101727:	e8 c4 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010172c:	83 c4 10             	add    $0x10,%esp
8010172f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101735:	73 69                	jae    801017a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101737:	89 f8                	mov    %edi,%eax
80101739:	83 ec 08             	sub    $0x8,%esp
8010173c:	c1 e8 03             	shr    $0x3,%eax
8010173f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101745:	50                   	push   %eax
80101746:	56                   	push   %esi
80101747:	e8 84 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010174c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010174f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101751:	89 f8                	mov    %edi,%eax
80101753:	83 e0 07             	and    $0x7,%eax
80101756:	c1 e0 06             	shl    $0x6,%eax
80101759:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010175d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101761:	75 bd                	jne    80101720 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101763:	83 ec 04             	sub    $0x4,%esp
80101766:	6a 40                	push   $0x40
80101768:	6a 00                	push   $0x0
8010176a:	51                   	push   %ecx
8010176b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010176e:	e8 fd 30 00 00       	call   80104870 <memset>
      dip->type = type;
80101773:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101777:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010177a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010177d:	89 1c 24             	mov    %ebx,(%esp)
80101780:	e8 5b 18 00 00       	call   80102fe0 <log_write>
      brelse(bp);
80101785:	89 1c 24             	mov    %ebx,(%esp)
80101788:	e8 63 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010178d:	83 c4 10             	add    $0x10,%esp
}
80101790:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101793:	89 fa                	mov    %edi,%edx
}
80101795:	5b                   	pop    %ebx
      return iget(dev, inum);
80101796:	89 f0                	mov    %esi,%eax
}
80101798:	5e                   	pop    %esi
80101799:	5f                   	pop    %edi
8010179a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010179b:	e9 10 fc ff ff       	jmp    801013b0 <iget>
  panic("ialloc: no inodes");
801017a0:	83 ec 0c             	sub    $0xc,%esp
801017a3:	68 bd 7a 10 80       	push   $0x80107abd
801017a8:	e8 d3 eb ff ff       	call   80100380 <panic>
801017ad:	8d 76 00             	lea    0x0(%esi),%esi

801017b0 <iupdate>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	56                   	push   %esi
801017b4:	53                   	push   %ebx
801017b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017b8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017bb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017be:	83 ec 08             	sub    $0x8,%esp
801017c1:	c1 e8 03             	shr    $0x3,%eax
801017c4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017ca:	50                   	push   %eax
801017cb:	ff 73 a4             	push   -0x5c(%ebx)
801017ce:	e8 fd e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801017d3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017d7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017da:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017dc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017f0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801017f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801017f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801017fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801017ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101803:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101807:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010180a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010180d:	6a 34                	push   $0x34
8010180f:	53                   	push   %ebx
80101810:	50                   	push   %eax
80101811:	e8 ea 30 00 00       	call   80104900 <memmove>
  log_write(bp);
80101816:	89 34 24             	mov    %esi,(%esp)
80101819:	e8 c2 17 00 00       	call   80102fe0 <log_write>
  brelse(bp);
8010181e:	83 c4 10             	add    $0x10,%esp
80101821:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101824:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101827:	5b                   	pop    %ebx
80101828:	5e                   	pop    %esi
80101829:	5d                   	pop    %ebp
  brelse(bp);
8010182a:	e9 c1 e9 ff ff       	jmp    801001f0 <brelse>
8010182f:	90                   	nop

80101830 <idup>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	53                   	push   %ebx
80101834:	83 ec 10             	sub    $0x10,%esp
80101837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010183a:	68 60 09 11 80       	push   $0x80110960
8010183f:	e8 2c 2f 00 00       	call   80104770 <acquire>
  ip->ref++;
80101844:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101848:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010184f:	e8 bc 2e 00 00       	call   80104710 <release>
}
80101854:	89 d8                	mov    %ebx,%eax
80101856:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101859:	c9                   	leave
8010185a:	c3                   	ret
8010185b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101860 <ilock>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101868:	85 db                	test   %ebx,%ebx
8010186a:	0f 84 b7 00 00 00    	je     80101927 <ilock+0xc7>
80101870:	8b 53 08             	mov    0x8(%ebx),%edx
80101873:	85 d2                	test   %edx,%edx
80101875:	0f 8e ac 00 00 00    	jle    80101927 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010187b:	83 ec 0c             	sub    $0xc,%esp
8010187e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101881:	50                   	push   %eax
80101882:	e8 09 2c 00 00       	call   80104490 <acquiresleep>
  if(ip->valid == 0){
80101887:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010188a:	83 c4 10             	add    $0x10,%esp
8010188d:	85 c0                	test   %eax,%eax
8010188f:	74 0f                	je     801018a0 <ilock+0x40>
}
80101891:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101894:	5b                   	pop    %ebx
80101895:	5e                   	pop    %esi
80101896:	5d                   	pop    %ebp
80101897:	c3                   	ret
80101898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010189f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018a0:	8b 43 04             	mov    0x4(%ebx),%eax
801018a3:	83 ec 08             	sub    $0x8,%esp
801018a6:	c1 e8 03             	shr    $0x3,%eax
801018a9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801018af:	50                   	push   %eax
801018b0:	ff 33                	push   (%ebx)
801018b2:	e8 19 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018b7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018ba:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018bc:	8b 43 04             	mov    0x4(%ebx),%eax
801018bf:	83 e0 07             	and    $0x7,%eax
801018c2:	c1 e0 06             	shl    $0x6,%eax
801018c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018c9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018cc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801018cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801018d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801018df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801018e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801018ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018f1:	6a 34                	push   $0x34
801018f3:	50                   	push   %eax
801018f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018f7:	50                   	push   %eax
801018f8:	e8 03 30 00 00       	call   80104900 <memmove>
    brelse(bp);
801018fd:	89 34 24             	mov    %esi,(%esp)
80101900:	e8 eb e8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101905:	83 c4 10             	add    $0x10,%esp
80101908:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010190d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101914:	0f 85 77 ff ff ff    	jne    80101891 <ilock+0x31>
      panic("ilock: no type");
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 d5 7a 10 80       	push   $0x80107ad5
80101922:	e8 59 ea ff ff       	call   80100380 <panic>
    panic("ilock");
80101927:	83 ec 0c             	sub    $0xc,%esp
8010192a:	68 cf 7a 10 80       	push   $0x80107acf
8010192f:	e8 4c ea ff ff       	call   80100380 <panic>
80101934:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010193b:	00 
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101940 <iunlock>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	56                   	push   %esi
80101944:	53                   	push   %ebx
80101945:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101948:	85 db                	test   %ebx,%ebx
8010194a:	74 28                	je     80101974 <iunlock+0x34>
8010194c:	83 ec 0c             	sub    $0xc,%esp
8010194f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101952:	56                   	push   %esi
80101953:	e8 d8 2b 00 00       	call   80104530 <holdingsleep>
80101958:	83 c4 10             	add    $0x10,%esp
8010195b:	85 c0                	test   %eax,%eax
8010195d:	74 15                	je     80101974 <iunlock+0x34>
8010195f:	8b 43 08             	mov    0x8(%ebx),%eax
80101962:	85 c0                	test   %eax,%eax
80101964:	7e 0e                	jle    80101974 <iunlock+0x34>
  releasesleep(&ip->lock);
80101966:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101969:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010196f:	e9 7c 2b 00 00       	jmp    801044f0 <releasesleep>
    panic("iunlock");
80101974:	83 ec 0c             	sub    $0xc,%esp
80101977:	68 e4 7a 10 80       	push   $0x80107ae4
8010197c:	e8 ff e9 ff ff       	call   80100380 <panic>
80101981:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101988:	00 
80101989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101990 <iput>:
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 28             	sub    $0x28,%esp
80101999:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010199c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010199f:	57                   	push   %edi
801019a0:	e8 eb 2a 00 00       	call   80104490 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019a5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	85 d2                	test   %edx,%edx
801019ad:	74 07                	je     801019b6 <iput+0x26>
801019af:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801019b4:	74 32                	je     801019e8 <iput+0x58>
  releasesleep(&ip->lock);
801019b6:	83 ec 0c             	sub    $0xc,%esp
801019b9:	57                   	push   %edi
801019ba:	e8 31 2b 00 00       	call   801044f0 <releasesleep>
  acquire(&icache.lock);
801019bf:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019c6:	e8 a5 2d 00 00       	call   80104770 <acquire>
  ip->ref--;
801019cb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019cf:	83 c4 10             	add    $0x10,%esp
801019d2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801019d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019dc:	5b                   	pop    %ebx
801019dd:	5e                   	pop    %esi
801019de:	5f                   	pop    %edi
801019df:	5d                   	pop    %ebp
  release(&icache.lock);
801019e0:	e9 2b 2d 00 00       	jmp    80104710 <release>
801019e5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801019e8:	83 ec 0c             	sub    $0xc,%esp
801019eb:	68 60 09 11 80       	push   $0x80110960
801019f0:	e8 7b 2d 00 00       	call   80104770 <acquire>
    int r = ip->ref;
801019f5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801019f8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019ff:	e8 0c 2d 00 00       	call   80104710 <release>
    if(r == 1){
80101a04:	83 c4 10             	add    $0x10,%esp
80101a07:	83 fe 01             	cmp    $0x1,%esi
80101a0a:	75 aa                	jne    801019b6 <iput+0x26>
80101a0c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a12:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a15:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a18:	89 df                	mov    %ebx,%edi
80101a1a:	89 cb                	mov    %ecx,%ebx
80101a1c:	eb 09                	jmp    80101a27 <iput+0x97>
80101a1e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a20:	83 c6 04             	add    $0x4,%esi
80101a23:	39 de                	cmp    %ebx,%esi
80101a25:	74 19                	je     80101a40 <iput+0xb0>
    if(ip->addrs[i]){
80101a27:	8b 16                	mov    (%esi),%edx
80101a29:	85 d2                	test   %edx,%edx
80101a2b:	74 f3                	je     80101a20 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a2d:	8b 07                	mov    (%edi),%eax
80101a2f:	e8 7c fa ff ff       	call   801014b0 <bfree>
      ip->addrs[i] = 0;
80101a34:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a3a:	eb e4                	jmp    80101a20 <iput+0x90>
80101a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a40:	89 fb                	mov    %edi,%ebx
80101a42:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a45:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101a4b:	85 c0                	test   %eax,%eax
80101a4d:	75 2d                	jne    80101a7c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a4f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101a52:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a59:	53                   	push   %ebx
80101a5a:	e8 51 fd ff ff       	call   801017b0 <iupdate>
      ip->type = 0;
80101a5f:	31 c0                	xor    %eax,%eax
80101a61:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101a65:	89 1c 24             	mov    %ebx,(%esp)
80101a68:	e8 43 fd ff ff       	call   801017b0 <iupdate>
      ip->valid = 0;
80101a6d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a74:	83 c4 10             	add    $0x10,%esp
80101a77:	e9 3a ff ff ff       	jmp    801019b6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a7c:	83 ec 08             	sub    $0x8,%esp
80101a7f:	50                   	push   %eax
80101a80:	ff 33                	push   (%ebx)
80101a82:	e8 49 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a87:	83 c4 10             	add    $0x10,%esp
80101a8a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a8d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a93:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a96:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a99:	89 cf                	mov    %ecx,%edi
80101a9b:	eb 0a                	jmp    80101aa7 <iput+0x117>
80101a9d:	8d 76 00             	lea    0x0(%esi),%esi
80101aa0:	83 c6 04             	add    $0x4,%esi
80101aa3:	39 fe                	cmp    %edi,%esi
80101aa5:	74 0f                	je     80101ab6 <iput+0x126>
      if(a[j])
80101aa7:	8b 16                	mov    (%esi),%edx
80101aa9:	85 d2                	test   %edx,%edx
80101aab:	74 f3                	je     80101aa0 <iput+0x110>
        bfree(ip->dev, a[j]);
80101aad:	8b 03                	mov    (%ebx),%eax
80101aaf:	e8 fc f9 ff ff       	call   801014b0 <bfree>
80101ab4:	eb ea                	jmp    80101aa0 <iput+0x110>
    brelse(bp);
80101ab6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ab9:	83 ec 0c             	sub    $0xc,%esp
80101abc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101abf:	50                   	push   %eax
80101ac0:	e8 2b e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ac5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101acb:	8b 03                	mov    (%ebx),%eax
80101acd:	e8 de f9 ff ff       	call   801014b0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101ad2:	83 c4 10             	add    $0x10,%esp
80101ad5:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101adc:	00 00 00 
80101adf:	e9 6b ff ff ff       	jmp    80101a4f <iput+0xbf>
80101ae4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aeb:	00 
80101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101af0 <iunlockput>:
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	56                   	push   %esi
80101af4:	53                   	push   %ebx
80101af5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101af8:	85 db                	test   %ebx,%ebx
80101afa:	74 34                	je     80101b30 <iunlockput+0x40>
80101afc:	83 ec 0c             	sub    $0xc,%esp
80101aff:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b02:	56                   	push   %esi
80101b03:	e8 28 2a 00 00       	call   80104530 <holdingsleep>
80101b08:	83 c4 10             	add    $0x10,%esp
80101b0b:	85 c0                	test   %eax,%eax
80101b0d:	74 21                	je     80101b30 <iunlockput+0x40>
80101b0f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b12:	85 c0                	test   %eax,%eax
80101b14:	7e 1a                	jle    80101b30 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b16:	83 ec 0c             	sub    $0xc,%esp
80101b19:	56                   	push   %esi
80101b1a:	e8 d1 29 00 00       	call   801044f0 <releasesleep>
  iput(ip);
80101b1f:	83 c4 10             	add    $0x10,%esp
80101b22:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b28:	5b                   	pop    %ebx
80101b29:	5e                   	pop    %esi
80101b2a:	5d                   	pop    %ebp
  iput(ip);
80101b2b:	e9 60 fe ff ff       	jmp    80101990 <iput>
    panic("iunlock");
80101b30:	83 ec 0c             	sub    $0xc,%esp
80101b33:	68 e4 7a 10 80       	push   $0x80107ae4
80101b38:	e8 43 e8 ff ff       	call   80100380 <panic>
80101b3d:	8d 76 00             	lea    0x0(%esi),%esi

80101b40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	8b 55 08             	mov    0x8(%ebp),%edx
80101b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b49:	8b 0a                	mov    (%edx),%ecx
80101b4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b54:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b5b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b63:	8b 52 58             	mov    0x58(%edx),%edx
80101b66:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b69:	5d                   	pop    %ebp
80101b6a:	c3                   	ret
80101b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 75 08             	mov    0x8(%ebp),%esi
80101b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b7f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b82:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101b87:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b8a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101b8d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101b90:	0f 84 aa 00 00 00    	je     80101c40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b96:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101b99:	8b 56 58             	mov    0x58(%esi),%edx
80101b9c:	39 fa                	cmp    %edi,%edx
80101b9e:	0f 82 bd 00 00 00    	jb     80101c61 <readi+0xf1>
80101ba4:	89 f9                	mov    %edi,%ecx
80101ba6:	31 db                	xor    %ebx,%ebx
80101ba8:	01 c1                	add    %eax,%ecx
80101baa:	0f 92 c3             	setb   %bl
80101bad:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101bb0:	0f 82 ab 00 00 00    	jb     80101c61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bb6:	89 d3                	mov    %edx,%ebx
80101bb8:	29 fb                	sub    %edi,%ebx
80101bba:	39 ca                	cmp    %ecx,%edx
80101bbc:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bbf:	85 c0                	test   %eax,%eax
80101bc1:	74 73                	je     80101c36 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101bc6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101bd3:	89 fa                	mov    %edi,%edx
80101bd5:	c1 ea 09             	shr    $0x9,%edx
80101bd8:	89 d8                	mov    %ebx,%eax
80101bda:	e8 51 f9 ff ff       	call   80101530 <bmap>
80101bdf:	83 ec 08             	sub    $0x8,%esp
80101be2:	50                   	push   %eax
80101be3:	ff 33                	push   (%ebx)
80101be5:	e8 e6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bed:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bf4:	89 f8                	mov    %edi,%eax
80101bf6:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bfb:	29 f3                	sub    %esi,%ebx
80101bfd:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101bff:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c03:	39 d9                	cmp    %ebx,%ecx
80101c05:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c08:	83 c4 0c             	add    $0xc,%esp
80101c0b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c0c:	01 de                	add    %ebx,%esi
80101c0e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101c10:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101c13:	50                   	push   %eax
80101c14:	ff 75 e0             	push   -0x20(%ebp)
80101c17:	e8 e4 2c 00 00       	call   80104900 <memmove>
    brelse(bp);
80101c1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c1f:	89 14 24             	mov    %edx,(%esp)
80101c22:	e8 c9 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c2a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c2d:	83 c4 10             	add    $0x10,%esp
80101c30:	39 de                	cmp    %ebx,%esi
80101c32:	72 9c                	jb     80101bd0 <readi+0x60>
80101c34:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101c36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c39:	5b                   	pop    %ebx
80101c3a:	5e                   	pop    %esi
80101c3b:	5f                   	pop    %edi
80101c3c:	5d                   	pop    %ebp
80101c3d:	c3                   	ret
80101c3e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c40:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101c44:	66 83 fa 09          	cmp    $0x9,%dx
80101c48:	77 17                	ja     80101c61 <readi+0xf1>
80101c4a:	8b 14 d5 00 09 11 80 	mov    -0x7feef700(,%edx,8),%edx
80101c51:	85 d2                	test   %edx,%edx
80101c53:	74 0c                	je     80101c61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101c55:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c5b:	5b                   	pop    %ebx
80101c5c:	5e                   	pop    %esi
80101c5d:	5f                   	pop    %edi
80101c5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c5f:	ff e2                	jmp    *%edx
      return -1;
80101c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c66:	eb ce                	jmp    80101c36 <readi+0xc6>
80101c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c6f:	00 

80101c70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 1c             	sub    $0x1c,%esp
80101c79:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c7f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c87:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101c8a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c8d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101c90:	0f 84 ba 00 00 00    	je     80101d50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c96:	39 78 58             	cmp    %edi,0x58(%eax)
80101c99:	0f 82 ea 00 00 00    	jb     80101d89 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c9f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ca2:	89 f2                	mov    %esi,%edx
80101ca4:	01 fa                	add    %edi,%edx
80101ca6:	0f 82 dd 00 00 00    	jb     80101d89 <writei+0x119>
80101cac:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101cb2:	0f 87 d1 00 00 00    	ja     80101d89 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cb8:	85 f6                	test   %esi,%esi
80101cba:	0f 84 85 00 00 00    	je     80101d45 <writei+0xd5>
80101cc0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101cc7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cd0:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101cd3:	89 fa                	mov    %edi,%edx
80101cd5:	c1 ea 09             	shr    $0x9,%edx
80101cd8:	89 f0                	mov    %esi,%eax
80101cda:	e8 51 f8 ff ff       	call   80101530 <bmap>
80101cdf:	83 ec 08             	sub    $0x8,%esp
80101ce2:	50                   	push   %eax
80101ce3:	ff 36                	push   (%esi)
80101ce5:	e8 e6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ced:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101cf0:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cf5:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101cf7:	89 f8                	mov    %edi,%eax
80101cf9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101cfe:	29 d3                	sub    %edx,%ebx
80101d00:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d02:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d06:	39 d9                	cmp    %ebx,%ecx
80101d08:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d0b:	83 c4 0c             	add    $0xc,%esp
80101d0e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d0f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101d11:	ff 75 dc             	push   -0x24(%ebp)
80101d14:	50                   	push   %eax
80101d15:	e8 e6 2b 00 00       	call   80104900 <memmove>
    log_write(bp);
80101d1a:	89 34 24             	mov    %esi,(%esp)
80101d1d:	e8 be 12 00 00       	call   80102fe0 <log_write>
    brelse(bp);
80101d22:	89 34 24             	mov    %esi,(%esp)
80101d25:	e8 c6 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d2a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d30:	83 c4 10             	add    $0x10,%esp
80101d33:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d36:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d39:	39 d8                	cmp    %ebx,%eax
80101d3b:	72 93                	jb     80101cd0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d3d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d40:	39 78 58             	cmp    %edi,0x58(%eax)
80101d43:	72 33                	jb     80101d78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d45:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d4b:	5b                   	pop    %ebx
80101d4c:	5e                   	pop    %esi
80101d4d:	5f                   	pop    %edi
80101d4e:	5d                   	pop    %ebp
80101d4f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d54:	66 83 f8 09          	cmp    $0x9,%ax
80101d58:	77 2f                	ja     80101d89 <writei+0x119>
80101d5a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101d61:	85 c0                	test   %eax,%eax
80101d63:	74 24                	je     80101d89 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101d65:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101d68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6b:	5b                   	pop    %ebx
80101d6c:	5e                   	pop    %esi
80101d6d:	5f                   	pop    %edi
80101d6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d6f:	ff e0                	jmp    *%eax
80101d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101d78:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d7b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101d7e:	50                   	push   %eax
80101d7f:	e8 2c fa ff ff       	call   801017b0 <iupdate>
80101d84:	83 c4 10             	add    $0x10,%esp
80101d87:	eb bc                	jmp    80101d45 <writei+0xd5>
      return -1;
80101d89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d8e:	eb b8                	jmp    80101d48 <writei+0xd8>

80101d90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d96:	6a 0e                	push   $0xe
80101d98:	ff 75 0c             	push   0xc(%ebp)
80101d9b:	ff 75 08             	push   0x8(%ebp)
80101d9e:	e8 cd 2b 00 00       	call   80104970 <strncmp>
}
80101da3:	c9                   	leave
80101da4:	c3                   	ret
80101da5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dac:	00 
80101dad:	8d 76 00             	lea    0x0(%esi),%esi

80101db0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	83 ec 1c             	sub    $0x1c,%esp
80101db9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101dc1:	0f 85 85 00 00 00    	jne    80101e4c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101dc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101dca:	31 ff                	xor    %edi,%edi
80101dcc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dcf:	85 d2                	test   %edx,%edx
80101dd1:	74 3e                	je     80101e11 <dirlookup+0x61>
80101dd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dd8:	6a 10                	push   $0x10
80101dda:	57                   	push   %edi
80101ddb:	56                   	push   %esi
80101ddc:	53                   	push   %ebx
80101ddd:	e8 8e fd ff ff       	call   80101b70 <readi>
80101de2:	83 c4 10             	add    $0x10,%esp
80101de5:	83 f8 10             	cmp    $0x10,%eax
80101de8:	75 55                	jne    80101e3f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101dea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101def:	74 18                	je     80101e09 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101df1:	83 ec 04             	sub    $0x4,%esp
80101df4:	8d 45 da             	lea    -0x26(%ebp),%eax
80101df7:	6a 0e                	push   $0xe
80101df9:	50                   	push   %eax
80101dfa:	ff 75 0c             	push   0xc(%ebp)
80101dfd:	e8 6e 2b 00 00       	call   80104970 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e02:	83 c4 10             	add    $0x10,%esp
80101e05:	85 c0                	test   %eax,%eax
80101e07:	74 17                	je     80101e20 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e09:	83 c7 10             	add    $0x10,%edi
80101e0c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e0f:	72 c7                	jb     80101dd8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e11:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e14:	31 c0                	xor    %eax,%eax
}
80101e16:	5b                   	pop    %ebx
80101e17:	5e                   	pop    %esi
80101e18:	5f                   	pop    %edi
80101e19:	5d                   	pop    %ebp
80101e1a:	c3                   	ret
80101e1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101e20:	8b 45 10             	mov    0x10(%ebp),%eax
80101e23:	85 c0                	test   %eax,%eax
80101e25:	74 05                	je     80101e2c <dirlookup+0x7c>
        *poff = off;
80101e27:	8b 45 10             	mov    0x10(%ebp),%eax
80101e2a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e2c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e30:	8b 03                	mov    (%ebx),%eax
80101e32:	e8 79 f5 ff ff       	call   801013b0 <iget>
}
80101e37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e3a:	5b                   	pop    %ebx
80101e3b:	5e                   	pop    %esi
80101e3c:	5f                   	pop    %edi
80101e3d:	5d                   	pop    %ebp
80101e3e:	c3                   	ret
      panic("dirlookup read");
80101e3f:	83 ec 0c             	sub    $0xc,%esp
80101e42:	68 fe 7a 10 80       	push   $0x80107afe
80101e47:	e8 34 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101e4c:	83 ec 0c             	sub    $0xc,%esp
80101e4f:	68 ec 7a 10 80       	push   $0x80107aec
80101e54:	e8 27 e5 ff ff       	call   80100380 <panic>
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e60:	55                   	push   %ebp
80101e61:	89 e5                	mov    %esp,%ebp
80101e63:	57                   	push   %edi
80101e64:	56                   	push   %esi
80101e65:	53                   	push   %ebx
80101e66:	89 c3                	mov    %eax,%ebx
80101e68:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e6b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e6e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e71:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e74:	0f 84 9e 01 00 00    	je     80102018 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e7a:	e8 01 1c 00 00       	call   80103a80 <myproc>
  acquire(&icache.lock);
80101e7f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e82:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e85:	68 60 09 11 80       	push   $0x80110960
80101e8a:	e8 e1 28 00 00       	call   80104770 <acquire>
  ip->ref++;
80101e8f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e93:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101e9a:	e8 71 28 00 00       	call   80104710 <release>
80101e9f:	83 c4 10             	add    $0x10,%esp
80101ea2:	eb 07                	jmp    80101eab <namex+0x4b>
80101ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ea8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101eab:	0f b6 03             	movzbl (%ebx),%eax
80101eae:	3c 2f                	cmp    $0x2f,%al
80101eb0:	74 f6                	je     80101ea8 <namex+0x48>
  if(*path == 0)
80101eb2:	84 c0                	test   %al,%al
80101eb4:	0f 84 06 01 00 00    	je     80101fc0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101eba:	0f b6 03             	movzbl (%ebx),%eax
80101ebd:	84 c0                	test   %al,%al
80101ebf:	0f 84 10 01 00 00    	je     80101fd5 <namex+0x175>
80101ec5:	89 df                	mov    %ebx,%edi
80101ec7:	3c 2f                	cmp    $0x2f,%al
80101ec9:	0f 84 06 01 00 00    	je     80101fd5 <namex+0x175>
80101ecf:	90                   	nop
80101ed0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101ed4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101ed7:	3c 2f                	cmp    $0x2f,%al
80101ed9:	74 04                	je     80101edf <namex+0x7f>
80101edb:	84 c0                	test   %al,%al
80101edd:	75 f1                	jne    80101ed0 <namex+0x70>
  len = path - s;
80101edf:	89 f8                	mov    %edi,%eax
80101ee1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101ee3:	83 f8 0d             	cmp    $0xd,%eax
80101ee6:	0f 8e ac 00 00 00    	jle    80101f98 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101eec:	83 ec 04             	sub    $0x4,%esp
80101eef:	6a 0e                	push   $0xe
80101ef1:	53                   	push   %ebx
80101ef2:	89 fb                	mov    %edi,%ebx
80101ef4:	ff 75 e4             	push   -0x1c(%ebp)
80101ef7:	e8 04 2a 00 00       	call   80104900 <memmove>
80101efc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101eff:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f02:	75 0c                	jne    80101f10 <namex+0xb0>
80101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f08:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f0b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f0e:	74 f8                	je     80101f08 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f10:	83 ec 0c             	sub    $0xc,%esp
80101f13:	56                   	push   %esi
80101f14:	e8 47 f9 ff ff       	call   80101860 <ilock>
    if(ip->type != T_DIR){
80101f19:	83 c4 10             	add    $0x10,%esp
80101f1c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f21:	0f 85 b7 00 00 00    	jne    80101fde <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f27:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f2a:	85 c0                	test   %eax,%eax
80101f2c:	74 09                	je     80101f37 <namex+0xd7>
80101f2e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f31:	0f 84 f7 00 00 00    	je     8010202e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f37:	83 ec 04             	sub    $0x4,%esp
80101f3a:	6a 00                	push   $0x0
80101f3c:	ff 75 e4             	push   -0x1c(%ebp)
80101f3f:	56                   	push   %esi
80101f40:	e8 6b fe ff ff       	call   80101db0 <dirlookup>
80101f45:	83 c4 10             	add    $0x10,%esp
80101f48:	89 c7                	mov    %eax,%edi
80101f4a:	85 c0                	test   %eax,%eax
80101f4c:	0f 84 8c 00 00 00    	je     80101fde <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f52:	83 ec 0c             	sub    $0xc,%esp
80101f55:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101f58:	51                   	push   %ecx
80101f59:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101f5c:	e8 cf 25 00 00       	call   80104530 <holdingsleep>
80101f61:	83 c4 10             	add    $0x10,%esp
80101f64:	85 c0                	test   %eax,%eax
80101f66:	0f 84 02 01 00 00    	je     8010206e <namex+0x20e>
80101f6c:	8b 56 08             	mov    0x8(%esi),%edx
80101f6f:	85 d2                	test   %edx,%edx
80101f71:	0f 8e f7 00 00 00    	jle    8010206e <namex+0x20e>
  releasesleep(&ip->lock);
80101f77:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f7a:	83 ec 0c             	sub    $0xc,%esp
80101f7d:	51                   	push   %ecx
80101f7e:	e8 6d 25 00 00       	call   801044f0 <releasesleep>
  iput(ip);
80101f83:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101f86:	89 fe                	mov    %edi,%esi
  iput(ip);
80101f88:	e8 03 fa ff ff       	call   80101990 <iput>
80101f8d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f90:	e9 16 ff ff ff       	jmp    80101eab <namex+0x4b>
80101f95:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101f98:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f9b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101f9e:	83 ec 04             	sub    $0x4,%esp
80101fa1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101fa4:	50                   	push   %eax
80101fa5:	53                   	push   %ebx
    name[len] = 0;
80101fa6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101fa8:	ff 75 e4             	push   -0x1c(%ebp)
80101fab:	e8 50 29 00 00       	call   80104900 <memmove>
    name[len] = 0;
80101fb0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101fb3:	83 c4 10             	add    $0x10,%esp
80101fb6:	c6 01 00             	movb   $0x0,(%ecx)
80101fb9:	e9 41 ff ff ff       	jmp    80101eff <namex+0x9f>
80101fbe:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80101fc0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101fc3:	85 c0                	test   %eax,%eax
80101fc5:	0f 85 93 00 00 00    	jne    8010205e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80101fcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fce:	89 f0                	mov    %esi,%eax
80101fd0:	5b                   	pop    %ebx
80101fd1:	5e                   	pop    %esi
80101fd2:	5f                   	pop    %edi
80101fd3:	5d                   	pop    %ebp
80101fd4:	c3                   	ret
  while(*path != '/' && *path != 0)
80101fd5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101fd8:	89 df                	mov    %ebx,%edi
80101fda:	31 c0                	xor    %eax,%eax
80101fdc:	eb c0                	jmp    80101f9e <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fde:	83 ec 0c             	sub    $0xc,%esp
80101fe1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101fe4:	53                   	push   %ebx
80101fe5:	e8 46 25 00 00       	call   80104530 <holdingsleep>
80101fea:	83 c4 10             	add    $0x10,%esp
80101fed:	85 c0                	test   %eax,%eax
80101fef:	74 7d                	je     8010206e <namex+0x20e>
80101ff1:	8b 4e 08             	mov    0x8(%esi),%ecx
80101ff4:	85 c9                	test   %ecx,%ecx
80101ff6:	7e 76                	jle    8010206e <namex+0x20e>
  releasesleep(&ip->lock);
80101ff8:	83 ec 0c             	sub    $0xc,%esp
80101ffb:	53                   	push   %ebx
80101ffc:	e8 ef 24 00 00       	call   801044f0 <releasesleep>
  iput(ip);
80102001:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102004:	31 f6                	xor    %esi,%esi
  iput(ip);
80102006:	e8 85 f9 ff ff       	call   80101990 <iput>
      return 0;
8010200b:	83 c4 10             	add    $0x10,%esp
}
8010200e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102011:	89 f0                	mov    %esi,%eax
80102013:	5b                   	pop    %ebx
80102014:	5e                   	pop    %esi
80102015:	5f                   	pop    %edi
80102016:	5d                   	pop    %ebp
80102017:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102018:	ba 01 00 00 00       	mov    $0x1,%edx
8010201d:	b8 01 00 00 00       	mov    $0x1,%eax
80102022:	e8 89 f3 ff ff       	call   801013b0 <iget>
80102027:	89 c6                	mov    %eax,%esi
80102029:	e9 7d fe ff ff       	jmp    80101eab <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010202e:	83 ec 0c             	sub    $0xc,%esp
80102031:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102034:	53                   	push   %ebx
80102035:	e8 f6 24 00 00       	call   80104530 <holdingsleep>
8010203a:	83 c4 10             	add    $0x10,%esp
8010203d:	85 c0                	test   %eax,%eax
8010203f:	74 2d                	je     8010206e <namex+0x20e>
80102041:	8b 7e 08             	mov    0x8(%esi),%edi
80102044:	85 ff                	test   %edi,%edi
80102046:	7e 26                	jle    8010206e <namex+0x20e>
  releasesleep(&ip->lock);
80102048:	83 ec 0c             	sub    $0xc,%esp
8010204b:	53                   	push   %ebx
8010204c:	e8 9f 24 00 00       	call   801044f0 <releasesleep>
}
80102051:	83 c4 10             	add    $0x10,%esp
}
80102054:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102057:	89 f0                	mov    %esi,%eax
80102059:	5b                   	pop    %ebx
8010205a:	5e                   	pop    %esi
8010205b:	5f                   	pop    %edi
8010205c:	5d                   	pop    %ebp
8010205d:	c3                   	ret
    iput(ip);
8010205e:	83 ec 0c             	sub    $0xc,%esp
80102061:	56                   	push   %esi
      return 0;
80102062:	31 f6                	xor    %esi,%esi
    iput(ip);
80102064:	e8 27 f9 ff ff       	call   80101990 <iput>
    return 0;
80102069:	83 c4 10             	add    $0x10,%esp
8010206c:	eb a0                	jmp    8010200e <namex+0x1ae>
    panic("iunlock");
8010206e:	83 ec 0c             	sub    $0xc,%esp
80102071:	68 e4 7a 10 80       	push   $0x80107ae4
80102076:	e8 05 e3 ff ff       	call   80100380 <panic>
8010207b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102080 <dirlink>:
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 20             	sub    $0x20,%esp
80102089:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010208c:	6a 00                	push   $0x0
8010208e:	ff 75 0c             	push   0xc(%ebp)
80102091:	53                   	push   %ebx
80102092:	e8 19 fd ff ff       	call   80101db0 <dirlookup>
80102097:	83 c4 10             	add    $0x10,%esp
8010209a:	85 c0                	test   %eax,%eax
8010209c:	75 67                	jne    80102105 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010209e:	8b 7b 58             	mov    0x58(%ebx),%edi
801020a1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020a4:	85 ff                	test   %edi,%edi
801020a6:	74 29                	je     801020d1 <dirlink+0x51>
801020a8:	31 ff                	xor    %edi,%edi
801020aa:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020ad:	eb 09                	jmp    801020b8 <dirlink+0x38>
801020af:	90                   	nop
801020b0:	83 c7 10             	add    $0x10,%edi
801020b3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801020b6:	73 19                	jae    801020d1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020b8:	6a 10                	push   $0x10
801020ba:	57                   	push   %edi
801020bb:	56                   	push   %esi
801020bc:	53                   	push   %ebx
801020bd:	e8 ae fa ff ff       	call   80101b70 <readi>
801020c2:	83 c4 10             	add    $0x10,%esp
801020c5:	83 f8 10             	cmp    $0x10,%eax
801020c8:	75 4e                	jne    80102118 <dirlink+0x98>
    if(de.inum == 0)
801020ca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020cf:	75 df                	jne    801020b0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801020d1:	83 ec 04             	sub    $0x4,%esp
801020d4:	8d 45 da             	lea    -0x26(%ebp),%eax
801020d7:	6a 0e                	push   $0xe
801020d9:	ff 75 0c             	push   0xc(%ebp)
801020dc:	50                   	push   %eax
801020dd:	e8 de 28 00 00       	call   801049c0 <strncpy>
  de.inum = inum;
801020e2:	8b 45 10             	mov    0x10(%ebp),%eax
801020e5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020e9:	6a 10                	push   $0x10
801020eb:	57                   	push   %edi
801020ec:	56                   	push   %esi
801020ed:	53                   	push   %ebx
801020ee:	e8 7d fb ff ff       	call   80101c70 <writei>
801020f3:	83 c4 20             	add    $0x20,%esp
801020f6:	83 f8 10             	cmp    $0x10,%eax
801020f9:	75 2a                	jne    80102125 <dirlink+0xa5>
  return 0;
801020fb:	31 c0                	xor    %eax,%eax
}
801020fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102100:	5b                   	pop    %ebx
80102101:	5e                   	pop    %esi
80102102:	5f                   	pop    %edi
80102103:	5d                   	pop    %ebp
80102104:	c3                   	ret
    iput(ip);
80102105:	83 ec 0c             	sub    $0xc,%esp
80102108:	50                   	push   %eax
80102109:	e8 82 f8 ff ff       	call   80101990 <iput>
    return -1;
8010210e:	83 c4 10             	add    $0x10,%esp
80102111:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102116:	eb e5                	jmp    801020fd <dirlink+0x7d>
      panic("dirlink read");
80102118:	83 ec 0c             	sub    $0xc,%esp
8010211b:	68 0d 7b 10 80       	push   $0x80107b0d
80102120:	e8 5b e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102125:	83 ec 0c             	sub    $0xc,%esp
80102128:	68 a0 7d 10 80       	push   $0x80107da0
8010212d:	e8 4e e2 ff ff       	call   80100380 <panic>
80102132:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102139:	00 
8010213a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102140 <namei>:

struct inode*
namei(char *path)
{
80102140:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102141:	31 d2                	xor    %edx,%edx
{
80102143:	89 e5                	mov    %esp,%ebp
80102145:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102148:	8b 45 08             	mov    0x8(%ebp),%eax
8010214b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010214e:	e8 0d fd ff ff       	call   80101e60 <namex>
}
80102153:	c9                   	leave
80102154:	c3                   	ret
80102155:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010215c:	00 
8010215d:	8d 76 00             	lea    0x0(%esi),%esi

80102160 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102160:	55                   	push   %ebp
  return namex(path, 1, name);
80102161:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102166:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102168:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010216b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010216e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010216f:	e9 ec fc ff ff       	jmp    80101e60 <namex>
80102174:	66 90                	xchg   %ax,%ax
80102176:	66 90                	xchg   %ax,%ax
80102178:	66 90                	xchg   %ax,%ax
8010217a:	66 90                	xchg   %ax,%ax
8010217c:	66 90                	xchg   %ax,%ax
8010217e:	66 90                	xchg   %ax,%ax

80102180 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102180:	55                   	push   %ebp
80102181:	89 e5                	mov    %esp,%ebp
80102183:	57                   	push   %edi
80102184:	56                   	push   %esi
80102185:	53                   	push   %ebx
80102186:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102189:	85 c0                	test   %eax,%eax
8010218b:	0f 84 b4 00 00 00    	je     80102245 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102191:	8b 70 08             	mov    0x8(%eax),%esi
80102194:	89 c3                	mov    %eax,%ebx
80102196:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010219c:	0f 87 96 00 00 00    	ja     80102238 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021a2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801021a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021ae:	00 
801021af:	90                   	nop
801021b0:	89 ca                	mov    %ecx,%edx
801021b2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021b3:	83 e0 c0             	and    $0xffffffc0,%eax
801021b6:	3c 40                	cmp    $0x40,%al
801021b8:	75 f6                	jne    801021b0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021ba:	31 ff                	xor    %edi,%edi
801021bc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801021c1:	89 f8                	mov    %edi,%eax
801021c3:	ee                   	out    %al,(%dx)
801021c4:	b8 01 00 00 00       	mov    $0x1,%eax
801021c9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801021ce:	ee                   	out    %al,(%dx)
801021cf:	ba f3 01 00 00       	mov    $0x1f3,%edx
801021d4:	89 f0                	mov    %esi,%eax
801021d6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801021d7:	89 f0                	mov    %esi,%eax
801021d9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801021de:	c1 f8 08             	sar    $0x8,%eax
801021e1:	ee                   	out    %al,(%dx)
801021e2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801021e7:	89 f8                	mov    %edi,%eax
801021e9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801021ea:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801021ee:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021f3:	c1 e0 04             	shl    $0x4,%eax
801021f6:	83 e0 10             	and    $0x10,%eax
801021f9:	83 c8 e0             	or     $0xffffffe0,%eax
801021fc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801021fd:	f6 03 04             	testb  $0x4,(%ebx)
80102200:	75 16                	jne    80102218 <idestart+0x98>
80102202:	b8 20 00 00 00       	mov    $0x20,%eax
80102207:	89 ca                	mov    %ecx,%edx
80102209:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010220a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010220d:	5b                   	pop    %ebx
8010220e:	5e                   	pop    %esi
8010220f:	5f                   	pop    %edi
80102210:	5d                   	pop    %ebp
80102211:	c3                   	ret
80102212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102218:	b8 30 00 00 00       	mov    $0x30,%eax
8010221d:	89 ca                	mov    %ecx,%edx
8010221f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102220:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102225:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102228:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010222d:	fc                   	cld
8010222e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102230:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102233:	5b                   	pop    %ebx
80102234:	5e                   	pop    %esi
80102235:	5f                   	pop    %edi
80102236:	5d                   	pop    %ebp
80102237:	c3                   	ret
    panic("incorrect blockno");
80102238:	83 ec 0c             	sub    $0xc,%esp
8010223b:	68 23 7b 10 80       	push   $0x80107b23
80102240:	e8 3b e1 ff ff       	call   80100380 <panic>
    panic("idestart");
80102245:	83 ec 0c             	sub    $0xc,%esp
80102248:	68 1a 7b 10 80       	push   $0x80107b1a
8010224d:	e8 2e e1 ff ff       	call   80100380 <panic>
80102252:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102259:	00 
8010225a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102260 <ideinit>:
{
80102260:	55                   	push   %ebp
80102261:	89 e5                	mov    %esp,%ebp
80102263:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102266:	68 35 7b 10 80       	push   $0x80107b35
8010226b:	68 00 26 11 80       	push   $0x80112600
80102270:	e8 0b 23 00 00       	call   80104580 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102275:	58                   	pop    %eax
80102276:	a1 84 27 11 80       	mov    0x80112784,%eax
8010227b:	5a                   	pop    %edx
8010227c:	83 e8 01             	sub    $0x1,%eax
8010227f:	50                   	push   %eax
80102280:	6a 0e                	push   $0xe
80102282:	e8 99 02 00 00       	call   80102520 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102287:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010228a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010228f:	90                   	nop
80102290:	89 ca                	mov    %ecx,%edx
80102292:	ec                   	in     (%dx),%al
80102293:	83 e0 c0             	and    $0xffffffc0,%eax
80102296:	3c 40                	cmp    $0x40,%al
80102298:	75 f6                	jne    80102290 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010229a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010229f:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022a4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022a5:	89 ca                	mov    %ecx,%edx
801022a7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022a8:	84 c0                	test   %al,%al
801022aa:	75 1e                	jne    801022ca <ideinit+0x6a>
801022ac:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
801022b1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022bd:	00 
801022be:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801022c0:	83 e9 01             	sub    $0x1,%ecx
801022c3:	74 0f                	je     801022d4 <ideinit+0x74>
801022c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022c6:	84 c0                	test   %al,%al
801022c8:	74 f6                	je     801022c0 <ideinit+0x60>
      havedisk1 = 1;
801022ca:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
801022d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801022d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022de:	ee                   	out    %al,(%dx)
}
801022df:	c9                   	leave
801022e0:	c3                   	ret
801022e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022e8:	00 
801022e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801022f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	57                   	push   %edi
801022f4:	56                   	push   %esi
801022f5:	53                   	push   %ebx
801022f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801022f9:	68 00 26 11 80       	push   $0x80112600
801022fe:	e8 6d 24 00 00       	call   80104770 <acquire>

  if((b = idequeue) == 0){
80102303:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102309:	83 c4 10             	add    $0x10,%esp
8010230c:	85 db                	test   %ebx,%ebx
8010230e:	74 63                	je     80102373 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102310:	8b 43 58             	mov    0x58(%ebx),%eax
80102313:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102318:	8b 33                	mov    (%ebx),%esi
8010231a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102320:	75 2f                	jne    80102351 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102322:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010232e:	00 
8010232f:	90                   	nop
80102330:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102331:	89 c1                	mov    %eax,%ecx
80102333:	83 e1 c0             	and    $0xffffffc0,%ecx
80102336:	80 f9 40             	cmp    $0x40,%cl
80102339:	75 f5                	jne    80102330 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010233b:	a8 21                	test   $0x21,%al
8010233d:	75 12                	jne    80102351 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010233f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102342:	b9 80 00 00 00       	mov    $0x80,%ecx
80102347:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010234c:	fc                   	cld
8010234d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010234f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102351:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102354:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102357:	83 ce 02             	or     $0x2,%esi
8010235a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010235c:	53                   	push   %ebx
8010235d:	e8 8e 1e 00 00       	call   801041f0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102362:	a1 e4 25 11 80       	mov    0x801125e4,%eax
80102367:	83 c4 10             	add    $0x10,%esp
8010236a:	85 c0                	test   %eax,%eax
8010236c:	74 05                	je     80102373 <ideintr+0x83>
    idestart(idequeue);
8010236e:	e8 0d fe ff ff       	call   80102180 <idestart>
    release(&idelock);
80102373:	83 ec 0c             	sub    $0xc,%esp
80102376:	68 00 26 11 80       	push   $0x80112600
8010237b:	e8 90 23 00 00       	call   80104710 <release>

  release(&idelock);
}
80102380:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102383:	5b                   	pop    %ebx
80102384:	5e                   	pop    %esi
80102385:	5f                   	pop    %edi
80102386:	5d                   	pop    %ebp
80102387:	c3                   	ret
80102388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010238f:	00 

80102390 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	53                   	push   %ebx
80102394:	83 ec 10             	sub    $0x10,%esp
80102397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010239a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010239d:	50                   	push   %eax
8010239e:	e8 8d 21 00 00       	call   80104530 <holdingsleep>
801023a3:	83 c4 10             	add    $0x10,%esp
801023a6:	85 c0                	test   %eax,%eax
801023a8:	0f 84 c3 00 00 00    	je     80102471 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801023ae:	8b 03                	mov    (%ebx),%eax
801023b0:	83 e0 06             	and    $0x6,%eax
801023b3:	83 f8 02             	cmp    $0x2,%eax
801023b6:	0f 84 a8 00 00 00    	je     80102464 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801023bc:	8b 53 04             	mov    0x4(%ebx),%edx
801023bf:	85 d2                	test   %edx,%edx
801023c1:	74 0d                	je     801023d0 <iderw+0x40>
801023c3:	a1 e0 25 11 80       	mov    0x801125e0,%eax
801023c8:	85 c0                	test   %eax,%eax
801023ca:	0f 84 87 00 00 00    	je     80102457 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801023d0:	83 ec 0c             	sub    $0xc,%esp
801023d3:	68 00 26 11 80       	push   $0x80112600
801023d8:	e8 93 23 00 00       	call   80104770 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023dd:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
801023e2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023e9:	83 c4 10             	add    $0x10,%esp
801023ec:	85 c0                	test   %eax,%eax
801023ee:	74 60                	je     80102450 <iderw+0xc0>
801023f0:	89 c2                	mov    %eax,%edx
801023f2:	8b 40 58             	mov    0x58(%eax),%eax
801023f5:	85 c0                	test   %eax,%eax
801023f7:	75 f7                	jne    801023f0 <iderw+0x60>
801023f9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801023fc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801023fe:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102404:	74 3a                	je     80102440 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102406:	8b 03                	mov    (%ebx),%eax
80102408:	83 e0 06             	and    $0x6,%eax
8010240b:	83 f8 02             	cmp    $0x2,%eax
8010240e:	74 1b                	je     8010242b <iderw+0x9b>
    sleep(b, &idelock);
80102410:	83 ec 08             	sub    $0x8,%esp
80102413:	68 00 26 11 80       	push   $0x80112600
80102418:	53                   	push   %ebx
80102419:	e8 12 1d 00 00       	call   80104130 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010241e:	8b 03                	mov    (%ebx),%eax
80102420:	83 c4 10             	add    $0x10,%esp
80102423:	83 e0 06             	and    $0x6,%eax
80102426:	83 f8 02             	cmp    $0x2,%eax
80102429:	75 e5                	jne    80102410 <iderw+0x80>
  }


  release(&idelock);
8010242b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102432:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102435:	c9                   	leave
  release(&idelock);
80102436:	e9 d5 22 00 00       	jmp    80104710 <release>
8010243b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102440:	89 d8                	mov    %ebx,%eax
80102442:	e8 39 fd ff ff       	call   80102180 <idestart>
80102447:	eb bd                	jmp    80102406 <iderw+0x76>
80102449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102450:	ba e4 25 11 80       	mov    $0x801125e4,%edx
80102455:	eb a5                	jmp    801023fc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102457:	83 ec 0c             	sub    $0xc,%esp
8010245a:	68 64 7b 10 80       	push   $0x80107b64
8010245f:	e8 1c df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102464:	83 ec 0c             	sub    $0xc,%esp
80102467:	68 4f 7b 10 80       	push   $0x80107b4f
8010246c:	e8 0f df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102471:	83 ec 0c             	sub    $0xc,%esp
80102474:	68 39 7b 10 80       	push   $0x80107b39
80102479:	e8 02 df ff ff       	call   80100380 <panic>
8010247e:	66 90                	xchg   %ax,%ax

80102480 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102485:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010248c:	00 c0 fe 
  ioapic->reg = reg;
8010248f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102496:	00 00 00 
  return ioapic->data;
80102499:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010249f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801024a2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801024a8:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801024ae:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801024b5:	c1 ee 10             	shr    $0x10,%esi
801024b8:	89 f0                	mov    %esi,%eax
801024ba:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801024bd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801024c0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801024c3:	39 c2                	cmp    %eax,%edx
801024c5:	74 16                	je     801024dd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801024c7:	83 ec 0c             	sub    $0xc,%esp
801024ca:	68 54 7f 10 80       	push   $0x80107f54
801024cf:	e8 dc e1 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
801024d4:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
801024da:	83 c4 10             	add    $0x10,%esp
{
801024dd:	ba 10 00 00 00       	mov    $0x10,%edx
801024e2:	31 c0                	xor    %eax,%eax
801024e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
801024e8:	89 13                	mov    %edx,(%ebx)
801024ea:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
801024ed:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801024f3:	83 c0 01             	add    $0x1,%eax
801024f6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
801024fc:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801024ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102502:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102505:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102507:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010250d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102514:	39 c6                	cmp    %eax,%esi
80102516:	7d d0                	jge    801024e8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102518:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010251b:	5b                   	pop    %ebx
8010251c:	5e                   	pop    %esi
8010251d:	5d                   	pop    %ebp
8010251e:	c3                   	ret
8010251f:	90                   	nop

80102520 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102520:	55                   	push   %ebp
  ioapic->reg = reg;
80102521:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102527:	89 e5                	mov    %esp,%ebp
80102529:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010252c:	8d 50 20             	lea    0x20(%eax),%edx
8010252f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102533:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102535:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010253b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010253e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102541:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102544:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102546:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010254b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010254e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102551:	5d                   	pop    %ebp
80102552:	c3                   	ret
80102553:	66 90                	xchg   %ax,%ax
80102555:	66 90                	xchg   %ax,%ax
80102557:	66 90                	xchg   %ax,%ax
80102559:	66 90                	xchg   %ax,%ax
8010255b:	66 90                	xchg   %ax,%ax
8010255d:	66 90                	xchg   %ax,%ax
8010255f:	90                   	nop

80102560 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	53                   	push   %ebx
80102564:	83 ec 04             	sub    $0x4,%esp
80102567:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010256a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102570:	75 76                	jne    801025e8 <kfree+0x88>
80102572:	81 fb d0 c1 11 80    	cmp    $0x8011c1d0,%ebx
80102578:	72 6e                	jb     801025e8 <kfree+0x88>
8010257a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102580:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102585:	77 61                	ja     801025e8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102587:	83 ec 04             	sub    $0x4,%esp
8010258a:	68 00 10 00 00       	push   $0x1000
8010258f:	6a 01                	push   $0x1
80102591:	53                   	push   %ebx
80102592:	e8 d9 22 00 00       	call   80104870 <memset>

  if(kmem.use_lock)
80102597:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	85 d2                	test   %edx,%edx
801025a2:	75 1c                	jne    801025c0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801025a4:	a1 78 26 11 80       	mov    0x80112678,%eax
801025a9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801025ab:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
801025b0:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
801025b6:	85 c0                	test   %eax,%eax
801025b8:	75 1e                	jne    801025d8 <kfree+0x78>
    release(&kmem.lock);
}
801025ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025bd:	c9                   	leave
801025be:	c3                   	ret
801025bf:	90                   	nop
    acquire(&kmem.lock);
801025c0:	83 ec 0c             	sub    $0xc,%esp
801025c3:	68 40 26 11 80       	push   $0x80112640
801025c8:	e8 a3 21 00 00       	call   80104770 <acquire>
801025cd:	83 c4 10             	add    $0x10,%esp
801025d0:	eb d2                	jmp    801025a4 <kfree+0x44>
801025d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801025d8:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
801025df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025e2:	c9                   	leave
    release(&kmem.lock);
801025e3:	e9 28 21 00 00       	jmp    80104710 <release>
    panic("kfree");
801025e8:	83 ec 0c             	sub    $0xc,%esp
801025eb:	68 82 7b 10 80       	push   $0x80107b82
801025f0:	e8 8b dd ff ff       	call   80100380 <panic>
801025f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025fc:	00 
801025fd:	8d 76 00             	lea    0x0(%esi),%esi

80102600 <freerange>:
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	56                   	push   %esi
80102604:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102605:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102608:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010260b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102611:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102617:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010261d:	39 de                	cmp    %ebx,%esi
8010261f:	72 23                	jb     80102644 <freerange+0x44>
80102621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102628:	83 ec 0c             	sub    $0xc,%esp
8010262b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102631:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102637:	50                   	push   %eax
80102638:	e8 23 ff ff ff       	call   80102560 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010263d:	83 c4 10             	add    $0x10,%esp
80102640:	39 de                	cmp    %ebx,%esi
80102642:	73 e4                	jae    80102628 <freerange+0x28>
}
80102644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102647:	5b                   	pop    %ebx
80102648:	5e                   	pop    %esi
80102649:	5d                   	pop    %ebp
8010264a:	c3                   	ret
8010264b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102650 <kinit2>:
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	56                   	push   %esi
80102654:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102655:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102658:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010265b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102661:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102667:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010266d:	39 de                	cmp    %ebx,%esi
8010266f:	72 23                	jb     80102694 <kinit2+0x44>
80102671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102678:	83 ec 0c             	sub    $0xc,%esp
8010267b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102681:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102687:	50                   	push   %eax
80102688:	e8 d3 fe ff ff       	call   80102560 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010268d:	83 c4 10             	add    $0x10,%esp
80102690:	39 de                	cmp    %ebx,%esi
80102692:	73 e4                	jae    80102678 <kinit2+0x28>
  kmem.use_lock = 1;
80102694:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010269b:	00 00 00 
}
8010269e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026a1:	5b                   	pop    %ebx
801026a2:	5e                   	pop    %esi
801026a3:	5d                   	pop    %ebp
801026a4:	c3                   	ret
801026a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026ac:	00 
801026ad:	8d 76 00             	lea    0x0(%esi),%esi

801026b0 <kinit1>:
{
801026b0:	55                   	push   %ebp
801026b1:	89 e5                	mov    %esp,%ebp
801026b3:	56                   	push   %esi
801026b4:	53                   	push   %ebx
801026b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801026b8:	83 ec 08             	sub    $0x8,%esp
801026bb:	68 88 7b 10 80       	push   $0x80107b88
801026c0:	68 40 26 11 80       	push   $0x80112640
801026c5:	e8 b6 1e 00 00       	call   80104580 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801026ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026cd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801026d0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801026d7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801026da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026ec:	39 de                	cmp    %ebx,%esi
801026ee:	72 1c                	jb     8010270c <kinit1+0x5c>
    kfree(p);
801026f0:	83 ec 0c             	sub    $0xc,%esp
801026f3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026ff:	50                   	push   %eax
80102700:	e8 5b fe ff ff       	call   80102560 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102705:	83 c4 10             	add    $0x10,%esp
80102708:	39 de                	cmp    %ebx,%esi
8010270a:	73 e4                	jae    801026f0 <kinit1+0x40>
}
8010270c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010270f:	5b                   	pop    %ebx
80102710:	5e                   	pop    %esi
80102711:	5d                   	pop    %ebp
80102712:	c3                   	ret
80102713:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010271a:	00 
8010271b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102720 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
80102723:	53                   	push   %ebx
80102724:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102727:	a1 74 26 11 80       	mov    0x80112674,%eax
8010272c:	85 c0                	test   %eax,%eax
8010272e:	75 20                	jne    80102750 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102730:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102736:	85 db                	test   %ebx,%ebx
80102738:	74 07                	je     80102741 <kalloc+0x21>
    kmem.freelist = r->next;
8010273a:	8b 03                	mov    (%ebx),%eax
8010273c:	a3 78 26 11 80       	mov    %eax,0x80112678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102741:	89 d8                	mov    %ebx,%eax
80102743:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102746:	c9                   	leave
80102747:	c3                   	ret
80102748:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010274f:	00 
    acquire(&kmem.lock);
80102750:	83 ec 0c             	sub    $0xc,%esp
80102753:	68 40 26 11 80       	push   $0x80112640
80102758:	e8 13 20 00 00       	call   80104770 <acquire>
  r = kmem.freelist;
8010275d:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(kmem.use_lock)
80102763:	a1 74 26 11 80       	mov    0x80112674,%eax
  if(r)
80102768:	83 c4 10             	add    $0x10,%esp
8010276b:	85 db                	test   %ebx,%ebx
8010276d:	74 08                	je     80102777 <kalloc+0x57>
    kmem.freelist = r->next;
8010276f:	8b 13                	mov    (%ebx),%edx
80102771:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
80102777:	85 c0                	test   %eax,%eax
80102779:	74 c6                	je     80102741 <kalloc+0x21>
    release(&kmem.lock);
8010277b:	83 ec 0c             	sub    $0xc,%esp
8010277e:	68 40 26 11 80       	push   $0x80112640
80102783:	e8 88 1f 00 00       	call   80104710 <release>
}
80102788:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010278a:	83 c4 10             	add    $0x10,%esp
}
8010278d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102790:	c9                   	leave
80102791:	c3                   	ret
80102792:	66 90                	xchg   %ax,%ax
80102794:	66 90                	xchg   %ax,%ax
80102796:	66 90                	xchg   %ax,%ax
80102798:	66 90                	xchg   %ax,%ax
8010279a:	66 90                	xchg   %ax,%ax
8010279c:	66 90                	xchg   %ax,%ax
8010279e:	66 90                	xchg   %ax,%ax

801027a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027a0:	ba 64 00 00 00       	mov    $0x64,%edx
801027a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801027a6:	a8 01                	test   $0x1,%al
801027a8:	0f 84 c2 00 00 00    	je     80102870 <kbdgetc+0xd0>
{
801027ae:	55                   	push   %ebp
801027af:	ba 60 00 00 00       	mov    $0x60,%edx
801027b4:	89 e5                	mov    %esp,%ebp
801027b6:	53                   	push   %ebx
801027b7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801027b8:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
801027be:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801027c1:	3c e0                	cmp    $0xe0,%al
801027c3:	74 5b                	je     80102820 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801027c5:	89 da                	mov    %ebx,%edx
801027c7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801027ca:	84 c0                	test   %al,%al
801027cc:	78 62                	js     80102830 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801027ce:	85 d2                	test   %edx,%edx
801027d0:	74 09                	je     801027db <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801027d2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801027d5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801027d8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801027db:	0f b6 91 60 82 10 80 	movzbl -0x7fef7da0(%ecx),%edx
  shift ^= togglecode[data];
801027e2:	0f b6 81 60 81 10 80 	movzbl -0x7fef7ea0(%ecx),%eax
  shift |= shiftcode[data];
801027e9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801027eb:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801027ed:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801027ef:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
801027f5:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801027f8:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801027fb:	8b 04 85 40 81 10 80 	mov    -0x7fef7ec0(,%eax,4),%eax
80102802:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102806:	74 0b                	je     80102813 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102808:	8d 50 9f             	lea    -0x61(%eax),%edx
8010280b:	83 fa 19             	cmp    $0x19,%edx
8010280e:	77 48                	ja     80102858 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102810:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102813:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102816:	c9                   	leave
80102817:	c3                   	ret
80102818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010281f:	00 
    shift |= E0ESC;
80102820:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102823:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102825:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010282b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010282e:	c9                   	leave
8010282f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102830:	83 e0 7f             	and    $0x7f,%eax
80102833:	85 d2                	test   %edx,%edx
80102835:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102838:	0f b6 81 60 82 10 80 	movzbl -0x7fef7da0(%ecx),%eax
8010283f:	83 c8 40             	or     $0x40,%eax
80102842:	0f b6 c0             	movzbl %al,%eax
80102845:	f7 d0                	not    %eax
80102847:	21 d8                	and    %ebx,%eax
80102849:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
8010284e:	31 c0                	xor    %eax,%eax
80102850:	eb d9                	jmp    8010282b <kbdgetc+0x8b>
80102852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102858:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010285b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010285e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102861:	c9                   	leave
      c += 'a' - 'A';
80102862:	83 f9 1a             	cmp    $0x1a,%ecx
80102865:	0f 42 c2             	cmovb  %edx,%eax
}
80102868:	c3                   	ret
80102869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102875:	c3                   	ret
80102876:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010287d:	00 
8010287e:	66 90                	xchg   %ax,%ax

80102880 <kbdintr>:

void
kbdintr(void)
{
80102880:	55                   	push   %ebp
80102881:	89 e5                	mov    %esp,%ebp
80102883:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102886:	68 a0 27 10 80       	push   $0x801027a0
8010288b:	e8 10 e0 ff ff       	call   801008a0 <consoleintr>
}
80102890:	83 c4 10             	add    $0x10,%esp
80102893:	c9                   	leave
80102894:	c3                   	ret
80102895:	66 90                	xchg   %ax,%ax
80102897:	66 90                	xchg   %ax,%ax
80102899:	66 90                	xchg   %ax,%ax
8010289b:	66 90                	xchg   %ax,%ax
8010289d:	66 90                	xchg   %ax,%ax
8010289f:	90                   	nop

801028a0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801028a0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028a5:	85 c0                	test   %eax,%eax
801028a7:	0f 84 c3 00 00 00    	je     80102970 <lapicinit+0xd0>
  lapic[index] = value;
801028ad:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801028b4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ba:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801028c1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801028ce:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801028d1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801028db:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801028de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801028e8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ee:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801028f5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028f8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801028fb:	8b 50 30             	mov    0x30(%eax),%edx
801028fe:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102904:	75 72                	jne    80102978 <lapicinit+0xd8>
  lapic[index] = value;
80102906:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010290d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102910:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102913:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010291a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010291d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102920:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102927:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010292a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010292d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102934:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102937:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010293a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102941:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102944:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102947:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010294e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102951:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102958:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010295e:	80 e6 10             	and    $0x10,%dh
80102961:	75 f5                	jne    80102958 <lapicinit+0xb8>
  lapic[index] = value;
80102963:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010296a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010296d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102970:	c3                   	ret
80102971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102978:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010297f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102982:	8b 50 20             	mov    0x20(%eax),%edx
}
80102985:	e9 7c ff ff ff       	jmp    80102906 <lapicinit+0x66>
8010298a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102990 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102990:	a1 80 26 11 80       	mov    0x80112680,%eax
80102995:	85 c0                	test   %eax,%eax
80102997:	74 07                	je     801029a0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102999:	8b 40 20             	mov    0x20(%eax),%eax
8010299c:	c1 e8 18             	shr    $0x18,%eax
8010299f:	c3                   	ret
    return 0;
801029a0:	31 c0                	xor    %eax,%eax
}
801029a2:	c3                   	ret
801029a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029aa:	00 
801029ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801029b0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801029b0:	a1 80 26 11 80       	mov    0x80112680,%eax
801029b5:	85 c0                	test   %eax,%eax
801029b7:	74 0d                	je     801029c6 <lapiceoi+0x16>
  lapic[index] = value;
801029b9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801029c6:	c3                   	ret
801029c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ce:	00 
801029cf:	90                   	nop

801029d0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801029d0:	c3                   	ret
801029d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029d8:	00 
801029d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801029e0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801029e0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e1:	b8 0f 00 00 00       	mov    $0xf,%eax
801029e6:	ba 70 00 00 00       	mov    $0x70,%edx
801029eb:	89 e5                	mov    %esp,%ebp
801029ed:	53                   	push   %ebx
801029ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801029f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801029f4:	ee                   	out    %al,(%dx)
801029f5:	b8 0a 00 00 00       	mov    $0xa,%eax
801029fa:	ba 71 00 00 00       	mov    $0x71,%edx
801029ff:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a00:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102a02:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102a05:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a0b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a0d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102a10:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102a12:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a15:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102a18:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102a1e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102a23:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a29:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a2c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102a33:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a36:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a39:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102a40:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a43:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a46:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a4c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a4f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a55:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a58:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a5e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a61:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a67:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102a6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a6d:	c9                   	leave
80102a6e:	c3                   	ret
80102a6f:	90                   	nop

80102a70 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102a70:	55                   	push   %ebp
80102a71:	b8 0b 00 00 00       	mov    $0xb,%eax
80102a76:	ba 70 00 00 00       	mov    $0x70,%edx
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	57                   	push   %edi
80102a7e:	56                   	push   %esi
80102a7f:	53                   	push   %ebx
80102a80:	83 ec 4c             	sub    $0x4c,%esp
80102a83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a84:	ba 71 00 00 00       	mov    $0x71,%edx
80102a89:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102a8a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a8d:	bf 70 00 00 00       	mov    $0x70,%edi
80102a92:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102a95:	8d 76 00             	lea    0x0(%esi),%esi
80102a98:	31 c0                	xor    %eax,%eax
80102a9a:	89 fa                	mov    %edi,%edx
80102a9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102aa2:	89 ca                	mov    %ecx,%edx
80102aa4:	ec                   	in     (%dx),%al
80102aa5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa8:	89 fa                	mov    %edi,%edx
80102aaa:	b8 02 00 00 00       	mov    $0x2,%eax
80102aaf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab0:	89 ca                	mov    %ecx,%edx
80102ab2:	ec                   	in     (%dx),%al
80102ab3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab6:	89 fa                	mov    %edi,%edx
80102ab8:	b8 04 00 00 00       	mov    $0x4,%eax
80102abd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abe:	89 ca                	mov    %ecx,%edx
80102ac0:	ec                   	in     (%dx),%al
80102ac1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac4:	89 fa                	mov    %edi,%edx
80102ac6:	b8 07 00 00 00       	mov    $0x7,%eax
80102acb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102acc:	89 ca                	mov    %ecx,%edx
80102ace:	ec                   	in     (%dx),%al
80102acf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad2:	89 fa                	mov    %edi,%edx
80102ad4:	b8 08 00 00 00       	mov    $0x8,%eax
80102ad9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ada:	89 ca                	mov    %ecx,%edx
80102adc:	ec                   	in     (%dx),%al
80102add:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102adf:	89 fa                	mov    %edi,%edx
80102ae1:	b8 09 00 00 00       	mov    $0x9,%eax
80102ae6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae7:	89 ca                	mov    %ecx,%edx
80102ae9:	ec                   	in     (%dx),%al
80102aea:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aed:	89 fa                	mov    %edi,%edx
80102aef:	b8 0a 00 00 00       	mov    $0xa,%eax
80102af4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af5:	89 ca                	mov    %ecx,%edx
80102af7:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102af8:	84 c0                	test   %al,%al
80102afa:	78 9c                	js     80102a98 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102afc:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102b00:	89 f2                	mov    %esi,%edx
80102b02:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102b05:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b08:	89 fa                	mov    %edi,%edx
80102b0a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b0d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102b11:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102b14:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b17:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102b1b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b1e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102b22:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b25:	31 c0                	xor    %eax,%eax
80102b27:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b28:	89 ca                	mov    %ecx,%edx
80102b2a:	ec                   	in     (%dx),%al
80102b2b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b2e:	89 fa                	mov    %edi,%edx
80102b30:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102b33:	b8 02 00 00 00       	mov    $0x2,%eax
80102b38:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b39:	89 ca                	mov    %ecx,%edx
80102b3b:	ec                   	in     (%dx),%al
80102b3c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b3f:	89 fa                	mov    %edi,%edx
80102b41:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102b44:	b8 04 00 00 00       	mov    $0x4,%eax
80102b49:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b4a:	89 ca                	mov    %ecx,%edx
80102b4c:	ec                   	in     (%dx),%al
80102b4d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b50:	89 fa                	mov    %edi,%edx
80102b52:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b55:	b8 07 00 00 00       	mov    $0x7,%eax
80102b5a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5b:	89 ca                	mov    %ecx,%edx
80102b5d:	ec                   	in     (%dx),%al
80102b5e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b61:	89 fa                	mov    %edi,%edx
80102b63:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b66:	b8 08 00 00 00       	mov    $0x8,%eax
80102b6b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b6c:	89 ca                	mov    %ecx,%edx
80102b6e:	ec                   	in     (%dx),%al
80102b6f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b72:	89 fa                	mov    %edi,%edx
80102b74:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b77:	b8 09 00 00 00       	mov    $0x9,%eax
80102b7c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b7d:	89 ca                	mov    %ecx,%edx
80102b7f:	ec                   	in     (%dx),%al
80102b80:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b83:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102b86:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b89:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102b8c:	6a 18                	push   $0x18
80102b8e:	50                   	push   %eax
80102b8f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102b92:	50                   	push   %eax
80102b93:	e8 18 1d 00 00       	call   801048b0 <memcmp>
80102b98:	83 c4 10             	add    $0x10,%esp
80102b9b:	85 c0                	test   %eax,%eax
80102b9d:	0f 85 f5 fe ff ff    	jne    80102a98 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ba3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102baa:	89 f0                	mov    %esi,%eax
80102bac:	84 c0                	test   %al,%al
80102bae:	75 78                	jne    80102c28 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102bb0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bb3:	89 c2                	mov    %eax,%edx
80102bb5:	83 e0 0f             	and    $0xf,%eax
80102bb8:	c1 ea 04             	shr    $0x4,%edx
80102bbb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bbe:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bc1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102bc4:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102bc7:	89 c2                	mov    %eax,%edx
80102bc9:	83 e0 0f             	and    $0xf,%eax
80102bcc:	c1 ea 04             	shr    $0x4,%edx
80102bcf:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bd2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bd5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102bd8:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102bdb:	89 c2                	mov    %eax,%edx
80102bdd:	83 e0 0f             	and    $0xf,%eax
80102be0:	c1 ea 04             	shr    $0x4,%edx
80102be3:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102be6:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102be9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102bec:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102bef:	89 c2                	mov    %eax,%edx
80102bf1:	83 e0 0f             	and    $0xf,%eax
80102bf4:	c1 ea 04             	shr    $0x4,%edx
80102bf7:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bfa:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bfd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c00:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c03:	89 c2                	mov    %eax,%edx
80102c05:	83 e0 0f             	and    $0xf,%eax
80102c08:	c1 ea 04             	shr    $0x4,%edx
80102c0b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c0e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c11:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c14:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c17:	89 c2                	mov    %eax,%edx
80102c19:	83 e0 0f             	and    $0xf,%eax
80102c1c:	c1 ea 04             	shr    $0x4,%edx
80102c1f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c22:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c25:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102c28:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c2b:	89 03                	mov    %eax,(%ebx)
80102c2d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c30:	89 43 04             	mov    %eax,0x4(%ebx)
80102c33:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c36:	89 43 08             	mov    %eax,0x8(%ebx)
80102c39:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c3c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102c3f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c42:	89 43 10             	mov    %eax,0x10(%ebx)
80102c45:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c48:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102c4b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102c52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c55:	5b                   	pop    %ebx
80102c56:	5e                   	pop    %esi
80102c57:	5f                   	pop    %edi
80102c58:	5d                   	pop    %ebp
80102c59:	c3                   	ret
80102c5a:	66 90                	xchg   %ax,%ax
80102c5c:	66 90                	xchg   %ax,%ax
80102c5e:	66 90                	xchg   %ax,%ax

80102c60 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c60:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102c66:	85 c9                	test   %ecx,%ecx
80102c68:	0f 8e 8a 00 00 00    	jle    80102cf8 <install_trans+0x98>
{
80102c6e:	55                   	push   %ebp
80102c6f:	89 e5                	mov    %esp,%ebp
80102c71:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102c72:	31 ff                	xor    %edi,%edi
{
80102c74:	56                   	push   %esi
80102c75:	53                   	push   %ebx
80102c76:	83 ec 0c             	sub    $0xc,%esp
80102c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102c80:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c85:	83 ec 08             	sub    $0x8,%esp
80102c88:	01 f8                	add    %edi,%eax
80102c8a:	83 c0 01             	add    $0x1,%eax
80102c8d:	50                   	push   %eax
80102c8e:	ff 35 e4 26 11 80    	push   0x801126e4
80102c94:	e8 37 d4 ff ff       	call   801000d0 <bread>
80102c99:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c9b:	58                   	pop    %eax
80102c9c:	5a                   	pop    %edx
80102c9d:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102ca4:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102caa:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cad:	e8 1e d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cb2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cb5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cb7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cba:	68 00 02 00 00       	push   $0x200
80102cbf:	50                   	push   %eax
80102cc0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102cc3:	50                   	push   %eax
80102cc4:	e8 37 1c 00 00       	call   80104900 <memmove>
    bwrite(dbuf);  // write dst to disk
80102cc9:	89 1c 24             	mov    %ebx,(%esp)
80102ccc:	e8 df d4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102cd1:	89 34 24             	mov    %esi,(%esp)
80102cd4:	e8 17 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102cd9:	89 1c 24             	mov    %ebx,(%esp)
80102cdc:	e8 0f d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ce1:	83 c4 10             	add    $0x10,%esp
80102ce4:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102cea:	7f 94                	jg     80102c80 <install_trans+0x20>
  }
}
80102cec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cef:	5b                   	pop    %ebx
80102cf0:	5e                   	pop    %esi
80102cf1:	5f                   	pop    %edi
80102cf2:	5d                   	pop    %ebp
80102cf3:	c3                   	ret
80102cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cf8:	c3                   	ret
80102cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d00 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	53                   	push   %ebx
80102d04:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d07:	ff 35 d4 26 11 80    	push   0x801126d4
80102d0d:	ff 35 e4 26 11 80    	push   0x801126e4
80102d13:	e8 b8 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102d18:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d1b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102d1d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102d22:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102d25:	85 c0                	test   %eax,%eax
80102d27:	7e 19                	jle    80102d42 <write_head+0x42>
80102d29:	31 d2                	xor    %edx,%edx
80102d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102d30:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102d37:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d3b:	83 c2 01             	add    $0x1,%edx
80102d3e:	39 d0                	cmp    %edx,%eax
80102d40:	75 ee                	jne    80102d30 <write_head+0x30>
  }
  bwrite(buf);
80102d42:	83 ec 0c             	sub    $0xc,%esp
80102d45:	53                   	push   %ebx
80102d46:	e8 65 d4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102d4b:	89 1c 24             	mov    %ebx,(%esp)
80102d4e:	e8 9d d4 ff ff       	call   801001f0 <brelse>
}
80102d53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d56:	83 c4 10             	add    $0x10,%esp
80102d59:	c9                   	leave
80102d5a:	c3                   	ret
80102d5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102d60 <initlog>:
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	53                   	push   %ebx
80102d64:	83 ec 2c             	sub    $0x2c,%esp
80102d67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102d6a:	68 8d 7b 10 80       	push   $0x80107b8d
80102d6f:	68 a0 26 11 80       	push   $0x801126a0
80102d74:	e8 07 18 00 00       	call   80104580 <initlock>
  readsb(dev, &sb);
80102d79:	58                   	pop    %eax
80102d7a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102d7d:	5a                   	pop    %edx
80102d7e:	50                   	push   %eax
80102d7f:	53                   	push   %ebx
80102d80:	e8 7b e8 ff ff       	call   80101600 <readsb>
  log.start = sb.logstart;
80102d85:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102d88:	59                   	pop    %ecx
  log.dev = dev;
80102d89:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102d8f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102d92:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102d97:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102d9d:	5a                   	pop    %edx
80102d9e:	50                   	push   %eax
80102d9f:	53                   	push   %ebx
80102da0:	e8 2b d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102da5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102da8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102dab:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102db1:	85 db                	test   %ebx,%ebx
80102db3:	7e 1d                	jle    80102dd2 <initlog+0x72>
80102db5:	31 d2                	xor    %edx,%edx
80102db7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dbe:	00 
80102dbf:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102dc0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102dc4:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102dcb:	83 c2 01             	add    $0x1,%edx
80102dce:	39 d3                	cmp    %edx,%ebx
80102dd0:	75 ee                	jne    80102dc0 <initlog+0x60>
  brelse(buf);
80102dd2:	83 ec 0c             	sub    $0xc,%esp
80102dd5:	50                   	push   %eax
80102dd6:	e8 15 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102ddb:	e8 80 fe ff ff       	call   80102c60 <install_trans>
  log.lh.n = 0;
80102de0:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102de7:	00 00 00 
  write_head(); // clear the log
80102dea:	e8 11 ff ff ff       	call   80102d00 <write_head>
}
80102def:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102df2:	83 c4 10             	add    $0x10,%esp
80102df5:	c9                   	leave
80102df6:	c3                   	ret
80102df7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dfe:	00 
80102dff:	90                   	nop

80102e00 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102e06:	68 a0 26 11 80       	push   $0x801126a0
80102e0b:	e8 60 19 00 00       	call   80104770 <acquire>
80102e10:	83 c4 10             	add    $0x10,%esp
80102e13:	eb 18                	jmp    80102e2d <begin_op+0x2d>
80102e15:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e18:	83 ec 08             	sub    $0x8,%esp
80102e1b:	68 a0 26 11 80       	push   $0x801126a0
80102e20:	68 a0 26 11 80       	push   $0x801126a0
80102e25:	e8 06 13 00 00       	call   80104130 <sleep>
80102e2a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102e2d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102e32:	85 c0                	test   %eax,%eax
80102e34:	75 e2                	jne    80102e18 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102e36:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e3b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102e41:	83 c0 01             	add    $0x1,%eax
80102e44:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102e47:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102e4a:	83 fa 1e             	cmp    $0x1e,%edx
80102e4d:	7f c9                	jg     80102e18 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102e4f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102e52:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102e57:	68 a0 26 11 80       	push   $0x801126a0
80102e5c:	e8 af 18 00 00       	call   80104710 <release>
      break;
    }
  }
}
80102e61:	83 c4 10             	add    $0x10,%esp
80102e64:	c9                   	leave
80102e65:	c3                   	ret
80102e66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e6d:	00 
80102e6e:	66 90                	xchg   %ax,%ax

80102e70 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	57                   	push   %edi
80102e74:	56                   	push   %esi
80102e75:	53                   	push   %ebx
80102e76:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102e79:	68 a0 26 11 80       	push   $0x801126a0
80102e7e:	e8 ed 18 00 00       	call   80104770 <acquire>
  log.outstanding -= 1;
80102e83:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102e88:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102e8e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102e91:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102e94:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102e9a:	85 f6                	test   %esi,%esi
80102e9c:	0f 85 22 01 00 00    	jne    80102fc4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102ea2:	85 db                	test   %ebx,%ebx
80102ea4:	0f 85 f6 00 00 00    	jne    80102fa0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102eaa:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102eb1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102eb4:	83 ec 0c             	sub    $0xc,%esp
80102eb7:	68 a0 26 11 80       	push   $0x801126a0
80102ebc:	e8 4f 18 00 00       	call   80104710 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ec1:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102ec7:	83 c4 10             	add    $0x10,%esp
80102eca:	85 c9                	test   %ecx,%ecx
80102ecc:	7f 42                	jg     80102f10 <end_op+0xa0>
    acquire(&log.lock);
80102ece:	83 ec 0c             	sub    $0xc,%esp
80102ed1:	68 a0 26 11 80       	push   $0x801126a0
80102ed6:	e8 95 18 00 00       	call   80104770 <acquire>
    log.committing = 0;
80102edb:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102ee2:	00 00 00 
    wakeup(&log);
80102ee5:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102eec:	e8 ff 12 00 00       	call   801041f0 <wakeup>
    release(&log.lock);
80102ef1:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ef8:	e8 13 18 00 00       	call   80104710 <release>
80102efd:	83 c4 10             	add    $0x10,%esp
}
80102f00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f03:	5b                   	pop    %ebx
80102f04:	5e                   	pop    %esi
80102f05:	5f                   	pop    %edi
80102f06:	5d                   	pop    %ebp
80102f07:	c3                   	ret
80102f08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f0f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f10:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102f15:	83 ec 08             	sub    $0x8,%esp
80102f18:	01 d8                	add    %ebx,%eax
80102f1a:	83 c0 01             	add    $0x1,%eax
80102f1d:	50                   	push   %eax
80102f1e:	ff 35 e4 26 11 80    	push   0x801126e4
80102f24:	e8 a7 d1 ff ff       	call   801000d0 <bread>
80102f29:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f2b:	58                   	pop    %eax
80102f2c:	5a                   	pop    %edx
80102f2d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102f34:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102f3a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f3d:	e8 8e d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102f42:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f45:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f47:	8d 40 5c             	lea    0x5c(%eax),%eax
80102f4a:	68 00 02 00 00       	push   $0x200
80102f4f:	50                   	push   %eax
80102f50:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f53:	50                   	push   %eax
80102f54:	e8 a7 19 00 00       	call   80104900 <memmove>
    bwrite(to);  // write the log
80102f59:	89 34 24             	mov    %esi,(%esp)
80102f5c:	e8 4f d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102f61:	89 3c 24             	mov    %edi,(%esp)
80102f64:	e8 87 d2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102f69:	89 34 24             	mov    %esi,(%esp)
80102f6c:	e8 7f d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f71:	83 c4 10             	add    $0x10,%esp
80102f74:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102f7a:	7c 94                	jl     80102f10 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102f7c:	e8 7f fd ff ff       	call   80102d00 <write_head>
    install_trans(); // Now install writes to home locations
80102f81:	e8 da fc ff ff       	call   80102c60 <install_trans>
    log.lh.n = 0;
80102f86:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102f8d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102f90:	e8 6b fd ff ff       	call   80102d00 <write_head>
80102f95:	e9 34 ff ff ff       	jmp    80102ece <end_op+0x5e>
80102f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102fa0:	83 ec 0c             	sub    $0xc,%esp
80102fa3:	68 a0 26 11 80       	push   $0x801126a0
80102fa8:	e8 43 12 00 00       	call   801041f0 <wakeup>
  release(&log.lock);
80102fad:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102fb4:	e8 57 17 00 00       	call   80104710 <release>
80102fb9:	83 c4 10             	add    $0x10,%esp
}
80102fbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fbf:	5b                   	pop    %ebx
80102fc0:	5e                   	pop    %esi
80102fc1:	5f                   	pop    %edi
80102fc2:	5d                   	pop    %ebp
80102fc3:	c3                   	ret
    panic("log.committing");
80102fc4:	83 ec 0c             	sub    $0xc,%esp
80102fc7:	68 91 7b 10 80       	push   $0x80107b91
80102fcc:	e8 af d3 ff ff       	call   80100380 <panic>
80102fd1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fd8:	00 
80102fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102fe0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	53                   	push   %ebx
80102fe4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102fe7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102fed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ff0:	83 fa 1d             	cmp    $0x1d,%edx
80102ff3:	7f 7d                	jg     80103072 <log_write+0x92>
80102ff5:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102ffa:	83 e8 01             	sub    $0x1,%eax
80102ffd:	39 c2                	cmp    %eax,%edx
80102fff:	7d 71                	jge    80103072 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103001:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80103006:	85 c0                	test   %eax,%eax
80103008:	7e 75                	jle    8010307f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010300a:	83 ec 0c             	sub    $0xc,%esp
8010300d:	68 a0 26 11 80       	push   $0x801126a0
80103012:	e8 59 17 00 00       	call   80104770 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103017:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010301a:	83 c4 10             	add    $0x10,%esp
8010301d:	31 c0                	xor    %eax,%eax
8010301f:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103025:	85 d2                	test   %edx,%edx
80103027:	7f 0e                	jg     80103037 <log_write+0x57>
80103029:	eb 15                	jmp    80103040 <log_write+0x60>
8010302b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103030:	83 c0 01             	add    $0x1,%eax
80103033:	39 c2                	cmp    %eax,%edx
80103035:	74 29                	je     80103060 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103037:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
8010303e:	75 f0                	jne    80103030 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103040:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80103047:	39 c2                	cmp    %eax,%edx
80103049:	74 1c                	je     80103067 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010304b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010304e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103051:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103058:	c9                   	leave
  release(&log.lock);
80103059:	e9 b2 16 00 00       	jmp    80104710 <release>
8010305e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103060:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80103067:	83 c2 01             	add    $0x1,%edx
8010306a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80103070:	eb d9                	jmp    8010304b <log_write+0x6b>
    panic("too big a transaction");
80103072:	83 ec 0c             	sub    $0xc,%esp
80103075:	68 a0 7b 10 80       	push   $0x80107ba0
8010307a:	e8 01 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010307f:	83 ec 0c             	sub    $0xc,%esp
80103082:	68 b6 7b 10 80       	push   $0x80107bb6
80103087:	e8 f4 d2 ff ff       	call   80100380 <panic>
8010308c:	66 90                	xchg   %ax,%ax
8010308e:	66 90                	xchg   %ax,%ax

80103090 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103090:	55                   	push   %ebp
80103091:	89 e5                	mov    %esp,%ebp
80103093:	53                   	push   %ebx
80103094:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103097:	e8 c4 09 00 00       	call   80103a60 <cpuid>
8010309c:	89 c3                	mov    %eax,%ebx
8010309e:	e8 bd 09 00 00       	call   80103a60 <cpuid>
801030a3:	83 ec 04             	sub    $0x4,%esp
801030a6:	53                   	push   %ebx
801030a7:	50                   	push   %eax
801030a8:	68 d1 7b 10 80       	push   $0x80107bd1
801030ad:	e8 fe d5 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801030b2:	e8 59 2d 00 00       	call   80105e10 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801030b7:	e8 44 09 00 00       	call   80103a00 <mycpu>
801030bc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801030be:	b8 01 00 00 00       	mov    $0x1,%eax
801030c3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801030ca:	e8 41 0c 00 00       	call   80103d10 <scheduler>
801030cf:	90                   	nop

801030d0 <mpenter>:
{
801030d0:	55                   	push   %ebp
801030d1:	89 e5                	mov    %esp,%ebp
801030d3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801030d6:	e8 65 3f 00 00       	call   80107040 <switchkvm>
  seginit();
801030db:	e8 40 3e 00 00       	call   80106f20 <seginit>
  lapicinit();
801030e0:	e8 bb f7 ff ff       	call   801028a0 <lapicinit>
  mpmain();
801030e5:	e8 a6 ff ff ff       	call   80103090 <mpmain>
801030ea:	66 90                	xchg   %ax,%ax
801030ec:	66 90                	xchg   %ax,%ax
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <main>:
{
801030f0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801030f4:	83 e4 f0             	and    $0xfffffff0,%esp
801030f7:	ff 71 fc             	push   -0x4(%ecx)
801030fa:	55                   	push   %ebp
801030fb:	89 e5                	mov    %esp,%ebp
801030fd:	53                   	push   %ebx
801030fe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801030ff:	83 ec 08             	sub    $0x8,%esp
80103102:	68 00 00 40 80       	push   $0x80400000
80103107:	68 d0 c1 11 80       	push   $0x8011c1d0
8010310c:	e8 9f f5 ff ff       	call   801026b0 <kinit1>
  kvmalloc();      // kernel page table
80103111:	e8 ba 44 00 00       	call   801075d0 <kvmalloc>
  mpinit();        // detect other processors
80103116:	e8 85 01 00 00       	call   801032a0 <mpinit>
  lapicinit();     // interrupt controller
8010311b:	e8 80 f7 ff ff       	call   801028a0 <lapicinit>
  seginit();       // segment descriptors
80103120:	e8 fb 3d 00 00       	call   80106f20 <seginit>
  picinit();       // disable pic
80103125:	e8 96 03 00 00       	call   801034c0 <picinit>
  ioapicinit();    // another interrupt controller
8010312a:	e8 51 f3 ff ff       	call   80102480 <ioapicinit>
  consoleinit();   // console hardware
8010312f:	e8 ec d9 ff ff       	call   80100b20 <consoleinit>
  uartinit();      // serial port
80103134:	e8 57 30 00 00       	call   80106190 <uartinit>
  pinit();         // process table
80103139:	e8 a2 08 00 00       	call   801039e0 <pinit>
  tvinit();        // trap vectors
8010313e:	e8 4d 2c 00 00       	call   80105d90 <tvinit>
  binit();         // buffer cache
80103143:	e8 f8 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103148:	e8 a3 dd ff ff       	call   80100ef0 <fileinit>
  ideinit();       // disk 
8010314d:	e8 0e f1 ff ff       	call   80102260 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103152:	83 c4 0c             	add    $0xc,%esp
80103155:	68 8a 00 00 00       	push   $0x8a
8010315a:	68 8c b4 10 80       	push   $0x8010b48c
8010315f:	68 00 70 00 80       	push   $0x80007000
80103164:	e8 97 17 00 00       	call   80104900 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103169:	83 c4 10             	add    $0x10,%esp
8010316c:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103173:	00 00 00 
80103176:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010317b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103180:	76 7e                	jbe    80103200 <main+0x110>
80103182:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103187:	eb 20                	jmp    801031a9 <main+0xb9>
80103189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103190:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103197:	00 00 00 
8010319a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801031a0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801031a5:	39 c3                	cmp    %eax,%ebx
801031a7:	73 57                	jae    80103200 <main+0x110>
    if(c == mycpu())  // We've started already.
801031a9:	e8 52 08 00 00       	call   80103a00 <mycpu>
801031ae:	39 c3                	cmp    %eax,%ebx
801031b0:	74 de                	je     80103190 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801031b2:	e8 69 f5 ff ff       	call   80102720 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801031b7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801031ba:	c7 05 f8 6f 00 80 d0 	movl   $0x801030d0,0x80006ff8
801031c1:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031c4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801031cb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801031ce:	05 00 10 00 00       	add    $0x1000,%eax
801031d3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801031d8:	0f b6 03             	movzbl (%ebx),%eax
801031db:	68 00 70 00 00       	push   $0x7000
801031e0:	50                   	push   %eax
801031e1:	e8 fa f7 ff ff       	call   801029e0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801031e6:	83 c4 10             	add    $0x10,%esp
801031e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801031f6:	85 c0                	test   %eax,%eax
801031f8:	74 f6                	je     801031f0 <main+0x100>
801031fa:	eb 94                	jmp    80103190 <main+0xa0>
801031fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103200:	83 ec 08             	sub    $0x8,%esp
80103203:	68 00 00 00 8e       	push   $0x8e000000
80103208:	68 00 00 40 80       	push   $0x80400000
8010320d:	e8 3e f4 ff ff       	call   80102650 <kinit2>
  userinit();      // first user process
80103212:	e8 99 08 00 00       	call   80103ab0 <userinit>
  mpmain();        // finish this processor's setup
80103217:	e8 74 fe ff ff       	call   80103090 <mpmain>
8010321c:	66 90                	xchg   %ax,%ax
8010321e:	66 90                	xchg   %ax,%ax

80103220 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	57                   	push   %edi
80103224:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103225:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010322b:	53                   	push   %ebx
  e = addr+len;
8010322c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010322f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103232:	39 de                	cmp    %ebx,%esi
80103234:	72 10                	jb     80103246 <mpsearch1+0x26>
80103236:	eb 50                	jmp    80103288 <mpsearch1+0x68>
80103238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010323f:	00 
80103240:	89 fe                	mov    %edi,%esi
80103242:	39 df                	cmp    %ebx,%edi
80103244:	73 42                	jae    80103288 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103246:	83 ec 04             	sub    $0x4,%esp
80103249:	8d 7e 10             	lea    0x10(%esi),%edi
8010324c:	6a 04                	push   $0x4
8010324e:	68 e5 7b 10 80       	push   $0x80107be5
80103253:	56                   	push   %esi
80103254:	e8 57 16 00 00       	call   801048b0 <memcmp>
80103259:	83 c4 10             	add    $0x10,%esp
8010325c:	85 c0                	test   %eax,%eax
8010325e:	75 e0                	jne    80103240 <mpsearch1+0x20>
80103260:	89 f2                	mov    %esi,%edx
80103262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103268:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010326b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010326e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103270:	39 fa                	cmp    %edi,%edx
80103272:	75 f4                	jne    80103268 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103274:	84 c0                	test   %al,%al
80103276:	75 c8                	jne    80103240 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103278:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010327b:	89 f0                	mov    %esi,%eax
8010327d:	5b                   	pop    %ebx
8010327e:	5e                   	pop    %esi
8010327f:	5f                   	pop    %edi
80103280:	5d                   	pop    %ebp
80103281:	c3                   	ret
80103282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103288:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010328b:	31 f6                	xor    %esi,%esi
}
8010328d:	5b                   	pop    %ebx
8010328e:	89 f0                	mov    %esi,%eax
80103290:	5e                   	pop    %esi
80103291:	5f                   	pop    %edi
80103292:	5d                   	pop    %ebp
80103293:	c3                   	ret
80103294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010329b:	00 
8010329c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032a0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	57                   	push   %edi
801032a4:	56                   	push   %esi
801032a5:	53                   	push   %ebx
801032a6:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801032a9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801032b0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801032b7:	c1 e0 08             	shl    $0x8,%eax
801032ba:	09 d0                	or     %edx,%eax
801032bc:	c1 e0 04             	shl    $0x4,%eax
801032bf:	75 1b                	jne    801032dc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801032c1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801032c8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801032cf:	c1 e0 08             	shl    $0x8,%eax
801032d2:	09 d0                	or     %edx,%eax
801032d4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801032d7:	2d 00 04 00 00       	sub    $0x400,%eax
801032dc:	ba 00 04 00 00       	mov    $0x400,%edx
801032e1:	e8 3a ff ff ff       	call   80103220 <mpsearch1>
801032e6:	85 c0                	test   %eax,%eax
801032e8:	0f 84 6a 01 00 00    	je     80103458 <mpinit+0x1b8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801032f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032f4:	8b 40 04             	mov    0x4(%eax),%eax
801032f7:	85 c0                	test   %eax,%eax
801032f9:	0f 84 e9 00 00 00    	je     801033e8 <mpinit+0x148>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801032ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103302:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103305:	8b 40 04             	mov    0x4(%eax),%eax
80103308:	05 00 00 00 80       	add    $0x80000000,%eax
8010330d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103310:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103313:	6a 04                	push   $0x4
80103315:	68 02 7c 10 80       	push   $0x80107c02
8010331a:	50                   	push   %eax
8010331b:	e8 90 15 00 00       	call   801048b0 <memcmp>
80103320:	83 c4 10             	add    $0x10,%esp
80103323:	85 c0                	test   %eax,%eax
80103325:	0f 85 bd 00 00 00    	jne    801033e8 <mpinit+0x148>
  if(conf->version != 1 && conf->version != 4)
8010332b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010332e:	80 78 06 01          	cmpb   $0x1,0x6(%eax)
80103332:	74 0d                	je     80103341 <mpinit+0xa1>
80103334:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103337:	80 78 06 04          	cmpb   $0x4,0x6(%eax)
8010333b:	0f 85 a7 00 00 00    	jne    801033e8 <mpinit+0x148>
  if(sum((uchar*)conf, conf->length) != 0)
80103341:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103344:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80103348:	8b 45 e0             	mov    -0x20(%ebp),%eax
  for(i=0; i<len; i++)
8010334b:	66 85 d2             	test   %dx,%dx
8010334e:	74 1c                	je     8010336c <mpinit+0xcc>
80103350:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  sum = 0;
80103353:	31 d2                	xor    %edx,%edx
80103355:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103358:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
8010335b:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010335e:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103360:	39 c3                	cmp    %eax,%ebx
80103362:	75 f4                	jne    80103358 <mpinit+0xb8>
  if(sum((uchar*)conf, conf->length) != 0)
80103364:	84 d2                	test   %dl,%dl
80103366:	0f 85 7c 00 00 00    	jne    801033e8 <mpinit+0x148>
  *pmp = mp;
8010336c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  return conf;
8010336f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103372:	85 d2                	test   %edx,%edx
80103374:	74 72                	je     801033e8 <mpinit+0x148>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103376:	8b 42 24             	mov    0x24(%edx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103379:	0f b7 4a 04          	movzwl 0x4(%edx),%ecx
8010337d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
  ismp = 1;
80103380:	be 01 00 00 00       	mov    $0x1,%esi
  lapic = (uint*)conf->lapicaddr;
80103385:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010338a:	8d 42 2c             	lea    0x2c(%edx),%eax
8010338d:	01 ca                	add    %ecx,%edx
8010338f:	90                   	nop
80103390:	39 d0                	cmp    %edx,%eax
80103392:	73 19                	jae    801033ad <mpinit+0x10d>
    switch(*p){
80103394:	0f b6 08             	movzbl (%eax),%ecx
80103397:	80 f9 02             	cmp    $0x2,%cl
8010339a:	74 5c                	je     801033f8 <mpinit+0x158>
8010339c:	0f 87 9e 00 00 00    	ja     80103440 <mpinit+0x1a0>
801033a2:	84 c9                	test   %cl,%cl
801033a4:	74 6a                	je     80103410 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801033a6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033a9:	39 d0                	cmp    %edx,%eax
801033ab:	72 e7                	jb     80103394 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801033ad:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
801033b0:	85 f6                	test   %esi,%esi
801033b2:	0f 84 f0 00 00 00    	je     801034a8 <mpinit+0x208>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801033b8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801033bc:	74 15                	je     801033d3 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033be:	b8 70 00 00 00       	mov    $0x70,%eax
801033c3:	ba 22 00 00 00       	mov    $0x22,%edx
801033c8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801033c9:	ba 23 00 00 00       	mov    $0x23,%edx
801033ce:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801033cf:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033d2:	ee                   	out    %al,(%dx)
  }
}
801033d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033d6:	5b                   	pop    %ebx
801033d7:	5e                   	pop    %esi
801033d8:	5f                   	pop    %edi
801033d9:	5d                   	pop    %ebp
801033da:	c3                   	ret
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801033db:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801033e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801033e8:	83 ec 0c             	sub    $0xc,%esp
801033eb:	68 ea 7b 10 80       	push   $0x80107bea
801033f0:	e8 8b cf ff ff       	call   80100380 <panic>
801033f5:	8d 76 00             	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
801033f8:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801033fc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801033ff:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
80103405:	eb 89                	jmp    80103390 <mpinit+0xf0>
80103407:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010340e:	00 
8010340f:	90                   	nop
      if(ncpu < NCPU) {
80103410:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103416:	83 f9 07             	cmp    $0x7,%ecx
80103419:	7f 19                	jg     80103434 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010341b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103421:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103425:	83 c1 01             	add    $0x1,%ecx
80103428:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010342e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103434:	83 c0 14             	add    $0x14,%eax
      continue;
80103437:	e9 54 ff ff ff       	jmp    80103390 <mpinit+0xf0>
8010343c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103440:	83 e9 03             	sub    $0x3,%ecx
80103443:	80 f9 01             	cmp    $0x1,%cl
80103446:	0f 86 5a ff ff ff    	jbe    801033a6 <mpinit+0x106>
8010344c:	31 f6                	xor    %esi,%esi
8010344e:	e9 3d ff ff ff       	jmp    80103390 <mpinit+0xf0>
80103453:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
{
80103458:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010345d:	eb 0f                	jmp    8010346e <mpinit+0x1ce>
8010345f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103460:	89 f3                	mov    %esi,%ebx
80103462:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103468:	0f 84 6d ff ff ff    	je     801033db <mpinit+0x13b>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010346e:	83 ec 04             	sub    $0x4,%esp
80103471:	8d 73 10             	lea    0x10(%ebx),%esi
80103474:	6a 04                	push   $0x4
80103476:	68 e5 7b 10 80       	push   $0x80107be5
8010347b:	53                   	push   %ebx
8010347c:	e8 2f 14 00 00       	call   801048b0 <memcmp>
80103481:	83 c4 10             	add    $0x10,%esp
80103484:	85 c0                	test   %eax,%eax
80103486:	75 d8                	jne    80103460 <mpinit+0x1c0>
80103488:	89 da                	mov    %ebx,%edx
8010348a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103490:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103493:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103496:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103498:	39 f2                	cmp    %esi,%edx
8010349a:	75 f4                	jne    80103490 <mpinit+0x1f0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010349c:	84 c0                	test   %al,%al
8010349e:	75 c0                	jne    80103460 <mpinit+0x1c0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034a0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801034a3:	e9 49 fe ff ff       	jmp    801032f1 <mpinit+0x51>
    panic("Didn't find a suitable machine");
801034a8:	83 ec 0c             	sub    $0xc,%esp
801034ab:	68 88 7f 10 80       	push   $0x80107f88
801034b0:	e8 cb ce ff ff       	call   80100380 <panic>
801034b5:	66 90                	xchg   %ax,%ax
801034b7:	66 90                	xchg   %ax,%ax
801034b9:	66 90                	xchg   %ax,%ax
801034bb:	66 90                	xchg   %ax,%ax
801034bd:	66 90                	xchg   %ax,%ax
801034bf:	90                   	nop

801034c0 <picinit>:
801034c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034c5:	ba 21 00 00 00       	mov    $0x21,%edx
801034ca:	ee                   	out    %al,(%dx)
801034cb:	ba a1 00 00 00       	mov    $0xa1,%edx
801034d0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801034d1:	c3                   	ret
801034d2:	66 90                	xchg   %ax,%ax
801034d4:	66 90                	xchg   %ax,%ax
801034d6:	66 90                	xchg   %ax,%ax
801034d8:	66 90                	xchg   %ax,%ax
801034da:	66 90                	xchg   %ax,%ax
801034dc:	66 90                	xchg   %ax,%ax
801034de:	66 90                	xchg   %ax,%ax

801034e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	57                   	push   %edi
801034e4:	56                   	push   %esi
801034e5:	53                   	push   %ebx
801034e6:	83 ec 0c             	sub    $0xc,%esp
801034e9:	8b 75 08             	mov    0x8(%ebp),%esi
801034ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801034ef:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801034f5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801034fb:	e8 10 da ff ff       	call   80100f10 <filealloc>
80103500:	89 06                	mov    %eax,(%esi)
80103502:	85 c0                	test   %eax,%eax
80103504:	0f 84 a5 00 00 00    	je     801035af <pipealloc+0xcf>
8010350a:	e8 01 da ff ff       	call   80100f10 <filealloc>
8010350f:	89 07                	mov    %eax,(%edi)
80103511:	85 c0                	test   %eax,%eax
80103513:	0f 84 84 00 00 00    	je     8010359d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103519:	e8 02 f2 ff ff       	call   80102720 <kalloc>
8010351e:	89 c3                	mov    %eax,%ebx
80103520:	85 c0                	test   %eax,%eax
80103522:	0f 84 a0 00 00 00    	je     801035c8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103528:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010352f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103532:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103535:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010353c:	00 00 00 
  p->nwrite = 0;
8010353f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103546:	00 00 00 
  p->nread = 0;
80103549:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103550:	00 00 00 
  initlock(&p->lock, "pipe");
80103553:	68 07 7c 10 80       	push   $0x80107c07
80103558:	50                   	push   %eax
80103559:	e8 22 10 00 00       	call   80104580 <initlock>
  (*f0)->type = FD_PIPE;
8010355e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103560:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103563:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103569:	8b 06                	mov    (%esi),%eax
8010356b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010356f:	8b 06                	mov    (%esi),%eax
80103571:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103575:	8b 06                	mov    (%esi),%eax
80103577:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010357a:	8b 07                	mov    (%edi),%eax
8010357c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103582:	8b 07                	mov    (%edi),%eax
80103584:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103588:	8b 07                	mov    (%edi),%eax
8010358a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010358e:	8b 07                	mov    (%edi),%eax
80103590:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103593:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103595:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103598:	5b                   	pop    %ebx
80103599:	5e                   	pop    %esi
8010359a:	5f                   	pop    %edi
8010359b:	5d                   	pop    %ebp
8010359c:	c3                   	ret
  if(*f0)
8010359d:	8b 06                	mov    (%esi),%eax
8010359f:	85 c0                	test   %eax,%eax
801035a1:	74 1e                	je     801035c1 <pipealloc+0xe1>
    fileclose(*f0);
801035a3:	83 ec 0c             	sub    $0xc,%esp
801035a6:	50                   	push   %eax
801035a7:	e8 24 da ff ff       	call   80100fd0 <fileclose>
801035ac:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801035af:	8b 07                	mov    (%edi),%eax
801035b1:	85 c0                	test   %eax,%eax
801035b3:	74 0c                	je     801035c1 <pipealloc+0xe1>
    fileclose(*f1);
801035b5:	83 ec 0c             	sub    $0xc,%esp
801035b8:	50                   	push   %eax
801035b9:	e8 12 da ff ff       	call   80100fd0 <fileclose>
801035be:	83 c4 10             	add    $0x10,%esp
  return -1;
801035c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035c6:	eb cd                	jmp    80103595 <pipealloc+0xb5>
  if(*f0)
801035c8:	8b 06                	mov    (%esi),%eax
801035ca:	85 c0                	test   %eax,%eax
801035cc:	75 d5                	jne    801035a3 <pipealloc+0xc3>
801035ce:	eb df                	jmp    801035af <pipealloc+0xcf>

801035d0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	56                   	push   %esi
801035d4:	53                   	push   %ebx
801035d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801035db:	83 ec 0c             	sub    $0xc,%esp
801035de:	53                   	push   %ebx
801035df:	e8 8c 11 00 00       	call   80104770 <acquire>
  if(writable){
801035e4:	83 c4 10             	add    $0x10,%esp
801035e7:	85 f6                	test   %esi,%esi
801035e9:	74 65                	je     80103650 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801035eb:	83 ec 0c             	sub    $0xc,%esp
801035ee:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801035f4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801035fb:	00 00 00 
    wakeup(&p->nread);
801035fe:	50                   	push   %eax
801035ff:	e8 ec 0b 00 00       	call   801041f0 <wakeup>
80103604:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103607:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010360d:	85 d2                	test   %edx,%edx
8010360f:	75 0a                	jne    8010361b <pipeclose+0x4b>
80103611:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103617:	85 c0                	test   %eax,%eax
80103619:	74 15                	je     80103630 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010361b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010361e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103621:	5b                   	pop    %ebx
80103622:	5e                   	pop    %esi
80103623:	5d                   	pop    %ebp
    release(&p->lock);
80103624:	e9 e7 10 00 00       	jmp    80104710 <release>
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103630:	83 ec 0c             	sub    $0xc,%esp
80103633:	53                   	push   %ebx
80103634:	e8 d7 10 00 00       	call   80104710 <release>
    kfree((char*)p);
80103639:	83 c4 10             	add    $0x10,%esp
8010363c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010363f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103642:	5b                   	pop    %ebx
80103643:	5e                   	pop    %esi
80103644:	5d                   	pop    %ebp
    kfree((char*)p);
80103645:	e9 16 ef ff ff       	jmp    80102560 <kfree>
8010364a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103650:	83 ec 0c             	sub    $0xc,%esp
80103653:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103659:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103660:	00 00 00 
    wakeup(&p->nwrite);
80103663:	50                   	push   %eax
80103664:	e8 87 0b 00 00       	call   801041f0 <wakeup>
80103669:	83 c4 10             	add    $0x10,%esp
8010366c:	eb 99                	jmp    80103607 <pipeclose+0x37>
8010366e:	66 90                	xchg   %ax,%ax

80103670 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	57                   	push   %edi
80103674:	56                   	push   %esi
80103675:	53                   	push   %ebx
80103676:	83 ec 28             	sub    $0x28,%esp
80103679:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010367c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010367f:	53                   	push   %ebx
80103680:	e8 eb 10 00 00       	call   80104770 <acquire>
  for(i = 0; i < n; i++){
80103685:	83 c4 10             	add    $0x10,%esp
80103688:	85 ff                	test   %edi,%edi
8010368a:	0f 8e ce 00 00 00    	jle    8010375e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103690:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103696:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103699:	89 7d 10             	mov    %edi,0x10(%ebp)
8010369c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010369f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801036a2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801036a5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036ab:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036b1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036b7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801036bd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801036c0:	0f 85 b6 00 00 00    	jne    8010377c <pipewrite+0x10c>
801036c6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801036c9:	eb 3b                	jmp    80103706 <pipewrite+0x96>
801036cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801036d0:	e8 ab 03 00 00       	call   80103a80 <myproc>
801036d5:	8b 48 24             	mov    0x24(%eax),%ecx
801036d8:	85 c9                	test   %ecx,%ecx
801036da:	75 34                	jne    80103710 <pipewrite+0xa0>
      wakeup(&p->nread);
801036dc:	83 ec 0c             	sub    $0xc,%esp
801036df:	56                   	push   %esi
801036e0:	e8 0b 0b 00 00       	call   801041f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036e5:	58                   	pop    %eax
801036e6:	5a                   	pop    %edx
801036e7:	53                   	push   %ebx
801036e8:	57                   	push   %edi
801036e9:	e8 42 0a 00 00       	call   80104130 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036ee:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036f4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801036fa:	83 c4 10             	add    $0x10,%esp
801036fd:	05 00 02 00 00       	add    $0x200,%eax
80103702:	39 c2                	cmp    %eax,%edx
80103704:	75 2a                	jne    80103730 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103706:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010370c:	85 c0                	test   %eax,%eax
8010370e:	75 c0                	jne    801036d0 <pipewrite+0x60>
        release(&p->lock);
80103710:	83 ec 0c             	sub    $0xc,%esp
80103713:	53                   	push   %ebx
80103714:	e8 f7 0f 00 00       	call   80104710 <release>
        return -1;
80103719:	83 c4 10             	add    $0x10,%esp
8010371c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103721:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103724:	5b                   	pop    %ebx
80103725:	5e                   	pop    %esi
80103726:	5f                   	pop    %edi
80103727:	5d                   	pop    %ebp
80103728:	c3                   	ret
80103729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103730:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103733:	8d 42 01             	lea    0x1(%edx),%eax
80103736:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010373c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010373f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103745:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103748:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010374c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103750:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103753:	39 c1                	cmp    %eax,%ecx
80103755:	0f 85 50 ff ff ff    	jne    801036ab <pipewrite+0x3b>
8010375b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010375e:	83 ec 0c             	sub    $0xc,%esp
80103761:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103767:	50                   	push   %eax
80103768:	e8 83 0a 00 00       	call   801041f0 <wakeup>
  release(&p->lock);
8010376d:	89 1c 24             	mov    %ebx,(%esp)
80103770:	e8 9b 0f 00 00       	call   80104710 <release>
  return n;
80103775:	83 c4 10             	add    $0x10,%esp
80103778:	89 f8                	mov    %edi,%eax
8010377a:	eb a5                	jmp    80103721 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010377c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010377f:	eb b2                	jmp    80103733 <pipewrite+0xc3>
80103781:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103788:	00 
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103790 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	57                   	push   %edi
80103794:	56                   	push   %esi
80103795:	53                   	push   %ebx
80103796:	83 ec 18             	sub    $0x18,%esp
80103799:	8b 75 08             	mov    0x8(%ebp),%esi
8010379c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010379f:	56                   	push   %esi
801037a0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801037a6:	e8 c5 0f 00 00       	call   80104770 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037ab:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037b1:	83 c4 10             	add    $0x10,%esp
801037b4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037ba:	74 2f                	je     801037eb <piperead+0x5b>
801037bc:	eb 37                	jmp    801037f5 <piperead+0x65>
801037be:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801037c0:	e8 bb 02 00 00       	call   80103a80 <myproc>
801037c5:	8b 40 24             	mov    0x24(%eax),%eax
801037c8:	85 c0                	test   %eax,%eax
801037ca:	0f 85 80 00 00 00    	jne    80103850 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801037d0:	83 ec 08             	sub    $0x8,%esp
801037d3:	56                   	push   %esi
801037d4:	53                   	push   %ebx
801037d5:	e8 56 09 00 00       	call   80104130 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037da:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037e0:	83 c4 10             	add    $0x10,%esp
801037e3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037e9:	75 0a                	jne    801037f5 <piperead+0x65>
801037eb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801037f1:	85 d2                	test   %edx,%edx
801037f3:	75 cb                	jne    801037c0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801037f8:	31 db                	xor    %ebx,%ebx
801037fa:	85 c9                	test   %ecx,%ecx
801037fc:	7f 26                	jg     80103824 <piperead+0x94>
801037fe:	eb 2c                	jmp    8010382c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103800:	8d 48 01             	lea    0x1(%eax),%ecx
80103803:	25 ff 01 00 00       	and    $0x1ff,%eax
80103808:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010380e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103813:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103816:	83 c3 01             	add    $0x1,%ebx
80103819:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010381c:	74 0e                	je     8010382c <piperead+0x9c>
8010381e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103824:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010382a:	75 d4                	jne    80103800 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010382c:	83 ec 0c             	sub    $0xc,%esp
8010382f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103835:	50                   	push   %eax
80103836:	e8 b5 09 00 00       	call   801041f0 <wakeup>
  release(&p->lock);
8010383b:	89 34 24             	mov    %esi,(%esp)
8010383e:	e8 cd 0e 00 00       	call   80104710 <release>
  return i;
80103843:	83 c4 10             	add    $0x10,%esp
}
80103846:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103849:	89 d8                	mov    %ebx,%eax
8010384b:	5b                   	pop    %ebx
8010384c:	5e                   	pop    %esi
8010384d:	5f                   	pop    %edi
8010384e:	5d                   	pop    %ebp
8010384f:	c3                   	ret
      release(&p->lock);
80103850:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103853:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103858:	56                   	push   %esi
80103859:	e8 b2 0e 00 00       	call   80104710 <release>
      return -1;
8010385e:	83 c4 10             	add    $0x10,%esp
}
80103861:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103864:	89 d8                	mov    %ebx,%eax
80103866:	5b                   	pop    %ebx
80103867:	5e                   	pop    %esi
80103868:	5f                   	pop    %edi
80103869:	5d                   	pop    %ebp
8010386a:	c3                   	ret
8010386b:	66 90                	xchg   %ax,%ax
8010386d:	66 90                	xchg   %ax,%ax
8010386f:	90                   	nop

80103870 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103874:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
80103879:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010387c:	68 20 2d 11 80       	push   $0x80112d20
80103881:	e8 ea 0e 00 00       	call   80104770 <acquire>
80103886:	83 c4 10             	add    $0x10,%esp
80103889:	eb 17                	jmp    801038a2 <allocproc+0x32>
8010388b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103890:	81 c3 f0 01 00 00    	add    $0x1f0,%ebx
80103896:	81 fb 54 a9 11 80    	cmp    $0x8011a954,%ebx
8010389c:	0f 84 be 00 00 00    	je     80103960 <allocproc+0xf0>
    if(p->state == UNUSED)
801038a2:	8b 43 0c             	mov    0xc(%ebx),%eax
801038a5:	85 c0                	test   %eax,%eax
801038a7:	75 e7                	jne    80103890 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801038a9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->priority=DEFAULT_PRIORITY;
  release(&ptable.lock);
801038ae:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801038b1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority=DEFAULT_PRIORITY;
801038b8:	c7 83 88 00 00 00 14 	movl   $0x14,0x88(%ebx)
801038bf:	00 00 00 
  p->pid = nextpid++;
801038c2:	89 43 10             	mov    %eax,0x10(%ebx)
801038c5:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801038c8:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
801038cd:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801038d3:	e8 38 0e 00 00       	call   80104710 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801038d8:	e8 43 ee ff ff       	call   80102720 <kalloc>
801038dd:	83 c4 10             	add    $0x10,%esp
801038e0:	89 43 08             	mov    %eax,0x8(%ebx)
801038e3:	85 c0                	test   %eax,%eax
801038e5:	0f 84 8e 00 00 00    	je     80103979 <allocproc+0x109>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801038eb:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801038f1:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801038f4:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801038f9:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801038fc:	c7 40 14 7f 5d 10 80 	movl   $0x80105d7f,0x14(%eax)
  p->context = (struct context*)sp;
80103903:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103906:	6a 14                	push   $0x14
80103908:	6a 00                	push   $0x0
8010390a:	50                   	push   %eax
8010390b:	e8 60 0f 00 00       	call   80104870 <memset>
  p->context->eip = (uint)forkret;
80103910:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->sched_count=0;
  p->run_ticks=0;
  p->page_faults=0;
  p->twostrike_mode = 0;
  p->strike_count = 0;
  return p;
80103913:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103916:	c7 40 10 90 39 10 80 	movl   $0x80103990,0x10(%eax)
}
8010391d:	89 d8                	mov    %ebx,%eax
  p->sched_count=0;
8010391f:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103926:	00 00 00 
  p->run_ticks=0;
80103929:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103930:	00 00 00 
  p->page_faults=0;
80103933:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010393a:	00 00 00 
  p->twostrike_mode = 0;
8010393d:	c7 83 e8 01 00 00 00 	movl   $0x0,0x1e8(%ebx)
80103944:	00 00 00 
  p->strike_count = 0;
80103947:	c7 83 ec 01 00 00 00 	movl   $0x0,0x1ec(%ebx)
8010394e:	00 00 00 
}
80103951:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103954:	c9                   	leave
80103955:	c3                   	ret
80103956:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010395d:	00 
8010395e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103960:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103963:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103965:	68 20 2d 11 80       	push   $0x80112d20
8010396a:	e8 a1 0d 00 00       	call   80104710 <release>
  return 0;
8010396f:	83 c4 10             	add    $0x10,%esp
}
80103972:	89 d8                	mov    %ebx,%eax
80103974:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103977:	c9                   	leave
80103978:	c3                   	ret
    p->state = UNUSED;
80103979:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103980:	31 db                	xor    %ebx,%ebx
80103982:	eb ee                	jmp    80103972 <allocproc+0x102>
80103984:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010398b:	00 
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103990 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103996:	68 20 2d 11 80       	push   $0x80112d20
8010399b:	e8 70 0d 00 00       	call   80104710 <release>

  if (first) {
801039a0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801039a5:	83 c4 10             	add    $0x10,%esp
801039a8:	85 c0                	test   %eax,%eax
801039aa:	75 04                	jne    801039b0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039ac:	c9                   	leave
801039ad:	c3                   	ret
801039ae:	66 90                	xchg   %ax,%ax
    first = 0;
801039b0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801039b7:	00 00 00 
    iinit(ROOTDEV);
801039ba:	83 ec 0c             	sub    $0xc,%esp
801039bd:	6a 01                	push   $0x1
801039bf:	e8 7c dc ff ff       	call   80101640 <iinit>
    initlog(ROOTDEV);
801039c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801039cb:	e8 90 f3 ff ff       	call   80102d60 <initlog>
}
801039d0:	83 c4 10             	add    $0x10,%esp
801039d3:	c9                   	leave
801039d4:	c3                   	ret
801039d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039dc:	00 
801039dd:	8d 76 00             	lea    0x0(%esi),%esi

801039e0 <pinit>:
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801039e6:	68 0c 7c 10 80       	push   $0x80107c0c
801039eb:	68 20 2d 11 80       	push   $0x80112d20
801039f0:	e8 8b 0b 00 00       	call   80104580 <initlock>
}
801039f5:	83 c4 10             	add    $0x10,%esp
801039f8:	c9                   	leave
801039f9:	c3                   	ret
801039fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a00 <mycpu>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	56                   	push   %esi
80103a04:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a05:	9c                   	pushf
80103a06:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a07:	f6 c4 02             	test   $0x2,%ah
80103a0a:	75 46                	jne    80103a52 <mycpu+0x52>
  apicid = lapicid();
80103a0c:	e8 7f ef ff ff       	call   80102990 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103a11:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103a17:	85 f6                	test   %esi,%esi
80103a19:	7e 2a                	jle    80103a45 <mycpu+0x45>
80103a1b:	31 d2                	xor    %edx,%edx
80103a1d:	eb 08                	jmp    80103a27 <mycpu+0x27>
80103a1f:	90                   	nop
80103a20:	83 c2 01             	add    $0x1,%edx
80103a23:	39 f2                	cmp    %esi,%edx
80103a25:	74 1e                	je     80103a45 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103a27:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103a2d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103a34:	39 c3                	cmp    %eax,%ebx
80103a36:	75 e8                	jne    80103a20 <mycpu+0x20>
}
80103a38:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103a3b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103a41:	5b                   	pop    %ebx
80103a42:	5e                   	pop    %esi
80103a43:	5d                   	pop    %ebp
80103a44:	c3                   	ret
  panic("unknown apicid\n");
80103a45:	83 ec 0c             	sub    $0xc,%esp
80103a48:	68 13 7c 10 80       	push   $0x80107c13
80103a4d:	e8 2e c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103a52:	83 ec 0c             	sub    $0xc,%esp
80103a55:	68 a8 7f 10 80       	push   $0x80107fa8
80103a5a:	e8 21 c9 ff ff       	call   80100380 <panic>
80103a5f:	90                   	nop

80103a60 <cpuid>:
cpuid() {
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a66:	e8 95 ff ff ff       	call   80103a00 <mycpu>
}
80103a6b:	c9                   	leave
  return mycpu()-cpus;
80103a6c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103a71:	c1 f8 04             	sar    $0x4,%eax
80103a74:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a7a:	c3                   	ret
80103a7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103a80 <myproc>:
myproc(void) {
80103a80:	55                   	push   %ebp
80103a81:	89 e5                	mov    %esp,%ebp
80103a83:	53                   	push   %ebx
80103a84:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103a87:	e8 94 0b 00 00       	call   80104620 <pushcli>
  c = mycpu();
80103a8c:	e8 6f ff ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103a91:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a97:	e8 d4 0b 00 00       	call   80104670 <popcli>
}
80103a9c:	89 d8                	mov    %ebx,%eax
80103a9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aa1:	c9                   	leave
80103aa2:	c3                   	ret
80103aa3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aaa:	00 
80103aab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103ab0 <userinit>:
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	53                   	push   %ebx
80103ab4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ab7:	e8 b4 fd ff ff       	call   80103870 <allocproc>
80103abc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103abe:	a3 54 a9 11 80       	mov    %eax,0x8011a954
  if((p->pgdir = setupkvm()) == 0)
80103ac3:	e8 88 3a 00 00       	call   80107550 <setupkvm>
80103ac8:	89 43 04             	mov    %eax,0x4(%ebx)
80103acb:	85 c0                	test   %eax,%eax
80103acd:	0f 84 bd 00 00 00    	je     80103b90 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ad3:	83 ec 04             	sub    $0x4,%esp
80103ad6:	68 2c 00 00 00       	push   $0x2c
80103adb:	68 60 b4 10 80       	push   $0x8010b460
80103ae0:	50                   	push   %eax
80103ae1:	e8 7a 36 00 00       	call   80107160 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ae6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ae9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103aef:	6a 4c                	push   $0x4c
80103af1:	6a 00                	push   $0x0
80103af3:	ff 73 18             	push   0x18(%ebx)
80103af6:	e8 75 0d 00 00       	call   80104870 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103afb:	8b 43 18             	mov    0x18(%ebx),%eax
80103afe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b03:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b06:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b0b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b12:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b16:	8b 43 18             	mov    0x18(%ebx),%eax
80103b19:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b1d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b21:	8b 43 18             	mov    0x18(%ebx),%eax
80103b24:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b28:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b2c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b2f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103b36:	8b 43 18             	mov    0x18(%ebx),%eax
80103b39:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103b40:	8b 43 18             	mov    0x18(%ebx),%eax
80103b43:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b4a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b4d:	6a 10                	push   $0x10
80103b4f:	68 3c 7c 10 80       	push   $0x80107c3c
80103b54:	50                   	push   %eax
80103b55:	e8 c6 0e 00 00       	call   80104a20 <safestrcpy>
  p->cwd = namei("/");
80103b5a:	c7 04 24 45 7c 10 80 	movl   $0x80107c45,(%esp)
80103b61:	e8 da e5 ff ff       	call   80102140 <namei>
80103b66:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103b69:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b70:	e8 fb 0b 00 00       	call   80104770 <acquire>
  p->state = RUNNABLE;
80103b75:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b7c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b83:	e8 88 0b 00 00       	call   80104710 <release>
}
80103b88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b8b:	83 c4 10             	add    $0x10,%esp
80103b8e:	c9                   	leave
80103b8f:	c3                   	ret
    panic("userinit: out of memory?");
80103b90:	83 ec 0c             	sub    $0xc,%esp
80103b93:	68 23 7c 10 80       	push   $0x80107c23
80103b98:	e8 e3 c7 ff ff       	call   80100380 <panic>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi

80103ba0 <growproc>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	56                   	push   %esi
80103ba4:	53                   	push   %ebx
80103ba5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ba8:	e8 73 0a 00 00       	call   80104620 <pushcli>
  c = mycpu();
80103bad:	e8 4e fe ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103bb2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bb8:	e8 b3 0a 00 00       	call   80104670 <popcli>
  sz = curproc->sz;
80103bbd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103bbf:	85 f6                	test   %esi,%esi
80103bc1:	7e 1d                	jle    80103be0 <growproc+0x40>
    sz+=n;
80103bc3:	01 f0                	add    %esi,%eax
  switchuvm(curproc);
80103bc5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103bc8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103bca:	53                   	push   %ebx
80103bcb:	e8 80 34 00 00       	call   80107050 <switchuvm>
  return 0;
80103bd0:	83 c4 10             	add    $0x10,%esp
80103bd3:	31 c0                	xor    %eax,%eax
}
80103bd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bd8:	5b                   	pop    %ebx
80103bd9:	5e                   	pop    %esi
80103bda:	5d                   	pop    %ebp
80103bdb:	c3                   	ret
80103bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(n < 0){
80103be0:	74 e3                	je     80103bc5 <growproc+0x25>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103be2:	83 ec 04             	sub    $0x4,%esp
80103be5:	01 c6                	add    %eax,%esi
80103be7:	56                   	push   %esi
80103be8:	50                   	push   %eax
80103be9:	ff 73 04             	push   0x4(%ebx)
80103bec:	e8 af 38 00 00       	call   801074a0 <deallocuvm>
80103bf1:	83 c4 10             	add    $0x10,%esp
80103bf4:	85 c0                	test   %eax,%eax
80103bf6:	75 cd                	jne    80103bc5 <growproc+0x25>
      return -1;
80103bf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bfd:	eb d6                	jmp    80103bd5 <growproc+0x35>
80103bff:	90                   	nop

80103c00 <fork>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c09:	e8 12 0a 00 00       	call   80104620 <pushcli>
  c = mycpu();
80103c0e:	e8 ed fd ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103c13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c19:	e8 52 0a 00 00       	call   80104670 <popcli>
  if((np = allocproc()) == 0){
80103c1e:	e8 4d fc ff ff       	call   80103870 <allocproc>
80103c23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c26:	85 c0                	test   %eax,%eax
80103c28:	0f 84 d6 00 00 00    	je     80103d04 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c2e:	83 ec 08             	sub    $0x8,%esp
80103c31:	ff 33                	push   (%ebx)
80103c33:	89 c7                	mov    %eax,%edi
80103c35:	ff 73 04             	push   0x4(%ebx)
80103c38:	e8 03 3a 00 00       	call   80107640 <copyuvm>
80103c3d:	83 c4 10             	add    $0x10,%esp
80103c40:	89 47 04             	mov    %eax,0x4(%edi)
80103c43:	85 c0                	test   %eax,%eax
80103c45:	0f 84 9a 00 00 00    	je     80103ce5 <fork+0xe5>
  np->sz = curproc->sz;
80103c4b:	8b 03                	mov    (%ebx),%eax
80103c4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c50:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103c52:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103c55:	89 c8                	mov    %ecx,%eax
80103c57:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103c5a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c5f:	8b 73 18             	mov    0x18(%ebx),%esi
80103c62:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c64:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103c66:	8b 40 18             	mov    0x18(%eax),%eax
80103c69:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103c70:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c74:	85 c0                	test   %eax,%eax
80103c76:	74 13                	je     80103c8b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c78:	83 ec 0c             	sub    $0xc,%esp
80103c7b:	50                   	push   %eax
80103c7c:	e8 ff d2 ff ff       	call   80100f80 <filedup>
80103c81:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c84:	83 c4 10             	add    $0x10,%esp
80103c87:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c8b:	83 c6 01             	add    $0x1,%esi
80103c8e:	83 fe 10             	cmp    $0x10,%esi
80103c91:	75 dd                	jne    80103c70 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103c93:	83 ec 0c             	sub    $0xc,%esp
80103c96:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c99:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103c9c:	e8 8f db ff ff       	call   80101830 <idup>
80103ca1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ca4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ca7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103caa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103cad:	6a 10                	push   $0x10
80103caf:	53                   	push   %ebx
80103cb0:	50                   	push   %eax
80103cb1:	e8 6a 0d 00 00       	call   80104a20 <safestrcpy>
  pid = np->pid;
80103cb6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103cb9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cc0:	e8 ab 0a 00 00       	call   80104770 <acquire>
  np->state = RUNNABLE;
80103cc5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103ccc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cd3:	e8 38 0a 00 00       	call   80104710 <release>
  return pid;
80103cd8:	83 c4 10             	add    $0x10,%esp
}
80103cdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cde:	89 d8                	mov    %ebx,%eax
80103ce0:	5b                   	pop    %ebx
80103ce1:	5e                   	pop    %esi
80103ce2:	5f                   	pop    %edi
80103ce3:	5d                   	pop    %ebp
80103ce4:	c3                   	ret
    kfree(np->kstack);
80103ce5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ce8:	83 ec 0c             	sub    $0xc,%esp
80103ceb:	ff 73 08             	push   0x8(%ebx)
80103cee:	e8 6d e8 ff ff       	call   80102560 <kfree>
    np->kstack = 0;
80103cf3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103cfa:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103cfd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103d04:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d09:	eb d0                	jmp    80103cdb <fork+0xdb>
80103d0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103d10 <scheduler>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	57                   	push   %edi
80103d14:	56                   	push   %esi
80103d15:	53                   	push   %ebx
80103d16:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103d19:	e8 e2 fc ff ff       	call   80103a00 <mycpu>
  c->proc = 0;
80103d1e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d25:	00 00 00 
  struct cpu *c = mycpu();
80103d28:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103d2a:	8d 70 04             	lea    0x4(%eax),%esi
80103d2d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d30:	fb                   	sti
    acquire(&ptable.lock);
80103d31:	83 ec 0c             	sub    $0xc,%esp
    struct proc *highest_priority_p = 0;
80103d34:	31 ff                	xor    %edi,%edi
    acquire(&ptable.lock);
80103d36:	68 20 2d 11 80       	push   $0x80112d20
80103d3b:	e8 30 0a 00 00       	call   80104770 <acquire>
80103d40:	83 c4 10             	add    $0x10,%esp
    int highest_priority = 1000; // big number so any real priority is lower
80103d43:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d48:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d4d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103d50:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103d54:	75 0e                	jne    80103d64 <scheduler+0x54>
      if(p->priority < highest_priority){
80103d56:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80103d5c:	39 d1                	cmp    %edx,%ecx
80103d5e:	7e 04                	jle    80103d64 <scheduler+0x54>
        highest_priority = p->priority;
80103d60:	89 d1                	mov    %edx,%ecx
        highest_priority_p = p;
80103d62:	89 c7                	mov    %eax,%edi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d64:	05 f0 01 00 00       	add    $0x1f0,%eax
80103d69:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
80103d6e:	75 e0                	jne    80103d50 <scheduler+0x40>
    if(highest_priority_p != 0){
80103d70:	85 ff                	test   %edi,%edi
80103d72:	74 33                	je     80103da7 <scheduler+0x97>
      switchuvm(p);
80103d74:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103d77:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103d7d:	57                   	push   %edi
80103d7e:	e8 cd 32 00 00       	call   80107050 <switchuvm>
      p->state = RUNNING;
80103d83:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
      swtch(&(c->scheduler), p->context);
80103d8a:	58                   	pop    %eax
80103d8b:	5a                   	pop    %edx
80103d8c:	ff 77 1c             	push   0x1c(%edi)
80103d8f:	56                   	push   %esi
80103d90:	e8 e6 0c 00 00       	call   80104a7b <swtch>
      switchkvm();
80103d95:	e8 a6 32 00 00       	call   80107040 <switchkvm>
      c->proc = 0;
80103d9a:	83 c4 10             	add    $0x10,%esp
80103d9d:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103da4:	00 00 00 
    release(&ptable.lock);
80103da7:	83 ec 0c             	sub    $0xc,%esp
80103daa:	68 20 2d 11 80       	push   $0x80112d20
80103daf:	e8 5c 09 00 00       	call   80104710 <release>
  for(;;){
80103db4:	83 c4 10             	add    $0x10,%esp
80103db7:	e9 74 ff ff ff       	jmp    80103d30 <scheduler+0x20>
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103dc0 <sched>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	56                   	push   %esi
80103dc4:	53                   	push   %ebx
  pushcli();
80103dc5:	e8 56 08 00 00       	call   80104620 <pushcli>
  c = mycpu();
80103dca:	e8 31 fc ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103dcf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dd5:	e8 96 08 00 00       	call   80104670 <popcli>
  if(!holding(&ptable.lock))
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 20 2d 11 80       	push   $0x80112d20
80103de2:	e8 e9 08 00 00       	call   801046d0 <holding>
80103de7:	83 c4 10             	add    $0x10,%esp
80103dea:	85 c0                	test   %eax,%eax
80103dec:	74 4f                	je     80103e3d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dee:	e8 0d fc ff ff       	call   80103a00 <mycpu>
80103df3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dfa:	75 68                	jne    80103e64 <sched+0xa4>
  if(p->state == RUNNING)
80103dfc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e00:	74 55                	je     80103e57 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e02:	9c                   	pushf
80103e03:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e04:	f6 c4 02             	test   $0x2,%ah
80103e07:	75 41                	jne    80103e4a <sched+0x8a>
  intena = mycpu()->intena;
80103e09:	e8 f2 fb ff ff       	call   80103a00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e0e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e11:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e17:	e8 e4 fb ff ff       	call   80103a00 <mycpu>
80103e1c:	83 ec 08             	sub    $0x8,%esp
80103e1f:	ff 70 04             	push   0x4(%eax)
80103e22:	53                   	push   %ebx
80103e23:	e8 53 0c 00 00       	call   80104a7b <swtch>
  mycpu()->intena = intena;
80103e28:	e8 d3 fb ff ff       	call   80103a00 <mycpu>
}
80103e2d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e30:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e39:	5b                   	pop    %ebx
80103e3a:	5e                   	pop    %esi
80103e3b:	5d                   	pop    %ebp
80103e3c:	c3                   	ret
    panic("sched ptable.lock");
80103e3d:	83 ec 0c             	sub    $0xc,%esp
80103e40:	68 47 7c 10 80       	push   $0x80107c47
80103e45:	e8 36 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e4a:	83 ec 0c             	sub    $0xc,%esp
80103e4d:	68 73 7c 10 80       	push   $0x80107c73
80103e52:	e8 29 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e57:	83 ec 0c             	sub    $0xc,%esp
80103e5a:	68 65 7c 10 80       	push   $0x80107c65
80103e5f:	e8 1c c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e64:	83 ec 0c             	sub    $0xc,%esp
80103e67:	68 59 7c 10 80       	push   $0x80107c59
80103e6c:	e8 0f c5 ff ff       	call   80100380 <panic>
80103e71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e78:	00 
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e80 <exit>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103e89:	e8 f2 fb ff ff       	call   80103a80 <myproc>
  if(curproc == initproc)
80103e8e:	39 05 54 a9 11 80    	cmp    %eax,0x8011a954
80103e94:	0f 84 07 01 00 00    	je     80103fa1 <exit+0x121>
80103e9a:	89 c3                	mov    %eax,%ebx
80103e9c:	8d 70 28             	lea    0x28(%eax),%esi
80103e9f:	8d 78 68             	lea    0x68(%eax),%edi
80103ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103ea8:	8b 06                	mov    (%esi),%eax
80103eaa:	85 c0                	test   %eax,%eax
80103eac:	74 12                	je     80103ec0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103eae:	83 ec 0c             	sub    $0xc,%esp
80103eb1:	50                   	push   %eax
80103eb2:	e8 19 d1 ff ff       	call   80100fd0 <fileclose>
      curproc->ofile[fd] = 0;
80103eb7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103ebd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103ec0:	83 c6 04             	add    $0x4,%esi
80103ec3:	39 f7                	cmp    %esi,%edi
80103ec5:	75 e1                	jne    80103ea8 <exit+0x28>
  begin_op();
80103ec7:	e8 34 ef ff ff       	call   80102e00 <begin_op>
  iput(curproc->cwd);
80103ecc:	83 ec 0c             	sub    $0xc,%esp
80103ecf:	ff 73 68             	push   0x68(%ebx)
80103ed2:	e8 b9 da ff ff       	call   80101990 <iput>
  end_op();
80103ed7:	e8 94 ef ff ff       	call   80102e70 <end_op>
  curproc->cwd = 0;
80103edc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103ee3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eea:	e8 81 08 00 00       	call   80104770 <acquire>
  wakeup1(curproc->parent);
80103eef:	8b 53 14             	mov    0x14(%ebx),%edx
80103ef2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ef5:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103efa:	eb 10                	jmp    80103f0c <exit+0x8c>
80103efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f00:	05 f0 01 00 00       	add    $0x1f0,%eax
80103f05:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
80103f0a:	74 1e                	je     80103f2a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103f0c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f10:	75 ee                	jne    80103f00 <exit+0x80>
80103f12:	3b 50 20             	cmp    0x20(%eax),%edx
80103f15:	75 e9                	jne    80103f00 <exit+0x80>
      p->state = RUNNABLE;
80103f17:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f1e:	05 f0 01 00 00       	add    $0x1f0,%eax
80103f23:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
80103f28:	75 e2                	jne    80103f0c <exit+0x8c>
      p->parent = initproc;
80103f2a:	8b 0d 54 a9 11 80    	mov    0x8011a954,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f30:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103f35:	eb 17                	jmp    80103f4e <exit+0xce>
80103f37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f3e:	00 
80103f3f:	90                   	nop
80103f40:	81 c2 f0 01 00 00    	add    $0x1f0,%edx
80103f46:	81 fa 54 a9 11 80    	cmp    $0x8011a954,%edx
80103f4c:	74 3a                	je     80103f88 <exit+0x108>
    if(p->parent == curproc){
80103f4e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103f51:	75 ed                	jne    80103f40 <exit+0xc0>
      if(p->state == ZOMBIE)
80103f53:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f57:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f5a:	75 e4                	jne    80103f40 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f5c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f61:	eb 11                	jmp    80103f74 <exit+0xf4>
80103f63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f68:	05 f0 01 00 00       	add    $0x1f0,%eax
80103f6d:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
80103f72:	74 cc                	je     80103f40 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f78:	75 ee                	jne    80103f68 <exit+0xe8>
80103f7a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f7d:	75 e9                	jne    80103f68 <exit+0xe8>
      p->state = RUNNABLE;
80103f7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f86:	eb e0                	jmp    80103f68 <exit+0xe8>
  curproc->state = ZOMBIE;
80103f88:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f8f:	e8 2c fe ff ff       	call   80103dc0 <sched>
  panic("zombie exit");
80103f94:	83 ec 0c             	sub    $0xc,%esp
80103f97:	68 94 7c 10 80       	push   $0x80107c94
80103f9c:	e8 df c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103fa1:	83 ec 0c             	sub    $0xc,%esp
80103fa4:	68 87 7c 10 80       	push   $0x80107c87
80103fa9:	e8 d2 c3 ff ff       	call   80100380 <panic>
80103fae:	66 90                	xchg   %ax,%ax

80103fb0 <wait>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
  pushcli();
80103fb5:	e8 66 06 00 00       	call   80104620 <pushcli>
  c = mycpu();
80103fba:	e8 41 fa ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80103fbf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fc5:	e8 a6 06 00 00       	call   80104670 <popcli>
  acquire(&ptable.lock);
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 20 2d 11 80       	push   $0x80112d20
80103fd2:	e8 99 07 00 00       	call   80104770 <acquire>
80103fd7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fdc:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103fe1:	eb 13                	jmp    80103ff6 <wait+0x46>
80103fe3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fe8:	81 c3 f0 01 00 00    	add    $0x1f0,%ebx
80103fee:	81 fb 54 a9 11 80    	cmp    $0x8011a954,%ebx
80103ff4:	74 1e                	je     80104014 <wait+0x64>
      if(p->parent != curproc)
80103ff6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ff9:	75 ed                	jne    80103fe8 <wait+0x38>
      if(p->state == ZOMBIE){
80103ffb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fff:	74 5f                	je     80104060 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104001:	81 c3 f0 01 00 00    	add    $0x1f0,%ebx
      havekids = 1;
80104007:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010400c:	81 fb 54 a9 11 80    	cmp    $0x8011a954,%ebx
80104012:	75 e2                	jne    80103ff6 <wait+0x46>
    if(!havekids || curproc->killed){
80104014:	85 c0                	test   %eax,%eax
80104016:	0f 84 9a 00 00 00    	je     801040b6 <wait+0x106>
8010401c:	8b 46 24             	mov    0x24(%esi),%eax
8010401f:	85 c0                	test   %eax,%eax
80104021:	0f 85 8f 00 00 00    	jne    801040b6 <wait+0x106>
  pushcli();
80104027:	e8 f4 05 00 00       	call   80104620 <pushcli>
  c = mycpu();
8010402c:	e8 cf f9 ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80104031:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104037:	e8 34 06 00 00       	call   80104670 <popcli>
  if(p == 0)
8010403c:	85 db                	test   %ebx,%ebx
8010403e:	0f 84 89 00 00 00    	je     801040cd <wait+0x11d>
  p->chan = chan;
80104044:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104047:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010404e:	e8 6d fd ff ff       	call   80103dc0 <sched>
  p->chan = 0;
80104053:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010405a:	e9 7b ff ff ff       	jmp    80103fda <wait+0x2a>
8010405f:	90                   	nop
        kfree(p->kstack);
80104060:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104063:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104066:	ff 73 08             	push   0x8(%ebx)
80104069:	e8 f2 e4 ff ff       	call   80102560 <kfree>
        p->kstack = 0;
8010406e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104075:	5a                   	pop    %edx
80104076:	ff 73 04             	push   0x4(%ebx)
80104079:	e8 52 34 00 00       	call   801074d0 <freevm>
        p->pid = 0;
8010407e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104085:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010408c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104090:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104097:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010409e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040a5:	e8 66 06 00 00       	call   80104710 <release>
        return pid;
801040aa:	83 c4 10             	add    $0x10,%esp
}
801040ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040b0:	89 f0                	mov    %esi,%eax
801040b2:	5b                   	pop    %ebx
801040b3:	5e                   	pop    %esi
801040b4:	5d                   	pop    %ebp
801040b5:	c3                   	ret
      release(&ptable.lock);
801040b6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801040b9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801040be:	68 20 2d 11 80       	push   $0x80112d20
801040c3:	e8 48 06 00 00       	call   80104710 <release>
      return -1;
801040c8:	83 c4 10             	add    $0x10,%esp
801040cb:	eb e0                	jmp    801040ad <wait+0xfd>
    panic("sleep");
801040cd:	83 ec 0c             	sub    $0xc,%esp
801040d0:	68 a0 7c 10 80       	push   $0x80107ca0
801040d5:	e8 a6 c2 ff ff       	call   80100380 <panic>
801040da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040e0 <yield>:
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040e7:	68 20 2d 11 80       	push   $0x80112d20
801040ec:	e8 7f 06 00 00       	call   80104770 <acquire>
  pushcli();
801040f1:	e8 2a 05 00 00       	call   80104620 <pushcli>
  c = mycpu();
801040f6:	e8 05 f9 ff ff       	call   80103a00 <mycpu>
  p = c->proc;
801040fb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104101:	e8 6a 05 00 00       	call   80104670 <popcli>
  myproc()->state = RUNNABLE;
80104106:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010410d:	e8 ae fc ff ff       	call   80103dc0 <sched>
  release(&ptable.lock);
80104112:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104119:	e8 f2 05 00 00       	call   80104710 <release>
}
8010411e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104121:	83 c4 10             	add    $0x10,%esp
80104124:	c9                   	leave
80104125:	c3                   	ret
80104126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010412d:	00 
8010412e:	66 90                	xchg   %ax,%ax

80104130 <sleep>:
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
80104134:	56                   	push   %esi
80104135:	53                   	push   %ebx
80104136:	83 ec 0c             	sub    $0xc,%esp
80104139:	8b 7d 08             	mov    0x8(%ebp),%edi
8010413c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010413f:	e8 dc 04 00 00       	call   80104620 <pushcli>
  c = mycpu();
80104144:	e8 b7 f8 ff ff       	call   80103a00 <mycpu>
  p = c->proc;
80104149:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010414f:	e8 1c 05 00 00       	call   80104670 <popcli>
  if(p == 0)
80104154:	85 db                	test   %ebx,%ebx
80104156:	0f 84 87 00 00 00    	je     801041e3 <sleep+0xb3>
  if(lk == 0)
8010415c:	85 f6                	test   %esi,%esi
8010415e:	74 76                	je     801041d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104160:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104166:	74 50                	je     801041b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104168:	83 ec 0c             	sub    $0xc,%esp
8010416b:	68 20 2d 11 80       	push   $0x80112d20
80104170:	e8 fb 05 00 00       	call   80104770 <acquire>
    release(lk);
80104175:	89 34 24             	mov    %esi,(%esp)
80104178:	e8 93 05 00 00       	call   80104710 <release>
  p->chan = chan;
8010417d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104180:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104187:	e8 34 fc ff ff       	call   80103dc0 <sched>
  p->chan = 0;
8010418c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104193:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010419a:	e8 71 05 00 00       	call   80104710 <release>
    acquire(lk);
8010419f:	83 c4 10             	add    $0x10,%esp
801041a2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801041a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041a8:	5b                   	pop    %ebx
801041a9:	5e                   	pop    %esi
801041aa:	5f                   	pop    %edi
801041ab:	5d                   	pop    %ebp
    acquire(lk);
801041ac:	e9 bf 05 00 00       	jmp    80104770 <acquire>
801041b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801041b8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801041bb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041c2:	e8 f9 fb ff ff       	call   80103dc0 <sched>
  p->chan = 0;
801041c7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801041ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041d1:	5b                   	pop    %ebx
801041d2:	5e                   	pop    %esi
801041d3:	5f                   	pop    %edi
801041d4:	5d                   	pop    %ebp
801041d5:	c3                   	ret
    panic("sleep without lk");
801041d6:	83 ec 0c             	sub    $0xc,%esp
801041d9:	68 a6 7c 10 80       	push   $0x80107ca6
801041de:	e8 9d c1 ff ff       	call   80100380 <panic>
    panic("sleep");
801041e3:	83 ec 0c             	sub    $0xc,%esp
801041e6:	68 a0 7c 10 80       	push   $0x80107ca0
801041eb:	e8 90 c1 ff ff       	call   80100380 <panic>

801041f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	53                   	push   %ebx
801041f4:	83 ec 10             	sub    $0x10,%esp
801041f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041fa:	68 20 2d 11 80       	push   $0x80112d20
801041ff:	e8 6c 05 00 00       	call   80104770 <acquire>
80104204:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104207:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010420c:	eb 0e                	jmp    8010421c <wakeup+0x2c>
8010420e:	66 90                	xchg   %ax,%ax
80104210:	05 f0 01 00 00       	add    $0x1f0,%eax
80104215:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
8010421a:	74 1e                	je     8010423a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010421c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104220:	75 ee                	jne    80104210 <wakeup+0x20>
80104222:	3b 58 20             	cmp    0x20(%eax),%ebx
80104225:	75 e9                	jne    80104210 <wakeup+0x20>
      p->state = RUNNABLE;
80104227:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010422e:	05 f0 01 00 00       	add    $0x1f0,%eax
80104233:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
80104238:	75 e2                	jne    8010421c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010423a:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104241:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104244:	c9                   	leave
  release(&ptable.lock);
80104245:	e9 c6 04 00 00       	jmp    80104710 <release>
8010424a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104250 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	53                   	push   %ebx
80104254:	83 ec 10             	sub    $0x10,%esp
80104257:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010425a:	68 20 2d 11 80       	push   $0x80112d20
8010425f:	e8 0c 05 00 00       	call   80104770 <acquire>
80104264:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104267:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010426c:	eb 0e                	jmp    8010427c <kill+0x2c>
8010426e:	66 90                	xchg   %ax,%ax
80104270:	05 f0 01 00 00       	add    $0x1f0,%eax
80104275:	3d 54 a9 11 80       	cmp    $0x8011a954,%eax
8010427a:	74 34                	je     801042b0 <kill+0x60>
    if(p->pid == pid){
8010427c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010427f:	75 ef                	jne    80104270 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104281:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104285:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010428c:	75 07                	jne    80104295 <kill+0x45>
        p->state = RUNNABLE;
8010428e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104295:	83 ec 0c             	sub    $0xc,%esp
80104298:	68 20 2d 11 80       	push   $0x80112d20
8010429d:	e8 6e 04 00 00       	call   80104710 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801042a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801042a5:	83 c4 10             	add    $0x10,%esp
801042a8:	31 c0                	xor    %eax,%eax
}
801042aa:	c9                   	leave
801042ab:	c3                   	ret
801042ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801042b0:	83 ec 0c             	sub    $0xc,%esp
801042b3:	68 20 2d 11 80       	push   $0x80112d20
801042b8:	e8 53 04 00 00       	call   80104710 <release>
}
801042bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801042c0:	83 c4 10             	add    $0x10,%esp
801042c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042c8:	c9                   	leave
801042c9:	c3                   	ret
801042ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	57                   	push   %edi
801042d4:	56                   	push   %esi
801042d5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042d8:	53                   	push   %ebx
801042d9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801042de:	83 ec 3c             	sub    $0x3c,%esp
801042e1:	eb 27                	jmp    8010430a <procdump+0x3a>
801042e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042e8:	83 ec 0c             	sub    $0xc,%esp
801042eb:	68 eb 7d 10 80       	push   $0x80107deb
801042f0:	e8 bb c3 ff ff       	call   801006b0 <cprintf>
801042f5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042f8:	81 c3 f0 01 00 00    	add    $0x1f0,%ebx
801042fe:	81 fb c0 a9 11 80    	cmp    $0x8011a9c0,%ebx
80104304:	0f 84 7e 00 00 00    	je     80104388 <procdump+0xb8>
    if(p->state == UNUSED)
8010430a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010430d:	85 c0                	test   %eax,%eax
8010430f:	74 e7                	je     801042f8 <procdump+0x28>
      state = "???";
80104311:	ba b7 7c 10 80       	mov    $0x80107cb7,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104316:	83 f8 05             	cmp    $0x5,%eax
80104319:	77 11                	ja     8010432c <procdump+0x5c>
8010431b:	8b 14 85 78 83 10 80 	mov    -0x7fef7c88(,%eax,4),%edx
      state = "???";
80104322:	b8 b7 7c 10 80       	mov    $0x80107cb7,%eax
80104327:	85 d2                	test   %edx,%edx
80104329:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010432c:	53                   	push   %ebx
8010432d:	52                   	push   %edx
8010432e:	ff 73 a4             	push   -0x5c(%ebx)
80104331:	68 bb 7c 10 80       	push   $0x80107cbb
80104336:	e8 75 c3 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
8010433b:	83 c4 10             	add    $0x10,%esp
8010433e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104342:	75 a4                	jne    801042e8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104344:	83 ec 08             	sub    $0x8,%esp
80104347:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010434a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010434d:	50                   	push   %eax
8010434e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104351:	8b 40 0c             	mov    0xc(%eax),%eax
80104354:	83 c0 08             	add    $0x8,%eax
80104357:	50                   	push   %eax
80104358:	e8 43 02 00 00       	call   801045a0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010435d:	83 c4 10             	add    $0x10,%esp
80104360:	8b 17                	mov    (%edi),%edx
80104362:	85 d2                	test   %edx,%edx
80104364:	74 82                	je     801042e8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104366:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104369:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010436c:	52                   	push   %edx
8010436d:	68 e1 79 10 80       	push   $0x801079e1
80104372:	e8 39 c3 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104377:	83 c4 10             	add    $0x10,%esp
8010437a:	39 f7                	cmp    %esi,%edi
8010437c:	75 e2                	jne    80104360 <procdump+0x90>
8010437e:	e9 65 ff ff ff       	jmp    801042e8 <procdump+0x18>
80104383:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104388:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010438b:	5b                   	pop    %ebx
8010438c:	5e                   	pop    %esi
8010438d:	5f                   	pop    %edi
8010438e:	5d                   	pop    %ebp
8010438f:	c3                   	ret

80104390 <get_proc_info_kernel>:

int
get_proc_info_kernel(int pid, struct proc_info *info)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	57                   	push   %edi
80104394:	56                   	push   %esi
80104395:	53                   	push   %ebx
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104396:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
8010439b:	83 ec 18             	sub    $0x18,%esp
8010439e:	8b 75 08             	mov    0x8(%ebp),%esi
801043a1:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&ptable.lock);
801043a4:	68 20 2d 11 80       	push   $0x80112d20
801043a9:	e8 c2 03 00 00       	call   80104770 <acquire>
801043ae:	83 c4 10             	add    $0x10,%esp
801043b1:	eb 13                	jmp    801043c6 <get_proc_info_kernel+0x36>
801043b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043b8:	81 c3 f0 01 00 00    	add    $0x1f0,%ebx
801043be:	81 fb 54 a9 11 80    	cmp    $0x8011a954,%ebx
801043c4:	74 6a                	je     80104430 <get_proc_info_kernel+0xa0>
    if(p->pid == pid && p->state != UNUSED){
801043c6:	39 73 10             	cmp    %esi,0x10(%ebx)
801043c9:	75 ed                	jne    801043b8 <get_proc_info_kernel+0x28>
801043cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801043ce:	85 c0                	test   %eax,%eax
801043d0:	74 e6                	je     801043b8 <get_proc_info_kernel+0x28>
      info->pid = p->pid;
      safestrcpy(info->name, p->name, sizeof(info->name));
801043d2:	83 ec 04             	sub    $0x4,%esp
801043d5:	8d 43 6c             	lea    0x6c(%ebx),%eax
      info->pid = p->pid;
801043d8:	89 37                	mov    %esi,(%edi)
      safestrcpy(info->name, p->name, sizeof(info->name));
801043da:	6a 10                	push   $0x10
801043dc:	50                   	push   %eax
801043dd:	8d 47 04             	lea    0x4(%edi),%eax
801043e0:	50                   	push   %eax
801043e1:	e8 3a 06 00 00       	call   80104a20 <safestrcpy>

      char *st = "UNKNOWN";
      switch(p->state){
801043e6:	8b 53 0c             	mov    0xc(%ebx),%edx
801043e9:	83 c4 10             	add    $0x10,%esp
801043ec:	b8 c4 7c 10 80       	mov    $0x80107cc4,%eax
801043f1:	83 fa 05             	cmp    $0x5,%edx
801043f4:	76 2d                	jbe    80104423 <get_proc_info_kernel+0x93>
      case SLEEPING: st = "SLEEPING"; break;
      case RUNNABLE: st = "RUNNABLE"; break;
      case RUNNING:  st = "RUNNING";  break;
      case ZOMBIE:   st = "ZOMBIE";   break;
      }
      safestrcpy(info->state, st, sizeof(info->state));
801043f6:	83 ec 04             	sub    $0x4,%esp
801043f9:	6a 10                	push   $0x10
801043fb:	50                   	push   %eax
801043fc:	8d 47 14             	lea    0x14(%edi),%eax
801043ff:	50                   	push   %eax
80104400:	e8 1b 06 00 00       	call   80104a20 <safestrcpy>
      info->sz = p->sz;
80104405:	8b 03                	mov    (%ebx),%eax
80104407:	89 47 24             	mov    %eax,0x24(%edi)

      release(&ptable.lock);
8010440a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104411:	e8 fa 02 00 00       	call   80104710 <release>
      return 0;
80104416:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ptable.lock);
  return -1;
}
80104419:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
8010441c:	31 c0                	xor    %eax,%eax
}
8010441e:	5b                   	pop    %ebx
8010441f:	5e                   	pop    %esi
80104420:	5f                   	pop    %edi
80104421:	5d                   	pop    %ebp
80104422:	c3                   	ret
80104423:	8b 04 95 60 83 10 80 	mov    -0x7fef7ca0(,%edx,4),%eax
8010442a:	eb ca                	jmp    801043f6 <get_proc_info_kernel+0x66>
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104430:	83 ec 0c             	sub    $0xc,%esp
80104433:	68 20 2d 11 80       	push   $0x80112d20
80104438:	e8 d3 02 00 00       	call   80104710 <release>
  return -1;
8010443d:	83 c4 10             	add    $0x10,%esp
}
80104440:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104443:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104448:	5b                   	pop    %ebx
80104449:	5e                   	pop    %esi
8010444a:	5f                   	pop    %edi
8010444b:	5d                   	pop    %ebp
8010444c:	c3                   	ret
8010444d:	66 90                	xchg   %ax,%ax
8010444f:	90                   	nop

80104450 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 0c             	sub    $0xc,%esp
80104457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010445a:	68 25 7d 10 80       	push   $0x80107d25
8010445f:	8d 43 04             	lea    0x4(%ebx),%eax
80104462:	50                   	push   %eax
80104463:	e8 18 01 00 00       	call   80104580 <initlock>
  lk->name = name;
80104468:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010446b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104471:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104474:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010447b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010447e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104481:	c9                   	leave
80104482:	c3                   	ret
80104483:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010448a:	00 
8010448b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104490 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
80104495:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104498:	8d 73 04             	lea    0x4(%ebx),%esi
8010449b:	83 ec 0c             	sub    $0xc,%esp
8010449e:	56                   	push   %esi
8010449f:	e8 cc 02 00 00       	call   80104770 <acquire>
  while (lk->locked) {
801044a4:	8b 13                	mov    (%ebx),%edx
801044a6:	83 c4 10             	add    $0x10,%esp
801044a9:	85 d2                	test   %edx,%edx
801044ab:	74 16                	je     801044c3 <acquiresleep+0x33>
801044ad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801044b0:	83 ec 08             	sub    $0x8,%esp
801044b3:	56                   	push   %esi
801044b4:	53                   	push   %ebx
801044b5:	e8 76 fc ff ff       	call   80104130 <sleep>
  while (lk->locked) {
801044ba:	8b 03                	mov    (%ebx),%eax
801044bc:	83 c4 10             	add    $0x10,%esp
801044bf:	85 c0                	test   %eax,%eax
801044c1:	75 ed                	jne    801044b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801044c3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801044c9:	e8 b2 f5 ff ff       	call   80103a80 <myproc>
801044ce:	8b 40 10             	mov    0x10(%eax),%eax
801044d1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801044d4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801044d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044da:	5b                   	pop    %ebx
801044db:	5e                   	pop    %esi
801044dc:	5d                   	pop    %ebp
  release(&lk->lk);
801044dd:	e9 2e 02 00 00       	jmp    80104710 <release>
801044e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044e9:	00 
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	56                   	push   %esi
801044f4:	53                   	push   %ebx
801044f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044f8:	8d 73 04             	lea    0x4(%ebx),%esi
801044fb:	83 ec 0c             	sub    $0xc,%esp
801044fe:	56                   	push   %esi
801044ff:	e8 6c 02 00 00       	call   80104770 <acquire>
  lk->locked = 0;
80104504:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010450a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104511:	89 1c 24             	mov    %ebx,(%esp)
80104514:	e8 d7 fc ff ff       	call   801041f0 <wakeup>
  release(&lk->lk);
80104519:	83 c4 10             	add    $0x10,%esp
8010451c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010451f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104522:	5b                   	pop    %ebx
80104523:	5e                   	pop    %esi
80104524:	5d                   	pop    %ebp
  release(&lk->lk);
80104525:	e9 e6 01 00 00       	jmp    80104710 <release>
8010452a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104530 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	31 ff                	xor    %edi,%edi
80104536:	56                   	push   %esi
80104537:	53                   	push   %ebx
80104538:	83 ec 18             	sub    $0x18,%esp
8010453b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010453e:	8d 73 04             	lea    0x4(%ebx),%esi
80104541:	56                   	push   %esi
80104542:	e8 29 02 00 00       	call   80104770 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104547:	8b 03                	mov    (%ebx),%eax
80104549:	83 c4 10             	add    $0x10,%esp
8010454c:	85 c0                	test   %eax,%eax
8010454e:	75 18                	jne    80104568 <holdingsleep+0x38>
  release(&lk->lk);
80104550:	83 ec 0c             	sub    $0xc,%esp
80104553:	56                   	push   %esi
80104554:	e8 b7 01 00 00       	call   80104710 <release>
  return r;
}
80104559:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010455c:	89 f8                	mov    %edi,%eax
8010455e:	5b                   	pop    %ebx
8010455f:	5e                   	pop    %esi
80104560:	5f                   	pop    %edi
80104561:	5d                   	pop    %ebp
80104562:	c3                   	ret
80104563:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104568:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010456b:	e8 10 f5 ff ff       	call   80103a80 <myproc>
80104570:	39 58 10             	cmp    %ebx,0x10(%eax)
80104573:	0f 94 c0             	sete   %al
80104576:	0f b6 c0             	movzbl %al,%eax
80104579:	89 c7                	mov    %eax,%edi
8010457b:	eb d3                	jmp    80104550 <holdingsleep+0x20>
8010457d:	66 90                	xchg   %ax,%ax
8010457f:	90                   	nop

80104580 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104586:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104589:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010458f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104592:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104599:	5d                   	pop    %ebp
8010459a:	c3                   	ret
8010459b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801045a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	53                   	push   %ebx
801045a4:	8b 45 08             	mov    0x8(%ebp),%eax
801045a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801045aa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045ad:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801045b2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
801045b7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045bc:	76 10                	jbe    801045ce <getcallerpcs+0x2e>
801045be:	eb 28                	jmp    801045e8 <getcallerpcs+0x48>
801045c0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801045c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045cc:	77 1a                	ja     801045e8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801045ce:	8b 5a 04             	mov    0x4(%edx),%ebx
801045d1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801045d4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801045d7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801045d9:	83 f8 0a             	cmp    $0xa,%eax
801045dc:	75 e2                	jne    801045c0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801045de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045e1:	c9                   	leave
801045e2:	c3                   	ret
801045e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801045e8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
801045eb:	83 c1 28             	add    $0x28,%ecx
801045ee:	89 ca                	mov    %ecx,%edx
801045f0:	29 c2                	sub    %eax,%edx
801045f2:	83 e2 04             	and    $0x4,%edx
801045f5:	74 11                	je     80104608 <getcallerpcs+0x68>
    pcs[i] = 0;
801045f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801045fd:	83 c0 04             	add    $0x4,%eax
80104600:	39 c1                	cmp    %eax,%ecx
80104602:	74 da                	je     801045de <getcallerpcs+0x3e>
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104608:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010460e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104611:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104618:	39 c1                	cmp    %eax,%ecx
8010461a:	75 ec                	jne    80104608 <getcallerpcs+0x68>
8010461c:	eb c0                	jmp    801045de <getcallerpcs+0x3e>
8010461e:	66 90                	xchg   %ax,%ax

80104620 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 04             	sub    $0x4,%esp
80104627:	9c                   	pushf
80104628:	5b                   	pop    %ebx
  asm volatile("cli");
80104629:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010462a:	e8 d1 f3 ff ff       	call   80103a00 <mycpu>
8010462f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104635:	85 c0                	test   %eax,%eax
80104637:	74 17                	je     80104650 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104639:	e8 c2 f3 ff ff       	call   80103a00 <mycpu>
8010463e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104645:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104648:	c9                   	leave
80104649:	c3                   	ret
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104650:	e8 ab f3 ff ff       	call   80103a00 <mycpu>
80104655:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010465b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104661:	eb d6                	jmp    80104639 <pushcli+0x19>
80104663:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010466a:	00 
8010466b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104670 <popcli>:

void
popcli(void)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104676:	9c                   	pushf
80104677:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104678:	f6 c4 02             	test   $0x2,%ah
8010467b:	75 35                	jne    801046b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010467d:	e8 7e f3 ff ff       	call   80103a00 <mycpu>
80104682:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104689:	78 34                	js     801046bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010468b:	e8 70 f3 ff ff       	call   80103a00 <mycpu>
80104690:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104696:	85 d2                	test   %edx,%edx
80104698:	74 06                	je     801046a0 <popcli+0x30>
    sti();
}
8010469a:	c9                   	leave
8010469b:	c3                   	ret
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046a0:	e8 5b f3 ff ff       	call   80103a00 <mycpu>
801046a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046ab:	85 c0                	test   %eax,%eax
801046ad:	74 eb                	je     8010469a <popcli+0x2a>
  asm volatile("sti");
801046af:	fb                   	sti
}
801046b0:	c9                   	leave
801046b1:	c3                   	ret
    panic("popcli - interruptible");
801046b2:	83 ec 0c             	sub    $0xc,%esp
801046b5:	68 30 7d 10 80       	push   $0x80107d30
801046ba:	e8 c1 bc ff ff       	call   80100380 <panic>
    panic("popcli");
801046bf:	83 ec 0c             	sub    $0xc,%esp
801046c2:	68 47 7d 10 80       	push   $0x80107d47
801046c7:	e8 b4 bc ff ff       	call   80100380 <panic>
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046d0 <holding>:
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 75 08             	mov    0x8(%ebp),%esi
801046d8:	31 db                	xor    %ebx,%ebx
  pushcli();
801046da:	e8 41 ff ff ff       	call   80104620 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801046df:	8b 06                	mov    (%esi),%eax
801046e1:	85 c0                	test   %eax,%eax
801046e3:	75 0b                	jne    801046f0 <holding+0x20>
  popcli();
801046e5:	e8 86 ff ff ff       	call   80104670 <popcli>
}
801046ea:	89 d8                	mov    %ebx,%eax
801046ec:	5b                   	pop    %ebx
801046ed:	5e                   	pop    %esi
801046ee:	5d                   	pop    %ebp
801046ef:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
801046f0:	8b 5e 08             	mov    0x8(%esi),%ebx
801046f3:	e8 08 f3 ff ff       	call   80103a00 <mycpu>
801046f8:	39 c3                	cmp    %eax,%ebx
801046fa:	0f 94 c3             	sete   %bl
  popcli();
801046fd:	e8 6e ff ff ff       	call   80104670 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104702:	0f b6 db             	movzbl %bl,%ebx
}
80104705:	89 d8                	mov    %ebx,%eax
80104707:	5b                   	pop    %ebx
80104708:	5e                   	pop    %esi
80104709:	5d                   	pop    %ebp
8010470a:	c3                   	ret
8010470b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104710 <release>:
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104718:	e8 03 ff ff ff       	call   80104620 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010471d:	8b 03                	mov    (%ebx),%eax
8010471f:	85 c0                	test   %eax,%eax
80104721:	75 15                	jne    80104738 <release+0x28>
  popcli();
80104723:	e8 48 ff ff ff       	call   80104670 <popcli>
    panic("release");
80104728:	83 ec 0c             	sub    $0xc,%esp
8010472b:	68 4e 7d 10 80       	push   $0x80107d4e
80104730:	e8 4b bc ff ff       	call   80100380 <panic>
80104735:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104738:	8b 73 08             	mov    0x8(%ebx),%esi
8010473b:	e8 c0 f2 ff ff       	call   80103a00 <mycpu>
80104740:	39 c6                	cmp    %eax,%esi
80104742:	75 df                	jne    80104723 <release+0x13>
  popcli();
80104744:	e8 27 ff ff ff       	call   80104670 <popcli>
  lk->pcs[0] = 0;
80104749:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104750:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104757:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010475c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104762:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104765:	5b                   	pop    %ebx
80104766:	5e                   	pop    %esi
80104767:	5d                   	pop    %ebp
  popcli();
80104768:	e9 03 ff ff ff       	jmp    80104670 <popcli>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi

80104770 <acquire>:
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104777:	e8 a4 fe ff ff       	call   80104620 <pushcli>
  if(holding(lk))
8010477c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010477f:	e8 9c fe ff ff       	call   80104620 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104784:	8b 03                	mov    (%ebx),%eax
80104786:	85 c0                	test   %eax,%eax
80104788:	0f 85 b2 00 00 00    	jne    80104840 <acquire+0xd0>
  popcli();
8010478e:	e8 dd fe ff ff       	call   80104670 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104793:	b9 01 00 00 00       	mov    $0x1,%ecx
80104798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010479f:	00 
  while(xchg(&lk->locked, 1) != 0)
801047a0:	8b 55 08             	mov    0x8(%ebp),%edx
801047a3:	89 c8                	mov    %ecx,%eax
801047a5:	f0 87 02             	lock xchg %eax,(%edx)
801047a8:	85 c0                	test   %eax,%eax
801047aa:	75 f4                	jne    801047a0 <acquire+0x30>
  __sync_synchronize();
801047ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801047b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047b4:	e8 47 f2 ff ff       	call   80103a00 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801047b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801047bc:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801047be:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047c1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801047c7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801047cc:	77 32                	ja     80104800 <acquire+0x90>
  ebp = (uint*)v - 2;
801047ce:	89 e8                	mov    %ebp,%eax
801047d0:	eb 14                	jmp    801047e6 <acquire+0x76>
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047d8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801047de:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047e4:	77 1a                	ja     80104800 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801047e6:	8b 58 04             	mov    0x4(%eax),%ebx
801047e9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801047ed:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801047f0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801047f2:	83 fa 0a             	cmp    $0xa,%edx
801047f5:	75 e1                	jne    801047d8 <acquire+0x68>
}
801047f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047fa:	c9                   	leave
801047fb:	c3                   	ret
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104800:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104804:	83 c1 34             	add    $0x34,%ecx
80104807:	89 ca                	mov    %ecx,%edx
80104809:	29 c2                	sub    %eax,%edx
8010480b:	83 e2 04             	and    $0x4,%edx
8010480e:	74 10                	je     80104820 <acquire+0xb0>
    pcs[i] = 0;
80104810:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104816:	83 c0 04             	add    $0x4,%eax
80104819:	39 c1                	cmp    %eax,%ecx
8010481b:	74 da                	je     801047f7 <acquire+0x87>
8010481d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104820:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104826:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104829:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104830:	39 c1                	cmp    %eax,%ecx
80104832:	75 ec                	jne    80104820 <acquire+0xb0>
80104834:	eb c1                	jmp    801047f7 <acquire+0x87>
80104836:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010483d:	00 
8010483e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104840:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104843:	e8 b8 f1 ff ff       	call   80103a00 <mycpu>
80104848:	39 c3                	cmp    %eax,%ebx
8010484a:	0f 85 3e ff ff ff    	jne    8010478e <acquire+0x1e>
  popcli();
80104850:	e8 1b fe ff ff       	call   80104670 <popcli>
    panic("acquire");
80104855:	83 ec 0c             	sub    $0xc,%esp
80104858:	68 56 7d 10 80       	push   $0x80107d56
8010485d:	e8 1e bb ff ff       	call   80100380 <panic>
80104862:	66 90                	xchg   %ax,%ax
80104864:	66 90                	xchg   %ax,%ax
80104866:	66 90                	xchg   %ax,%ax
80104868:	66 90                	xchg   %ax,%ax
8010486a:	66 90                	xchg   %ax,%ax
8010486c:	66 90                	xchg   %ax,%ax
8010486e:	66 90                	xchg   %ax,%ax

80104870 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	8b 55 08             	mov    0x8(%ebp),%edx
80104877:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010487a:	89 d0                	mov    %edx,%eax
8010487c:	09 c8                	or     %ecx,%eax
8010487e:	a8 03                	test   $0x3,%al
80104880:	75 1e                	jne    801048a0 <memset+0x30>
    c &= 0xFF;
80104882:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104886:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104889:	89 d7                	mov    %edx,%edi
8010488b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104891:	fc                   	cld
80104892:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104894:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104897:	89 d0                	mov    %edx,%eax
80104899:	c9                   	leave
8010489a:	c3                   	ret
8010489b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801048a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801048a3:	89 d7                	mov    %edx,%edi
801048a5:	fc                   	cld
801048a6:	f3 aa                	rep stos %al,%es:(%edi)
801048a8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801048ab:	89 d0                	mov    %edx,%eax
801048ad:	c9                   	leave
801048ae:	c3                   	ret
801048af:	90                   	nop

801048b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	8b 75 10             	mov    0x10(%ebp),%esi
801048b7:	8b 45 08             	mov    0x8(%ebp),%eax
801048ba:	53                   	push   %ebx
801048bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801048be:	85 f6                	test   %esi,%esi
801048c0:	74 2e                	je     801048f0 <memcmp+0x40>
801048c2:	01 c6                	add    %eax,%esi
801048c4:	eb 14                	jmp    801048da <memcmp+0x2a>
801048c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048cd:	00 
801048ce:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801048d0:	83 c0 01             	add    $0x1,%eax
801048d3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801048d6:	39 f0                	cmp    %esi,%eax
801048d8:	74 16                	je     801048f0 <memcmp+0x40>
    if(*s1 != *s2)
801048da:	0f b6 08             	movzbl (%eax),%ecx
801048dd:	0f b6 1a             	movzbl (%edx),%ebx
801048e0:	38 d9                	cmp    %bl,%cl
801048e2:	74 ec                	je     801048d0 <memcmp+0x20>
      return *s1 - *s2;
801048e4:	0f b6 c1             	movzbl %cl,%eax
801048e7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801048e9:	5b                   	pop    %ebx
801048ea:	5e                   	pop    %esi
801048eb:	5d                   	pop    %ebp
801048ec:	c3                   	ret
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
801048f0:	5b                   	pop    %ebx
  return 0;
801048f1:	31 c0                	xor    %eax,%eax
}
801048f3:	5e                   	pop    %esi
801048f4:	5d                   	pop    %ebp
801048f5:	c3                   	ret
801048f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048fd:	00 
801048fe:	66 90                	xchg   %ax,%ax

80104900 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	8b 55 08             	mov    0x8(%ebp),%edx
80104907:	8b 45 10             	mov    0x10(%ebp),%eax
8010490a:	56                   	push   %esi
8010490b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010490e:	39 d6                	cmp    %edx,%esi
80104910:	73 26                	jae    80104938 <memmove+0x38>
80104912:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104915:	39 ca                	cmp    %ecx,%edx
80104917:	73 1f                	jae    80104938 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104919:	85 c0                	test   %eax,%eax
8010491b:	74 0f                	je     8010492c <memmove+0x2c>
8010491d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104920:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104924:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104927:	83 e8 01             	sub    $0x1,%eax
8010492a:	73 f4                	jae    80104920 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010492c:	5e                   	pop    %esi
8010492d:	89 d0                	mov    %edx,%eax
8010492f:	5f                   	pop    %edi
80104930:	5d                   	pop    %ebp
80104931:	c3                   	ret
80104932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104938:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010493b:	89 d7                	mov    %edx,%edi
8010493d:	85 c0                	test   %eax,%eax
8010493f:	74 eb                	je     8010492c <memmove+0x2c>
80104941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104948:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104949:	39 ce                	cmp    %ecx,%esi
8010494b:	75 fb                	jne    80104948 <memmove+0x48>
}
8010494d:	5e                   	pop    %esi
8010494e:	89 d0                	mov    %edx,%eax
80104950:	5f                   	pop    %edi
80104951:	5d                   	pop    %ebp
80104952:	c3                   	ret
80104953:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010495a:	00 
8010495b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104960 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104960:	eb 9e                	jmp    80104900 <memmove>
80104962:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104969:	00 
8010496a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104970 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	8b 55 10             	mov    0x10(%ebp),%edx
80104977:	8b 45 08             	mov    0x8(%ebp),%eax
8010497a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010497d:	85 d2                	test   %edx,%edx
8010497f:	75 16                	jne    80104997 <strncmp+0x27>
80104981:	eb 2d                	jmp    801049b0 <strncmp+0x40>
80104983:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104988:	3a 19                	cmp    (%ecx),%bl
8010498a:	75 12                	jne    8010499e <strncmp+0x2e>
    n--, p++, q++;
8010498c:	83 c0 01             	add    $0x1,%eax
8010498f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104992:	83 ea 01             	sub    $0x1,%edx
80104995:	74 19                	je     801049b0 <strncmp+0x40>
80104997:	0f b6 18             	movzbl (%eax),%ebx
8010499a:	84 db                	test   %bl,%bl
8010499c:	75 ea                	jne    80104988 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010499e:	0f b6 00             	movzbl (%eax),%eax
801049a1:	0f b6 11             	movzbl (%ecx),%edx
}
801049a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049a7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801049a8:	29 d0                	sub    %edx,%eax
}
801049aa:	c3                   	ret
801049ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801049b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801049b3:	31 c0                	xor    %eax,%eax
}
801049b5:	c9                   	leave
801049b6:	c3                   	ret
801049b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049be:	00 
801049bf:	90                   	nop

801049c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	57                   	push   %edi
801049c4:	56                   	push   %esi
801049c5:	8b 75 08             	mov    0x8(%ebp),%esi
801049c8:	53                   	push   %ebx
801049c9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801049cc:	89 f0                	mov    %esi,%eax
801049ce:	eb 15                	jmp    801049e5 <strncpy+0x25>
801049d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801049d4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801049d7:	83 c0 01             	add    $0x1,%eax
801049da:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801049de:	88 48 ff             	mov    %cl,-0x1(%eax)
801049e1:	84 c9                	test   %cl,%cl
801049e3:	74 13                	je     801049f8 <strncpy+0x38>
801049e5:	89 d3                	mov    %edx,%ebx
801049e7:	83 ea 01             	sub    $0x1,%edx
801049ea:	85 db                	test   %ebx,%ebx
801049ec:	7f e2                	jg     801049d0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
801049ee:	5b                   	pop    %ebx
801049ef:	89 f0                	mov    %esi,%eax
801049f1:	5e                   	pop    %esi
801049f2:	5f                   	pop    %edi
801049f3:	5d                   	pop    %ebp
801049f4:	c3                   	ret
801049f5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
801049f8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801049fb:	83 e9 01             	sub    $0x1,%ecx
801049fe:	85 d2                	test   %edx,%edx
80104a00:	74 ec                	je     801049ee <strncpy+0x2e>
80104a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104a08:	83 c0 01             	add    $0x1,%eax
80104a0b:	89 ca                	mov    %ecx,%edx
80104a0d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104a11:	29 c2                	sub    %eax,%edx
80104a13:	85 d2                	test   %edx,%edx
80104a15:	7f f1                	jg     80104a08 <strncpy+0x48>
}
80104a17:	5b                   	pop    %ebx
80104a18:	89 f0                	mov    %esi,%eax
80104a1a:	5e                   	pop    %esi
80104a1b:	5f                   	pop    %edi
80104a1c:	5d                   	pop    %ebp
80104a1d:	c3                   	ret
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	8b 55 10             	mov    0x10(%ebp),%edx
80104a27:	8b 75 08             	mov    0x8(%ebp),%esi
80104a2a:	53                   	push   %ebx
80104a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104a2e:	85 d2                	test   %edx,%edx
80104a30:	7e 25                	jle    80104a57 <safestrcpy+0x37>
80104a32:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104a36:	89 f2                	mov    %esi,%edx
80104a38:	eb 16                	jmp    80104a50 <safestrcpy+0x30>
80104a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a40:	0f b6 08             	movzbl (%eax),%ecx
80104a43:	83 c0 01             	add    $0x1,%eax
80104a46:	83 c2 01             	add    $0x1,%edx
80104a49:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a4c:	84 c9                	test   %cl,%cl
80104a4e:	74 04                	je     80104a54 <safestrcpy+0x34>
80104a50:	39 d8                	cmp    %ebx,%eax
80104a52:	75 ec                	jne    80104a40 <safestrcpy+0x20>
    ;
  *s = 0;
80104a54:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104a57:	89 f0                	mov    %esi,%eax
80104a59:	5b                   	pop    %ebx
80104a5a:	5e                   	pop    %esi
80104a5b:	5d                   	pop    %ebp
80104a5c:	c3                   	ret
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <strlen>:

int
strlen(const char *s)
{
80104a60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104a61:	31 c0                	xor    %eax,%eax
{
80104a63:	89 e5                	mov    %esp,%ebp
80104a65:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104a68:	80 3a 00             	cmpb   $0x0,(%edx)
80104a6b:	74 0c                	je     80104a79 <strlen+0x19>
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi
80104a70:	83 c0 01             	add    $0x1,%eax
80104a73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a77:	75 f7                	jne    80104a70 <strlen+0x10>
    ;
  return n;
}
80104a79:	5d                   	pop    %ebp
80104a7a:	c3                   	ret

80104a7b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104a7b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104a7f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104a83:	55                   	push   %ebp
  pushl %ebx
80104a84:	53                   	push   %ebx
  pushl %esi
80104a85:	56                   	push   %esi
  pushl %edi
80104a86:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104a87:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104a89:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104a8b:	5f                   	pop    %edi
  popl %esi
80104a8c:	5e                   	pop    %esi
  popl %ebx
80104a8d:	5b                   	pop    %ebx
  popl %ebp
80104a8e:	5d                   	pop    %ebp
  ret
80104a8f:	c3                   	ret

80104a90 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	53                   	push   %ebx
80104a94:	83 ec 04             	sub    $0x4,%esp
80104a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104a9a:	e8 e1 ef ff ff       	call   80103a80 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a9f:	8b 00                	mov    (%eax),%eax
80104aa1:	39 c3                	cmp    %eax,%ebx
80104aa3:	73 1b                	jae    80104ac0 <fetchint+0x30>
80104aa5:	8d 53 04             	lea    0x4(%ebx),%edx
80104aa8:	39 d0                	cmp    %edx,%eax
80104aaa:	72 14                	jb     80104ac0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104aac:	8b 45 0c             	mov    0xc(%ebp),%eax
80104aaf:	8b 13                	mov    (%ebx),%edx
80104ab1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ab3:	31 c0                	xor    %eax,%eax
}
80104ab5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ab8:	c9                   	leave
80104ab9:	c3                   	ret
80104aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ac5:	eb ee                	jmp    80104ab5 <fetchint+0x25>
80104ac7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ace:	00 
80104acf:	90                   	nop

80104ad0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 04             	sub    $0x4,%esp
80104ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104ada:	e8 a1 ef ff ff       	call   80103a80 <myproc>

  if(addr >= curproc->sz)
80104adf:	3b 18                	cmp    (%eax),%ebx
80104ae1:	73 2d                	jae    80104b10 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104ae3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ae6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104ae8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104aea:	39 d3                	cmp    %edx,%ebx
80104aec:	73 22                	jae    80104b10 <fetchstr+0x40>
80104aee:	89 d8                	mov    %ebx,%eax
80104af0:	eb 0d                	jmp    80104aff <fetchstr+0x2f>
80104af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104af8:	83 c0 01             	add    $0x1,%eax
80104afb:	39 d0                	cmp    %edx,%eax
80104afd:	73 11                	jae    80104b10 <fetchstr+0x40>
    if(*s == 0)
80104aff:	80 38 00             	cmpb   $0x0,(%eax)
80104b02:	75 f4                	jne    80104af8 <fetchstr+0x28>
      return s - *pp;
80104b04:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104b06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b09:	c9                   	leave
80104b0a:	c3                   	ret
80104b0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104b13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b18:	c9                   	leave
80104b19:	c3                   	ret
80104b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	56                   	push   %esi
80104b24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b25:	e8 56 ef ff ff       	call   80103a80 <myproc>
80104b2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b2d:	8b 40 18             	mov    0x18(%eax),%eax
80104b30:	8b 40 44             	mov    0x44(%eax),%eax
80104b33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b36:	e8 45 ef ff ff       	call   80103a80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b3b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b3e:	8b 00                	mov    (%eax),%eax
80104b40:	39 c6                	cmp    %eax,%esi
80104b42:	73 1c                	jae    80104b60 <argint+0x40>
80104b44:	8d 53 08             	lea    0x8(%ebx),%edx
80104b47:	39 d0                	cmp    %edx,%eax
80104b49:	72 15                	jb     80104b60 <argint+0x40>
  *ip = *(int*)(addr);
80104b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b51:	89 10                	mov    %edx,(%eax)
  return 0;
80104b53:	31 c0                	xor    %eax,%eax
}
80104b55:	5b                   	pop    %ebx
80104b56:	5e                   	pop    %esi
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b65:	eb ee                	jmp    80104b55 <argint+0x35>
80104b67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b6e:	00 
80104b6f:	90                   	nop

80104b70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	57                   	push   %edi
80104b74:	56                   	push   %esi
80104b75:	53                   	push   %ebx
80104b76:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104b79:	e8 02 ef ff ff       	call   80103a80 <myproc>
80104b7e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b80:	e8 fb ee ff ff       	call   80103a80 <myproc>
80104b85:	8b 55 08             	mov    0x8(%ebp),%edx
80104b88:	8b 40 18             	mov    0x18(%eax),%eax
80104b8b:	8b 40 44             	mov    0x44(%eax),%eax
80104b8e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b91:	e8 ea ee ff ff       	call   80103a80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b96:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b99:	8b 00                	mov    (%eax),%eax
80104b9b:	39 c7                	cmp    %eax,%edi
80104b9d:	73 31                	jae    80104bd0 <argptr+0x60>
80104b9f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104ba2:	39 c8                	cmp    %ecx,%eax
80104ba4:	72 2a                	jb     80104bd0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ba6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104ba9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104bac:	85 d2                	test   %edx,%edx
80104bae:	78 20                	js     80104bd0 <argptr+0x60>
80104bb0:	8b 16                	mov    (%esi),%edx
80104bb2:	39 d0                	cmp    %edx,%eax
80104bb4:	73 1a                	jae    80104bd0 <argptr+0x60>
80104bb6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104bb9:	01 c3                	add    %eax,%ebx
80104bbb:	39 da                	cmp    %ebx,%edx
80104bbd:	72 11                	jb     80104bd0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104bbf:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bc2:	89 02                	mov    %eax,(%edx)
  return 0;
80104bc4:	31 c0                	xor    %eax,%eax
}
80104bc6:	83 c4 0c             	add    $0xc,%esp
80104bc9:	5b                   	pop    %ebx
80104bca:	5e                   	pop    %esi
80104bcb:	5f                   	pop    %edi
80104bcc:	5d                   	pop    %ebp
80104bcd:	c3                   	ret
80104bce:	66 90                	xchg   %ax,%ax
    return -1;
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bd5:	eb ef                	jmp    80104bc6 <argptr+0x56>
80104bd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bde:	00 
80104bdf:	90                   	nop

80104be0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	56                   	push   %esi
80104be4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104be5:	e8 96 ee ff ff       	call   80103a80 <myproc>
80104bea:	8b 55 08             	mov    0x8(%ebp),%edx
80104bed:	8b 40 18             	mov    0x18(%eax),%eax
80104bf0:	8b 40 44             	mov    0x44(%eax),%eax
80104bf3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104bf6:	e8 85 ee ff ff       	call   80103a80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bfb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104bfe:	8b 00                	mov    (%eax),%eax
80104c00:	39 c6                	cmp    %eax,%esi
80104c02:	73 44                	jae    80104c48 <argstr+0x68>
80104c04:	8d 53 08             	lea    0x8(%ebx),%edx
80104c07:	39 d0                	cmp    %edx,%eax
80104c09:	72 3d                	jb     80104c48 <argstr+0x68>
  *ip = *(int*)(addr);
80104c0b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104c0e:	e8 6d ee ff ff       	call   80103a80 <myproc>
  if(addr >= curproc->sz)
80104c13:	3b 18                	cmp    (%eax),%ebx
80104c15:	73 31                	jae    80104c48 <argstr+0x68>
  *pp = (char*)addr;
80104c17:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c1a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104c1c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104c1e:	39 d3                	cmp    %edx,%ebx
80104c20:	73 26                	jae    80104c48 <argstr+0x68>
80104c22:	89 d8                	mov    %ebx,%eax
80104c24:	eb 11                	jmp    80104c37 <argstr+0x57>
80104c26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c2d:	00 
80104c2e:	66 90                	xchg   %ax,%ax
80104c30:	83 c0 01             	add    $0x1,%eax
80104c33:	39 d0                	cmp    %edx,%eax
80104c35:	73 11                	jae    80104c48 <argstr+0x68>
    if(*s == 0)
80104c37:	80 38 00             	cmpb   $0x0,(%eax)
80104c3a:	75 f4                	jne    80104c30 <argstr+0x50>
      return s - *pp;
80104c3c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104c3e:	5b                   	pop    %ebx
80104c3f:	5e                   	pop    %esi
80104c40:	5d                   	pop    %ebp
80104c41:	c3                   	ret
80104c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c48:	5b                   	pop    %ebx
    return -1;
80104c49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c4e:	5e                   	pop    %esi
80104c4f:	5d                   	pop    %ebp
80104c50:	c3                   	ret
80104c51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c58:	00 
80104c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c60 <syscall>:
[SYS_twostrike]   sys_twostrike,
};

void
syscall(void)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	53                   	push   %ebx
80104c64:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104c67:	e8 14 ee ff ff       	call   80103a80 <myproc>
80104c6c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104c6e:	8b 40 18             	mov    0x18(%eax),%eax
80104c71:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c74:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c77:	83 fa 22             	cmp    $0x22,%edx
80104c7a:	77 24                	ja     80104ca0 <syscall+0x40>
80104c7c:	8b 14 85 a0 83 10 80 	mov    -0x7fef7c60(,%eax,4),%edx
80104c83:	85 d2                	test   %edx,%edx
80104c85:	74 19                	je     80104ca0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104c87:	ff d2                	call   *%edx
80104c89:	89 c2                	mov    %eax,%edx
80104c8b:	8b 43 18             	mov    0x18(%ebx),%eax
80104c8e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c94:	c9                   	leave
80104c95:	c3                   	ret
80104c96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c9d:	00 
80104c9e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104ca0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ca1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ca4:	50                   	push   %eax
80104ca5:	ff 73 10             	push   0x10(%ebx)
80104ca8:	68 5e 7d 10 80       	push   $0x80107d5e
80104cad:	e8 fe b9 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104cb2:	8b 43 18             	mov    0x18(%ebx),%eax
80104cb5:	83 c4 10             	add    $0x10,%esp
80104cb8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104cbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cc2:	c9                   	leave
80104cc3:	c3                   	ret
80104cc4:	66 90                	xchg   %ax,%ax
80104cc6:	66 90                	xchg   %ax,%ax
80104cc8:	66 90                	xchg   %ax,%ax
80104cca:	66 90                	xchg   %ax,%ax
80104ccc:	66 90                	xchg   %ax,%ax
80104cce:	66 90                	xchg   %ax,%ax

80104cd0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	57                   	push   %edi
80104cd4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104cd5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104cd8:	53                   	push   %ebx
80104cd9:	83 ec 34             	sub    $0x34,%esp
80104cdc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104cdf:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104ce2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104ce5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104ce8:	57                   	push   %edi
80104ce9:	50                   	push   %eax
80104cea:	e8 71 d4 ff ff       	call   80102160 <nameiparent>
80104cef:	83 c4 10             	add    $0x10,%esp
80104cf2:	85 c0                	test   %eax,%eax
80104cf4:	74 5e                	je     80104d54 <create+0x84>
    return 0;
  ilock(dp);
80104cf6:	83 ec 0c             	sub    $0xc,%esp
80104cf9:	89 c3                	mov    %eax,%ebx
80104cfb:	50                   	push   %eax
80104cfc:	e8 5f cb ff ff       	call   80101860 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104d01:	83 c4 0c             	add    $0xc,%esp
80104d04:	6a 00                	push   $0x0
80104d06:	57                   	push   %edi
80104d07:	53                   	push   %ebx
80104d08:	e8 a3 d0 ff ff       	call   80101db0 <dirlookup>
80104d0d:	83 c4 10             	add    $0x10,%esp
80104d10:	89 c6                	mov    %eax,%esi
80104d12:	85 c0                	test   %eax,%eax
80104d14:	74 4a                	je     80104d60 <create+0x90>
    iunlockput(dp);
80104d16:	83 ec 0c             	sub    $0xc,%esp
80104d19:	53                   	push   %ebx
80104d1a:	e8 d1 cd ff ff       	call   80101af0 <iunlockput>
    ilock(ip);
80104d1f:	89 34 24             	mov    %esi,(%esp)
80104d22:	e8 39 cb ff ff       	call   80101860 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104d27:	83 c4 10             	add    $0x10,%esp
80104d2a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104d2f:	75 17                	jne    80104d48 <create+0x78>
80104d31:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104d36:	75 10                	jne    80104d48 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d3b:	89 f0                	mov    %esi,%eax
80104d3d:	5b                   	pop    %ebx
80104d3e:	5e                   	pop    %esi
80104d3f:	5f                   	pop    %edi
80104d40:	5d                   	pop    %ebp
80104d41:	c3                   	ret
80104d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104d48:	83 ec 0c             	sub    $0xc,%esp
80104d4b:	56                   	push   %esi
80104d4c:	e8 9f cd ff ff       	call   80101af0 <iunlockput>
    return 0;
80104d51:	83 c4 10             	add    $0x10,%esp
}
80104d54:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104d57:	31 f6                	xor    %esi,%esi
}
80104d59:	5b                   	pop    %ebx
80104d5a:	89 f0                	mov    %esi,%eax
80104d5c:	5e                   	pop    %esi
80104d5d:	5f                   	pop    %edi
80104d5e:	5d                   	pop    %ebp
80104d5f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104d60:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104d64:	83 ec 08             	sub    $0x8,%esp
80104d67:	50                   	push   %eax
80104d68:	ff 33                	push   (%ebx)
80104d6a:	e8 81 c9 ff ff       	call   801016f0 <ialloc>
80104d6f:	83 c4 10             	add    $0x10,%esp
80104d72:	89 c6                	mov    %eax,%esi
80104d74:	85 c0                	test   %eax,%eax
80104d76:	0f 84 bc 00 00 00    	je     80104e38 <create+0x168>
  ilock(ip);
80104d7c:	83 ec 0c             	sub    $0xc,%esp
80104d7f:	50                   	push   %eax
80104d80:	e8 db ca ff ff       	call   80101860 <ilock>
  ip->major = major;
80104d85:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104d89:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104d8d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104d91:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104d95:	b8 01 00 00 00       	mov    $0x1,%eax
80104d9a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104d9e:	89 34 24             	mov    %esi,(%esp)
80104da1:	e8 0a ca ff ff       	call   801017b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104da6:	83 c4 10             	add    $0x10,%esp
80104da9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104dae:	74 30                	je     80104de0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104db0:	83 ec 04             	sub    $0x4,%esp
80104db3:	ff 76 04             	push   0x4(%esi)
80104db6:	57                   	push   %edi
80104db7:	53                   	push   %ebx
80104db8:	e8 c3 d2 ff ff       	call   80102080 <dirlink>
80104dbd:	83 c4 10             	add    $0x10,%esp
80104dc0:	85 c0                	test   %eax,%eax
80104dc2:	78 67                	js     80104e2b <create+0x15b>
  iunlockput(dp);
80104dc4:	83 ec 0c             	sub    $0xc,%esp
80104dc7:	53                   	push   %ebx
80104dc8:	e8 23 cd ff ff       	call   80101af0 <iunlockput>
  return ip;
80104dcd:	83 c4 10             	add    $0x10,%esp
}
80104dd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dd3:	89 f0                	mov    %esi,%eax
80104dd5:	5b                   	pop    %ebx
80104dd6:	5e                   	pop    %esi
80104dd7:	5f                   	pop    %edi
80104dd8:	5d                   	pop    %ebp
80104dd9:	c3                   	ret
80104dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104de0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104de3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104de8:	53                   	push   %ebx
80104de9:	e8 c2 c9 ff ff       	call   801017b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104dee:	83 c4 0c             	add    $0xc,%esp
80104df1:	ff 76 04             	push   0x4(%esi)
80104df4:	68 96 7d 10 80       	push   $0x80107d96
80104df9:	56                   	push   %esi
80104dfa:	e8 81 d2 ff ff       	call   80102080 <dirlink>
80104dff:	83 c4 10             	add    $0x10,%esp
80104e02:	85 c0                	test   %eax,%eax
80104e04:	78 18                	js     80104e1e <create+0x14e>
80104e06:	83 ec 04             	sub    $0x4,%esp
80104e09:	ff 73 04             	push   0x4(%ebx)
80104e0c:	68 95 7d 10 80       	push   $0x80107d95
80104e11:	56                   	push   %esi
80104e12:	e8 69 d2 ff ff       	call   80102080 <dirlink>
80104e17:	83 c4 10             	add    $0x10,%esp
80104e1a:	85 c0                	test   %eax,%eax
80104e1c:	79 92                	jns    80104db0 <create+0xe0>
      panic("create dots");
80104e1e:	83 ec 0c             	sub    $0xc,%esp
80104e21:	68 89 7d 10 80       	push   $0x80107d89
80104e26:	e8 55 b5 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104e2b:	83 ec 0c             	sub    $0xc,%esp
80104e2e:	68 98 7d 10 80       	push   $0x80107d98
80104e33:	e8 48 b5 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104e38:	83 ec 0c             	sub    $0xc,%esp
80104e3b:	68 7a 7d 10 80       	push   $0x80107d7a
80104e40:	e8 3b b5 ff ff       	call   80100380 <panic>
80104e45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e4c:	00 
80104e4d:	8d 76 00             	lea    0x0(%esi),%esi

80104e50 <sys_dup>:
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	56                   	push   %esi
80104e54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e55:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104e58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e5b:	50                   	push   %eax
80104e5c:	6a 00                	push   $0x0
80104e5e:	e8 bd fc ff ff       	call   80104b20 <argint>
80104e63:	83 c4 10             	add    $0x10,%esp
80104e66:	85 c0                	test   %eax,%eax
80104e68:	78 36                	js     80104ea0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e6e:	77 30                	ja     80104ea0 <sys_dup+0x50>
80104e70:	e8 0b ec ff ff       	call   80103a80 <myproc>
80104e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e7c:	85 f6                	test   %esi,%esi
80104e7e:	74 20                	je     80104ea0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104e80:	e8 fb eb ff ff       	call   80103a80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104e85:	31 db                	xor    %ebx,%ebx
80104e87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e8e:	00 
80104e8f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104e90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104e94:	85 d2                	test   %edx,%edx
80104e96:	74 18                	je     80104eb0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104e98:	83 c3 01             	add    $0x1,%ebx
80104e9b:	83 fb 10             	cmp    $0x10,%ebx
80104e9e:	75 f0                	jne    80104e90 <sys_dup+0x40>
}
80104ea0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104ea3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104ea8:	89 d8                	mov    %ebx,%eax
80104eaa:	5b                   	pop    %ebx
80104eab:	5e                   	pop    %esi
80104eac:	5d                   	pop    %ebp
80104ead:	c3                   	ret
80104eae:	66 90                	xchg   %ax,%ax
  filedup(f);
80104eb0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104eb3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104eb7:	56                   	push   %esi
80104eb8:	e8 c3 c0 ff ff       	call   80100f80 <filedup>
  return fd;
80104ebd:	83 c4 10             	add    $0x10,%esp
}
80104ec0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ec3:	89 d8                	mov    %ebx,%eax
80104ec5:	5b                   	pop    %ebx
80104ec6:	5e                   	pop    %esi
80104ec7:	5d                   	pop    %ebp
80104ec8:	c3                   	ret
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ed0 <sys_read>:
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104ed5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104ed8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104edb:	53                   	push   %ebx
80104edc:	6a 00                	push   $0x0
80104ede:	e8 3d fc ff ff       	call   80104b20 <argint>
80104ee3:	83 c4 10             	add    $0x10,%esp
80104ee6:	85 c0                	test   %eax,%eax
80104ee8:	78 5e                	js     80104f48 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104eee:	77 58                	ja     80104f48 <sys_read+0x78>
80104ef0:	e8 8b eb ff ff       	call   80103a80 <myproc>
80104ef5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ef8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104efc:	85 f6                	test   %esi,%esi
80104efe:	74 48                	je     80104f48 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f00:	83 ec 08             	sub    $0x8,%esp
80104f03:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f06:	50                   	push   %eax
80104f07:	6a 02                	push   $0x2
80104f09:	e8 12 fc ff ff       	call   80104b20 <argint>
80104f0e:	83 c4 10             	add    $0x10,%esp
80104f11:	85 c0                	test   %eax,%eax
80104f13:	78 33                	js     80104f48 <sys_read+0x78>
80104f15:	83 ec 04             	sub    $0x4,%esp
80104f18:	ff 75 f0             	push   -0x10(%ebp)
80104f1b:	53                   	push   %ebx
80104f1c:	6a 01                	push   $0x1
80104f1e:	e8 4d fc ff ff       	call   80104b70 <argptr>
80104f23:	83 c4 10             	add    $0x10,%esp
80104f26:	85 c0                	test   %eax,%eax
80104f28:	78 1e                	js     80104f48 <sys_read+0x78>
  return fileread(f, p, n);
80104f2a:	83 ec 04             	sub    $0x4,%esp
80104f2d:	ff 75 f0             	push   -0x10(%ebp)
80104f30:	ff 75 f4             	push   -0xc(%ebp)
80104f33:	56                   	push   %esi
80104f34:	e8 c7 c1 ff ff       	call   80101100 <fileread>
80104f39:	83 c4 10             	add    $0x10,%esp
}
80104f3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f3f:	5b                   	pop    %ebx
80104f40:	5e                   	pop    %esi
80104f41:	5d                   	pop    %ebp
80104f42:	c3                   	ret
80104f43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104f48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f4d:	eb ed                	jmp    80104f3c <sys_read+0x6c>
80104f4f:	90                   	nop

80104f50 <sys_write>:
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	56                   	push   %esi
80104f54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f55:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f5b:	53                   	push   %ebx
80104f5c:	6a 00                	push   $0x0
80104f5e:	e8 bd fb ff ff       	call   80104b20 <argint>
80104f63:	83 c4 10             	add    $0x10,%esp
80104f66:	85 c0                	test   %eax,%eax
80104f68:	78 5e                	js     80104fc8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f6e:	77 58                	ja     80104fc8 <sys_write+0x78>
80104f70:	e8 0b eb ff ff       	call   80103a80 <myproc>
80104f75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f7c:	85 f6                	test   %esi,%esi
80104f7e:	74 48                	je     80104fc8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f80:	83 ec 08             	sub    $0x8,%esp
80104f83:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f86:	50                   	push   %eax
80104f87:	6a 02                	push   $0x2
80104f89:	e8 92 fb ff ff       	call   80104b20 <argint>
80104f8e:	83 c4 10             	add    $0x10,%esp
80104f91:	85 c0                	test   %eax,%eax
80104f93:	78 33                	js     80104fc8 <sys_write+0x78>
80104f95:	83 ec 04             	sub    $0x4,%esp
80104f98:	ff 75 f0             	push   -0x10(%ebp)
80104f9b:	53                   	push   %ebx
80104f9c:	6a 01                	push   $0x1
80104f9e:	e8 cd fb ff ff       	call   80104b70 <argptr>
80104fa3:	83 c4 10             	add    $0x10,%esp
80104fa6:	85 c0                	test   %eax,%eax
80104fa8:	78 1e                	js     80104fc8 <sys_write+0x78>
  return filewrite(f, p, n);
80104faa:	83 ec 04             	sub    $0x4,%esp
80104fad:	ff 75 f0             	push   -0x10(%ebp)
80104fb0:	ff 75 f4             	push   -0xc(%ebp)
80104fb3:	56                   	push   %esi
80104fb4:	e8 d7 c1 ff ff       	call   80101190 <filewrite>
80104fb9:	83 c4 10             	add    $0x10,%esp
}
80104fbc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fbf:	5b                   	pop    %ebx
80104fc0:	5e                   	pop    %esi
80104fc1:	5d                   	pop    %ebp
80104fc2:	c3                   	ret
80104fc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fcd:	eb ed                	jmp    80104fbc <sys_write+0x6c>
80104fcf:	90                   	nop

80104fd0 <sys_close>:
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	56                   	push   %esi
80104fd4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104fd5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104fd8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104fdb:	50                   	push   %eax
80104fdc:	6a 00                	push   $0x0
80104fde:	e8 3d fb ff ff       	call   80104b20 <argint>
80104fe3:	83 c4 10             	add    $0x10,%esp
80104fe6:	85 c0                	test   %eax,%eax
80104fe8:	78 3e                	js     80105028 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104fea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104fee:	77 38                	ja     80105028 <sys_close+0x58>
80104ff0:	e8 8b ea ff ff       	call   80103a80 <myproc>
80104ff5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ff8:	8d 5a 08             	lea    0x8(%edx),%ebx
80104ffb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104fff:	85 f6                	test   %esi,%esi
80105001:	74 25                	je     80105028 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105003:	e8 78 ea ff ff       	call   80103a80 <myproc>
  fileclose(f);
80105008:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010500b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105012:	00 
  fileclose(f);
80105013:	56                   	push   %esi
80105014:	e8 b7 bf ff ff       	call   80100fd0 <fileclose>
  return 0;
80105019:	83 c4 10             	add    $0x10,%esp
8010501c:	31 c0                	xor    %eax,%eax
}
8010501e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105021:	5b                   	pop    %ebx
80105022:	5e                   	pop    %esi
80105023:	5d                   	pop    %ebp
80105024:	c3                   	ret
80105025:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010502d:	eb ef                	jmp    8010501e <sys_close+0x4e>
8010502f:	90                   	nop

80105030 <sys_fstat>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	56                   	push   %esi
80105034:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105035:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105038:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010503b:	53                   	push   %ebx
8010503c:	6a 00                	push   $0x0
8010503e:	e8 dd fa ff ff       	call   80104b20 <argint>
80105043:	83 c4 10             	add    $0x10,%esp
80105046:	85 c0                	test   %eax,%eax
80105048:	78 46                	js     80105090 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010504a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010504e:	77 40                	ja     80105090 <sys_fstat+0x60>
80105050:	e8 2b ea ff ff       	call   80103a80 <myproc>
80105055:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105058:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010505c:	85 f6                	test   %esi,%esi
8010505e:	74 30                	je     80105090 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105060:	83 ec 04             	sub    $0x4,%esp
80105063:	6a 14                	push   $0x14
80105065:	53                   	push   %ebx
80105066:	6a 01                	push   $0x1
80105068:	e8 03 fb ff ff       	call   80104b70 <argptr>
8010506d:	83 c4 10             	add    $0x10,%esp
80105070:	85 c0                	test   %eax,%eax
80105072:	78 1c                	js     80105090 <sys_fstat+0x60>
  return filestat(f, st);
80105074:	83 ec 08             	sub    $0x8,%esp
80105077:	ff 75 f4             	push   -0xc(%ebp)
8010507a:	56                   	push   %esi
8010507b:	e8 30 c0 ff ff       	call   801010b0 <filestat>
80105080:	83 c4 10             	add    $0x10,%esp
}
80105083:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105086:	5b                   	pop    %ebx
80105087:	5e                   	pop    %esi
80105088:	5d                   	pop    %ebp
80105089:	c3                   	ret
8010508a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105095:	eb ec                	jmp    80105083 <sys_fstat+0x53>
80105097:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010509e:	00 
8010509f:	90                   	nop

801050a0 <sys_link>:
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	57                   	push   %edi
801050a4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050a5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801050a8:	53                   	push   %ebx
801050a9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050ac:	50                   	push   %eax
801050ad:	6a 00                	push   $0x0
801050af:	e8 2c fb ff ff       	call   80104be0 <argstr>
801050b4:	83 c4 10             	add    $0x10,%esp
801050b7:	85 c0                	test   %eax,%eax
801050b9:	0f 88 fb 00 00 00    	js     801051ba <sys_link+0x11a>
801050bf:	83 ec 08             	sub    $0x8,%esp
801050c2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050c5:	50                   	push   %eax
801050c6:	6a 01                	push   $0x1
801050c8:	e8 13 fb ff ff       	call   80104be0 <argstr>
801050cd:	83 c4 10             	add    $0x10,%esp
801050d0:	85 c0                	test   %eax,%eax
801050d2:	0f 88 e2 00 00 00    	js     801051ba <sys_link+0x11a>
  begin_op();
801050d8:	e8 23 dd ff ff       	call   80102e00 <begin_op>
  if((ip = namei(old)) == 0){
801050dd:	83 ec 0c             	sub    $0xc,%esp
801050e0:	ff 75 d4             	push   -0x2c(%ebp)
801050e3:	e8 58 d0 ff ff       	call   80102140 <namei>
801050e8:	83 c4 10             	add    $0x10,%esp
801050eb:	89 c3                	mov    %eax,%ebx
801050ed:	85 c0                	test   %eax,%eax
801050ef:	0f 84 df 00 00 00    	je     801051d4 <sys_link+0x134>
  ilock(ip);
801050f5:	83 ec 0c             	sub    $0xc,%esp
801050f8:	50                   	push   %eax
801050f9:	e8 62 c7 ff ff       	call   80101860 <ilock>
  if(ip->type == T_DIR){
801050fe:	83 c4 10             	add    $0x10,%esp
80105101:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105106:	0f 84 b5 00 00 00    	je     801051c1 <sys_link+0x121>
  iupdate(ip);
8010510c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010510f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105114:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105117:	53                   	push   %ebx
80105118:	e8 93 c6 ff ff       	call   801017b0 <iupdate>
  iunlock(ip);
8010511d:	89 1c 24             	mov    %ebx,(%esp)
80105120:	e8 1b c8 ff ff       	call   80101940 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105125:	58                   	pop    %eax
80105126:	5a                   	pop    %edx
80105127:	57                   	push   %edi
80105128:	ff 75 d0             	push   -0x30(%ebp)
8010512b:	e8 30 d0 ff ff       	call   80102160 <nameiparent>
80105130:	83 c4 10             	add    $0x10,%esp
80105133:	89 c6                	mov    %eax,%esi
80105135:	85 c0                	test   %eax,%eax
80105137:	74 5b                	je     80105194 <sys_link+0xf4>
  ilock(dp);
80105139:	83 ec 0c             	sub    $0xc,%esp
8010513c:	50                   	push   %eax
8010513d:	e8 1e c7 ff ff       	call   80101860 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105142:	8b 03                	mov    (%ebx),%eax
80105144:	83 c4 10             	add    $0x10,%esp
80105147:	39 06                	cmp    %eax,(%esi)
80105149:	75 3d                	jne    80105188 <sys_link+0xe8>
8010514b:	83 ec 04             	sub    $0x4,%esp
8010514e:	ff 73 04             	push   0x4(%ebx)
80105151:	57                   	push   %edi
80105152:	56                   	push   %esi
80105153:	e8 28 cf ff ff       	call   80102080 <dirlink>
80105158:	83 c4 10             	add    $0x10,%esp
8010515b:	85 c0                	test   %eax,%eax
8010515d:	78 29                	js     80105188 <sys_link+0xe8>
  iunlockput(dp);
8010515f:	83 ec 0c             	sub    $0xc,%esp
80105162:	56                   	push   %esi
80105163:	e8 88 c9 ff ff       	call   80101af0 <iunlockput>
  iput(ip);
80105168:	89 1c 24             	mov    %ebx,(%esp)
8010516b:	e8 20 c8 ff ff       	call   80101990 <iput>
  end_op();
80105170:	e8 fb dc ff ff       	call   80102e70 <end_op>
  return 0;
80105175:	83 c4 10             	add    $0x10,%esp
80105178:	31 c0                	xor    %eax,%eax
}
8010517a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010517d:	5b                   	pop    %ebx
8010517e:	5e                   	pop    %esi
8010517f:	5f                   	pop    %edi
80105180:	5d                   	pop    %ebp
80105181:	c3                   	ret
80105182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105188:	83 ec 0c             	sub    $0xc,%esp
8010518b:	56                   	push   %esi
8010518c:	e8 5f c9 ff ff       	call   80101af0 <iunlockput>
    goto bad;
80105191:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105194:	83 ec 0c             	sub    $0xc,%esp
80105197:	53                   	push   %ebx
80105198:	e8 c3 c6 ff ff       	call   80101860 <ilock>
  ip->nlink--;
8010519d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051a2:	89 1c 24             	mov    %ebx,(%esp)
801051a5:	e8 06 c6 ff ff       	call   801017b0 <iupdate>
  iunlockput(ip);
801051aa:	89 1c 24             	mov    %ebx,(%esp)
801051ad:	e8 3e c9 ff ff       	call   80101af0 <iunlockput>
  end_op();
801051b2:	e8 b9 dc ff ff       	call   80102e70 <end_op>
  return -1;
801051b7:	83 c4 10             	add    $0x10,%esp
    return -1;
801051ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051bf:	eb b9                	jmp    8010517a <sys_link+0xda>
    iunlockput(ip);
801051c1:	83 ec 0c             	sub    $0xc,%esp
801051c4:	53                   	push   %ebx
801051c5:	e8 26 c9 ff ff       	call   80101af0 <iunlockput>
    end_op();
801051ca:	e8 a1 dc ff ff       	call   80102e70 <end_op>
    return -1;
801051cf:	83 c4 10             	add    $0x10,%esp
801051d2:	eb e6                	jmp    801051ba <sys_link+0x11a>
    end_op();
801051d4:	e8 97 dc ff ff       	call   80102e70 <end_op>
    return -1;
801051d9:	eb df                	jmp    801051ba <sys_link+0x11a>
801051db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801051e0 <sys_unlink>:
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801051e5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801051e8:	53                   	push   %ebx
801051e9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801051ec:	50                   	push   %eax
801051ed:	6a 00                	push   $0x0
801051ef:	e8 ec f9 ff ff       	call   80104be0 <argstr>
801051f4:	83 c4 10             	add    $0x10,%esp
801051f7:	85 c0                	test   %eax,%eax
801051f9:	0f 88 54 01 00 00    	js     80105353 <sys_unlink+0x173>
  begin_op();
801051ff:	e8 fc db ff ff       	call   80102e00 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105204:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105207:	83 ec 08             	sub    $0x8,%esp
8010520a:	53                   	push   %ebx
8010520b:	ff 75 c0             	push   -0x40(%ebp)
8010520e:	e8 4d cf ff ff       	call   80102160 <nameiparent>
80105213:	83 c4 10             	add    $0x10,%esp
80105216:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105219:	85 c0                	test   %eax,%eax
8010521b:	0f 84 58 01 00 00    	je     80105379 <sys_unlink+0x199>
  ilock(dp);
80105221:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105224:	83 ec 0c             	sub    $0xc,%esp
80105227:	57                   	push   %edi
80105228:	e8 33 c6 ff ff       	call   80101860 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010522d:	58                   	pop    %eax
8010522e:	5a                   	pop    %edx
8010522f:	68 96 7d 10 80       	push   $0x80107d96
80105234:	53                   	push   %ebx
80105235:	e8 56 cb ff ff       	call   80101d90 <namecmp>
8010523a:	83 c4 10             	add    $0x10,%esp
8010523d:	85 c0                	test   %eax,%eax
8010523f:	0f 84 fb 00 00 00    	je     80105340 <sys_unlink+0x160>
80105245:	83 ec 08             	sub    $0x8,%esp
80105248:	68 95 7d 10 80       	push   $0x80107d95
8010524d:	53                   	push   %ebx
8010524e:	e8 3d cb ff ff       	call   80101d90 <namecmp>
80105253:	83 c4 10             	add    $0x10,%esp
80105256:	85 c0                	test   %eax,%eax
80105258:	0f 84 e2 00 00 00    	je     80105340 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010525e:	83 ec 04             	sub    $0x4,%esp
80105261:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105264:	50                   	push   %eax
80105265:	53                   	push   %ebx
80105266:	57                   	push   %edi
80105267:	e8 44 cb ff ff       	call   80101db0 <dirlookup>
8010526c:	83 c4 10             	add    $0x10,%esp
8010526f:	89 c3                	mov    %eax,%ebx
80105271:	85 c0                	test   %eax,%eax
80105273:	0f 84 c7 00 00 00    	je     80105340 <sys_unlink+0x160>
  ilock(ip);
80105279:	83 ec 0c             	sub    $0xc,%esp
8010527c:	50                   	push   %eax
8010527d:	e8 de c5 ff ff       	call   80101860 <ilock>
  if(ip->nlink < 1)
80105282:	83 c4 10             	add    $0x10,%esp
80105285:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010528a:	0f 8e 0a 01 00 00    	jle    8010539a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105290:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105295:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105298:	74 66                	je     80105300 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010529a:	83 ec 04             	sub    $0x4,%esp
8010529d:	6a 10                	push   $0x10
8010529f:	6a 00                	push   $0x0
801052a1:	57                   	push   %edi
801052a2:	e8 c9 f5 ff ff       	call   80104870 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052a7:	6a 10                	push   $0x10
801052a9:	ff 75 c4             	push   -0x3c(%ebp)
801052ac:	57                   	push   %edi
801052ad:	ff 75 b4             	push   -0x4c(%ebp)
801052b0:	e8 bb c9 ff ff       	call   80101c70 <writei>
801052b5:	83 c4 20             	add    $0x20,%esp
801052b8:	83 f8 10             	cmp    $0x10,%eax
801052bb:	0f 85 cc 00 00 00    	jne    8010538d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
801052c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052c6:	0f 84 94 00 00 00    	je     80105360 <sys_unlink+0x180>
  iunlockput(dp);
801052cc:	83 ec 0c             	sub    $0xc,%esp
801052cf:	ff 75 b4             	push   -0x4c(%ebp)
801052d2:	e8 19 c8 ff ff       	call   80101af0 <iunlockput>
  ip->nlink--;
801052d7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801052dc:	89 1c 24             	mov    %ebx,(%esp)
801052df:	e8 cc c4 ff ff       	call   801017b0 <iupdate>
  iunlockput(ip);
801052e4:	89 1c 24             	mov    %ebx,(%esp)
801052e7:	e8 04 c8 ff ff       	call   80101af0 <iunlockput>
  end_op();
801052ec:	e8 7f db ff ff       	call   80102e70 <end_op>
  return 0;
801052f1:	83 c4 10             	add    $0x10,%esp
801052f4:	31 c0                	xor    %eax,%eax
}
801052f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052f9:	5b                   	pop    %ebx
801052fa:	5e                   	pop    %esi
801052fb:	5f                   	pop    %edi
801052fc:	5d                   	pop    %ebp
801052fd:	c3                   	ret
801052fe:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105300:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105304:	76 94                	jbe    8010529a <sys_unlink+0xba>
80105306:	be 20 00 00 00       	mov    $0x20,%esi
8010530b:	eb 0b                	jmp    80105318 <sys_unlink+0x138>
8010530d:	8d 76 00             	lea    0x0(%esi),%esi
80105310:	83 c6 10             	add    $0x10,%esi
80105313:	3b 73 58             	cmp    0x58(%ebx),%esi
80105316:	73 82                	jae    8010529a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105318:	6a 10                	push   $0x10
8010531a:	56                   	push   %esi
8010531b:	57                   	push   %edi
8010531c:	53                   	push   %ebx
8010531d:	e8 4e c8 ff ff       	call   80101b70 <readi>
80105322:	83 c4 10             	add    $0x10,%esp
80105325:	83 f8 10             	cmp    $0x10,%eax
80105328:	75 56                	jne    80105380 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010532a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010532f:	74 df                	je     80105310 <sys_unlink+0x130>
    iunlockput(ip);
80105331:	83 ec 0c             	sub    $0xc,%esp
80105334:	53                   	push   %ebx
80105335:	e8 b6 c7 ff ff       	call   80101af0 <iunlockput>
    goto bad;
8010533a:	83 c4 10             	add    $0x10,%esp
8010533d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	ff 75 b4             	push   -0x4c(%ebp)
80105346:	e8 a5 c7 ff ff       	call   80101af0 <iunlockput>
  end_op();
8010534b:	e8 20 db ff ff       	call   80102e70 <end_op>
  return -1;
80105350:	83 c4 10             	add    $0x10,%esp
    return -1;
80105353:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105358:	eb 9c                	jmp    801052f6 <sys_unlink+0x116>
8010535a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105360:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105363:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105366:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010536b:	50                   	push   %eax
8010536c:	e8 3f c4 ff ff       	call   801017b0 <iupdate>
80105371:	83 c4 10             	add    $0x10,%esp
80105374:	e9 53 ff ff ff       	jmp    801052cc <sys_unlink+0xec>
    end_op();
80105379:	e8 f2 da ff ff       	call   80102e70 <end_op>
    return -1;
8010537e:	eb d3                	jmp    80105353 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105380:	83 ec 0c             	sub    $0xc,%esp
80105383:	68 ba 7d 10 80       	push   $0x80107dba
80105388:	e8 f3 af ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010538d:	83 ec 0c             	sub    $0xc,%esp
80105390:	68 cc 7d 10 80       	push   $0x80107dcc
80105395:	e8 e6 af ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010539a:	83 ec 0c             	sub    $0xc,%esp
8010539d:	68 a8 7d 10 80       	push   $0x80107da8
801053a2:	e8 d9 af ff ff       	call   80100380 <panic>
801053a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053ae:	00 
801053af:	90                   	nop

801053b0 <sys_open>:

int
sys_open(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	57                   	push   %edi
801053b4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053b5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801053b8:	53                   	push   %ebx
801053b9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053bc:	50                   	push   %eax
801053bd:	6a 00                	push   $0x0
801053bf:	e8 1c f8 ff ff       	call   80104be0 <argstr>
801053c4:	83 c4 10             	add    $0x10,%esp
801053c7:	85 c0                	test   %eax,%eax
801053c9:	0f 88 8e 00 00 00    	js     8010545d <sys_open+0xad>
801053cf:	83 ec 08             	sub    $0x8,%esp
801053d2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053d5:	50                   	push   %eax
801053d6:	6a 01                	push   $0x1
801053d8:	e8 43 f7 ff ff       	call   80104b20 <argint>
801053dd:	83 c4 10             	add    $0x10,%esp
801053e0:	85 c0                	test   %eax,%eax
801053e2:	78 79                	js     8010545d <sys_open+0xad>
    return -1;

  begin_op();
801053e4:	e8 17 da ff ff       	call   80102e00 <begin_op>

  if(omode & O_CREATE){
801053e9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053ed:	75 79                	jne    80105468 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801053ef:	83 ec 0c             	sub    $0xc,%esp
801053f2:	ff 75 e0             	push   -0x20(%ebp)
801053f5:	e8 46 cd ff ff       	call   80102140 <namei>
801053fa:	83 c4 10             	add    $0x10,%esp
801053fd:	89 c6                	mov    %eax,%esi
801053ff:	85 c0                	test   %eax,%eax
80105401:	0f 84 7e 00 00 00    	je     80105485 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105407:	83 ec 0c             	sub    $0xc,%esp
8010540a:	50                   	push   %eax
8010540b:	e8 50 c4 ff ff       	call   80101860 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105410:	83 c4 10             	add    $0x10,%esp
80105413:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105418:	0f 84 ba 00 00 00    	je     801054d8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010541e:	e8 ed ba ff ff       	call   80100f10 <filealloc>
80105423:	89 c7                	mov    %eax,%edi
80105425:	85 c0                	test   %eax,%eax
80105427:	74 23                	je     8010544c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105429:	e8 52 e6 ff ff       	call   80103a80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010542e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105430:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105434:	85 d2                	test   %edx,%edx
80105436:	74 58                	je     80105490 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105438:	83 c3 01             	add    $0x1,%ebx
8010543b:	83 fb 10             	cmp    $0x10,%ebx
8010543e:	75 f0                	jne    80105430 <sys_open+0x80>
    if(f)
      fileclose(f);
80105440:	83 ec 0c             	sub    $0xc,%esp
80105443:	57                   	push   %edi
80105444:	e8 87 bb ff ff       	call   80100fd0 <fileclose>
80105449:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010544c:	83 ec 0c             	sub    $0xc,%esp
8010544f:	56                   	push   %esi
80105450:	e8 9b c6 ff ff       	call   80101af0 <iunlockput>
    end_op();
80105455:	e8 16 da ff ff       	call   80102e70 <end_op>
    return -1;
8010545a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010545d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105462:	eb 65                	jmp    801054c9 <sys_open+0x119>
80105464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105468:	83 ec 0c             	sub    $0xc,%esp
8010546b:	31 c9                	xor    %ecx,%ecx
8010546d:	ba 02 00 00 00       	mov    $0x2,%edx
80105472:	6a 00                	push   $0x0
80105474:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105477:	e8 54 f8 ff ff       	call   80104cd0 <create>
    if(ip == 0){
8010547c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010547f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105481:	85 c0                	test   %eax,%eax
80105483:	75 99                	jne    8010541e <sys_open+0x6e>
      end_op();
80105485:	e8 e6 d9 ff ff       	call   80102e70 <end_op>
      return -1;
8010548a:	eb d1                	jmp    8010545d <sys_open+0xad>
8010548c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105490:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105493:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105497:	56                   	push   %esi
80105498:	e8 a3 c4 ff ff       	call   80101940 <iunlock>
  end_op();
8010549d:	e8 ce d9 ff ff       	call   80102e70 <end_op>

  f->type = FD_INODE;
801054a2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054ab:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801054ae:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801054b1:	89 d0                	mov    %edx,%eax
  f->off = 0;
801054b3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801054ba:	f7 d0                	not    %eax
801054bc:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054bf:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801054c2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054c5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801054c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054cc:	89 d8                	mov    %ebx,%eax
801054ce:	5b                   	pop    %ebx
801054cf:	5e                   	pop    %esi
801054d0:	5f                   	pop    %edi
801054d1:	5d                   	pop    %ebp
801054d2:	c3                   	ret
801054d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801054d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801054db:	85 c9                	test   %ecx,%ecx
801054dd:	0f 84 3b ff ff ff    	je     8010541e <sys_open+0x6e>
801054e3:	e9 64 ff ff ff       	jmp    8010544c <sys_open+0x9c>
801054e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ef:	00 

801054f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054f6:	e8 05 d9 ff ff       	call   80102e00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801054fb:	83 ec 08             	sub    $0x8,%esp
801054fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105501:	50                   	push   %eax
80105502:	6a 00                	push   $0x0
80105504:	e8 d7 f6 ff ff       	call   80104be0 <argstr>
80105509:	83 c4 10             	add    $0x10,%esp
8010550c:	85 c0                	test   %eax,%eax
8010550e:	78 30                	js     80105540 <sys_mkdir+0x50>
80105510:	83 ec 0c             	sub    $0xc,%esp
80105513:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105516:	31 c9                	xor    %ecx,%ecx
80105518:	ba 01 00 00 00       	mov    $0x1,%edx
8010551d:	6a 00                	push   $0x0
8010551f:	e8 ac f7 ff ff       	call   80104cd0 <create>
80105524:	83 c4 10             	add    $0x10,%esp
80105527:	85 c0                	test   %eax,%eax
80105529:	74 15                	je     80105540 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010552b:	83 ec 0c             	sub    $0xc,%esp
8010552e:	50                   	push   %eax
8010552f:	e8 bc c5 ff ff       	call   80101af0 <iunlockput>
  end_op();
80105534:	e8 37 d9 ff ff       	call   80102e70 <end_op>
  return 0;
80105539:	83 c4 10             	add    $0x10,%esp
8010553c:	31 c0                	xor    %eax,%eax
}
8010553e:	c9                   	leave
8010553f:	c3                   	ret
    end_op();
80105540:	e8 2b d9 ff ff       	call   80102e70 <end_op>
    return -1;
80105545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010554a:	c9                   	leave
8010554b:	c3                   	ret
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_mknod>:

int
sys_mknod(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105556:	e8 a5 d8 ff ff       	call   80102e00 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010555b:	83 ec 08             	sub    $0x8,%esp
8010555e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105561:	50                   	push   %eax
80105562:	6a 00                	push   $0x0
80105564:	e8 77 f6 ff ff       	call   80104be0 <argstr>
80105569:	83 c4 10             	add    $0x10,%esp
8010556c:	85 c0                	test   %eax,%eax
8010556e:	78 60                	js     801055d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105570:	83 ec 08             	sub    $0x8,%esp
80105573:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105576:	50                   	push   %eax
80105577:	6a 01                	push   $0x1
80105579:	e8 a2 f5 ff ff       	call   80104b20 <argint>
  if((argstr(0, &path)) < 0 ||
8010557e:	83 c4 10             	add    $0x10,%esp
80105581:	85 c0                	test   %eax,%eax
80105583:	78 4b                	js     801055d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105585:	83 ec 08             	sub    $0x8,%esp
80105588:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010558b:	50                   	push   %eax
8010558c:	6a 02                	push   $0x2
8010558e:	e8 8d f5 ff ff       	call   80104b20 <argint>
     argint(1, &major) < 0 ||
80105593:	83 c4 10             	add    $0x10,%esp
80105596:	85 c0                	test   %eax,%eax
80105598:	78 36                	js     801055d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010559a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010559e:	83 ec 0c             	sub    $0xc,%esp
801055a1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801055a5:	ba 03 00 00 00       	mov    $0x3,%edx
801055aa:	50                   	push   %eax
801055ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055ae:	e8 1d f7 ff ff       	call   80104cd0 <create>
     argint(2, &minor) < 0 ||
801055b3:	83 c4 10             	add    $0x10,%esp
801055b6:	85 c0                	test   %eax,%eax
801055b8:	74 16                	je     801055d0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801055ba:	83 ec 0c             	sub    $0xc,%esp
801055bd:	50                   	push   %eax
801055be:	e8 2d c5 ff ff       	call   80101af0 <iunlockput>
  end_op();
801055c3:	e8 a8 d8 ff ff       	call   80102e70 <end_op>
  return 0;
801055c8:	83 c4 10             	add    $0x10,%esp
801055cb:	31 c0                	xor    %eax,%eax
}
801055cd:	c9                   	leave
801055ce:	c3                   	ret
801055cf:	90                   	nop
    end_op();
801055d0:	e8 9b d8 ff ff       	call   80102e70 <end_op>
    return -1;
801055d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055da:	c9                   	leave
801055db:	c3                   	ret
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055e0 <sys_chdir>:

int
sys_chdir(void)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	56                   	push   %esi
801055e4:	53                   	push   %ebx
801055e5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801055e8:	e8 93 e4 ff ff       	call   80103a80 <myproc>
801055ed:	89 c6                	mov    %eax,%esi
  
  begin_op();
801055ef:	e8 0c d8 ff ff       	call   80102e00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801055f4:	83 ec 08             	sub    $0x8,%esp
801055f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055fa:	50                   	push   %eax
801055fb:	6a 00                	push   $0x0
801055fd:	e8 de f5 ff ff       	call   80104be0 <argstr>
80105602:	83 c4 10             	add    $0x10,%esp
80105605:	85 c0                	test   %eax,%eax
80105607:	78 77                	js     80105680 <sys_chdir+0xa0>
80105609:	83 ec 0c             	sub    $0xc,%esp
8010560c:	ff 75 f4             	push   -0xc(%ebp)
8010560f:	e8 2c cb ff ff       	call   80102140 <namei>
80105614:	83 c4 10             	add    $0x10,%esp
80105617:	89 c3                	mov    %eax,%ebx
80105619:	85 c0                	test   %eax,%eax
8010561b:	74 63                	je     80105680 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010561d:	83 ec 0c             	sub    $0xc,%esp
80105620:	50                   	push   %eax
80105621:	e8 3a c2 ff ff       	call   80101860 <ilock>
  if(ip->type != T_DIR){
80105626:	83 c4 10             	add    $0x10,%esp
80105629:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010562e:	75 30                	jne    80105660 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105630:	83 ec 0c             	sub    $0xc,%esp
80105633:	53                   	push   %ebx
80105634:	e8 07 c3 ff ff       	call   80101940 <iunlock>
  iput(curproc->cwd);
80105639:	58                   	pop    %eax
8010563a:	ff 76 68             	push   0x68(%esi)
8010563d:	e8 4e c3 ff ff       	call   80101990 <iput>
  end_op();
80105642:	e8 29 d8 ff ff       	call   80102e70 <end_op>
  curproc->cwd = ip;
80105647:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010564a:	83 c4 10             	add    $0x10,%esp
8010564d:	31 c0                	xor    %eax,%eax
}
8010564f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105652:	5b                   	pop    %ebx
80105653:	5e                   	pop    %esi
80105654:	5d                   	pop    %ebp
80105655:	c3                   	ret
80105656:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010565d:	00 
8010565e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105660:	83 ec 0c             	sub    $0xc,%esp
80105663:	53                   	push   %ebx
80105664:	e8 87 c4 ff ff       	call   80101af0 <iunlockput>
    end_op();
80105669:	e8 02 d8 ff ff       	call   80102e70 <end_op>
    return -1;
8010566e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105671:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105676:	eb d7                	jmp    8010564f <sys_chdir+0x6f>
80105678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010567f:	00 
    end_op();
80105680:	e8 eb d7 ff ff       	call   80102e70 <end_op>
    return -1;
80105685:	eb ea                	jmp    80105671 <sys_chdir+0x91>
80105687:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010568e:	00 
8010568f:	90                   	nop

80105690 <sys_exec>:

int
sys_exec(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	57                   	push   %edi
80105694:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105695:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010569b:	53                   	push   %ebx
8010569c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056a2:	50                   	push   %eax
801056a3:	6a 00                	push   $0x0
801056a5:	e8 36 f5 ff ff       	call   80104be0 <argstr>
801056aa:	83 c4 10             	add    $0x10,%esp
801056ad:	85 c0                	test   %eax,%eax
801056af:	0f 88 87 00 00 00    	js     8010573c <sys_exec+0xac>
801056b5:	83 ec 08             	sub    $0x8,%esp
801056b8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801056be:	50                   	push   %eax
801056bf:	6a 01                	push   $0x1
801056c1:	e8 5a f4 ff ff       	call   80104b20 <argint>
801056c6:	83 c4 10             	add    $0x10,%esp
801056c9:	85 c0                	test   %eax,%eax
801056cb:	78 6f                	js     8010573c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801056cd:	83 ec 04             	sub    $0x4,%esp
801056d0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801056d6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801056d8:	68 80 00 00 00       	push   $0x80
801056dd:	6a 00                	push   $0x0
801056df:	56                   	push   %esi
801056e0:	e8 8b f1 ff ff       	call   80104870 <memset>
801056e5:	83 c4 10             	add    $0x10,%esp
801056e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056ef:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801056f0:	83 ec 08             	sub    $0x8,%esp
801056f3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801056f9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105700:	50                   	push   %eax
80105701:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105707:	01 f8                	add    %edi,%eax
80105709:	50                   	push   %eax
8010570a:	e8 81 f3 ff ff       	call   80104a90 <fetchint>
8010570f:	83 c4 10             	add    $0x10,%esp
80105712:	85 c0                	test   %eax,%eax
80105714:	78 26                	js     8010573c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105716:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010571c:	85 c0                	test   %eax,%eax
8010571e:	74 30                	je     80105750 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105720:	83 ec 08             	sub    $0x8,%esp
80105723:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105726:	52                   	push   %edx
80105727:	50                   	push   %eax
80105728:	e8 a3 f3 ff ff       	call   80104ad0 <fetchstr>
8010572d:	83 c4 10             	add    $0x10,%esp
80105730:	85 c0                	test   %eax,%eax
80105732:	78 08                	js     8010573c <sys_exec+0xac>
  for(i=0;; i++){
80105734:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105737:	83 fb 20             	cmp    $0x20,%ebx
8010573a:	75 b4                	jne    801056f0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010573c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010573f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105744:	5b                   	pop    %ebx
80105745:	5e                   	pop    %esi
80105746:	5f                   	pop    %edi
80105747:	5d                   	pop    %ebp
80105748:	c3                   	ret
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105750:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105757:	00 00 00 00 
  return exec(path, argv);
8010575b:	83 ec 08             	sub    $0x8,%esp
8010575e:	56                   	push   %esi
8010575f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105765:	e8 06 b4 ff ff       	call   80100b70 <exec>
8010576a:	83 c4 10             	add    $0x10,%esp
}
8010576d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105770:	5b                   	pop    %ebx
80105771:	5e                   	pop    %esi
80105772:	5f                   	pop    %edi
80105773:	5d                   	pop    %ebp
80105774:	c3                   	ret
80105775:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010577c:	00 
8010577d:	8d 76 00             	lea    0x0(%esi),%esi

80105780 <sys_pipe>:

int
sys_pipe(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	57                   	push   %edi
80105784:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105785:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105788:	53                   	push   %ebx
80105789:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010578c:	6a 08                	push   $0x8
8010578e:	50                   	push   %eax
8010578f:	6a 00                	push   $0x0
80105791:	e8 da f3 ff ff       	call   80104b70 <argptr>
80105796:	83 c4 10             	add    $0x10,%esp
80105799:	85 c0                	test   %eax,%eax
8010579b:	0f 88 8b 00 00 00    	js     8010582c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801057a1:	83 ec 08             	sub    $0x8,%esp
801057a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801057a7:	50                   	push   %eax
801057a8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057ab:	50                   	push   %eax
801057ac:	e8 2f dd ff ff       	call   801034e0 <pipealloc>
801057b1:	83 c4 10             	add    $0x10,%esp
801057b4:	85 c0                	test   %eax,%eax
801057b6:	78 74                	js     8010582c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057b8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801057bb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801057bd:	e8 be e2 ff ff       	call   80103a80 <myproc>
    if(curproc->ofile[fd] == 0){
801057c2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801057c6:	85 f6                	test   %esi,%esi
801057c8:	74 16                	je     801057e0 <sys_pipe+0x60>
801057ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057d0:	83 c3 01             	add    $0x1,%ebx
801057d3:	83 fb 10             	cmp    $0x10,%ebx
801057d6:	74 3d                	je     80105815 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
801057d8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801057dc:	85 f6                	test   %esi,%esi
801057de:	75 f0                	jne    801057d0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801057e0:	8d 73 08             	lea    0x8(%ebx),%esi
801057e3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801057ea:	e8 91 e2 ff ff       	call   80103a80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057ef:	31 d2                	xor    %edx,%edx
801057f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801057f8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801057fc:	85 c9                	test   %ecx,%ecx
801057fe:	74 38                	je     80105838 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105800:	83 c2 01             	add    $0x1,%edx
80105803:	83 fa 10             	cmp    $0x10,%edx
80105806:	75 f0                	jne    801057f8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105808:	e8 73 e2 ff ff       	call   80103a80 <myproc>
8010580d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105814:	00 
    fileclose(rf);
80105815:	83 ec 0c             	sub    $0xc,%esp
80105818:	ff 75 e0             	push   -0x20(%ebp)
8010581b:	e8 b0 b7 ff ff       	call   80100fd0 <fileclose>
    fileclose(wf);
80105820:	58                   	pop    %eax
80105821:	ff 75 e4             	push   -0x1c(%ebp)
80105824:	e8 a7 b7 ff ff       	call   80100fd0 <fileclose>
    return -1;
80105829:	83 c4 10             	add    $0x10,%esp
    return -1;
8010582c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105831:	eb 16                	jmp    80105849 <sys_pipe+0xc9>
80105833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105838:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010583c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010583f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105841:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105844:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105847:	31 c0                	xor    %eax,%eax
}
80105849:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010584c:	5b                   	pop    %ebx
8010584d:	5e                   	pop    %esi
8010584e:	5f                   	pop    %edi
8010584f:	5d                   	pop    %ebp
80105850:	c3                   	ret
80105851:	66 90                	xchg   %ax,%ax
80105853:	66 90                	xchg   %ax,%ax
80105855:	66 90                	xchg   %ax,%ax
80105857:	66 90                	xchg   %ax,%ax
80105859:	66 90                	xchg   %ax,%ax
8010585b:	66 90                	xchg   %ax,%ax
8010585d:	66 90                	xchg   %ax,%ax
8010585f:	90                   	nop

80105860 <sys_fork>:
extern pte_t* walkpgdir(pde_t *pgdir, const void *va, int alloc);

int
sys_fork(void)
{
  return fork();
80105860:	e9 9b e3 ff ff       	jmp    80103c00 <fork>
80105865:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010586c:	00 
8010586d:	8d 76 00             	lea    0x0(%esi),%esi

80105870 <sys_exit>:
}

int
sys_exit(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 08             	sub    $0x8,%esp
  exit();
80105876:	e8 05 e6 ff ff       	call   80103e80 <exit>
  return 0;  // not reached
}
8010587b:	31 c0                	xor    %eax,%eax
8010587d:	c9                   	leave
8010587e:	c3                   	ret
8010587f:	90                   	nop

80105880 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105880:	e9 2b e7 ff ff       	jmp    80103fb0 <wait>
80105885:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010588c:	00 
8010588d:	8d 76 00             	lea    0x0(%esi),%esi

80105890 <sys_kill>:
}

int
sys_kill(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105896:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105899:	50                   	push   %eax
8010589a:	6a 00                	push   $0x0
8010589c:	e8 7f f2 ff ff       	call   80104b20 <argint>
801058a1:	83 c4 10             	add    $0x10,%esp
801058a4:	85 c0                	test   %eax,%eax
801058a6:	78 18                	js     801058c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801058a8:	83 ec 0c             	sub    $0xc,%esp
801058ab:	ff 75 f4             	push   -0xc(%ebp)
801058ae:	e8 9d e9 ff ff       	call   80104250 <kill>
801058b3:	83 c4 10             	add    $0x10,%esp
}
801058b6:	c9                   	leave
801058b7:	c3                   	ret
801058b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058bf:	00 
801058c0:	c9                   	leave
    return -1;
801058c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058c6:	c3                   	ret
801058c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058ce:	00 
801058cf:	90                   	nop

801058d0 <sys_getpid>:

int
sys_getpid(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058d6:	e8 a5 e1 ff ff       	call   80103a80 <myproc>
801058db:	8b 40 10             	mov    0x10(%eax),%eax
}
801058de:	c9                   	leave
801058df:	c3                   	ret

801058e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058ea:	50                   	push   %eax
801058eb:	6a 00                	push   $0x0
801058ed:	e8 2e f2 ff ff       	call   80104b20 <argint>
801058f2:	83 c4 10             	add    $0x10,%esp
801058f5:	85 c0                	test   %eax,%eax
801058f7:	78 27                	js     80105920 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801058f9:	e8 82 e1 ff ff       	call   80103a80 <myproc>
  if(growproc(n) < 0)
801058fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105901:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105903:	ff 75 f4             	push   -0xc(%ebp)
80105906:	e8 95 e2 ff ff       	call   80103ba0 <growproc>
8010590b:	83 c4 10             	add    $0x10,%esp
8010590e:	85 c0                	test   %eax,%eax
80105910:	78 0e                	js     80105920 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105912:	89 d8                	mov    %ebx,%eax
80105914:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105917:	c9                   	leave
80105918:	c3                   	ret
80105919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105920:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105925:	eb eb                	jmp    80105912 <sys_sbrk+0x32>
80105927:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010592e:	00 
8010592f:	90                   	nop

80105930 <sys_sleep>:

int
sys_sleep(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105934:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105937:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010593a:	50                   	push   %eax
8010593b:	6a 00                	push   $0x0
8010593d:	e8 de f1 ff ff       	call   80104b20 <argint>
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	85 c0                	test   %eax,%eax
80105947:	78 64                	js     801059ad <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105949:	83 ec 0c             	sub    $0xc,%esp
8010594c:	68 80 a9 11 80       	push   $0x8011a980
80105951:	e8 1a ee ff ff       	call   80104770 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105956:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105959:	8b 1d 60 a9 11 80    	mov    0x8011a960,%ebx
  while(ticks - ticks0 < n){
8010595f:	83 c4 10             	add    $0x10,%esp
80105962:	85 d2                	test   %edx,%edx
80105964:	75 2b                	jne    80105991 <sys_sleep+0x61>
80105966:	eb 58                	jmp    801059c0 <sys_sleep+0x90>
80105968:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010596f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105970:	83 ec 08             	sub    $0x8,%esp
80105973:	68 80 a9 11 80       	push   $0x8011a980
80105978:	68 60 a9 11 80       	push   $0x8011a960
8010597d:	e8 ae e7 ff ff       	call   80104130 <sleep>
  while(ticks - ticks0 < n){
80105982:	a1 60 a9 11 80       	mov    0x8011a960,%eax
80105987:	83 c4 10             	add    $0x10,%esp
8010598a:	29 d8                	sub    %ebx,%eax
8010598c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010598f:	73 2f                	jae    801059c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105991:	e8 ea e0 ff ff       	call   80103a80 <myproc>
80105996:	8b 40 24             	mov    0x24(%eax),%eax
80105999:	85 c0                	test   %eax,%eax
8010599b:	74 d3                	je     80105970 <sys_sleep+0x40>
      release(&tickslock);
8010599d:	83 ec 0c             	sub    $0xc,%esp
801059a0:	68 80 a9 11 80       	push   $0x8011a980
801059a5:	e8 66 ed ff ff       	call   80104710 <release>
      return -1;
801059aa:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801059ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801059b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059b5:	c9                   	leave
801059b6:	c3                   	ret
801059b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059be:	00 
801059bf:	90                   	nop
  release(&tickslock);
801059c0:	83 ec 0c             	sub    $0xc,%esp
801059c3:	68 80 a9 11 80       	push   $0x8011a980
801059c8:	e8 43 ed ff ff       	call   80104710 <release>
}
801059cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
801059d0:	83 c4 10             	add    $0x10,%esp
801059d3:	31 c0                	xor    %eax,%eax
}
801059d5:	c9                   	leave
801059d6:	c3                   	ret
801059d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059de:	00 
801059df:	90                   	nop

801059e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	53                   	push   %ebx
801059e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059e7:	68 80 a9 11 80       	push   $0x8011a980
801059ec:	e8 7f ed ff ff       	call   80104770 <acquire>
  xticks = ticks;
801059f1:	8b 1d 60 a9 11 80    	mov    0x8011a960,%ebx
  release(&tickslock);
801059f7:	c7 04 24 80 a9 11 80 	movl   $0x8011a980,(%esp)
801059fe:	e8 0d ed ff ff       	call   80104710 <release>
  return xticks;
}
80105a03:	89 d8                	mov    %ebx,%eax
80105a05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a08:	c9                   	leave
80105a09:	c3                   	ret
80105a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a10 <sys_strrev>:

int 
sys_strrev(void) 
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	56                   	push   %esi
80105a14:	53                   	push   %ebx
char *str;
int len, i;
if (argstr(0, &str) < 0 || argint(1, &len) < 0)
80105a15:	8d 45 f0             	lea    -0x10(%ebp),%eax
{
80105a18:	83 ec 18             	sub    $0x18,%esp
if (argstr(0, &str) < 0 || argint(1, &len) < 0)
80105a1b:	50                   	push   %eax
80105a1c:	6a 00                	push   $0x0
80105a1e:	e8 bd f1 ff ff       	call   80104be0 <argstr>
80105a23:	83 c4 10             	add    $0x10,%esp
80105a26:	85 c0                	test   %eax,%eax
80105a28:	78 62                	js     80105a8c <sys_strrev+0x7c>
80105a2a:	83 ec 08             	sub    $0x8,%esp
80105a2d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a30:	50                   	push   %eax
80105a31:	6a 01                	push   $0x1
80105a33:	e8 e8 f0 ff ff       	call   80104b20 <argint>
80105a38:	83 c4 10             	add    $0x10,%esp
80105a3b:	85 c0                	test   %eax,%eax
80105a3d:	78 4d                	js     80105a8c <sys_strrev+0x7c>
return -1;
// Simple in-place reversal
for (i = 0; i < len/2; i++) {
80105a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a42:	31 d2                	xor    %edx,%edx
80105a44:	83 f8 01             	cmp    $0x1,%eax
80105a47:	7e 3a                	jle    80105a83 <sys_strrev+0x73>
80105a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
char tmp = str[i];
80105a50:	8b 5d f0             	mov    -0x10(%ebp),%ebx
str[i] = str[len - i - 1];
80105a53:	29 d0                	sub    %edx,%eax
80105a55:	0f b6 44 03 ff       	movzbl -0x1(%ebx,%eax,1),%eax
char tmp = str[i];
80105a5a:	8d 0c 13             	lea    (%ebx,%edx,1),%ecx
80105a5d:	0f b6 31             	movzbl (%ecx),%esi
str[i] = str[len - i - 1];
80105a60:	88 01                	mov    %al,(%ecx)
str[len - i - 1] = tmp;
80105a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a65:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105a68:	89 f3                	mov    %esi,%ebx
80105a6a:	29 d0                	sub    %edx,%eax
for (i = 0; i < len/2; i++) {
80105a6c:	83 c2 01             	add    $0x1,%edx
str[len - i - 1] = tmp;
80105a6f:	88 5c 01 ff          	mov    %bl,-0x1(%ecx,%eax,1)
for (i = 0; i < len/2; i++) {
80105a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a76:	89 c1                	mov    %eax,%ecx
80105a78:	c1 e9 1f             	shr    $0x1f,%ecx
80105a7b:	01 c1                	add    %eax,%ecx
80105a7d:	d1 f9                	sar    $1,%ecx
80105a7f:	39 d1                	cmp    %edx,%ecx
80105a81:	7f cd                	jg     80105a50 <sys_strrev+0x40>
}
return 0;
80105a83:	31 c0                	xor    %eax,%eax
}
80105a85:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a88:	5b                   	pop    %ebx
80105a89:	5e                   	pop    %esi
80105a8a:	5d                   	pop    %ebp
80105a8b:	c3                   	ret
return -1;
80105a8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a91:	eb f2                	jmp    80105a85 <sys_strrev+0x75>
80105a93:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a9a:	00 
80105a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105aa0 <sys_setflag>:

int
sys_setflag(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	83 ec 20             	sub    $0x20,%esp
  int val;
  if(argint(0, &val) < 0)
80105aa6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105aa9:	50                   	push   %eax
80105aaa:	6a 00                	push   $0x0
80105aac:	e8 6f f0 ff ff       	call   80104b20 <argint>
80105ab1:	83 c4 10             	add    $0x10,%esp
80105ab4:	85 c0                	test   %eax,%eax
80105ab6:	78 18                	js     80105ad0 <sys_setflag+0x30>
    return -1;

  myproc()->userflag = val;
80105ab8:	e8 c3 df ff ff       	call   80103a80 <myproc>
80105abd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ac0:	89 50 7c             	mov    %edx,0x7c(%eax)
  return 0;
80105ac3:	31 c0                	xor    %eax,%eax
}
80105ac5:	c9                   	leave
80105ac6:	c3                   	ret
80105ac7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ace:	00 
80105acf:	90                   	nop
80105ad0:	c9                   	leave
    return -1;
80105ad1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ad6:	c3                   	ret
80105ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ade:	00 
80105adf:	90                   	nop

80105ae0 <sys_getflag>:

int
sys_getflag(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->userflag;
80105ae6:	e8 95 df ff ff       	call   80103a80 <myproc>
80105aeb:	8b 40 7c             	mov    0x7c(%eax),%eax
}
80105aee:	c9                   	leave
80105aef:	c3                   	ret

80105af0 <sys_getstats>:

int 
sys_getstats(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 1c             	sub    $0x1c,%esp
   int *user_stats_ptr;
   
   if(argptr(0,(void*)&user_stats_ptr, 2*sizeof(int))<0)
80105af6:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105af9:	6a 08                	push   $0x8
80105afb:	50                   	push   %eax
80105afc:	6a 00                	push   $0x0
80105afe:	e8 6d f0 ff ff       	call   80104b70 <argptr>
80105b03:	83 c4 10             	add    $0x10,%esp
80105b06:	85 c0                	test   %eax,%eax
80105b08:	78 36                	js     80105b40 <sys_getstats+0x50>
   return -1;
   struct proc *p = myproc();
80105b0a:	e8 71 df ff ff       	call   80103a80 <myproc>
   int kernel_stats[2];
   kernel_stats[0]=p->sched_count;
80105b0f:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
80105b15:	8b 88 80 00 00 00    	mov    0x80(%eax),%ecx
   kernel_stats[1]=p->run_ticks;
   
   if(copyout(p->pgdir, (uint)user_stats_ptr,(char*)kernel_stats,
80105b1b:	6a 08                	push   $0x8
   kernel_stats[0]=p->sched_count;
80105b1d:	89 55 f4             	mov    %edx,-0xc(%ebp)
   if(copyout(p->pgdir, (uint)user_stats_ptr,(char*)kernel_stats,
80105b20:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105b23:	52                   	push   %edx
80105b24:	ff 75 ec             	push   -0x14(%ebp)
80105b27:	ff 70 04             	push   0x4(%eax)
   kernel_stats[0]=p->sched_count;
80105b2a:	89 4d f0             	mov    %ecx,-0x10(%ebp)
   if(copyout(p->pgdir, (uint)user_stats_ptr,(char*)kernel_stats,
80105b2d:	e8 8e 1c 00 00       	call   801077c0 <copyout>
80105b32:	83 c4 10             	add    $0x10,%esp
         sizeof(kernel_stats))<0)
   return -1;
   return 0;
}
80105b35:	c9                   	leave
   if(copyout(p->pgdir, (uint)user_stats_ptr,(char*)kernel_stats,
80105b36:	c1 f8 1f             	sar    $0x1f,%eax
}
80105b39:	c3                   	ret
80105b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b40:	c9                   	leave
   return -1;
80105b41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b46:	c3                   	ret
80105b47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b4e:	00 
80105b4f:	90                   	nop

80105b50 <sys_get_proc_info>:

int
sys_get_proc_info(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	56                   	push   %esi
80105b54:	53                   	push   %ebx
  int pid;
  char *uaddr;                // pointer in user space
  struct proc_info info;

  if(argint(0, &pid) < 0)
80105b55:	8d 45 c8             	lea    -0x38(%ebp),%eax
{
80105b58:	83 ec 38             	sub    $0x38,%esp
  if(argint(0, &pid) < 0)
80105b5b:	50                   	push   %eax
80105b5c:	6a 00                	push   $0x0
80105b5e:	e8 bd ef ff ff       	call   80104b20 <argint>
80105b63:	83 c4 10             	add    $0x10,%esp
80105b66:	85 c0                	test   %eax,%eax
80105b68:	78 56                	js     80105bc0 <sys_get_proc_info+0x70>
    return -1;

  if(argptr(1, &uaddr, sizeof(info)) < 0)
80105b6a:	83 ec 04             	sub    $0x4,%esp
80105b6d:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105b70:	6a 28                	push   $0x28
80105b72:	50                   	push   %eax
80105b73:	6a 01                	push   $0x1
80105b75:	e8 f6 ef ff ff       	call   80104b70 <argptr>
80105b7a:	83 c4 10             	add    $0x10,%esp
80105b7d:	85 c0                	test   %eax,%eax
80105b7f:	78 3f                	js     80105bc0 <sys_get_proc_info+0x70>
    return -1;

  if(get_proc_info_kernel(pid, &info) < 0)
80105b81:	83 ec 08             	sub    $0x8,%esp
80105b84:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80105b87:	53                   	push   %ebx
80105b88:	ff 75 c8             	push   -0x38(%ebp)
80105b8b:	e8 00 e8 ff ff       	call   80104390 <get_proc_info_kernel>
80105b90:	83 c4 10             	add    $0x10,%esp
80105b93:	85 c0                	test   %eax,%eax
80105b95:	78 29                	js     80105bc0 <sys_get_proc_info+0x70>
    return -1;

  if(copyout(myproc()->pgdir, (uint)uaddr, (char*)&info, sizeof(info)) < 0)
80105b97:	8b 75 cc             	mov    -0x34(%ebp),%esi
80105b9a:	e8 e1 de ff ff       	call   80103a80 <myproc>
80105b9f:	6a 28                	push   $0x28
80105ba1:	53                   	push   %ebx
80105ba2:	56                   	push   %esi
80105ba3:	ff 70 04             	push   0x4(%eax)
80105ba6:	e8 15 1c 00 00       	call   801077c0 <copyout>
80105bab:	83 c4 10             	add    $0x10,%esp
80105bae:	c1 f8 1f             	sar    $0x1f,%eax
    return -1;

  return 0;
}
80105bb1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bb4:	5b                   	pop    %ebx
80105bb5:	5e                   	pop    %esi
80105bb6:	5d                   	pop    %ebp
80105bb7:	c3                   	ret
80105bb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bbf:	00 
    return -1;
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc5:	eb ea                	jmp    80105bb1 <sys_get_proc_info+0x61>
80105bc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bce:	00 
80105bcf:	90                   	nop

80105bd0 <sys_numvp>:

int sys_numvp(void) {
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	83 ec 08             	sub    $0x8,%esp
struct proc *p = myproc();
80105bd6:	e8 a5 de ff ff       	call   80103a80 <myproc>
return (p->sz + PGSIZE - 1)/PGSIZE + 1;
80105bdb:	8b 00                	mov    (%eax),%eax
}
80105bdd:	c9                   	leave
return (p->sz + PGSIZE - 1)/PGSIZE + 1;
80105bde:	05 ff 0f 00 00       	add    $0xfff,%eax
80105be3:	c1 e8 0c             	shr    $0xc,%eax
80105be6:	83 c0 01             	add    $0x1,%eax
}
80105be9:	c3                   	ret
80105bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105bf0 <sys_numpp>:

int sys_numpp(void) {
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	57                   	push   %edi
80105bf4:	56                   	push   %esi
80105bf5:	53                   	push   %ebx
80105bf6:	83 ec 0c             	sub    $0xc,%esp
struct proc *p = myproc();
80105bf9:	e8 82 de ff ff       	call   80103a80 <myproc>
pte_t *pte;
int count = 0;
for(uint a = 0; a < p->sz; a += PGSIZE){
80105bfe:	8b 10                	mov    (%eax),%edx
80105c00:	85 d2                	test   %edx,%edx
80105c02:	74 44                	je     80105c48 <sys_numpp+0x58>
80105c04:	89 c7                	mov    %eax,%edi
80105c06:	31 f6                	xor    %esi,%esi
int count = 0;
80105c08:	31 db                	xor    %ebx,%ebx
80105c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
pte = walkpgdir(p->pgdir, (void*)a, 0);
80105c10:	83 ec 04             	sub    $0x4,%esp
80105c13:	6a 00                	push   $0x0
80105c15:	56                   	push   %esi
80105c16:	ff 77 04             	push   0x4(%edi)
80105c19:	e8 92 13 00 00       	call   80106fb0 <walkpgdir>
if(pte && (*pte & PTE_P)) count++;
80105c1e:	83 c4 10             	add    $0x10,%esp
80105c21:	85 c0                	test   %eax,%eax
80105c23:	74 0b                	je     80105c30 <sys_numpp+0x40>
80105c25:	8b 00                	mov    (%eax),%eax
80105c27:	83 e0 01             	and    $0x1,%eax
80105c2a:	83 f8 01             	cmp    $0x1,%eax
80105c2d:	83 db ff             	sbb    $0xffffffff,%ebx
for(uint a = 0; a < p->sz; a += PGSIZE){
80105c30:	81 c6 00 10 00 00    	add    $0x1000,%esi
80105c36:	3b 37                	cmp    (%edi),%esi
80105c38:	72 d6                	jb     80105c10 <sys_numpp+0x20>
}
return count;
}
80105c3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c3d:	89 d8                	mov    %ebx,%eax
80105c3f:	5b                   	pop    %ebx
80105c40:	5e                   	pop    %esi
80105c41:	5f                   	pop    %edi
80105c42:	5d                   	pop    %ebp
80105c43:	c3                   	ret
80105c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c48:	8d 65 f4             	lea    -0xc(%ebp),%esp
int count = 0;
80105c4b:	31 db                	xor    %ebx,%ebx
}
80105c4d:	89 d8                	mov    %ebx,%eax
80105c4f:	5b                   	pop    %ebx
80105c50:	5e                   	pop    %esi
80105c51:	5f                   	pop    %edi
80105c52:	5d                   	pop    %ebp
80105c53:	c3                   	ret
80105c54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c5b:	00 
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c60 <sys_getptsize>:

int sys_getptsize(void) {
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	53                   	push   %ebx
80105c64:	83 ec 04             	sub    $0x4,%esp
struct proc *p = myproc();
80105c67:	e8 14 de ff ff       	call   80103a80 <myproc>
int count = 1; // outer page directory
80105c6c:	b9 01 00 00 00       	mov    $0x1,%ecx
80105c71:	8b 40 04             	mov    0x4(%eax),%eax
80105c74:	8d 98 00 10 00 00    	lea    0x1000(%eax),%ebx
80105c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
for(int i=0;i<NPDENTRIES;i++)
if(p->pgdir[i] & PTE_P) count++;
80105c80:	8b 10                	mov    (%eax),%edx
80105c82:	83 e2 01             	and    $0x1,%edx
80105c85:	83 fa 01             	cmp    $0x1,%edx
80105c88:	83 d9 ff             	sbb    $0xffffffff,%ecx
for(int i=0;i<NPDENTRIES;i++)
80105c8b:	83 c0 04             	add    $0x4,%eax
80105c8e:	39 c3                	cmp    %eax,%ebx
80105c90:	75 ee                	jne    80105c80 <sys_getptsize+0x20>
return count;
}
80105c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c95:	89 c8                	mov    %ecx,%eax
80105c97:	c9                   	leave
80105c98:	c3                   	ret
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <sys_setpriority>:

int
sys_setpriority(void)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	83 ec 20             	sub    $0x20,%esp
  int priority;
  if (argint(0, &priority) < 0)
80105ca6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ca9:	50                   	push   %eax
80105caa:	6a 00                	push   $0x0
80105cac:	e8 6f ee ff ff       	call   80104b20 <argint>
80105cb1:	83 c4 10             	add    $0x10,%esp
80105cb4:	85 c0                	test   %eax,%eax
80105cb6:	78 18                	js     80105cd0 <sys_setpriority+0x30>
    return -1;

  struct proc *cur = myproc();
80105cb8:	e8 c3 dd ff ff       	call   80103a80 <myproc>
  cur->priority = priority;
80105cbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105cc0:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
  return 0;
80105cc6:	31 c0                	xor    %eax,%eax
}
80105cc8:	c9                   	leave
80105cc9:	c3                   	ret
80105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cd0:	c9                   	leave
    return -1;
80105cd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cd6:	c3                   	ret
80105cd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cde:	00 
80105cdf:	90                   	nop

80105ce0 <sys_getpagefaults>:

int sys_getpagefaults(void) {
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	83 ec 08             	sub    $0x8,%esp
struct proc *p = myproc();
80105ce6:	e8 95 dd ff ff       	call   80103a80 <myproc>
return p->page_faults;
80105ceb:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
}
80105cf1:	c9                   	leave
80105cf2:	c3                   	ret
80105cf3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cfa:	00 
80105cfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105d00 <sys_twostrike>:

int
sys_twostrike(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	83 ec 20             	sub    $0x20,%esp
  int enabled;
  if(argint(0, &enabled) < 0)
80105d06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d09:	50                   	push   %eax
80105d0a:	6a 00                	push   $0x0
80105d0c:	e8 0f ee ff ff       	call   80104b20 <argint>
80105d11:	83 c4 10             	add    $0x10,%esp
80105d14:	85 c0                	test   %eax,%eax
80105d16:	78 48                	js     80105d60 <sys_twostrike+0x60>
    return -1;

  struct proc *p = myproc();
80105d18:	e8 63 dd ff ff       	call   80103a80 <myproc>
  if(p == 0)
80105d1d:	85 c0                	test   %eax,%eax
80105d1f:	74 3f                	je     80105d60 <sys_twostrike+0x60>
    return -1;

  if (enabled)
80105d21:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d24:	85 d2                	test   %edx,%edx
80105d26:	74 18                	je     80105d40 <sys_twostrike+0x40>
    p->twostrike_mode = 1;
80105d28:	c7 80 e8 01 00 00 01 	movl   $0x1,0x1e8(%eax)
80105d2f:	00 00 00 
  else {
    p->twostrike_mode = 0;
    p->strike_count = 0; // reset any existing strike count when disabled
  }

  return 0;
80105d32:	31 c0                	xor    %eax,%eax
}
80105d34:	c9                   	leave
80105d35:	c3                   	ret
80105d36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d3d:	00 
80105d3e:	66 90                	xchg   %ax,%ax
    p->twostrike_mode = 0;
80105d40:	c7 80 e8 01 00 00 00 	movl   $0x0,0x1e8(%eax)
80105d47:	00 00 00 
    p->strike_count = 0; // reset any existing strike count when disabled
80105d4a:	c7 80 ec 01 00 00 00 	movl   $0x0,0x1ec(%eax)
80105d51:	00 00 00 
  return 0;
80105d54:	31 c0                	xor    %eax,%eax
80105d56:	eb dc                	jmp    80105d34 <sys_twostrike+0x34>
80105d58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d5f:	00 
}
80105d60:	c9                   	leave
    return -1;
80105d61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d66:	c3                   	ret

80105d67 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d67:	1e                   	push   %ds
  pushl %es
80105d68:	06                   	push   %es
  pushl %fs
80105d69:	0f a0                	push   %fs
  pushl %gs
80105d6b:	0f a8                	push   %gs
  pushal
80105d6d:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105d6e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d72:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d74:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d76:	54                   	push   %esp
  call trap
80105d77:	e8 c4 00 00 00       	call   80105e40 <trap>
  addl $4, %esp
80105d7c:	83 c4 04             	add    $0x4,%esp

80105d7f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d7f:	61                   	popa
  popl %gs
80105d80:	0f a9                	pop    %gs
  popl %fs
80105d82:	0f a1                	pop    %fs
  popl %es
80105d84:	07                   	pop    %es
  popl %ds
80105d85:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d86:	83 c4 08             	add    $0x8,%esp
  iret
80105d89:	cf                   	iret
80105d8a:	66 90                	xchg   %ax,%ax
80105d8c:	66 90                	xchg   %ax,%ax
80105d8e:	66 90                	xchg   %ax,%ax

80105d90 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d90:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105d91:	31 c0                	xor    %eax,%eax
{
80105d93:	89 e5                	mov    %esp,%ebp
80105d95:	83 ec 08             	sub    $0x8,%esp
80105d98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d9f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105da0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105da7:	c7 04 c5 c2 a9 11 80 	movl   $0x8e000008,-0x7fee563e(,%eax,8)
80105dae:	08 00 00 8e 
80105db2:	66 89 14 c5 c0 a9 11 	mov    %dx,-0x7fee5640(,%eax,8)
80105db9:	80 
80105dba:	c1 ea 10             	shr    $0x10,%edx
80105dbd:	66 89 14 c5 c6 a9 11 	mov    %dx,-0x7fee563a(,%eax,8)
80105dc4:	80 
  for(i = 0; i < 256; i++)
80105dc5:	83 c0 01             	add    $0x1,%eax
80105dc8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105dcd:	75 d1                	jne    80105da0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105dcf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105dd2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105dd7:	c7 05 c2 ab 11 80 08 	movl   $0xef000008,0x8011abc2
80105dde:	00 00 ef 
  initlock(&tickslock, "time");
80105de1:	68 db 7d 10 80       	push   $0x80107ddb
80105de6:	68 80 a9 11 80       	push   $0x8011a980
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105deb:	66 a3 c0 ab 11 80    	mov    %ax,0x8011abc0
80105df1:	c1 e8 10             	shr    $0x10,%eax
80105df4:	66 a3 c6 ab 11 80    	mov    %ax,0x8011abc6
  initlock(&tickslock, "time");
80105dfa:	e8 81 e7 ff ff       	call   80104580 <initlock>
}
80105dff:	83 c4 10             	add    $0x10,%esp
80105e02:	c9                   	leave
80105e03:	c3                   	ret
80105e04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e0b:	00 
80105e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e10 <idtinit>:

void
idtinit(void)
{
80105e10:	55                   	push   %ebp
  pd[0] = size-1;
80105e11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105e16:	89 e5                	mov    %esp,%ebp
80105e18:	83 ec 10             	sub    $0x10,%esp
80105e1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105e1f:	b8 c0 a9 11 80       	mov    $0x8011a9c0,%eax
80105e24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105e28:	c1 e8 10             	shr    $0x10,%eax
80105e2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105e2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105e32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105e35:	c9                   	leave
80105e36:	c3                   	ret
80105e37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e3e:	00 
80105e3f:	90                   	nop

80105e40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	57                   	push   %edi
80105e44:	56                   	push   %esi
80105e45:	53                   	push   %ebx
80105e46:	83 ec 1c             	sub    $0x1c,%esp
80105e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105e4c:	8b 43 30             	mov    0x30(%ebx),%eax
80105e4f:	83 f8 40             	cmp    $0x40,%eax
80105e52:	0f 84 40 01 00 00    	je     80105f98 <trap+0x158>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105e58:	83 e8 0e             	sub    $0xe,%eax
80105e5b:	83 f8 31             	cmp    $0x31,%eax
80105e5e:	0f 87 9c 00 00 00    	ja     80105f00 <trap+0xc0>
80105e64:	ff 24 85 30 84 10 80 	jmp    *-0x7fef7bd0(,%eax,4)
80105e6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(myproc() && myproc()->state==RUNNING)
80105e70:	e8 0b dc ff ff       	call   80103a80 <myproc>
80105e75:	85 c0                	test   %eax,%eax
80105e77:	74 0f                	je     80105e88 <trap+0x48>
80105e79:	e8 02 dc ff ff       	call   80103a80 <myproc>
80105e7e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e82:	0f 84 30 02 00 00    	je     801060b8 <trap+0x278>
    {
       myproc()->run_ticks++;
    }
    if(cpuid() == 0){
80105e88:	e8 d3 db ff ff       	call   80103a60 <cpuid>
80105e8d:	85 c0                	test   %eax,%eax
80105e8f:	0f 84 4b 02 00 00    	je     801060e0 <trap+0x2a0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105e95:	e8 16 cb ff ff       	call   801029b0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e9a:	e8 e1 db ff ff       	call   80103a80 <myproc>
80105e9f:	85 c0                	test   %eax,%eax
80105ea1:	74 1a                	je     80105ebd <trap+0x7d>
80105ea3:	e8 d8 db ff ff       	call   80103a80 <myproc>
80105ea8:	8b 50 24             	mov    0x24(%eax),%edx
80105eab:	85 d2                	test   %edx,%edx
80105ead:	74 0e                	je     80105ebd <trap+0x7d>
80105eaf:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105eb3:	f7 d0                	not    %eax
80105eb5:	a8 03                	test   $0x3,%al
80105eb7:	0f 84 eb 01 00 00    	je     801060a8 <trap+0x268>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105ebd:	e8 be db ff ff       	call   80103a80 <myproc>
80105ec2:	85 c0                	test   %eax,%eax
80105ec4:	74 0f                	je     80105ed5 <trap+0x95>
80105ec6:	e8 b5 db ff ff       	call   80103a80 <myproc>
80105ecb:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105ecf:	0f 84 ab 00 00 00    	je     80105f80 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ed5:	e8 a6 db ff ff       	call   80103a80 <myproc>
80105eda:	85 c0                	test   %eax,%eax
80105edc:	74 1a                	je     80105ef8 <trap+0xb8>
80105ede:	e8 9d db ff ff       	call   80103a80 <myproc>
80105ee3:	8b 40 24             	mov    0x24(%eax),%eax
80105ee6:	85 c0                	test   %eax,%eax
80105ee8:	74 0e                	je     80105ef8 <trap+0xb8>
80105eea:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105eee:	f7 d0                	not    %eax
80105ef0:	a8 03                	test   $0x3,%al
80105ef2:	0f 84 cd 00 00 00    	je     80105fc5 <trap+0x185>
    exit();
}
80105ef8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105efb:	5b                   	pop    %ebx
80105efc:	5e                   	pop    %esi
80105efd:	5f                   	pop    %edi
80105efe:	5d                   	pop    %ebp
80105eff:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105f00:	e8 7b db ff ff       	call   80103a80 <myproc>
80105f05:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f08:	85 c0                	test   %eax,%eax
80105f0a:	0f 84 04 02 00 00    	je     80106114 <trap+0x2d4>
80105f10:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105f14:	0f 84 fa 01 00 00    	je     80106114 <trap+0x2d4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105f1a:	0f 20 d1             	mov    %cr2,%ecx
80105f1d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f20:	e8 3b db ff ff       	call   80103a60 <cpuid>
80105f25:	8b 73 30             	mov    0x30(%ebx),%esi
80105f28:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105f2b:	8b 43 34             	mov    0x34(%ebx),%eax
80105f2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105f31:	e8 4a db ff ff       	call   80103a80 <myproc>
80105f36:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105f39:	e8 42 db ff ff       	call   80103a80 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f3e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105f41:	51                   	push   %ecx
80105f42:	57                   	push   %edi
80105f43:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105f46:	52                   	push   %edx
80105f47:	ff 75 e4             	push   -0x1c(%ebp)
80105f4a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105f4b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105f4e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f51:	56                   	push   %esi
80105f52:	ff 70 10             	push   0x10(%eax)
80105f55:	68 50 80 10 80       	push   $0x80108050
80105f5a:	e8 51 a7 ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80105f5f:	83 c4 20             	add    $0x20,%esp
80105f62:	e8 19 db ff ff       	call   80103a80 <myproc>
80105f67:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f6e:	e8 0d db ff ff       	call   80103a80 <myproc>
80105f73:	85 c0                	test   %eax,%eax
80105f75:	0f 85 28 ff ff ff    	jne    80105ea3 <trap+0x63>
80105f7b:	e9 3d ff ff ff       	jmp    80105ebd <trap+0x7d>
  if(myproc() && myproc()->state == RUNNING &&
80105f80:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105f84:	0f 85 4b ff ff ff    	jne    80105ed5 <trap+0x95>
    yield();
80105f8a:	e8 51 e1 ff ff       	call   801040e0 <yield>
80105f8f:	e9 41 ff ff ff       	jmp    80105ed5 <trap+0x95>
80105f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105f98:	e8 e3 da ff ff       	call   80103a80 <myproc>
80105f9d:	8b 70 24             	mov    0x24(%eax),%esi
80105fa0:	85 f6                	test   %esi,%esi
80105fa2:	0f 85 28 01 00 00    	jne    801060d0 <trap+0x290>
    myproc()->tf = tf;
80105fa8:	e8 d3 da ff ff       	call   80103a80 <myproc>
80105fad:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105fb0:	e8 ab ec ff ff       	call   80104c60 <syscall>
    if(myproc()->killed)
80105fb5:	e8 c6 da ff ff       	call   80103a80 <myproc>
80105fba:	8b 48 24             	mov    0x24(%eax),%ecx
80105fbd:	85 c9                	test   %ecx,%ecx
80105fbf:	0f 84 33 ff ff ff    	je     80105ef8 <trap+0xb8>
}
80105fc5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fc8:	5b                   	pop    %ebx
80105fc9:	5e                   	pop    %esi
80105fca:	5f                   	pop    %edi
80105fcb:	5d                   	pop    %ebp
      exit();
80105fcc:	e9 af de ff ff       	jmp    80103e80 <exit>
80105fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105fd8:	8b 7b 38             	mov    0x38(%ebx),%edi
80105fdb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105fdf:	e8 7c da ff ff       	call   80103a60 <cpuid>
80105fe4:	57                   	push   %edi
80105fe5:	56                   	push   %esi
80105fe6:	50                   	push   %eax
80105fe7:	68 d0 7f 10 80       	push   $0x80107fd0
80105fec:	e8 bf a6 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105ff1:	e8 ba c9 ff ff       	call   801029b0 <lapiceoi>
    break;
80105ff6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ff9:	e8 82 da ff ff       	call   80103a80 <myproc>
80105ffe:	85 c0                	test   %eax,%eax
80106000:	0f 85 9d fe ff ff    	jne    80105ea3 <trap+0x63>
80106006:	e9 b2 fe ff ff       	jmp    80105ebd <trap+0x7d>
8010600b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    kbdintr();
80106010:	e8 6b c8 ff ff       	call   80102880 <kbdintr>
    lapiceoi();
80106015:	e8 96 c9 ff ff       	call   801029b0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010601a:	e8 61 da ff ff       	call   80103a80 <myproc>
8010601f:	85 c0                	test   %eax,%eax
80106021:	0f 85 7c fe ff ff    	jne    80105ea3 <trap+0x63>
80106027:	e9 91 fe ff ff       	jmp    80105ebd <trap+0x7d>
8010602c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106030:	e8 ab 02 00 00       	call   801062e0 <uartintr>
    lapiceoi();
80106035:	e8 76 c9 ff ff       	call   801029b0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010603a:	e8 41 da ff ff       	call   80103a80 <myproc>
8010603f:	85 c0                	test   %eax,%eax
80106041:	0f 85 5c fe ff ff    	jne    80105ea3 <trap+0x63>
80106047:	e9 71 fe ff ff       	jmp    80105ebd <trap+0x7d>
8010604c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106050:	e8 9b c2 ff ff       	call   801022f0 <ideintr>
80106055:	e9 3b fe ff ff       	jmp    80105e95 <trap+0x55>
8010605a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct proc *p = myproc();
80106060:	e8 1b da ff ff       	call   80103a80 <myproc>
80106065:	89 c6                	mov    %eax,%esi
    if (p == 0) {
80106067:	85 c0                	test   %eax,%eax
80106069:	0f 84 cd 00 00 00    	je     8010613c <trap+0x2fc>
    p->page_faults++;
8010606f:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
80106076:	0f 20 d2             	mov    %cr2,%edx
    if (vmfault(p->pgdir, rcr2(), tf->err & 2) < 0) {
80106079:	8b 43 34             	mov    0x34(%ebx),%eax
8010607c:	83 ec 04             	sub    $0x4,%esp
8010607f:	83 e0 02             	and    $0x2,%eax
80106082:	50                   	push   %eax
80106083:	52                   	push   %edx
80106084:	ff 76 04             	push   0x4(%esi)
80106087:	e8 04 18 00 00       	call   80107890 <vmfault>
8010608c:	83 c4 10             	add    $0x10,%esp
8010608f:	85 c0                	test   %eax,%eax
80106091:	0f 89 03 fe ff ff    	jns    80105e9a <trap+0x5a>
      p->killed = 1;
80106097:	c7 46 24 01 00 00 00 	movl   $0x1,0x24(%esi)
8010609e:	e9 f7 fd ff ff       	jmp    80105e9a <trap+0x5a>
801060a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    exit();
801060a8:	e8 d3 dd ff ff       	call   80103e80 <exit>
801060ad:	e9 0b fe ff ff       	jmp    80105ebd <trap+0x7d>
801060b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       myproc()->run_ticks++;
801060b8:	e8 c3 d9 ff ff       	call   80103a80 <myproc>
801060bd:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
801060c4:	e9 bf fd ff ff       	jmp    80105e88 <trap+0x48>
801060c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      exit();
801060d0:	e8 ab dd ff ff       	call   80103e80 <exit>
801060d5:	e9 ce fe ff ff       	jmp    80105fa8 <trap+0x168>
801060da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801060e0:	83 ec 0c             	sub    $0xc,%esp
801060e3:	68 80 a9 11 80       	push   $0x8011a980
801060e8:	e8 83 e6 ff ff       	call   80104770 <acquire>
      ticks++;
801060ed:	83 05 60 a9 11 80 01 	addl   $0x1,0x8011a960
      wakeup(&ticks);
801060f4:	c7 04 24 60 a9 11 80 	movl   $0x8011a960,(%esp)
801060fb:	e8 f0 e0 ff ff       	call   801041f0 <wakeup>
      release(&tickslock);
80106100:	c7 04 24 80 a9 11 80 	movl   $0x8011a980,(%esp)
80106107:	e8 04 e6 ff ff       	call   80104710 <release>
8010610c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010610f:	e9 81 fd ff ff       	jmp    80105e95 <trap+0x55>
80106114:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106117:	e8 44 d9 ff ff       	call   80103a60 <cpuid>
8010611c:	83 ec 0c             	sub    $0xc,%esp
8010611f:	56                   	push   %esi
80106120:	57                   	push   %edi
80106121:	50                   	push   %eax
80106122:	ff 73 30             	push   0x30(%ebx)
80106125:	68 1c 80 10 80       	push   $0x8010801c
8010612a:	e8 81 a5 ff ff       	call   801006b0 <cprintf>
      panic("trap");
8010612f:	83 c4 14             	add    $0x14,%esp
80106132:	68 e0 7d 10 80       	push   $0x80107de0
80106137:	e8 44 a2 ff ff       	call   80100380 <panic>
      cprintf("page fault in kernel with no process\n");
8010613c:	83 ec 0c             	sub    $0xc,%esp
8010613f:	68 f4 7f 10 80       	push   $0x80107ff4
80106144:	e8 67 a5 ff ff       	call   801006b0 <cprintf>
      panic("trap");
80106149:	c7 04 24 e0 7d 10 80 	movl   $0x80107de0,(%esp)
80106150:	e8 2b a2 ff ff       	call   80100380 <panic>
80106155:	66 90                	xchg   %ax,%ax
80106157:	66 90                	xchg   %ax,%ax
80106159:	66 90                	xchg   %ax,%ax
8010615b:	66 90                	xchg   %ax,%ax
8010615d:	66 90                	xchg   %ax,%ax
8010615f:	90                   	nop

80106160 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106160:	a1 c0 b1 11 80       	mov    0x8011b1c0,%eax
80106165:	85 c0                	test   %eax,%eax
80106167:	74 17                	je     80106180 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106169:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010616e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010616f:	a8 01                	test   $0x1,%al
80106171:	74 0d                	je     80106180 <uartgetc+0x20>
80106173:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106178:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106179:	0f b6 c0             	movzbl %al,%eax
8010617c:	c3                   	ret
8010617d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106185:	c3                   	ret
80106186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010618d:	00 
8010618e:	66 90                	xchg   %ax,%ax

80106190 <uartinit>:
{
80106190:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106191:	31 c9                	xor    %ecx,%ecx
80106193:	89 c8                	mov    %ecx,%eax
80106195:	89 e5                	mov    %esp,%ebp
80106197:	57                   	push   %edi
80106198:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010619d:	56                   	push   %esi
8010619e:	89 fa                	mov    %edi,%edx
801061a0:	53                   	push   %ebx
801061a1:	83 ec 1c             	sub    $0x1c,%esp
801061a4:	ee                   	out    %al,(%dx)
801061a5:	be fb 03 00 00       	mov    $0x3fb,%esi
801061aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801061af:	89 f2                	mov    %esi,%edx
801061b1:	ee                   	out    %al,(%dx)
801061b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801061b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061bc:	ee                   	out    %al,(%dx)
801061bd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801061c2:	89 c8                	mov    %ecx,%eax
801061c4:	89 da                	mov    %ebx,%edx
801061c6:	ee                   	out    %al,(%dx)
801061c7:	b8 03 00 00 00       	mov    $0x3,%eax
801061cc:	89 f2                	mov    %esi,%edx
801061ce:	ee                   	out    %al,(%dx)
801061cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801061d4:	89 c8                	mov    %ecx,%eax
801061d6:	ee                   	out    %al,(%dx)
801061d7:	b8 01 00 00 00       	mov    $0x1,%eax
801061dc:	89 da                	mov    %ebx,%edx
801061de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801061e5:	3c ff                	cmp    $0xff,%al
801061e7:	0f 84 7c 00 00 00    	je     80106269 <uartinit+0xd9>
  uart = 1;
801061ed:	c7 05 c0 b1 11 80 01 	movl   $0x1,0x8011b1c0
801061f4:	00 00 00 
801061f7:	89 fa                	mov    %edi,%edx
801061f9:	ec                   	in     (%dx),%al
801061fa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061ff:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106200:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106203:	bf e5 7d 10 80       	mov    $0x80107de5,%edi
80106208:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010620d:	6a 00                	push   $0x0
8010620f:	6a 04                	push   $0x4
80106211:	e8 0a c3 ff ff       	call   80102520 <ioapicenable>
80106216:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106219:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010621d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106220:	a1 c0 b1 11 80       	mov    0x8011b1c0,%eax
80106225:	85 c0                	test   %eax,%eax
80106227:	74 32                	je     8010625b <uartinit+0xcb>
80106229:	89 f2                	mov    %esi,%edx
8010622b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010622c:	a8 20                	test   $0x20,%al
8010622e:	75 21                	jne    80106251 <uartinit+0xc1>
80106230:	bb 80 00 00 00       	mov    $0x80,%ebx
80106235:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106238:	83 ec 0c             	sub    $0xc,%esp
8010623b:	6a 0a                	push   $0xa
8010623d:	e8 8e c7 ff ff       	call   801029d0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106242:	83 c4 10             	add    $0x10,%esp
80106245:	83 eb 01             	sub    $0x1,%ebx
80106248:	74 07                	je     80106251 <uartinit+0xc1>
8010624a:	89 f2                	mov    %esi,%edx
8010624c:	ec                   	in     (%dx),%al
8010624d:	a8 20                	test   $0x20,%al
8010624f:	74 e7                	je     80106238 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106251:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106256:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010625a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010625b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010625f:	83 c7 01             	add    $0x1,%edi
80106262:	88 45 e7             	mov    %al,-0x19(%ebp)
80106265:	84 c0                	test   %al,%al
80106267:	75 b7                	jne    80106220 <uartinit+0x90>
}
80106269:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010626c:	5b                   	pop    %ebx
8010626d:	5e                   	pop    %esi
8010626e:	5f                   	pop    %edi
8010626f:	5d                   	pop    %ebp
80106270:	c3                   	ret
80106271:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106278:	00 
80106279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106280 <uartputc>:
  if(!uart)
80106280:	a1 c0 b1 11 80       	mov    0x8011b1c0,%eax
80106285:	85 c0                	test   %eax,%eax
80106287:	74 4f                	je     801062d8 <uartputc+0x58>
{
80106289:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010628a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010628f:	89 e5                	mov    %esp,%ebp
80106291:	56                   	push   %esi
80106292:	53                   	push   %ebx
80106293:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106294:	a8 20                	test   $0x20,%al
80106296:	75 29                	jne    801062c1 <uartputc+0x41>
80106298:	bb 80 00 00 00       	mov    $0x80,%ebx
8010629d:	be fd 03 00 00       	mov    $0x3fd,%esi
801062a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801062a8:	83 ec 0c             	sub    $0xc,%esp
801062ab:	6a 0a                	push   $0xa
801062ad:	e8 1e c7 ff ff       	call   801029d0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801062b2:	83 c4 10             	add    $0x10,%esp
801062b5:	83 eb 01             	sub    $0x1,%ebx
801062b8:	74 07                	je     801062c1 <uartputc+0x41>
801062ba:	89 f2                	mov    %esi,%edx
801062bc:	ec                   	in     (%dx),%al
801062bd:	a8 20                	test   $0x20,%al
801062bf:	74 e7                	je     801062a8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801062c1:	8b 45 08             	mov    0x8(%ebp),%eax
801062c4:	ba f8 03 00 00       	mov    $0x3f8,%edx
801062c9:	ee                   	out    %al,(%dx)
}
801062ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801062cd:	5b                   	pop    %ebx
801062ce:	5e                   	pop    %esi
801062cf:	5d                   	pop    %ebp
801062d0:	c3                   	ret
801062d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062d8:	c3                   	ret
801062d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062e0 <uartintr>:

void
uartintr(void)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801062e6:	68 60 61 10 80       	push   $0x80106160
801062eb:	e8 b0 a5 ff ff       	call   801008a0 <consoleintr>
}
801062f0:	83 c4 10             	add    $0x10,%esp
801062f3:	c9                   	leave
801062f4:	c3                   	ret

801062f5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801062f5:	6a 00                	push   $0x0
  pushl $0
801062f7:	6a 00                	push   $0x0
  jmp alltraps
801062f9:	e9 69 fa ff ff       	jmp    80105d67 <alltraps>

801062fe <vector1>:
.globl vector1
vector1:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $1
80106300:	6a 01                	push   $0x1
  jmp alltraps
80106302:	e9 60 fa ff ff       	jmp    80105d67 <alltraps>

80106307 <vector2>:
.globl vector2
vector2:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $2
80106309:	6a 02                	push   $0x2
  jmp alltraps
8010630b:	e9 57 fa ff ff       	jmp    80105d67 <alltraps>

80106310 <vector3>:
.globl vector3
vector3:
  pushl $0
80106310:	6a 00                	push   $0x0
  pushl $3
80106312:	6a 03                	push   $0x3
  jmp alltraps
80106314:	e9 4e fa ff ff       	jmp    80105d67 <alltraps>

80106319 <vector4>:
.globl vector4
vector4:
  pushl $0
80106319:	6a 00                	push   $0x0
  pushl $4
8010631b:	6a 04                	push   $0x4
  jmp alltraps
8010631d:	e9 45 fa ff ff       	jmp    80105d67 <alltraps>

80106322 <vector5>:
.globl vector5
vector5:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $5
80106324:	6a 05                	push   $0x5
  jmp alltraps
80106326:	e9 3c fa ff ff       	jmp    80105d67 <alltraps>

8010632b <vector6>:
.globl vector6
vector6:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $6
8010632d:	6a 06                	push   $0x6
  jmp alltraps
8010632f:	e9 33 fa ff ff       	jmp    80105d67 <alltraps>

80106334 <vector7>:
.globl vector7
vector7:
  pushl $0
80106334:	6a 00                	push   $0x0
  pushl $7
80106336:	6a 07                	push   $0x7
  jmp alltraps
80106338:	e9 2a fa ff ff       	jmp    80105d67 <alltraps>

8010633d <vector8>:
.globl vector8
vector8:
  pushl $8
8010633d:	6a 08                	push   $0x8
  jmp alltraps
8010633f:	e9 23 fa ff ff       	jmp    80105d67 <alltraps>

80106344 <vector9>:
.globl vector9
vector9:
  pushl $0
80106344:	6a 00                	push   $0x0
  pushl $9
80106346:	6a 09                	push   $0x9
  jmp alltraps
80106348:	e9 1a fa ff ff       	jmp    80105d67 <alltraps>

8010634d <vector10>:
.globl vector10
vector10:
  pushl $10
8010634d:	6a 0a                	push   $0xa
  jmp alltraps
8010634f:	e9 13 fa ff ff       	jmp    80105d67 <alltraps>

80106354 <vector11>:
.globl vector11
vector11:
  pushl $11
80106354:	6a 0b                	push   $0xb
  jmp alltraps
80106356:	e9 0c fa ff ff       	jmp    80105d67 <alltraps>

8010635b <vector12>:
.globl vector12
vector12:
  pushl $12
8010635b:	6a 0c                	push   $0xc
  jmp alltraps
8010635d:	e9 05 fa ff ff       	jmp    80105d67 <alltraps>

80106362 <vector13>:
.globl vector13
vector13:
  pushl $13
80106362:	6a 0d                	push   $0xd
  jmp alltraps
80106364:	e9 fe f9 ff ff       	jmp    80105d67 <alltraps>

80106369 <vector14>:
.globl vector14
vector14:
  pushl $14
80106369:	6a 0e                	push   $0xe
  jmp alltraps
8010636b:	e9 f7 f9 ff ff       	jmp    80105d67 <alltraps>

80106370 <vector15>:
.globl vector15
vector15:
  pushl $0
80106370:	6a 00                	push   $0x0
  pushl $15
80106372:	6a 0f                	push   $0xf
  jmp alltraps
80106374:	e9 ee f9 ff ff       	jmp    80105d67 <alltraps>

80106379 <vector16>:
.globl vector16
vector16:
  pushl $0
80106379:	6a 00                	push   $0x0
  pushl $16
8010637b:	6a 10                	push   $0x10
  jmp alltraps
8010637d:	e9 e5 f9 ff ff       	jmp    80105d67 <alltraps>

80106382 <vector17>:
.globl vector17
vector17:
  pushl $17
80106382:	6a 11                	push   $0x11
  jmp alltraps
80106384:	e9 de f9 ff ff       	jmp    80105d67 <alltraps>

80106389 <vector18>:
.globl vector18
vector18:
  pushl $0
80106389:	6a 00                	push   $0x0
  pushl $18
8010638b:	6a 12                	push   $0x12
  jmp alltraps
8010638d:	e9 d5 f9 ff ff       	jmp    80105d67 <alltraps>

80106392 <vector19>:
.globl vector19
vector19:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $19
80106394:	6a 13                	push   $0x13
  jmp alltraps
80106396:	e9 cc f9 ff ff       	jmp    80105d67 <alltraps>

8010639b <vector20>:
.globl vector20
vector20:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $20
8010639d:	6a 14                	push   $0x14
  jmp alltraps
8010639f:	e9 c3 f9 ff ff       	jmp    80105d67 <alltraps>

801063a4 <vector21>:
.globl vector21
vector21:
  pushl $0
801063a4:	6a 00                	push   $0x0
  pushl $21
801063a6:	6a 15                	push   $0x15
  jmp alltraps
801063a8:	e9 ba f9 ff ff       	jmp    80105d67 <alltraps>

801063ad <vector22>:
.globl vector22
vector22:
  pushl $0
801063ad:	6a 00                	push   $0x0
  pushl $22
801063af:	6a 16                	push   $0x16
  jmp alltraps
801063b1:	e9 b1 f9 ff ff       	jmp    80105d67 <alltraps>

801063b6 <vector23>:
.globl vector23
vector23:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $23
801063b8:	6a 17                	push   $0x17
  jmp alltraps
801063ba:	e9 a8 f9 ff ff       	jmp    80105d67 <alltraps>

801063bf <vector24>:
.globl vector24
vector24:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $24
801063c1:	6a 18                	push   $0x18
  jmp alltraps
801063c3:	e9 9f f9 ff ff       	jmp    80105d67 <alltraps>

801063c8 <vector25>:
.globl vector25
vector25:
  pushl $0
801063c8:	6a 00                	push   $0x0
  pushl $25
801063ca:	6a 19                	push   $0x19
  jmp alltraps
801063cc:	e9 96 f9 ff ff       	jmp    80105d67 <alltraps>

801063d1 <vector26>:
.globl vector26
vector26:
  pushl $0
801063d1:	6a 00                	push   $0x0
  pushl $26
801063d3:	6a 1a                	push   $0x1a
  jmp alltraps
801063d5:	e9 8d f9 ff ff       	jmp    80105d67 <alltraps>

801063da <vector27>:
.globl vector27
vector27:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $27
801063dc:	6a 1b                	push   $0x1b
  jmp alltraps
801063de:	e9 84 f9 ff ff       	jmp    80105d67 <alltraps>

801063e3 <vector28>:
.globl vector28
vector28:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $28
801063e5:	6a 1c                	push   $0x1c
  jmp alltraps
801063e7:	e9 7b f9 ff ff       	jmp    80105d67 <alltraps>

801063ec <vector29>:
.globl vector29
vector29:
  pushl $0
801063ec:	6a 00                	push   $0x0
  pushl $29
801063ee:	6a 1d                	push   $0x1d
  jmp alltraps
801063f0:	e9 72 f9 ff ff       	jmp    80105d67 <alltraps>

801063f5 <vector30>:
.globl vector30
vector30:
  pushl $0
801063f5:	6a 00                	push   $0x0
  pushl $30
801063f7:	6a 1e                	push   $0x1e
  jmp alltraps
801063f9:	e9 69 f9 ff ff       	jmp    80105d67 <alltraps>

801063fe <vector31>:
.globl vector31
vector31:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $31
80106400:	6a 1f                	push   $0x1f
  jmp alltraps
80106402:	e9 60 f9 ff ff       	jmp    80105d67 <alltraps>

80106407 <vector32>:
.globl vector32
vector32:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $32
80106409:	6a 20                	push   $0x20
  jmp alltraps
8010640b:	e9 57 f9 ff ff       	jmp    80105d67 <alltraps>

80106410 <vector33>:
.globl vector33
vector33:
  pushl $0
80106410:	6a 00                	push   $0x0
  pushl $33
80106412:	6a 21                	push   $0x21
  jmp alltraps
80106414:	e9 4e f9 ff ff       	jmp    80105d67 <alltraps>

80106419 <vector34>:
.globl vector34
vector34:
  pushl $0
80106419:	6a 00                	push   $0x0
  pushl $34
8010641b:	6a 22                	push   $0x22
  jmp alltraps
8010641d:	e9 45 f9 ff ff       	jmp    80105d67 <alltraps>

80106422 <vector35>:
.globl vector35
vector35:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $35
80106424:	6a 23                	push   $0x23
  jmp alltraps
80106426:	e9 3c f9 ff ff       	jmp    80105d67 <alltraps>

8010642b <vector36>:
.globl vector36
vector36:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $36
8010642d:	6a 24                	push   $0x24
  jmp alltraps
8010642f:	e9 33 f9 ff ff       	jmp    80105d67 <alltraps>

80106434 <vector37>:
.globl vector37
vector37:
  pushl $0
80106434:	6a 00                	push   $0x0
  pushl $37
80106436:	6a 25                	push   $0x25
  jmp alltraps
80106438:	e9 2a f9 ff ff       	jmp    80105d67 <alltraps>

8010643d <vector38>:
.globl vector38
vector38:
  pushl $0
8010643d:	6a 00                	push   $0x0
  pushl $38
8010643f:	6a 26                	push   $0x26
  jmp alltraps
80106441:	e9 21 f9 ff ff       	jmp    80105d67 <alltraps>

80106446 <vector39>:
.globl vector39
vector39:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $39
80106448:	6a 27                	push   $0x27
  jmp alltraps
8010644a:	e9 18 f9 ff ff       	jmp    80105d67 <alltraps>

8010644f <vector40>:
.globl vector40
vector40:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $40
80106451:	6a 28                	push   $0x28
  jmp alltraps
80106453:	e9 0f f9 ff ff       	jmp    80105d67 <alltraps>

80106458 <vector41>:
.globl vector41
vector41:
  pushl $0
80106458:	6a 00                	push   $0x0
  pushl $41
8010645a:	6a 29                	push   $0x29
  jmp alltraps
8010645c:	e9 06 f9 ff ff       	jmp    80105d67 <alltraps>

80106461 <vector42>:
.globl vector42
vector42:
  pushl $0
80106461:	6a 00                	push   $0x0
  pushl $42
80106463:	6a 2a                	push   $0x2a
  jmp alltraps
80106465:	e9 fd f8 ff ff       	jmp    80105d67 <alltraps>

8010646a <vector43>:
.globl vector43
vector43:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $43
8010646c:	6a 2b                	push   $0x2b
  jmp alltraps
8010646e:	e9 f4 f8 ff ff       	jmp    80105d67 <alltraps>

80106473 <vector44>:
.globl vector44
vector44:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $44
80106475:	6a 2c                	push   $0x2c
  jmp alltraps
80106477:	e9 eb f8 ff ff       	jmp    80105d67 <alltraps>

8010647c <vector45>:
.globl vector45
vector45:
  pushl $0
8010647c:	6a 00                	push   $0x0
  pushl $45
8010647e:	6a 2d                	push   $0x2d
  jmp alltraps
80106480:	e9 e2 f8 ff ff       	jmp    80105d67 <alltraps>

80106485 <vector46>:
.globl vector46
vector46:
  pushl $0
80106485:	6a 00                	push   $0x0
  pushl $46
80106487:	6a 2e                	push   $0x2e
  jmp alltraps
80106489:	e9 d9 f8 ff ff       	jmp    80105d67 <alltraps>

8010648e <vector47>:
.globl vector47
vector47:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $47
80106490:	6a 2f                	push   $0x2f
  jmp alltraps
80106492:	e9 d0 f8 ff ff       	jmp    80105d67 <alltraps>

80106497 <vector48>:
.globl vector48
vector48:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $48
80106499:	6a 30                	push   $0x30
  jmp alltraps
8010649b:	e9 c7 f8 ff ff       	jmp    80105d67 <alltraps>

801064a0 <vector49>:
.globl vector49
vector49:
  pushl $0
801064a0:	6a 00                	push   $0x0
  pushl $49
801064a2:	6a 31                	push   $0x31
  jmp alltraps
801064a4:	e9 be f8 ff ff       	jmp    80105d67 <alltraps>

801064a9 <vector50>:
.globl vector50
vector50:
  pushl $0
801064a9:	6a 00                	push   $0x0
  pushl $50
801064ab:	6a 32                	push   $0x32
  jmp alltraps
801064ad:	e9 b5 f8 ff ff       	jmp    80105d67 <alltraps>

801064b2 <vector51>:
.globl vector51
vector51:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $51
801064b4:	6a 33                	push   $0x33
  jmp alltraps
801064b6:	e9 ac f8 ff ff       	jmp    80105d67 <alltraps>

801064bb <vector52>:
.globl vector52
vector52:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $52
801064bd:	6a 34                	push   $0x34
  jmp alltraps
801064bf:	e9 a3 f8 ff ff       	jmp    80105d67 <alltraps>

801064c4 <vector53>:
.globl vector53
vector53:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $53
801064c6:	6a 35                	push   $0x35
  jmp alltraps
801064c8:	e9 9a f8 ff ff       	jmp    80105d67 <alltraps>

801064cd <vector54>:
.globl vector54
vector54:
  pushl $0
801064cd:	6a 00                	push   $0x0
  pushl $54
801064cf:	6a 36                	push   $0x36
  jmp alltraps
801064d1:	e9 91 f8 ff ff       	jmp    80105d67 <alltraps>

801064d6 <vector55>:
.globl vector55
vector55:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $55
801064d8:	6a 37                	push   $0x37
  jmp alltraps
801064da:	e9 88 f8 ff ff       	jmp    80105d67 <alltraps>

801064df <vector56>:
.globl vector56
vector56:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $56
801064e1:	6a 38                	push   $0x38
  jmp alltraps
801064e3:	e9 7f f8 ff ff       	jmp    80105d67 <alltraps>

801064e8 <vector57>:
.globl vector57
vector57:
  pushl $0
801064e8:	6a 00                	push   $0x0
  pushl $57
801064ea:	6a 39                	push   $0x39
  jmp alltraps
801064ec:	e9 76 f8 ff ff       	jmp    80105d67 <alltraps>

801064f1 <vector58>:
.globl vector58
vector58:
  pushl $0
801064f1:	6a 00                	push   $0x0
  pushl $58
801064f3:	6a 3a                	push   $0x3a
  jmp alltraps
801064f5:	e9 6d f8 ff ff       	jmp    80105d67 <alltraps>

801064fa <vector59>:
.globl vector59
vector59:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $59
801064fc:	6a 3b                	push   $0x3b
  jmp alltraps
801064fe:	e9 64 f8 ff ff       	jmp    80105d67 <alltraps>

80106503 <vector60>:
.globl vector60
vector60:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $60
80106505:	6a 3c                	push   $0x3c
  jmp alltraps
80106507:	e9 5b f8 ff ff       	jmp    80105d67 <alltraps>

8010650c <vector61>:
.globl vector61
vector61:
  pushl $0
8010650c:	6a 00                	push   $0x0
  pushl $61
8010650e:	6a 3d                	push   $0x3d
  jmp alltraps
80106510:	e9 52 f8 ff ff       	jmp    80105d67 <alltraps>

80106515 <vector62>:
.globl vector62
vector62:
  pushl $0
80106515:	6a 00                	push   $0x0
  pushl $62
80106517:	6a 3e                	push   $0x3e
  jmp alltraps
80106519:	e9 49 f8 ff ff       	jmp    80105d67 <alltraps>

8010651e <vector63>:
.globl vector63
vector63:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $63
80106520:	6a 3f                	push   $0x3f
  jmp alltraps
80106522:	e9 40 f8 ff ff       	jmp    80105d67 <alltraps>

80106527 <vector64>:
.globl vector64
vector64:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $64
80106529:	6a 40                	push   $0x40
  jmp alltraps
8010652b:	e9 37 f8 ff ff       	jmp    80105d67 <alltraps>

80106530 <vector65>:
.globl vector65
vector65:
  pushl $0
80106530:	6a 00                	push   $0x0
  pushl $65
80106532:	6a 41                	push   $0x41
  jmp alltraps
80106534:	e9 2e f8 ff ff       	jmp    80105d67 <alltraps>

80106539 <vector66>:
.globl vector66
vector66:
  pushl $0
80106539:	6a 00                	push   $0x0
  pushl $66
8010653b:	6a 42                	push   $0x42
  jmp alltraps
8010653d:	e9 25 f8 ff ff       	jmp    80105d67 <alltraps>

80106542 <vector67>:
.globl vector67
vector67:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $67
80106544:	6a 43                	push   $0x43
  jmp alltraps
80106546:	e9 1c f8 ff ff       	jmp    80105d67 <alltraps>

8010654b <vector68>:
.globl vector68
vector68:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $68
8010654d:	6a 44                	push   $0x44
  jmp alltraps
8010654f:	e9 13 f8 ff ff       	jmp    80105d67 <alltraps>

80106554 <vector69>:
.globl vector69
vector69:
  pushl $0
80106554:	6a 00                	push   $0x0
  pushl $69
80106556:	6a 45                	push   $0x45
  jmp alltraps
80106558:	e9 0a f8 ff ff       	jmp    80105d67 <alltraps>

8010655d <vector70>:
.globl vector70
vector70:
  pushl $0
8010655d:	6a 00                	push   $0x0
  pushl $70
8010655f:	6a 46                	push   $0x46
  jmp alltraps
80106561:	e9 01 f8 ff ff       	jmp    80105d67 <alltraps>

80106566 <vector71>:
.globl vector71
vector71:
  pushl $0
80106566:	6a 00                	push   $0x0
  pushl $71
80106568:	6a 47                	push   $0x47
  jmp alltraps
8010656a:	e9 f8 f7 ff ff       	jmp    80105d67 <alltraps>

8010656f <vector72>:
.globl vector72
vector72:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $72
80106571:	6a 48                	push   $0x48
  jmp alltraps
80106573:	e9 ef f7 ff ff       	jmp    80105d67 <alltraps>

80106578 <vector73>:
.globl vector73
vector73:
  pushl $0
80106578:	6a 00                	push   $0x0
  pushl $73
8010657a:	6a 49                	push   $0x49
  jmp alltraps
8010657c:	e9 e6 f7 ff ff       	jmp    80105d67 <alltraps>

80106581 <vector74>:
.globl vector74
vector74:
  pushl $0
80106581:	6a 00                	push   $0x0
  pushl $74
80106583:	6a 4a                	push   $0x4a
  jmp alltraps
80106585:	e9 dd f7 ff ff       	jmp    80105d67 <alltraps>

8010658a <vector75>:
.globl vector75
vector75:
  pushl $0
8010658a:	6a 00                	push   $0x0
  pushl $75
8010658c:	6a 4b                	push   $0x4b
  jmp alltraps
8010658e:	e9 d4 f7 ff ff       	jmp    80105d67 <alltraps>

80106593 <vector76>:
.globl vector76
vector76:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $76
80106595:	6a 4c                	push   $0x4c
  jmp alltraps
80106597:	e9 cb f7 ff ff       	jmp    80105d67 <alltraps>

8010659c <vector77>:
.globl vector77
vector77:
  pushl $0
8010659c:	6a 00                	push   $0x0
  pushl $77
8010659e:	6a 4d                	push   $0x4d
  jmp alltraps
801065a0:	e9 c2 f7 ff ff       	jmp    80105d67 <alltraps>

801065a5 <vector78>:
.globl vector78
vector78:
  pushl $0
801065a5:	6a 00                	push   $0x0
  pushl $78
801065a7:	6a 4e                	push   $0x4e
  jmp alltraps
801065a9:	e9 b9 f7 ff ff       	jmp    80105d67 <alltraps>

801065ae <vector79>:
.globl vector79
vector79:
  pushl $0
801065ae:	6a 00                	push   $0x0
  pushl $79
801065b0:	6a 4f                	push   $0x4f
  jmp alltraps
801065b2:	e9 b0 f7 ff ff       	jmp    80105d67 <alltraps>

801065b7 <vector80>:
.globl vector80
vector80:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $80
801065b9:	6a 50                	push   $0x50
  jmp alltraps
801065bb:	e9 a7 f7 ff ff       	jmp    80105d67 <alltraps>

801065c0 <vector81>:
.globl vector81
vector81:
  pushl $0
801065c0:	6a 00                	push   $0x0
  pushl $81
801065c2:	6a 51                	push   $0x51
  jmp alltraps
801065c4:	e9 9e f7 ff ff       	jmp    80105d67 <alltraps>

801065c9 <vector82>:
.globl vector82
vector82:
  pushl $0
801065c9:	6a 00                	push   $0x0
  pushl $82
801065cb:	6a 52                	push   $0x52
  jmp alltraps
801065cd:	e9 95 f7 ff ff       	jmp    80105d67 <alltraps>

801065d2 <vector83>:
.globl vector83
vector83:
  pushl $0
801065d2:	6a 00                	push   $0x0
  pushl $83
801065d4:	6a 53                	push   $0x53
  jmp alltraps
801065d6:	e9 8c f7 ff ff       	jmp    80105d67 <alltraps>

801065db <vector84>:
.globl vector84
vector84:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $84
801065dd:	6a 54                	push   $0x54
  jmp alltraps
801065df:	e9 83 f7 ff ff       	jmp    80105d67 <alltraps>

801065e4 <vector85>:
.globl vector85
vector85:
  pushl $0
801065e4:	6a 00                	push   $0x0
  pushl $85
801065e6:	6a 55                	push   $0x55
  jmp alltraps
801065e8:	e9 7a f7 ff ff       	jmp    80105d67 <alltraps>

801065ed <vector86>:
.globl vector86
vector86:
  pushl $0
801065ed:	6a 00                	push   $0x0
  pushl $86
801065ef:	6a 56                	push   $0x56
  jmp alltraps
801065f1:	e9 71 f7 ff ff       	jmp    80105d67 <alltraps>

801065f6 <vector87>:
.globl vector87
vector87:
  pushl $0
801065f6:	6a 00                	push   $0x0
  pushl $87
801065f8:	6a 57                	push   $0x57
  jmp alltraps
801065fa:	e9 68 f7 ff ff       	jmp    80105d67 <alltraps>

801065ff <vector88>:
.globl vector88
vector88:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $88
80106601:	6a 58                	push   $0x58
  jmp alltraps
80106603:	e9 5f f7 ff ff       	jmp    80105d67 <alltraps>

80106608 <vector89>:
.globl vector89
vector89:
  pushl $0
80106608:	6a 00                	push   $0x0
  pushl $89
8010660a:	6a 59                	push   $0x59
  jmp alltraps
8010660c:	e9 56 f7 ff ff       	jmp    80105d67 <alltraps>

80106611 <vector90>:
.globl vector90
vector90:
  pushl $0
80106611:	6a 00                	push   $0x0
  pushl $90
80106613:	6a 5a                	push   $0x5a
  jmp alltraps
80106615:	e9 4d f7 ff ff       	jmp    80105d67 <alltraps>

8010661a <vector91>:
.globl vector91
vector91:
  pushl $0
8010661a:	6a 00                	push   $0x0
  pushl $91
8010661c:	6a 5b                	push   $0x5b
  jmp alltraps
8010661e:	e9 44 f7 ff ff       	jmp    80105d67 <alltraps>

80106623 <vector92>:
.globl vector92
vector92:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $92
80106625:	6a 5c                	push   $0x5c
  jmp alltraps
80106627:	e9 3b f7 ff ff       	jmp    80105d67 <alltraps>

8010662c <vector93>:
.globl vector93
vector93:
  pushl $0
8010662c:	6a 00                	push   $0x0
  pushl $93
8010662e:	6a 5d                	push   $0x5d
  jmp alltraps
80106630:	e9 32 f7 ff ff       	jmp    80105d67 <alltraps>

80106635 <vector94>:
.globl vector94
vector94:
  pushl $0
80106635:	6a 00                	push   $0x0
  pushl $94
80106637:	6a 5e                	push   $0x5e
  jmp alltraps
80106639:	e9 29 f7 ff ff       	jmp    80105d67 <alltraps>

8010663e <vector95>:
.globl vector95
vector95:
  pushl $0
8010663e:	6a 00                	push   $0x0
  pushl $95
80106640:	6a 5f                	push   $0x5f
  jmp alltraps
80106642:	e9 20 f7 ff ff       	jmp    80105d67 <alltraps>

80106647 <vector96>:
.globl vector96
vector96:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $96
80106649:	6a 60                	push   $0x60
  jmp alltraps
8010664b:	e9 17 f7 ff ff       	jmp    80105d67 <alltraps>

80106650 <vector97>:
.globl vector97
vector97:
  pushl $0
80106650:	6a 00                	push   $0x0
  pushl $97
80106652:	6a 61                	push   $0x61
  jmp alltraps
80106654:	e9 0e f7 ff ff       	jmp    80105d67 <alltraps>

80106659 <vector98>:
.globl vector98
vector98:
  pushl $0
80106659:	6a 00                	push   $0x0
  pushl $98
8010665b:	6a 62                	push   $0x62
  jmp alltraps
8010665d:	e9 05 f7 ff ff       	jmp    80105d67 <alltraps>

80106662 <vector99>:
.globl vector99
vector99:
  pushl $0
80106662:	6a 00                	push   $0x0
  pushl $99
80106664:	6a 63                	push   $0x63
  jmp alltraps
80106666:	e9 fc f6 ff ff       	jmp    80105d67 <alltraps>

8010666b <vector100>:
.globl vector100
vector100:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $100
8010666d:	6a 64                	push   $0x64
  jmp alltraps
8010666f:	e9 f3 f6 ff ff       	jmp    80105d67 <alltraps>

80106674 <vector101>:
.globl vector101
vector101:
  pushl $0
80106674:	6a 00                	push   $0x0
  pushl $101
80106676:	6a 65                	push   $0x65
  jmp alltraps
80106678:	e9 ea f6 ff ff       	jmp    80105d67 <alltraps>

8010667d <vector102>:
.globl vector102
vector102:
  pushl $0
8010667d:	6a 00                	push   $0x0
  pushl $102
8010667f:	6a 66                	push   $0x66
  jmp alltraps
80106681:	e9 e1 f6 ff ff       	jmp    80105d67 <alltraps>

80106686 <vector103>:
.globl vector103
vector103:
  pushl $0
80106686:	6a 00                	push   $0x0
  pushl $103
80106688:	6a 67                	push   $0x67
  jmp alltraps
8010668a:	e9 d8 f6 ff ff       	jmp    80105d67 <alltraps>

8010668f <vector104>:
.globl vector104
vector104:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $104
80106691:	6a 68                	push   $0x68
  jmp alltraps
80106693:	e9 cf f6 ff ff       	jmp    80105d67 <alltraps>

80106698 <vector105>:
.globl vector105
vector105:
  pushl $0
80106698:	6a 00                	push   $0x0
  pushl $105
8010669a:	6a 69                	push   $0x69
  jmp alltraps
8010669c:	e9 c6 f6 ff ff       	jmp    80105d67 <alltraps>

801066a1 <vector106>:
.globl vector106
vector106:
  pushl $0
801066a1:	6a 00                	push   $0x0
  pushl $106
801066a3:	6a 6a                	push   $0x6a
  jmp alltraps
801066a5:	e9 bd f6 ff ff       	jmp    80105d67 <alltraps>

801066aa <vector107>:
.globl vector107
vector107:
  pushl $0
801066aa:	6a 00                	push   $0x0
  pushl $107
801066ac:	6a 6b                	push   $0x6b
  jmp alltraps
801066ae:	e9 b4 f6 ff ff       	jmp    80105d67 <alltraps>

801066b3 <vector108>:
.globl vector108
vector108:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $108
801066b5:	6a 6c                	push   $0x6c
  jmp alltraps
801066b7:	e9 ab f6 ff ff       	jmp    80105d67 <alltraps>

801066bc <vector109>:
.globl vector109
vector109:
  pushl $0
801066bc:	6a 00                	push   $0x0
  pushl $109
801066be:	6a 6d                	push   $0x6d
  jmp alltraps
801066c0:	e9 a2 f6 ff ff       	jmp    80105d67 <alltraps>

801066c5 <vector110>:
.globl vector110
vector110:
  pushl $0
801066c5:	6a 00                	push   $0x0
  pushl $110
801066c7:	6a 6e                	push   $0x6e
  jmp alltraps
801066c9:	e9 99 f6 ff ff       	jmp    80105d67 <alltraps>

801066ce <vector111>:
.globl vector111
vector111:
  pushl $0
801066ce:	6a 00                	push   $0x0
  pushl $111
801066d0:	6a 6f                	push   $0x6f
  jmp alltraps
801066d2:	e9 90 f6 ff ff       	jmp    80105d67 <alltraps>

801066d7 <vector112>:
.globl vector112
vector112:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $112
801066d9:	6a 70                	push   $0x70
  jmp alltraps
801066db:	e9 87 f6 ff ff       	jmp    80105d67 <alltraps>

801066e0 <vector113>:
.globl vector113
vector113:
  pushl $0
801066e0:	6a 00                	push   $0x0
  pushl $113
801066e2:	6a 71                	push   $0x71
  jmp alltraps
801066e4:	e9 7e f6 ff ff       	jmp    80105d67 <alltraps>

801066e9 <vector114>:
.globl vector114
vector114:
  pushl $0
801066e9:	6a 00                	push   $0x0
  pushl $114
801066eb:	6a 72                	push   $0x72
  jmp alltraps
801066ed:	e9 75 f6 ff ff       	jmp    80105d67 <alltraps>

801066f2 <vector115>:
.globl vector115
vector115:
  pushl $0
801066f2:	6a 00                	push   $0x0
  pushl $115
801066f4:	6a 73                	push   $0x73
  jmp alltraps
801066f6:	e9 6c f6 ff ff       	jmp    80105d67 <alltraps>

801066fb <vector116>:
.globl vector116
vector116:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $116
801066fd:	6a 74                	push   $0x74
  jmp alltraps
801066ff:	e9 63 f6 ff ff       	jmp    80105d67 <alltraps>

80106704 <vector117>:
.globl vector117
vector117:
  pushl $0
80106704:	6a 00                	push   $0x0
  pushl $117
80106706:	6a 75                	push   $0x75
  jmp alltraps
80106708:	e9 5a f6 ff ff       	jmp    80105d67 <alltraps>

8010670d <vector118>:
.globl vector118
vector118:
  pushl $0
8010670d:	6a 00                	push   $0x0
  pushl $118
8010670f:	6a 76                	push   $0x76
  jmp alltraps
80106711:	e9 51 f6 ff ff       	jmp    80105d67 <alltraps>

80106716 <vector119>:
.globl vector119
vector119:
  pushl $0
80106716:	6a 00                	push   $0x0
  pushl $119
80106718:	6a 77                	push   $0x77
  jmp alltraps
8010671a:	e9 48 f6 ff ff       	jmp    80105d67 <alltraps>

8010671f <vector120>:
.globl vector120
vector120:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $120
80106721:	6a 78                	push   $0x78
  jmp alltraps
80106723:	e9 3f f6 ff ff       	jmp    80105d67 <alltraps>

80106728 <vector121>:
.globl vector121
vector121:
  pushl $0
80106728:	6a 00                	push   $0x0
  pushl $121
8010672a:	6a 79                	push   $0x79
  jmp alltraps
8010672c:	e9 36 f6 ff ff       	jmp    80105d67 <alltraps>

80106731 <vector122>:
.globl vector122
vector122:
  pushl $0
80106731:	6a 00                	push   $0x0
  pushl $122
80106733:	6a 7a                	push   $0x7a
  jmp alltraps
80106735:	e9 2d f6 ff ff       	jmp    80105d67 <alltraps>

8010673a <vector123>:
.globl vector123
vector123:
  pushl $0
8010673a:	6a 00                	push   $0x0
  pushl $123
8010673c:	6a 7b                	push   $0x7b
  jmp alltraps
8010673e:	e9 24 f6 ff ff       	jmp    80105d67 <alltraps>

80106743 <vector124>:
.globl vector124
vector124:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $124
80106745:	6a 7c                	push   $0x7c
  jmp alltraps
80106747:	e9 1b f6 ff ff       	jmp    80105d67 <alltraps>

8010674c <vector125>:
.globl vector125
vector125:
  pushl $0
8010674c:	6a 00                	push   $0x0
  pushl $125
8010674e:	6a 7d                	push   $0x7d
  jmp alltraps
80106750:	e9 12 f6 ff ff       	jmp    80105d67 <alltraps>

80106755 <vector126>:
.globl vector126
vector126:
  pushl $0
80106755:	6a 00                	push   $0x0
  pushl $126
80106757:	6a 7e                	push   $0x7e
  jmp alltraps
80106759:	e9 09 f6 ff ff       	jmp    80105d67 <alltraps>

8010675e <vector127>:
.globl vector127
vector127:
  pushl $0
8010675e:	6a 00                	push   $0x0
  pushl $127
80106760:	6a 7f                	push   $0x7f
  jmp alltraps
80106762:	e9 00 f6 ff ff       	jmp    80105d67 <alltraps>

80106767 <vector128>:
.globl vector128
vector128:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $128
80106769:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010676e:	e9 f4 f5 ff ff       	jmp    80105d67 <alltraps>

80106773 <vector129>:
.globl vector129
vector129:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $129
80106775:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010677a:	e9 e8 f5 ff ff       	jmp    80105d67 <alltraps>

8010677f <vector130>:
.globl vector130
vector130:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $130
80106781:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106786:	e9 dc f5 ff ff       	jmp    80105d67 <alltraps>

8010678b <vector131>:
.globl vector131
vector131:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $131
8010678d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106792:	e9 d0 f5 ff ff       	jmp    80105d67 <alltraps>

80106797 <vector132>:
.globl vector132
vector132:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $132
80106799:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010679e:	e9 c4 f5 ff ff       	jmp    80105d67 <alltraps>

801067a3 <vector133>:
.globl vector133
vector133:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $133
801067a5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801067aa:	e9 b8 f5 ff ff       	jmp    80105d67 <alltraps>

801067af <vector134>:
.globl vector134
vector134:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $134
801067b1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801067b6:	e9 ac f5 ff ff       	jmp    80105d67 <alltraps>

801067bb <vector135>:
.globl vector135
vector135:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $135
801067bd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801067c2:	e9 a0 f5 ff ff       	jmp    80105d67 <alltraps>

801067c7 <vector136>:
.globl vector136
vector136:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $136
801067c9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801067ce:	e9 94 f5 ff ff       	jmp    80105d67 <alltraps>

801067d3 <vector137>:
.globl vector137
vector137:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $137
801067d5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801067da:	e9 88 f5 ff ff       	jmp    80105d67 <alltraps>

801067df <vector138>:
.globl vector138
vector138:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $138
801067e1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801067e6:	e9 7c f5 ff ff       	jmp    80105d67 <alltraps>

801067eb <vector139>:
.globl vector139
vector139:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $139
801067ed:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801067f2:	e9 70 f5 ff ff       	jmp    80105d67 <alltraps>

801067f7 <vector140>:
.globl vector140
vector140:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $140
801067f9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801067fe:	e9 64 f5 ff ff       	jmp    80105d67 <alltraps>

80106803 <vector141>:
.globl vector141
vector141:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $141
80106805:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010680a:	e9 58 f5 ff ff       	jmp    80105d67 <alltraps>

8010680f <vector142>:
.globl vector142
vector142:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $142
80106811:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106816:	e9 4c f5 ff ff       	jmp    80105d67 <alltraps>

8010681b <vector143>:
.globl vector143
vector143:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $143
8010681d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106822:	e9 40 f5 ff ff       	jmp    80105d67 <alltraps>

80106827 <vector144>:
.globl vector144
vector144:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $144
80106829:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010682e:	e9 34 f5 ff ff       	jmp    80105d67 <alltraps>

80106833 <vector145>:
.globl vector145
vector145:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $145
80106835:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010683a:	e9 28 f5 ff ff       	jmp    80105d67 <alltraps>

8010683f <vector146>:
.globl vector146
vector146:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $146
80106841:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106846:	e9 1c f5 ff ff       	jmp    80105d67 <alltraps>

8010684b <vector147>:
.globl vector147
vector147:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $147
8010684d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106852:	e9 10 f5 ff ff       	jmp    80105d67 <alltraps>

80106857 <vector148>:
.globl vector148
vector148:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $148
80106859:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010685e:	e9 04 f5 ff ff       	jmp    80105d67 <alltraps>

80106863 <vector149>:
.globl vector149
vector149:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $149
80106865:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010686a:	e9 f8 f4 ff ff       	jmp    80105d67 <alltraps>

8010686f <vector150>:
.globl vector150
vector150:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $150
80106871:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106876:	e9 ec f4 ff ff       	jmp    80105d67 <alltraps>

8010687b <vector151>:
.globl vector151
vector151:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $151
8010687d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106882:	e9 e0 f4 ff ff       	jmp    80105d67 <alltraps>

80106887 <vector152>:
.globl vector152
vector152:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $152
80106889:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010688e:	e9 d4 f4 ff ff       	jmp    80105d67 <alltraps>

80106893 <vector153>:
.globl vector153
vector153:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $153
80106895:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010689a:	e9 c8 f4 ff ff       	jmp    80105d67 <alltraps>

8010689f <vector154>:
.globl vector154
vector154:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $154
801068a1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801068a6:	e9 bc f4 ff ff       	jmp    80105d67 <alltraps>

801068ab <vector155>:
.globl vector155
vector155:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $155
801068ad:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801068b2:	e9 b0 f4 ff ff       	jmp    80105d67 <alltraps>

801068b7 <vector156>:
.globl vector156
vector156:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $156
801068b9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801068be:	e9 a4 f4 ff ff       	jmp    80105d67 <alltraps>

801068c3 <vector157>:
.globl vector157
vector157:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $157
801068c5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801068ca:	e9 98 f4 ff ff       	jmp    80105d67 <alltraps>

801068cf <vector158>:
.globl vector158
vector158:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $158
801068d1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801068d6:	e9 8c f4 ff ff       	jmp    80105d67 <alltraps>

801068db <vector159>:
.globl vector159
vector159:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $159
801068dd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801068e2:	e9 80 f4 ff ff       	jmp    80105d67 <alltraps>

801068e7 <vector160>:
.globl vector160
vector160:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $160
801068e9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801068ee:	e9 74 f4 ff ff       	jmp    80105d67 <alltraps>

801068f3 <vector161>:
.globl vector161
vector161:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $161
801068f5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801068fa:	e9 68 f4 ff ff       	jmp    80105d67 <alltraps>

801068ff <vector162>:
.globl vector162
vector162:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $162
80106901:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106906:	e9 5c f4 ff ff       	jmp    80105d67 <alltraps>

8010690b <vector163>:
.globl vector163
vector163:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $163
8010690d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106912:	e9 50 f4 ff ff       	jmp    80105d67 <alltraps>

80106917 <vector164>:
.globl vector164
vector164:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $164
80106919:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010691e:	e9 44 f4 ff ff       	jmp    80105d67 <alltraps>

80106923 <vector165>:
.globl vector165
vector165:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $165
80106925:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010692a:	e9 38 f4 ff ff       	jmp    80105d67 <alltraps>

8010692f <vector166>:
.globl vector166
vector166:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $166
80106931:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106936:	e9 2c f4 ff ff       	jmp    80105d67 <alltraps>

8010693b <vector167>:
.globl vector167
vector167:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $167
8010693d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106942:	e9 20 f4 ff ff       	jmp    80105d67 <alltraps>

80106947 <vector168>:
.globl vector168
vector168:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $168
80106949:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010694e:	e9 14 f4 ff ff       	jmp    80105d67 <alltraps>

80106953 <vector169>:
.globl vector169
vector169:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $169
80106955:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010695a:	e9 08 f4 ff ff       	jmp    80105d67 <alltraps>

8010695f <vector170>:
.globl vector170
vector170:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $170
80106961:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106966:	e9 fc f3 ff ff       	jmp    80105d67 <alltraps>

8010696b <vector171>:
.globl vector171
vector171:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $171
8010696d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106972:	e9 f0 f3 ff ff       	jmp    80105d67 <alltraps>

80106977 <vector172>:
.globl vector172
vector172:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $172
80106979:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010697e:	e9 e4 f3 ff ff       	jmp    80105d67 <alltraps>

80106983 <vector173>:
.globl vector173
vector173:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $173
80106985:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010698a:	e9 d8 f3 ff ff       	jmp    80105d67 <alltraps>

8010698f <vector174>:
.globl vector174
vector174:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $174
80106991:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106996:	e9 cc f3 ff ff       	jmp    80105d67 <alltraps>

8010699b <vector175>:
.globl vector175
vector175:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $175
8010699d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801069a2:	e9 c0 f3 ff ff       	jmp    80105d67 <alltraps>

801069a7 <vector176>:
.globl vector176
vector176:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $176
801069a9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801069ae:	e9 b4 f3 ff ff       	jmp    80105d67 <alltraps>

801069b3 <vector177>:
.globl vector177
vector177:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $177
801069b5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801069ba:	e9 a8 f3 ff ff       	jmp    80105d67 <alltraps>

801069bf <vector178>:
.globl vector178
vector178:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $178
801069c1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801069c6:	e9 9c f3 ff ff       	jmp    80105d67 <alltraps>

801069cb <vector179>:
.globl vector179
vector179:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $179
801069cd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801069d2:	e9 90 f3 ff ff       	jmp    80105d67 <alltraps>

801069d7 <vector180>:
.globl vector180
vector180:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $180
801069d9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801069de:	e9 84 f3 ff ff       	jmp    80105d67 <alltraps>

801069e3 <vector181>:
.globl vector181
vector181:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $181
801069e5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801069ea:	e9 78 f3 ff ff       	jmp    80105d67 <alltraps>

801069ef <vector182>:
.globl vector182
vector182:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $182
801069f1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801069f6:	e9 6c f3 ff ff       	jmp    80105d67 <alltraps>

801069fb <vector183>:
.globl vector183
vector183:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $183
801069fd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106a02:	e9 60 f3 ff ff       	jmp    80105d67 <alltraps>

80106a07 <vector184>:
.globl vector184
vector184:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $184
80106a09:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106a0e:	e9 54 f3 ff ff       	jmp    80105d67 <alltraps>

80106a13 <vector185>:
.globl vector185
vector185:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $185
80106a15:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106a1a:	e9 48 f3 ff ff       	jmp    80105d67 <alltraps>

80106a1f <vector186>:
.globl vector186
vector186:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $186
80106a21:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106a26:	e9 3c f3 ff ff       	jmp    80105d67 <alltraps>

80106a2b <vector187>:
.globl vector187
vector187:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $187
80106a2d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106a32:	e9 30 f3 ff ff       	jmp    80105d67 <alltraps>

80106a37 <vector188>:
.globl vector188
vector188:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $188
80106a39:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106a3e:	e9 24 f3 ff ff       	jmp    80105d67 <alltraps>

80106a43 <vector189>:
.globl vector189
vector189:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $189
80106a45:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106a4a:	e9 18 f3 ff ff       	jmp    80105d67 <alltraps>

80106a4f <vector190>:
.globl vector190
vector190:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $190
80106a51:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106a56:	e9 0c f3 ff ff       	jmp    80105d67 <alltraps>

80106a5b <vector191>:
.globl vector191
vector191:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $191
80106a5d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106a62:	e9 00 f3 ff ff       	jmp    80105d67 <alltraps>

80106a67 <vector192>:
.globl vector192
vector192:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $192
80106a69:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106a6e:	e9 f4 f2 ff ff       	jmp    80105d67 <alltraps>

80106a73 <vector193>:
.globl vector193
vector193:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $193
80106a75:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106a7a:	e9 e8 f2 ff ff       	jmp    80105d67 <alltraps>

80106a7f <vector194>:
.globl vector194
vector194:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $194
80106a81:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106a86:	e9 dc f2 ff ff       	jmp    80105d67 <alltraps>

80106a8b <vector195>:
.globl vector195
vector195:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $195
80106a8d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106a92:	e9 d0 f2 ff ff       	jmp    80105d67 <alltraps>

80106a97 <vector196>:
.globl vector196
vector196:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $196
80106a99:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106a9e:	e9 c4 f2 ff ff       	jmp    80105d67 <alltraps>

80106aa3 <vector197>:
.globl vector197
vector197:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $197
80106aa5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106aaa:	e9 b8 f2 ff ff       	jmp    80105d67 <alltraps>

80106aaf <vector198>:
.globl vector198
vector198:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $198
80106ab1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106ab6:	e9 ac f2 ff ff       	jmp    80105d67 <alltraps>

80106abb <vector199>:
.globl vector199
vector199:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $199
80106abd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106ac2:	e9 a0 f2 ff ff       	jmp    80105d67 <alltraps>

80106ac7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $200
80106ac9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106ace:	e9 94 f2 ff ff       	jmp    80105d67 <alltraps>

80106ad3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $201
80106ad5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106ada:	e9 88 f2 ff ff       	jmp    80105d67 <alltraps>

80106adf <vector202>:
.globl vector202
vector202:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $202
80106ae1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ae6:	e9 7c f2 ff ff       	jmp    80105d67 <alltraps>

80106aeb <vector203>:
.globl vector203
vector203:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $203
80106aed:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106af2:	e9 70 f2 ff ff       	jmp    80105d67 <alltraps>

80106af7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $204
80106af9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106afe:	e9 64 f2 ff ff       	jmp    80105d67 <alltraps>

80106b03 <vector205>:
.globl vector205
vector205:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $205
80106b05:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106b0a:	e9 58 f2 ff ff       	jmp    80105d67 <alltraps>

80106b0f <vector206>:
.globl vector206
vector206:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $206
80106b11:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106b16:	e9 4c f2 ff ff       	jmp    80105d67 <alltraps>

80106b1b <vector207>:
.globl vector207
vector207:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $207
80106b1d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106b22:	e9 40 f2 ff ff       	jmp    80105d67 <alltraps>

80106b27 <vector208>:
.globl vector208
vector208:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $208
80106b29:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106b2e:	e9 34 f2 ff ff       	jmp    80105d67 <alltraps>

80106b33 <vector209>:
.globl vector209
vector209:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $209
80106b35:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106b3a:	e9 28 f2 ff ff       	jmp    80105d67 <alltraps>

80106b3f <vector210>:
.globl vector210
vector210:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $210
80106b41:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106b46:	e9 1c f2 ff ff       	jmp    80105d67 <alltraps>

80106b4b <vector211>:
.globl vector211
vector211:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $211
80106b4d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106b52:	e9 10 f2 ff ff       	jmp    80105d67 <alltraps>

80106b57 <vector212>:
.globl vector212
vector212:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $212
80106b59:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106b5e:	e9 04 f2 ff ff       	jmp    80105d67 <alltraps>

80106b63 <vector213>:
.globl vector213
vector213:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $213
80106b65:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106b6a:	e9 f8 f1 ff ff       	jmp    80105d67 <alltraps>

80106b6f <vector214>:
.globl vector214
vector214:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $214
80106b71:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106b76:	e9 ec f1 ff ff       	jmp    80105d67 <alltraps>

80106b7b <vector215>:
.globl vector215
vector215:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $215
80106b7d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106b82:	e9 e0 f1 ff ff       	jmp    80105d67 <alltraps>

80106b87 <vector216>:
.globl vector216
vector216:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $216
80106b89:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106b8e:	e9 d4 f1 ff ff       	jmp    80105d67 <alltraps>

80106b93 <vector217>:
.globl vector217
vector217:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $217
80106b95:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106b9a:	e9 c8 f1 ff ff       	jmp    80105d67 <alltraps>

80106b9f <vector218>:
.globl vector218
vector218:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $218
80106ba1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106ba6:	e9 bc f1 ff ff       	jmp    80105d67 <alltraps>

80106bab <vector219>:
.globl vector219
vector219:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $219
80106bad:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106bb2:	e9 b0 f1 ff ff       	jmp    80105d67 <alltraps>

80106bb7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $220
80106bb9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106bbe:	e9 a4 f1 ff ff       	jmp    80105d67 <alltraps>

80106bc3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $221
80106bc5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106bca:	e9 98 f1 ff ff       	jmp    80105d67 <alltraps>

80106bcf <vector222>:
.globl vector222
vector222:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $222
80106bd1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106bd6:	e9 8c f1 ff ff       	jmp    80105d67 <alltraps>

80106bdb <vector223>:
.globl vector223
vector223:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $223
80106bdd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106be2:	e9 80 f1 ff ff       	jmp    80105d67 <alltraps>

80106be7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $224
80106be9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106bee:	e9 74 f1 ff ff       	jmp    80105d67 <alltraps>

80106bf3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $225
80106bf5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106bfa:	e9 68 f1 ff ff       	jmp    80105d67 <alltraps>

80106bff <vector226>:
.globl vector226
vector226:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $226
80106c01:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106c06:	e9 5c f1 ff ff       	jmp    80105d67 <alltraps>

80106c0b <vector227>:
.globl vector227
vector227:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $227
80106c0d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106c12:	e9 50 f1 ff ff       	jmp    80105d67 <alltraps>

80106c17 <vector228>:
.globl vector228
vector228:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $228
80106c19:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106c1e:	e9 44 f1 ff ff       	jmp    80105d67 <alltraps>

80106c23 <vector229>:
.globl vector229
vector229:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $229
80106c25:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106c2a:	e9 38 f1 ff ff       	jmp    80105d67 <alltraps>

80106c2f <vector230>:
.globl vector230
vector230:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $230
80106c31:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106c36:	e9 2c f1 ff ff       	jmp    80105d67 <alltraps>

80106c3b <vector231>:
.globl vector231
vector231:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $231
80106c3d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106c42:	e9 20 f1 ff ff       	jmp    80105d67 <alltraps>

80106c47 <vector232>:
.globl vector232
vector232:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $232
80106c49:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106c4e:	e9 14 f1 ff ff       	jmp    80105d67 <alltraps>

80106c53 <vector233>:
.globl vector233
vector233:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $233
80106c55:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106c5a:	e9 08 f1 ff ff       	jmp    80105d67 <alltraps>

80106c5f <vector234>:
.globl vector234
vector234:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $234
80106c61:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106c66:	e9 fc f0 ff ff       	jmp    80105d67 <alltraps>

80106c6b <vector235>:
.globl vector235
vector235:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $235
80106c6d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106c72:	e9 f0 f0 ff ff       	jmp    80105d67 <alltraps>

80106c77 <vector236>:
.globl vector236
vector236:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $236
80106c79:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106c7e:	e9 e4 f0 ff ff       	jmp    80105d67 <alltraps>

80106c83 <vector237>:
.globl vector237
vector237:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $237
80106c85:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106c8a:	e9 d8 f0 ff ff       	jmp    80105d67 <alltraps>

80106c8f <vector238>:
.globl vector238
vector238:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $238
80106c91:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106c96:	e9 cc f0 ff ff       	jmp    80105d67 <alltraps>

80106c9b <vector239>:
.globl vector239
vector239:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $239
80106c9d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106ca2:	e9 c0 f0 ff ff       	jmp    80105d67 <alltraps>

80106ca7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $240
80106ca9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106cae:	e9 b4 f0 ff ff       	jmp    80105d67 <alltraps>

80106cb3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $241
80106cb5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106cba:	e9 a8 f0 ff ff       	jmp    80105d67 <alltraps>

80106cbf <vector242>:
.globl vector242
vector242:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $242
80106cc1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106cc6:	e9 9c f0 ff ff       	jmp    80105d67 <alltraps>

80106ccb <vector243>:
.globl vector243
vector243:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $243
80106ccd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106cd2:	e9 90 f0 ff ff       	jmp    80105d67 <alltraps>

80106cd7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $244
80106cd9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106cde:	e9 84 f0 ff ff       	jmp    80105d67 <alltraps>

80106ce3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $245
80106ce5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106cea:	e9 78 f0 ff ff       	jmp    80105d67 <alltraps>

80106cef <vector246>:
.globl vector246
vector246:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $246
80106cf1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106cf6:	e9 6c f0 ff ff       	jmp    80105d67 <alltraps>

80106cfb <vector247>:
.globl vector247
vector247:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $247
80106cfd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106d02:	e9 60 f0 ff ff       	jmp    80105d67 <alltraps>

80106d07 <vector248>:
.globl vector248
vector248:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $248
80106d09:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106d0e:	e9 54 f0 ff ff       	jmp    80105d67 <alltraps>

80106d13 <vector249>:
.globl vector249
vector249:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $249
80106d15:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106d1a:	e9 48 f0 ff ff       	jmp    80105d67 <alltraps>

80106d1f <vector250>:
.globl vector250
vector250:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $250
80106d21:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106d26:	e9 3c f0 ff ff       	jmp    80105d67 <alltraps>

80106d2b <vector251>:
.globl vector251
vector251:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $251
80106d2d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106d32:	e9 30 f0 ff ff       	jmp    80105d67 <alltraps>

80106d37 <vector252>:
.globl vector252
vector252:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $252
80106d39:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106d3e:	e9 24 f0 ff ff       	jmp    80105d67 <alltraps>

80106d43 <vector253>:
.globl vector253
vector253:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $253
80106d45:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106d4a:	e9 18 f0 ff ff       	jmp    80105d67 <alltraps>

80106d4f <vector254>:
.globl vector254
vector254:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $254
80106d51:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106d56:	e9 0c f0 ff ff       	jmp    80105d67 <alltraps>

80106d5b <vector255>:
.globl vector255
vector255:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $255
80106d5d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106d62:	e9 00 f0 ff ff       	jmp    80105d67 <alltraps>
80106d67:	66 90                	xchg   %ax,%ax
80106d69:	66 90                	xchg   %ax,%ax
80106d6b:	66 90                	xchg   %ax,%ax
80106d6d:	66 90                	xchg   %ax,%ax
80106d6f:	90                   	nop

80106d70 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106d76:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106d7c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d82:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106d85:	39 d3                	cmp    %edx,%ebx
80106d87:	73 56                	jae    80106ddf <deallocuvm.part.0+0x6f>
80106d89:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106d8c:	89 c6                	mov    %eax,%esi
80106d8e:	89 d7                	mov    %edx,%edi
80106d90:	eb 12                	jmp    80106da4 <deallocuvm.part.0+0x34>
80106d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106d98:	83 c2 01             	add    $0x1,%edx
80106d9b:	89 d3                	mov    %edx,%ebx
80106d9d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106da0:	39 fb                	cmp    %edi,%ebx
80106da2:	73 38                	jae    80106ddc <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106da4:	89 da                	mov    %ebx,%edx
80106da6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106da9:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106dac:	a8 01                	test   $0x1,%al
80106dae:	74 e8                	je     80106d98 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106db0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106db7:	c1 e9 0a             	shr    $0xa,%ecx
80106dba:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106dc0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106dc7:	85 c0                	test   %eax,%eax
80106dc9:	74 cd                	je     80106d98 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106dcb:	8b 10                	mov    (%eax),%edx
80106dcd:	f6 c2 01             	test   $0x1,%dl
80106dd0:	75 1e                	jne    80106df0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106dd2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dd8:	39 fb                	cmp    %edi,%ebx
80106dda:	72 c8                	jb     80106da4 <deallocuvm.part.0+0x34>
80106ddc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ddf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de2:	89 c8                	mov    %ecx,%eax
80106de4:	5b                   	pop    %ebx
80106de5:	5e                   	pop    %esi
80106de6:	5f                   	pop    %edi
80106de7:	5d                   	pop    %ebp
80106de8:	c3                   	ret
80106de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106df0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106df6:	74 26                	je     80106e1e <deallocuvm.part.0+0xae>
      kfree(v);
80106df8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106dfb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106e01:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106e04:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106e0a:	52                   	push   %edx
80106e0b:	e8 50 b7 ff ff       	call   80102560 <kfree>
      *pte = 0;
80106e10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106e13:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106e16:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106e1c:	eb 82                	jmp    80106da0 <deallocuvm.part.0+0x30>
        panic("kfree");
80106e1e:	83 ec 0c             	sub    $0xc,%esp
80106e21:	68 82 7b 10 80       	push   $0x80107b82
80106e26:	e8 55 95 ff ff       	call   80100380 <panic>
80106e2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106e30 <mappages>:
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	57                   	push   %edi
80106e34:	56                   	push   %esi
80106e35:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106e36:	89 d3                	mov    %edx,%ebx
80106e38:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106e3e:	83 ec 1c             	sub    $0x1c,%esp
80106e41:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106e44:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106e48:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e4d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106e50:	8b 45 08             	mov    0x8(%ebp),%eax
80106e53:	29 d8                	sub    %ebx,%eax
80106e55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e58:	eb 3f                	jmp    80106e99 <mappages+0x69>
80106e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106e60:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106e62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106e67:	c1 ea 0a             	shr    $0xa,%edx
80106e6a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106e70:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106e77:	85 c0                	test   %eax,%eax
80106e79:	74 75                	je     80106ef0 <mappages+0xc0>
    if(*pte & PTE_P)
80106e7b:	f6 00 01             	testb  $0x1,(%eax)
80106e7e:	0f 85 86 00 00 00    	jne    80106f0a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106e84:	0b 75 0c             	or     0xc(%ebp),%esi
80106e87:	83 ce 01             	or     $0x1,%esi
80106e8a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106e8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106e8f:	39 c3                	cmp    %eax,%ebx
80106e91:	74 6d                	je     80106f00 <mappages+0xd0>
    a += PGSIZE;
80106e93:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106e99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106e9c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106e9f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106ea2:	89 d8                	mov    %ebx,%eax
80106ea4:	c1 e8 16             	shr    $0x16,%eax
80106ea7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106eaa:	8b 07                	mov    (%edi),%eax
80106eac:	a8 01                	test   $0x1,%al
80106eae:	75 b0                	jne    80106e60 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106eb0:	e8 6b b8 ff ff       	call   80102720 <kalloc>
80106eb5:	85 c0                	test   %eax,%eax
80106eb7:	74 37                	je     80106ef0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106eb9:	83 ec 04             	sub    $0x4,%esp
80106ebc:	68 00 10 00 00       	push   $0x1000
80106ec1:	6a 00                	push   $0x0
80106ec3:	50                   	push   %eax
80106ec4:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106ec7:	e8 a4 d9 ff ff       	call   80104870 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ecc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106ecf:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ed2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106ed8:	83 c8 07             	or     $0x7,%eax
80106edb:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106edd:	89 d8                	mov    %ebx,%eax
80106edf:	c1 e8 0a             	shr    $0xa,%eax
80106ee2:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ee7:	01 d0                	add    %edx,%eax
80106ee9:	eb 90                	jmp    80106e7b <mappages+0x4b>
80106eeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106ef0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ef3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ef8:	5b                   	pop    %ebx
80106ef9:	5e                   	pop    %esi
80106efa:	5f                   	pop    %edi
80106efb:	5d                   	pop    %ebp
80106efc:	c3                   	ret
80106efd:	8d 76 00             	lea    0x0(%esi),%esi
80106f00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f03:	31 c0                	xor    %eax,%eax
}
80106f05:	5b                   	pop    %ebx
80106f06:	5e                   	pop    %esi
80106f07:	5f                   	pop    %edi
80106f08:	5d                   	pop    %ebp
80106f09:	c3                   	ret
      panic("remap");
80106f0a:	83 ec 0c             	sub    $0xc,%esp
80106f0d:	68 ed 7d 10 80       	push   $0x80107ded
80106f12:	e8 69 94 ff ff       	call   80100380 <panic>
80106f17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f1e:	00 
80106f1f:	90                   	nop

80106f20 <seginit>:
{
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106f26:	e8 35 cb ff ff       	call   80103a60 <cpuid>
  pd[0] = size-1;
80106f2b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f30:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106f36:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106f3a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106f41:	ff 00 00 
80106f44:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106f4b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f4e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106f55:	ff 00 00 
80106f58:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106f5f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f62:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106f69:	ff 00 00 
80106f6c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106f73:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f76:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106f7d:	ff 00 00 
80106f80:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106f87:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106f8a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
80106f8f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106f93:	c1 e8 10             	shr    $0x10,%eax
80106f96:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106f9a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106f9d:	0f 01 10             	lgdtl  (%eax)
}
80106fa0:	c9                   	leave
80106fa1:	c3                   	ret
80106fa2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fa9:	00 
80106faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fb0 <walkpgdir>:
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	53                   	push   %ebx
80106fb6:	83 ec 0c             	sub    $0xc,%esp
80106fb9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pde = &pgdir[PDX(va)];
80106fbc:	8b 55 08             	mov    0x8(%ebp),%edx
80106fbf:	89 fe                	mov    %edi,%esi
80106fc1:	c1 ee 16             	shr    $0x16,%esi
80106fc4:	8d 34 b2             	lea    (%edx,%esi,4),%esi
  if(*pde & PTE_P){
80106fc7:	8b 1e                	mov    (%esi),%ebx
80106fc9:	f6 c3 01             	test   $0x1,%bl
80106fcc:	74 22                	je     80106ff0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fce:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fd4:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
  return &pgtab[PTX(va)];
80106fda:	89 f8                	mov    %edi,%eax
}
80106fdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106fdf:	c1 e8 0a             	shr    $0xa,%eax
80106fe2:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fe7:	01 d8                	add    %ebx,%eax
}
80106fe9:	5b                   	pop    %ebx
80106fea:	5e                   	pop    %esi
80106feb:	5f                   	pop    %edi
80106fec:	5d                   	pop    %ebp
80106fed:	c3                   	ret
80106fee:	66 90                	xchg   %ax,%ax
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106ff0:	8b 45 10             	mov    0x10(%ebp),%eax
80106ff3:	85 c0                	test   %eax,%eax
80106ff5:	74 31                	je     80107028 <walkpgdir+0x78>
80106ff7:	e8 24 b7 ff ff       	call   80102720 <kalloc>
80106ffc:	89 c3                	mov    %eax,%ebx
80106ffe:	85 c0                	test   %eax,%eax
80107000:	74 26                	je     80107028 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
80107002:	83 ec 04             	sub    $0x4,%esp
80107005:	68 00 10 00 00       	push   $0x1000
8010700a:	6a 00                	push   $0x0
8010700c:	50                   	push   %eax
8010700d:	e8 5e d8 ff ff       	call   80104870 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107012:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107018:	83 c4 10             	add    $0x10,%esp
8010701b:	83 c8 07             	or     $0x7,%eax
8010701e:	89 06                	mov    %eax,(%esi)
80107020:	eb b8                	jmp    80106fda <walkpgdir+0x2a>
80107022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80107028:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
8010702b:	31 c0                	xor    %eax,%eax
}
8010702d:	5b                   	pop    %ebx
8010702e:	5e                   	pop    %esi
8010702f:	5f                   	pop    %edi
80107030:	5d                   	pop    %ebp
80107031:	c3                   	ret
80107032:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107039:	00 
8010703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107040 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107040:	a1 c4 b1 11 80       	mov    0x8011b1c4,%eax
80107045:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010704a:	0f 22 d8             	mov    %eax,%cr3
}
8010704d:	c3                   	ret
8010704e:	66 90                	xchg   %ax,%ax

80107050 <switchuvm>:
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
80107056:	83 ec 1c             	sub    $0x1c,%esp
80107059:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010705c:	85 f6                	test   %esi,%esi
8010705e:	0f 84 cb 00 00 00    	je     8010712f <switchuvm+0xdf>
  if(p->kstack == 0)
80107064:	8b 46 08             	mov    0x8(%esi),%eax
80107067:	85 c0                	test   %eax,%eax
80107069:	0f 84 da 00 00 00    	je     80107149 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010706f:	8b 46 04             	mov    0x4(%esi),%eax
80107072:	85 c0                	test   %eax,%eax
80107074:	0f 84 c2 00 00 00    	je     8010713c <switchuvm+0xec>
  pushcli();
8010707a:	e8 a1 d5 ff ff       	call   80104620 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010707f:	e8 7c c9 ff ff       	call   80103a00 <mycpu>
80107084:	89 c3                	mov    %eax,%ebx
80107086:	e8 75 c9 ff ff       	call   80103a00 <mycpu>
8010708b:	89 c7                	mov    %eax,%edi
8010708d:	e8 6e c9 ff ff       	call   80103a00 <mycpu>
80107092:	83 c7 08             	add    $0x8,%edi
80107095:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107098:	e8 63 c9 ff ff       	call   80103a00 <mycpu>
8010709d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801070a0:	ba 67 00 00 00       	mov    $0x67,%edx
801070a5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801070ac:	83 c0 08             	add    $0x8,%eax
801070af:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801070b6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801070bb:	83 c1 08             	add    $0x8,%ecx
801070be:	c1 e8 18             	shr    $0x18,%eax
801070c1:	c1 e9 10             	shr    $0x10,%ecx
801070c4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801070ca:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801070d0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801070d5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801070dc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801070e1:	e8 1a c9 ff ff       	call   80103a00 <mycpu>
801070e6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801070ed:	e8 0e c9 ff ff       	call   80103a00 <mycpu>
801070f2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801070f6:	8b 5e 08             	mov    0x8(%esi),%ebx
801070f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070ff:	e8 fc c8 ff ff       	call   80103a00 <mycpu>
80107104:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107107:	e8 f4 c8 ff ff       	call   80103a00 <mycpu>
8010710c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107110:	b8 28 00 00 00       	mov    $0x28,%eax
80107115:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107118:	8b 46 04             	mov    0x4(%esi),%eax
8010711b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107120:	0f 22 d8             	mov    %eax,%cr3
}
80107123:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107126:	5b                   	pop    %ebx
80107127:	5e                   	pop    %esi
80107128:	5f                   	pop    %edi
80107129:	5d                   	pop    %ebp
  popcli();
8010712a:	e9 41 d5 ff ff       	jmp    80104670 <popcli>
    panic("switchuvm: no process");
8010712f:	83 ec 0c             	sub    $0xc,%esp
80107132:	68 f3 7d 10 80       	push   $0x80107df3
80107137:	e8 44 92 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010713c:	83 ec 0c             	sub    $0xc,%esp
8010713f:	68 1e 7e 10 80       	push   $0x80107e1e
80107144:	e8 37 92 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107149:	83 ec 0c             	sub    $0xc,%esp
8010714c:	68 09 7e 10 80       	push   $0x80107e09
80107151:	e8 2a 92 ff ff       	call   80100380 <panic>
80107156:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010715d:	00 
8010715e:	66 90                	xchg   %ax,%ax

80107160 <inituvm>:
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 1c             	sub    $0x1c,%esp
80107169:	8b 45 08             	mov    0x8(%ebp),%eax
8010716c:	8b 75 10             	mov    0x10(%ebp),%esi
8010716f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107172:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107175:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010717b:	77 49                	ja     801071c6 <inituvm+0x66>
  mem = kalloc();
8010717d:	e8 9e b5 ff ff       	call   80102720 <kalloc>
  memset(mem, 0, PGSIZE);
80107182:	83 ec 04             	sub    $0x4,%esp
80107185:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010718a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010718c:	6a 00                	push   $0x0
8010718e:	50                   	push   %eax
8010718f:	e8 dc d6 ff ff       	call   80104870 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107194:	58                   	pop    %eax
80107195:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010719b:	5a                   	pop    %edx
8010719c:	6a 06                	push   $0x6
8010719e:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071a3:	31 d2                	xor    %edx,%edx
801071a5:	50                   	push   %eax
801071a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071a9:	e8 82 fc ff ff       	call   80106e30 <mappages>
  memmove(mem, init, sz);
801071ae:	83 c4 10             	add    $0x10,%esp
801071b1:	89 75 10             	mov    %esi,0x10(%ebp)
801071b4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801071b7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801071ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071bd:	5b                   	pop    %ebx
801071be:	5e                   	pop    %esi
801071bf:	5f                   	pop    %edi
801071c0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801071c1:	e9 3a d7 ff ff       	jmp    80104900 <memmove>
    panic("inituvm: more than a page");
801071c6:	83 ec 0c             	sub    $0xc,%esp
801071c9:	68 32 7e 10 80       	push   $0x80107e32
801071ce:	e8 ad 91 ff ff       	call   80100380 <panic>
801071d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071da:	00 
801071db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801071e0 <loaduvm>:
{
801071e0:	55                   	push   %ebp
801071e1:	89 e5                	mov    %esp,%ebp
801071e3:	57                   	push   %edi
801071e4:	56                   	push   %esi
801071e5:	53                   	push   %ebx
801071e6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
801071e9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
801071ec:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
801071ef:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
801071f5:	0f 85 a2 00 00 00    	jne    8010729d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
801071fb:	85 ff                	test   %edi,%edi
801071fd:	74 7d                	je     8010727c <loaduvm+0x9c>
801071ff:	90                   	nop
  pde = &pgdir[PDX(va)];
80107200:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107203:	8b 55 08             	mov    0x8(%ebp),%edx
80107206:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107208:	89 c1                	mov    %eax,%ecx
8010720a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010720d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107210:	f6 c1 01             	test   $0x1,%cl
80107213:	75 13                	jne    80107228 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80107215:	83 ec 0c             	sub    $0xc,%esp
80107218:	68 4c 7e 10 80       	push   $0x80107e4c
8010721d:	e8 5e 91 ff ff       	call   80100380 <panic>
80107222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107228:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010722b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107231:	25 fc 0f 00 00       	and    $0xffc,%eax
80107236:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010723d:	85 c9                	test   %ecx,%ecx
8010723f:	74 d4                	je     80107215 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80107241:	89 fb                	mov    %edi,%ebx
80107243:	b8 00 10 00 00       	mov    $0x1000,%eax
80107248:	29 f3                	sub    %esi,%ebx
8010724a:	39 c3                	cmp    %eax,%ebx
8010724c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010724f:	53                   	push   %ebx
80107250:	8b 45 14             	mov    0x14(%ebp),%eax
80107253:	01 f0                	add    %esi,%eax
80107255:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107256:	8b 01                	mov    (%ecx),%eax
80107258:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010725d:	05 00 00 00 80       	add    $0x80000000,%eax
80107262:	50                   	push   %eax
80107263:	ff 75 10             	push   0x10(%ebp)
80107266:	e8 05 a9 ff ff       	call   80101b70 <readi>
8010726b:	83 c4 10             	add    $0x10,%esp
8010726e:	39 d8                	cmp    %ebx,%eax
80107270:	75 1e                	jne    80107290 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80107272:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107278:	39 fe                	cmp    %edi,%esi
8010727a:	72 84                	jb     80107200 <loaduvm+0x20>
}
8010727c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010727f:	31 c0                	xor    %eax,%eax
}
80107281:	5b                   	pop    %ebx
80107282:	5e                   	pop    %esi
80107283:	5f                   	pop    %edi
80107284:	5d                   	pop    %ebp
80107285:	c3                   	ret
80107286:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010728d:	00 
8010728e:	66 90                	xchg   %ax,%ax
80107290:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107293:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107298:	5b                   	pop    %ebx
80107299:	5e                   	pop    %esi
8010729a:	5f                   	pop    %edi
8010729b:	5d                   	pop    %ebp
8010729c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
8010729d:	83 ec 0c             	sub    $0xc,%esp
801072a0:	68 94 80 10 80       	push   $0x80108094
801072a5:	e8 d6 90 ff ff       	call   80100380 <panic>
801072aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801072b0 <allocuvm>:
int allocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801072b0:	55                   	push   %ebp
801072b1:	89 e5                	mov    %esp,%ebp
801072b3:	57                   	push   %edi
801072b4:	56                   	push   %esi
801072b5:	53                   	push   %ebx
801072b6:	83 ec 1c             	sub    $0x1c,%esp
801072b9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE) return 0;
801072bc:	85 f6                	test   %esi,%esi
801072be:	0f 88 86 01 00 00    	js     8010744a <allocuvm+0x19a>
801072c4:	89 f0                	mov    %esi,%eax
  if(newsz < oldsz) return oldsz;
801072c6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801072c9:	0f 82 49 01 00 00    	jb     80107418 <allocuvm+0x168>
  a = PGROUNDUP(oldsz);
801072cf:	8b 7d 0c             	mov    0xc(%ebp),%edi
801072d2:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801072d8:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(; a < newsz; a += PGSIZE) {
801072de:	39 f7                	cmp    %esi,%edi
801072e0:	0f 83 35 01 00 00    	jae    8010741b <allocuvm+0x16b>
801072e6:	89 75 e0             	mov    %esi,-0x20(%ebp)
801072e9:	eb 35                	jmp    80107320 <allocuvm+0x70>
801072eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        cprintf("Allocated page %d at virtual address 0x%x\n",
801072f0:	83 ec 04             	sub    $0x4,%esp
        cur->pages[cur->page_count++] = (int)a;
801072f3:	8d 50 01             	lea    0x1(%eax),%edx
801072f6:	89 93 e4 01 00 00    	mov    %edx,0x1e4(%ebx)
801072fc:	89 bc 83 94 01 00 00 	mov    %edi,0x194(%ebx,%eax,4)
        cprintf("Allocated page %d at virtual address 0x%x\n",
80107303:	57                   	push   %edi
80107304:	50                   	push   %eax
80107305:	68 b8 80 10 80       	push   $0x801080b8
8010730a:	e8 a1 93 ff ff       	call   801006b0 <cprintf>
8010730f:	83 c4 10             	add    $0x10,%esp
  for(; a < newsz; a += PGSIZE) {
80107312:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107318:	39 f7                	cmp    %esi,%edi
8010731a:	0f 83 e6 00 00 00    	jae    80107406 <allocuvm+0x156>
    mem = kalloc();
80107320:	e8 fb b3 ff ff       	call   80102720 <kalloc>
80107325:	89 c3                	mov    %eax,%ebx
    if(mem == 0) {
80107327:	85 c0                	test   %eax,%eax
80107329:	0f 84 f9 00 00 00    	je     80107428 <allocuvm+0x178>
    memset(mem, 0, PGSIZE);
8010732f:	83 ec 04             	sub    $0x4,%esp
80107332:	68 00 10 00 00       	push   $0x1000
80107337:	6a 00                	push   $0x0
80107339:	50                   	push   %eax
8010733a:	e8 31 d5 ff ff       	call   80104870 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0) {
8010733f:	58                   	pop    %eax
80107340:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107346:	5a                   	pop    %edx
80107347:	6a 06                	push   $0x6
80107349:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010734e:	89 fa                	mov    %edi,%edx
80107350:	50                   	push   %eax
80107351:	8b 45 08             	mov    0x8(%ebp),%eax
80107354:	e8 d7 fa ff ff       	call   80106e30 <mappages>
80107359:	83 c4 10             	add    $0x10,%esp
8010735c:	85 c0                	test   %eax,%eax
8010735e:	0f 88 24 01 00 00    	js     80107488 <allocuvm+0x1d8>
    struct proc *cur = myproc();
80107364:	e8 17 c7 ff ff       	call   80103a80 <myproc>
80107369:	89 c3                	mov    %eax,%ebx
    if(cur) {
8010736b:	85 c0                	test   %eax,%eax
8010736d:	74 a3                	je     80107312 <allocuvm+0x62>
      if(cur->page_count < MAX_PAGES) {
8010736f:	8b 80 e4 01 00 00    	mov    0x1e4(%eax),%eax
80107375:	83 f8 13             	cmp    $0x13,%eax
80107378:	0f 8e 72 ff ff ff    	jle    801072f0 <allocuvm+0x40>
        int evict = cur->pages[0];
8010737e:	8b 8b 94 01 00 00    	mov    0x194(%ebx),%ecx
  if(*pde & PTE_P){
80107384:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107387:	89 c8                	mov    %ecx,%eax
80107389:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
8010738c:	8b 04 82             	mov    (%edx,%eax,4),%eax
8010738f:	a8 01                	test   $0x1,%al
80107391:	74 25                	je     801073b8 <allocuvm+0x108>
  return &pgtab[PTX(va)];
80107393:	89 ca                	mov    %ecx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107395:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
8010739a:	c1 ea 0a             	shr    $0xa,%edx
8010739d:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801073a3:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
        if(pte && (*pte & PTE_P)) {
801073aa:	85 d2                	test   %edx,%edx
801073ac:	74 0a                	je     801073b8 <allocuvm+0x108>
801073ae:	8b 02                	mov    (%edx),%eax
801073b0:	a8 01                	test   $0x1,%al
801073b2:	0f 85 a0 00 00 00    	jne    80107458 <allocuvm+0x1a8>
801073b8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801073bb:	8d 83 94 01 00 00    	lea    0x194(%ebx),%eax
801073c1:	8d 93 e0 01 00 00    	lea    0x1e0(%ebx),%edx
801073c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801073ce:	00 
801073cf:	90                   	nop
          cur->pages[i-1] = cur->pages[i];
801073d0:	8b 48 04             	mov    0x4(%eax),%ecx
        for(int i = 1; i < MAX_PAGES; i++)
801073d3:	83 c0 04             	add    $0x4,%eax
          cur->pages[i-1] = cur->pages[i];
801073d6:	89 48 fc             	mov    %ecx,-0x4(%eax)
        for(int i = 1; i < MAX_PAGES; i++)
801073d9:	39 d0                	cmp    %edx,%eax
801073db:	75 f3                	jne    801073d0 <allocuvm+0x120>
        cur->pages[MAX_PAGES-1] = (int)a;
801073dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
        cprintf("Evicted page at 0x%x, allocated new page at 0x%x\n", evict, a);
801073e0:	83 ec 04             	sub    $0x4,%esp
        cur->pages[MAX_PAGES-1] = (int)a;
801073e3:	89 bb e0 01 00 00    	mov    %edi,0x1e0(%ebx)
        cprintf("Evicted page at 0x%x, allocated new page at 0x%x\n", evict, a);
801073e9:	57                   	push   %edi
  for(; a < newsz; a += PGSIZE) {
801073ea:	81 c7 00 10 00 00    	add    $0x1000,%edi
        cprintf("Evicted page at 0x%x, allocated new page at 0x%x\n", evict, a);
801073f0:	51                   	push   %ecx
801073f1:	68 e4 80 10 80       	push   $0x801080e4
801073f6:	e8 b5 92 ff ff       	call   801006b0 <cprintf>
801073fb:	83 c4 10             	add    $0x10,%esp
  for(; a < newsz; a += PGSIZE) {
801073fe:	39 f7                	cmp    %esi,%edi
80107400:	0f 82 1a ff ff ff    	jb     80107320 <allocuvm+0x70>
80107406:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80107409:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010740c:	5b                   	pop    %ebx
8010740d:	5e                   	pop    %esi
8010740e:	5f                   	pop    %edi
8010740f:	5d                   	pop    %ebp
80107410:	c3                   	ret
80107411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(newsz < oldsz) return oldsz;
80107418:	8b 45 0c             	mov    0xc(%ebp),%eax
}
8010741b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010741e:	5b                   	pop    %ebx
8010741f:	5e                   	pop    %esi
80107420:	5f                   	pop    %edi
80107421:	5d                   	pop    %ebp
80107422:	c3                   	ret
80107423:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory\n");
80107428:	83 ec 0c             	sub    $0xc,%esp
8010742b:	68 6a 7e 10 80       	push   $0x80107e6a
80107430:	e8 7b 92 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107435:	83 c4 10             	add    $0x10,%esp
80107438:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010743b:	74 0d                	je     8010744a <allocuvm+0x19a>
8010743d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107440:	8b 45 08             	mov    0x8(%ebp),%eax
80107443:	89 f2                	mov    %esi,%edx
80107445:	e8 26 f9 ff ff       	call   80106d70 <deallocuvm.part.0>
  if(newsz >= KERNBASE) return 0;
8010744a:	31 c0                	xor    %eax,%eax
}
8010744c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010744f:	5b                   	pop    %ebx
80107450:	5e                   	pop    %esi
80107451:	5f                   	pop    %edi
80107452:	5d                   	pop    %ebp
80107453:	c3                   	ret
80107454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          char *v = (char*)P2V(PTE_ADDR(*pte));
80107458:	25 00 f0 ff ff       	and    $0xfffff000,%eax
          kfree(v);
8010745d:	83 ec 0c             	sub    $0xc,%esp
80107460:	89 55 dc             	mov    %edx,-0x24(%ebp)
          char *v = (char*)P2V(PTE_ADDR(*pte));
80107463:	05 00 00 00 80       	add    $0x80000000,%eax
80107468:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
          kfree(v);
8010746b:	50                   	push   %eax
8010746c:	e8 ef b0 ff ff       	call   80102560 <kfree>
          *pte = 0;
80107471:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107474:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107477:	83 c4 10             	add    $0x10,%esp
8010747a:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
        for(int i = 1; i < MAX_PAGES; i++)
80107480:	e9 33 ff ff ff       	jmp    801073b8 <allocuvm+0x108>
80107485:	8d 76 00             	lea    0x0(%esi),%esi
      kfree(mem);
80107488:	83 ec 0c             	sub    $0xc,%esp
8010748b:	53                   	push   %ebx
8010748c:	e8 cf b0 ff ff       	call   80102560 <kfree>
  if(newsz >= oldsz)
80107491:	83 c4 10             	add    $0x10,%esp
80107494:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107497:	75 a4                	jne    8010743d <allocuvm+0x18d>
  if(newsz >= KERNBASE) return 0;
80107499:	31 c0                	xor    %eax,%eax
8010749b:	eb af                	jmp    8010744c <allocuvm+0x19c>
8010749d:	8d 76 00             	lea    0x0(%esi),%esi

801074a0 <deallocuvm>:
{
801074a0:	55                   	push   %ebp
801074a1:	89 e5                	mov    %esp,%ebp
801074a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801074a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801074a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801074ac:	39 d1                	cmp    %edx,%ecx
801074ae:	73 10                	jae    801074c0 <deallocuvm+0x20>
}
801074b0:	5d                   	pop    %ebp
801074b1:	e9 ba f8 ff ff       	jmp    80106d70 <deallocuvm.part.0>
801074b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074bd:	00 
801074be:	66 90                	xchg   %ax,%ax
801074c0:	89 d0                	mov    %edx,%eax
801074c2:	5d                   	pop    %ebp
801074c3:	c3                   	ret
801074c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074cb:	00 
801074cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801074d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801074d0:	55                   	push   %ebp
801074d1:	89 e5                	mov    %esp,%ebp
801074d3:	57                   	push   %edi
801074d4:	56                   	push   %esi
801074d5:	53                   	push   %ebx
801074d6:	83 ec 0c             	sub    $0xc,%esp
801074d9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801074dc:	85 f6                	test   %esi,%esi
801074de:	74 59                	je     80107539 <freevm+0x69>
  if(newsz >= oldsz)
801074e0:	31 c9                	xor    %ecx,%ecx
801074e2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801074e7:	89 f0                	mov    %esi,%eax
801074e9:	89 f3                	mov    %esi,%ebx
801074eb:	e8 80 f8 ff ff       	call   80106d70 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801074f0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801074f6:	eb 0f                	jmp    80107507 <freevm+0x37>
801074f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074ff:	00 
80107500:	83 c3 04             	add    $0x4,%ebx
80107503:	39 fb                	cmp    %edi,%ebx
80107505:	74 23                	je     8010752a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107507:	8b 03                	mov    (%ebx),%eax
80107509:	a8 01                	test   $0x1,%al
8010750b:	74 f3                	je     80107500 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010750d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107512:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107515:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107518:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010751d:	50                   	push   %eax
8010751e:	e8 3d b0 ff ff       	call   80102560 <kfree>
80107523:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107526:	39 fb                	cmp    %edi,%ebx
80107528:	75 dd                	jne    80107507 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010752a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010752d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107530:	5b                   	pop    %ebx
80107531:	5e                   	pop    %esi
80107532:	5f                   	pop    %edi
80107533:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107534:	e9 27 b0 ff ff       	jmp    80102560 <kfree>
    panic("freevm: no pgdir");
80107539:	83 ec 0c             	sub    $0xc,%esp
8010753c:	68 82 7e 10 80       	push   $0x80107e82
80107541:	e8 3a 8e ff ff       	call   80100380 <panic>
80107546:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010754d:	00 
8010754e:	66 90                	xchg   %ax,%ax

80107550 <setupkvm>:
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	56                   	push   %esi
80107554:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107555:	e8 c6 b1 ff ff       	call   80102720 <kalloc>
8010755a:	85 c0                	test   %eax,%eax
8010755c:	74 5e                	je     801075bc <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010755e:	83 ec 04             	sub    $0x4,%esp
80107561:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107563:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107568:	68 00 10 00 00       	push   $0x1000
8010756d:	6a 00                	push   $0x0
8010756f:	50                   	push   %eax
80107570:	e8 fb d2 ff ff       	call   80104870 <memset>
80107575:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107578:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010757b:	83 ec 08             	sub    $0x8,%esp
8010757e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107581:	8b 13                	mov    (%ebx),%edx
80107583:	ff 73 0c             	push   0xc(%ebx)
80107586:	50                   	push   %eax
80107587:	29 c1                	sub    %eax,%ecx
80107589:	89 f0                	mov    %esi,%eax
8010758b:	e8 a0 f8 ff ff       	call   80106e30 <mappages>
80107590:	83 c4 10             	add    $0x10,%esp
80107593:	85 c0                	test   %eax,%eax
80107595:	78 19                	js     801075b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107597:	83 c3 10             	add    $0x10,%ebx
8010759a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801075a0:	75 d6                	jne    80107578 <setupkvm+0x28>
}
801075a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801075a5:	89 f0                	mov    %esi,%eax
801075a7:	5b                   	pop    %ebx
801075a8:	5e                   	pop    %esi
801075a9:	5d                   	pop    %ebp
801075aa:	c3                   	ret
801075ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801075b0:	83 ec 0c             	sub    $0xc,%esp
801075b3:	56                   	push   %esi
801075b4:	e8 17 ff ff ff       	call   801074d0 <freevm>
      return 0;
801075b9:	83 c4 10             	add    $0x10,%esp
}
801075bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
801075bf:	31 f6                	xor    %esi,%esi
}
801075c1:	89 f0                	mov    %esi,%eax
801075c3:	5b                   	pop    %ebx
801075c4:	5e                   	pop    %esi
801075c5:	5d                   	pop    %ebp
801075c6:	c3                   	ret
801075c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075ce:	00 
801075cf:	90                   	nop

801075d0 <kvmalloc>:
{
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801075d6:	e8 75 ff ff ff       	call   80107550 <setupkvm>
801075db:	a3 c4 b1 11 80       	mov    %eax,0x8011b1c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075e0:	05 00 00 00 80       	add    $0x80000000,%eax
801075e5:	0f 22 d8             	mov    %eax,%cr3
}
801075e8:	c9                   	leave
801075e9:	c3                   	ret
801075ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	83 ec 08             	sub    $0x8,%esp
801075f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801075f9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801075fc:	89 c1                	mov    %eax,%ecx
801075fe:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107601:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107604:	f6 c2 01             	test   $0x1,%dl
80107607:	75 17                	jne    80107620 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107609:	83 ec 0c             	sub    $0xc,%esp
8010760c:	68 93 7e 10 80       	push   $0x80107e93
80107611:	e8 6a 8d ff ff       	call   80100380 <panic>
80107616:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010761d:	00 
8010761e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107620:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107623:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107629:	25 fc 0f 00 00       	and    $0xffc,%eax
8010762e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107635:	85 c0                	test   %eax,%eax
80107637:	74 d0                	je     80107609 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107639:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010763c:	c9                   	leave
8010763d:	c3                   	ret
8010763e:	66 90                	xchg   %ax,%ax

80107640 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107640:	55                   	push   %ebp
80107641:	89 e5                	mov    %esp,%ebp
80107643:	57                   	push   %edi
80107644:	56                   	push   %esi
80107645:	53                   	push   %ebx
80107646:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107649:	e8 02 ff ff ff       	call   80107550 <setupkvm>
8010764e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107651:	85 c0                	test   %eax,%eax
80107653:	0f 84 e9 00 00 00    	je     80107742 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107659:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010765c:	85 c9                	test   %ecx,%ecx
8010765e:	0f 84 b2 00 00 00    	je     80107716 <copyuvm+0xd6>
80107664:	31 f6                	xor    %esi,%esi
80107666:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010766d:	00 
8010766e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107670:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107673:	89 f0                	mov    %esi,%eax
80107675:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107678:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010767b:	a8 01                	test   $0x1,%al
8010767d:	75 11                	jne    80107690 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010767f:	83 ec 0c             	sub    $0xc,%esp
80107682:	68 9d 7e 10 80       	push   $0x80107e9d
80107687:	e8 f4 8c ff ff       	call   80100380 <panic>
8010768c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107690:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107692:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107697:	c1 ea 0a             	shr    $0xa,%edx
8010769a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801076a0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801076a7:	85 c0                	test   %eax,%eax
801076a9:	74 d4                	je     8010767f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801076ab:	8b 00                	mov    (%eax),%eax
801076ad:	a8 01                	test   $0x1,%al
801076af:	0f 84 9f 00 00 00    	je     80107754 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801076b5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801076b7:	25 ff 0f 00 00       	and    $0xfff,%eax
801076bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801076bf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801076c5:	e8 56 b0 ff ff       	call   80102720 <kalloc>
801076ca:	89 c3                	mov    %eax,%ebx
801076cc:	85 c0                	test   %eax,%eax
801076ce:	74 64                	je     80107734 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801076d0:	83 ec 04             	sub    $0x4,%esp
801076d3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801076d9:	68 00 10 00 00       	push   $0x1000
801076de:	57                   	push   %edi
801076df:	50                   	push   %eax
801076e0:	e8 1b d2 ff ff       	call   80104900 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801076e5:	58                   	pop    %eax
801076e6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801076ec:	5a                   	pop    %edx
801076ed:	ff 75 e4             	push   -0x1c(%ebp)
801076f0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801076f5:	89 f2                	mov    %esi,%edx
801076f7:	50                   	push   %eax
801076f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076fb:	e8 30 f7 ff ff       	call   80106e30 <mappages>
80107700:	83 c4 10             	add    $0x10,%esp
80107703:	85 c0                	test   %eax,%eax
80107705:	78 21                	js     80107728 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107707:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010770d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107710:	0f 82 5a ff ff ff    	jb     80107670 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107716:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107719:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010771c:	5b                   	pop    %ebx
8010771d:	5e                   	pop    %esi
8010771e:	5f                   	pop    %edi
8010771f:	5d                   	pop    %ebp
80107720:	c3                   	ret
80107721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107728:	83 ec 0c             	sub    $0xc,%esp
8010772b:	53                   	push   %ebx
8010772c:	e8 2f ae ff ff       	call   80102560 <kfree>
      goto bad;
80107731:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107734:	83 ec 0c             	sub    $0xc,%esp
80107737:	ff 75 e0             	push   -0x20(%ebp)
8010773a:	e8 91 fd ff ff       	call   801074d0 <freevm>
  return 0;
8010773f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107742:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107749:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010774c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010774f:	5b                   	pop    %ebx
80107750:	5e                   	pop    %esi
80107751:	5f                   	pop    %edi
80107752:	5d                   	pop    %ebp
80107753:	c3                   	ret
      panic("copyuvm: page not present");
80107754:	83 ec 0c             	sub    $0xc,%esp
80107757:	68 b7 7e 10 80       	push   $0x80107eb7
8010775c:	e8 1f 8c ff ff       	call   80100380 <panic>
80107761:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107768:	00 
80107769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107770 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
80107773:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107776:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107779:	89 c1                	mov    %eax,%ecx
8010777b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010777e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107781:	f6 c2 01             	test   $0x1,%dl
80107784:	0f 84 fe 01 00 00    	je     80107988 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010778a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010778d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107793:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107794:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107799:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801077a0:	89 d0                	mov    %edx,%eax
801077a2:	f7 d2                	not    %edx
801077a4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077a9:	05 00 00 00 80       	add    $0x80000000,%eax
801077ae:	83 e2 05             	and    $0x5,%edx
801077b1:	ba 00 00 00 00       	mov    $0x0,%edx
801077b6:	0f 45 c2             	cmovne %edx,%eax
}
801077b9:	c3                   	ret
801077ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801077c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	57                   	push   %edi
801077c4:	56                   	push   %esi
801077c5:	53                   	push   %ebx
801077c6:	83 ec 0c             	sub    $0xc,%esp
801077c9:	8b 75 14             	mov    0x14(%ebp),%esi
801077cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801077cf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801077d2:	85 f6                	test   %esi,%esi
801077d4:	75 51                	jne    80107827 <copyout+0x67>
801077d6:	e9 9d 00 00 00       	jmp    80107878 <copyout+0xb8>
801077db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
801077e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801077e6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801077ec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801077f2:	74 74                	je     80107868 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
801077f4:	89 fb                	mov    %edi,%ebx
801077f6:	29 c3                	sub    %eax,%ebx
801077f8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801077fe:	39 f3                	cmp    %esi,%ebx
80107800:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107803:	29 f8                	sub    %edi,%eax
80107805:	83 ec 04             	sub    $0x4,%esp
80107808:	01 c1                	add    %eax,%ecx
8010780a:	53                   	push   %ebx
8010780b:	52                   	push   %edx
8010780c:	89 55 10             	mov    %edx,0x10(%ebp)
8010780f:	51                   	push   %ecx
80107810:	e8 eb d0 ff ff       	call   80104900 <memmove>
    len -= n;
    buf += n;
80107815:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107818:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010781e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107821:	01 da                	add    %ebx,%edx
  while(len > 0){
80107823:	29 de                	sub    %ebx,%esi
80107825:	74 51                	je     80107878 <copyout+0xb8>
  if(*pde & PTE_P){
80107827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010782a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010782c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010782e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107831:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107837:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010783a:	f6 c1 01             	test   $0x1,%cl
8010783d:	0f 84 4c 01 00 00    	je     8010798f <copyout.cold>
  return &pgtab[PTX(va)];
80107843:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107845:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010784b:	c1 eb 0c             	shr    $0xc,%ebx
8010784e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107854:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010785b:	89 d9                	mov    %ebx,%ecx
8010785d:	f7 d1                	not    %ecx
8010785f:	83 e1 05             	and    $0x5,%ecx
80107862:	0f 84 78 ff ff ff    	je     801077e0 <copyout+0x20>
  }
  return 0;
}
80107868:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010786b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107870:	5b                   	pop    %ebx
80107871:	5e                   	pop    %esi
80107872:	5f                   	pop    %edi
80107873:	5d                   	pop    %ebp
80107874:	c3                   	ret
80107875:	8d 76 00             	lea    0x0(%esi),%esi
80107878:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010787b:	31 c0                	xor    %eax,%eax
}
8010787d:	5b                   	pop    %ebx
8010787e:	5e                   	pop    %esi
8010787f:	5f                   	pop    %edi
80107880:	5d                   	pop    %ebp
80107881:	c3                   	ret
80107882:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107889:	00 
8010788a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107890 <vmfault>:

int
vmfault(pde_t *pgdir, uint va, int write)
{
80107890:	55                   	push   %ebp
80107891:	89 e5                	mov    %esp,%ebp
80107893:	57                   	push   %edi
80107894:	56                   	push   %esi
80107895:	53                   	push   %ebx
80107896:	83 ec 0c             	sub    $0xc,%esp
80107899:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010789c:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *p = myproc();
8010789f:	e8 dc c1 ff ff       	call   80103a80 <myproc>
  char *mem;
  uint va_page;

  if (va >= p->sz)
801078a4:	3b 18                	cmp    (%eax),%ebx
801078a6:	0f 83 84 00 00 00    	jae    80107930 <vmfault+0xa0>
    return -1;

  va_page = PGROUNDDOWN(va);
801078ac:	89 df                	mov    %ebx,%edi
  pde = &pgdir[PDX(va)];
801078ae:	c1 eb 16             	shr    $0x16,%ebx
  if(*pde & PTE_P){
801078b1:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  va_page = PGROUNDDOWN(va);
801078b4:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801078ba:	a8 01                	test   $0x1,%al
801078bc:	74 20                	je     801078de <vmfault+0x4e>
  return &pgtab[PTX(va)];
801078be:	89 fa                	mov    %edi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801078c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801078c5:	c1 ea 0a             	shr    $0xa,%edx
801078c8:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801078ce:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax

  // if already mapped, nothing to do
  pte_t *pte = walkpgdir(pgdir, (void*)va_page, 0);
  if (pte && (*pte & PTE_P))
801078d5:	85 c0                	test   %eax,%eax
801078d7:	74 05                	je     801078de <vmfault+0x4e>
801078d9:	f6 00 01             	testb  $0x1,(%eax)
801078dc:	75 3b                	jne    80107919 <vmfault+0x89>
    return 0;

  mem = kalloc();
801078de:	e8 3d ae ff ff       	call   80102720 <kalloc>
801078e3:	89 c3                	mov    %eax,%ebx
  if (mem == 0)
801078e5:	85 c0                	test   %eax,%eax
801078e7:	74 47                	je     80107930 <vmfault+0xa0>
    return -1;

  memset(mem, 0, PGSIZE);
801078e9:	83 ec 04             	sub    $0x4,%esp
801078ec:	68 00 10 00 00       	push   $0x1000
801078f1:	6a 00                	push   $0x0
801078f3:	50                   	push   %eax
801078f4:	e8 77 cf ff ff       	call   80104870 <memset>

  if (mappages(pgdir, (void*)va_page, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0) {
801078f9:	58                   	pop    %eax
801078fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107900:	5a                   	pop    %edx
80107901:	6a 06                	push   $0x6
80107903:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107908:	89 fa                	mov    %edi,%edx
8010790a:	50                   	push   %eax
8010790b:	89 f0                	mov    %esi,%eax
8010790d:	e8 1e f5 ff ff       	call   80106e30 <mappages>
80107912:	83 c4 10             	add    $0x10,%esp
80107915:	85 c0                	test   %eax,%eax
80107917:	78 0a                	js     80107923 <vmfault+0x93>
    return 0;
80107919:	31 c0                	xor    %eax,%eax
    kfree(mem);
    return -1;
  }

  return 0;
}
8010791b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010791e:	5b                   	pop    %ebx
8010791f:	5e                   	pop    %esi
80107920:	5f                   	pop    %edi
80107921:	5d                   	pop    %ebp
80107922:	c3                   	ret
    kfree(mem);
80107923:	83 ec 0c             	sub    $0xc,%esp
80107926:	53                   	push   %ebx
80107927:	e8 34 ac ff ff       	call   80102560 <kfree>
    return -1;
8010792c:	83 c4 10             	add    $0x10,%esp
8010792f:	90                   	nop
    return -1;
80107930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107935:	eb e4                	jmp    8010791b <vmfault+0x8b>
80107937:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010793e:	00 
8010793f:	90                   	nop

80107940 <update_lru_access>:
void update_lru_access(struct proc *p, uint va) {
80107940:	55                   	push   %ebp
80107941:	89 e5                	mov    %esp,%ebp
80107943:	56                   	push   %esi
80107944:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107947:	8b 75 0c             	mov    0xc(%ebp),%esi
8010794a:	53                   	push   %ebx
  for (int i = 0; i < p->framecount; i++) {
8010794b:	8b 99 90 01 00 00    	mov    0x190(%ecx),%ebx
80107951:	85 db                	test   %ebx,%ebx
80107953:	7e 2f                	jle    80107984 <update_lru_access+0x44>
80107955:	31 c0                	xor    %eax,%eax
80107957:	eb 0e                	jmp    80107967 <update_lru_access+0x27>
80107959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107960:	83 c0 01             	add    $0x1,%eax
80107963:	39 d8                	cmp    %ebx,%eax
80107965:	74 1d                	je     80107984 <update_lru_access+0x44>
    if (p->frames[i].va == va) {
80107967:	89 c2                	mov    %eax,%edx
80107969:	c1 e2 04             	shl    $0x4,%edx
8010796c:	39 b4 11 90 00 00 00 	cmp    %esi,0x90(%ecx,%edx,1)
80107973:	75 eb                	jne    80107960 <update_lru_access+0x20>
      p->frames[i].last_used = ticks;
80107975:	89 d0                	mov    %edx,%eax
80107977:	8b 15 60 a9 11 80    	mov    0x8011a960,%edx
8010797d:	89 94 08 9c 00 00 00 	mov    %edx,0x9c(%eax,%ecx,1)
      break;
    }
  }
}
80107984:	5b                   	pop    %ebx
80107985:	5e                   	pop    %esi
80107986:	5d                   	pop    %ebp
80107987:	c3                   	ret

80107988 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107988:	a1 00 00 00 00       	mov    0x0,%eax
8010798d:	0f 0b                	ud2

8010798f <copyout.cold>:
8010798f:	a1 00 00 00 00       	mov    0x0,%eax
80107994:	0f 0b                	ud2
