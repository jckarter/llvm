// RUN: llvm-mc -triple i386-unknown-unknown --show-encoding %s | FileCheck %s

	pause
// CHECK: pause
// CHECK: encoding: [0xf3,0x90]
	sfence
// CHECK: sfence
// CHECK: encoding: [0x0f,0xae,0xf8]
	lfence
// CHECK: lfence
// CHECK: encoding: [0x0f,0xae,0xe8]
	mfence
// CHECK: mfence
// CHECK: encoding: [0x0f,0xae,0xf0]
	monitor
// CHECK: monitor
// CHECK: encoding: [0x0f,0x01,0xc8]
	monitor %eax, %ecx, %edx
// CHECK: monitor
// CHECK: encoding: [0x0f,0x01,0xc8]
	mwait
// CHECK: mwait
// CHECK: encoding: [0x0f,0x01,0xc9]
	mwait %eax, %ecx
// CHECK: mwait
// CHECK: encoding: [0x0f,0x01,0xc9]

	vmcall
// CHECK: vmcall
// CHECK: encoding: [0x0f,0x01,0xc1]
	vmfunc
// CHECK: vmfunc
// CHECK: encoding: [0x0f,0x01,0xd4]
	vmlaunch
// CHECK: vmlaunch
// CHECK: encoding: [0x0f,0x01,0xc2]
	vmresume
// CHECK: vmresume
// CHECK: encoding: [0x0f,0x01,0xc3]
	vmxoff
// CHECK: vmxoff
// CHECK: encoding: [0x0f,0x01,0xc4]
	swapgs
// CHECK: swapgs
// CHECK: encoding: [0x0f,0x01,0xf8]

	vmrun %eax
// CHECK: vmrun %eax
// CHECK: encoding: [0x0f,0x01,0xd8]
	vmmcall
// CHECK: vmmcall
// CHECK: encoding: [0x0f,0x01,0xd9]
	vmload %eax
// CHECK: vmload %eax
// CHECK: encoding: [0x0f,0x01,0xda]
	vmsave %eax
// CHECK: vmsave %eax
// CHECK: encoding: [0x0f,0x01,0xdb]
	stgi
// CHECK: stgi
// CHECK: encoding: [0x0f,0x01,0xdc]
	clgi
// CHECK: clgi
// CHECK: encoding: [0x0f,0x01,0xdd]
	skinit %eax
// CHECK: skinit %eax
// CHECK: encoding: [0x0f,0x01,0xde]
	invlpga %ecx, %eax
// CHECK: invlpga %ecx, %eax
// CHECK: encoding: [0x0f,0x01,0xdf]

	rdtscp
// CHECK: rdtscp
// CHECK:  encoding: [0x0f,0x01,0xf9]


// CHECK: movl	%eax, 16(%ebp)          # encoding: [0x89,0x45,0x10]
	movl	%eax, 16(%ebp)
// CHECK: movl	%eax, -16(%ebp)          # encoding: [0x89,0x45,0xf0]
	movl	%eax, -16(%ebp)

// CHECK: testb	%bl, %cl                # encoding: [0x84,0xcb]
        testb %bl, %cl

// CHECK: cmpl	%eax, %ebx              # encoding: [0x39,0xc3]
        cmpl %eax, %ebx

// CHECK: addw	%ax, %ax                # encoding: [0x66,0x01,0xc0]
        addw %ax, %ax

// CHECK: shrl	%eax                    # encoding: [0xd1,0xe8]
        shrl $1, %eax

// CHECK: shll	%eax                    # encoding: [0xd1,0xe0]
        sall $1, %eax
// CHECK: shll	%eax                    # encoding: [0xd1,0xe0]
        sal $1, %eax

// moffset forms of moves, rdar://7947184
movb	0, %al    // CHECK: movb 0, %al  # encoding: [0xa0,0x00,0x00,0x00,0x00]
movw	0, %ax    // CHECK: movw 0, %ax  # encoding: [0x66,0xa1,0x00,0x00,0x00,0x00]
movl	0, %eax   // CHECK: movl 0, %eax  # encoding: [0xa1,0x00,0x00,0x00,0x00]

// rdar://7973775
into
// CHECK: into
// CHECK:  encoding: [0xce]
int3
// CHECK: int3
// CHECK:  encoding: [0xcc]
int $4
// CHECK: int $4
// CHECK:  encoding: [0xcd,0x04]
int $255
// CHECK: int $255
// CHECK:  encoding: [0xcd,0xff]

// CHECK: pushfl	# encoding: [0x9c]
        pushf
// CHECK: pushfl	# encoding: [0x9c]
        pushfl
// CHECK: popfl	        # encoding: [0x9d]
        popf
// CHECK: popfl	        # encoding: [0x9d]
        popfl

// rdar://8014869
retl
// CHECK: ret
// CHECK:  encoding: [0xc3]

// rdar://7973854
// CHECK: cmoval	%eax, %edx
// CHECK:  encoding: [0x0f,0x47,0xd0]
        	cmoval	%eax,%edx

// CHECK: cmovael	%eax, %edx
// CHECK:  encoding: [0x0f,0x43,0xd0]
        	cmovael	%eax,%edx

// CHECK: cmovbel	%eax, %edx
// CHECK:  encoding: [0x0f,0x46,0xd0]
        	cmovbel	%eax,%edx

// CHECK: cmovbl	%eax, %edx
// CHECK:  encoding: [0x0f,0x42,0xd0]
        	cmovbl	%eax,%edx

// CHECK: cmovbw %bx, %bx
cmovnae	%bx,%bx


// CHECK: cmovbel	%eax, %edx
// CHECK:  encoding: [0x0f,0x46,0xd0]
        	cmovbel	%eax,%edx

// CHECK: cmovbl	%eax, %edx
// CHECK:  encoding: [0x0f,0x42,0xd0]
        	cmovcl	%eax,%edx

// CHECK: cmovel	%eax, %edx
// CHECK:  encoding: [0x0f,0x44,0xd0]
        	cmovel	%eax,%edx

// CHECK: cmovgl	%eax, %edx
// CHECK:  encoding: [0x0f,0x4f,0xd0]
        	cmovgl	%eax,%edx

// CHECK: cmovgel	%eax, %edx
// CHECK:  encoding: [0x0f,0x4d,0xd0]
        	cmovgel	%eax,%edx

// CHECK: cmovll	%eax, %edx
// CHECK:  encoding: [0x0f,0x4c,0xd0]
        	cmovll	%eax,%edx

// CHECK: cmovlel	%eax, %edx
// CHECK:  encoding: [0x0f,0x4e,0xd0]
        	cmovlel	%eax,%edx

// CHECK: cmovbel	%eax, %edx
// CHECK:  encoding: [0x0f,0x46,0xd0]
        	cmovnal	%eax,%edx

// CHECK: cmovnel	%eax, %edx
// CHECK:  encoding: [0x0f,0x45,0xd0]
        	cmovnel	%eax,%edx

// CHECK: cmovael	%eax, %edx
// CHECK:  encoding: [0x0f,0x43,0xd0]
        	cmovnbl	%eax,%edx

// CHECK: cmoval	%eax, %edx
// CHECK:  encoding: [0x0f,0x47,0xd0]
        	cmovnbel	%eax,%edx

// CHECK: cmovael	%eax, %edx
// CHECK:  encoding: [0x0f,0x43,0xd0]
        	cmovncl	%eax,%edx

// CHECK: cmovnel	%eax, %edx
// CHECK:  encoding: [0x0f,0x45,0xd0]
        	cmovnel	%eax,%edx

// CHECK: cmovlel	%eax, %edx
// CHECK:  encoding: [0x0f,0x4e,0xd0]
        	cmovngl	%eax,%edx

// CHECK: cmovgel	%eax, %edx
// CHECK:  encoding: [0x0f,0x4d,0xd0]
        	cmovnl	%eax,%edx

// CHECK: cmovnel	%eax, %edx
// CHECK:  encoding: [0x0f,0x45,0xd0]
        	cmovnel	%eax,%edx

// CHECK: cmovlel	%eax, %edx
// CHECK:  encoding: [0x0f,0x4e,0xd0]
        	cmovngl	%eax,%edx

// CHECK: cmovll	%eax, %edx
// CHECK:  encoding: [0x0f,0x4c,0xd0]
        	cmovngel	%eax,%edx

// CHECK: cmovgel	%eax, %edx
// CHECK:  encoding: [0x0f,0x4d,0xd0]
        	cmovnll	%eax,%edx

// CHECK: cmovgl	%eax, %edx
// CHECK:  encoding: [0x0f,0x4f,0xd0]
        	cmovnlel	%eax,%edx

// CHECK: cmovnol	%eax, %edx
// CHECK:  encoding: [0x0f,0x41,0xd0]
        	cmovnol	%eax,%edx

// CHECK: cmovnpl	%eax, %edx
// CHECK:  encoding: [0x0f,0x4b,0xd0]
        	cmovnpl	%eax,%edx

// CHECK: cmovnsl	%eax, %edx
// CHECK:  encoding: [0x0f,0x49,0xd0]
        	cmovnsl	%eax,%edx

// CHECK: cmovnel	%eax, %edx
// CHECK:  encoding: [0x0f,0x45,0xd0]
        	cmovnzl	%eax,%edx

// CHECK: cmovol	%eax, %edx
// CHECK:  encoding: [0x0f,0x40,0xd0]
        	cmovol	%eax,%edx

// CHECK: cmovpl	%eax, %edx
// CHECK:  encoding: [0x0f,0x4a,0xd0]
        	cmovpl	%eax,%edx

// CHECK: cmovsl	%eax, %edx
// CHECK:  encoding: [0x0f,0x48,0xd0]
        	cmovsl	%eax,%edx

// CHECK: cmovel	%eax, %edx
// CHECK:  encoding: [0x0f,0x44,0xd0]
        	cmovzl	%eax,%edx

// CHECK: cmpps	$0, %xmm0, %xmm1
// CHECK: encoding: [0x0f,0xc2,0xc8,0x00]
        cmpps $0, %xmm0, %xmm1
// CHECK:	cmpps	$0, (%eax), %xmm1
// CHECK: encoding: [0x0f,0xc2,0x08,0x00]
        cmpps $0, 0(%eax), %xmm1
// CHECK:	cmppd	$0, %xmm0, %xmm1
// CHECK: encoding: [0x66,0x0f,0xc2,0xc8,0x00]
        cmppd $0, %xmm0, %xmm1
// CHECK:	cmppd	$0, (%eax), %xmm1
// CHECK: encoding: [0x66,0x0f,0xc2,0x08,0x00]
        cmppd $0, 0(%eax), %xmm1
// CHECK:	cmpss	$0, %xmm0, %xmm1
// CHECK: encoding: [0xf3,0x0f,0xc2,0xc8,0x00]
        cmpss $0, %xmm0, %xmm1
// CHECK:	cmpss	$0, (%eax), %xmm1
// CHECK: encoding: [0xf3,0x0f,0xc2,0x08,0x00]
        cmpss $0, 0(%eax), %xmm1
// CHECK:	cmpsd	$0, %xmm0, %xmm1
// CHECK: encoding: [0xf2,0x0f,0xc2,0xc8,0x00]
        cmpsd $0, %xmm0, %xmm1
// CHECK:	cmpsd	$0, (%eax), %xmm1
// CHECK: encoding: [0xf2,0x0f,0xc2,0x08,0x00]
        cmpsd $0, 0(%eax), %xmm1

// Check matching of instructions which embed the SSE comparison code.

// CHECK: cmpps $0, %xmm0, %xmm1
// CHECK: encoding: [0x0f,0xc2,0xc8,0x00]
        cmpeqps %xmm0, %xmm1

// CHECK: cmppd $1, %xmm0, %xmm1
// CHECK: encoding: [0x66,0x0f,0xc2,0xc8,0x01]
        cmpltpd %xmm0, %xmm1

// CHECK: cmpss $2, %xmm0, %xmm1
// CHECK: encoding: [0xf3,0x0f,0xc2,0xc8,0x02]
        cmpless %xmm0, %xmm1

// CHECK: cmppd $3, %xmm0, %xmm1
// CHECK: encoding: [0x66,0x0f,0xc2,0xc8,0x03]
        cmpunordpd %xmm0, %xmm1

// CHECK: cmpps $4, %xmm0, %xmm1
// CHECK: encoding: [0x0f,0xc2,0xc8,0x04]
        cmpneqps %xmm0, %xmm1

// CHECK: cmppd $5, %xmm0, %xmm1
// CHECK: encoding: [0x66,0x0f,0xc2,0xc8,0x05]
        cmpnltpd %xmm0, %xmm1

// CHECK: cmpss $6, %xmm0, %xmm1
// CHECK: encoding: [0xf3,0x0f,0xc2,0xc8,0x06]
        cmpnless %xmm0, %xmm1

// CHECK: cmpsd $7, %xmm0, %xmm1
// CHECK: encoding: [0xf2,0x0f,0xc2,0xc8,0x07]
        cmpordsd %xmm0, %xmm1

// rdar://7995856
// CHECK: fmul	%st(0)
// CHECK:  encoding: [0xd8,0xc8]
        fmul %st(0), %st

// CHECK: fadd	%st(0)
// CHECK:  encoding: [0xd8,0xc0]
        fadd %st(0), %st

// CHECK: fsub	%st(0)
// CHECK:  encoding: [0xd8,0xe0]
        fsub %st(0), %st

// CHECK: fsubr	%st(0)
// CHECK:  encoding: [0xd8,0xe8]
        fsubr %st(0), %st

// CHECK: fdivr	%st(0)
// CHECK:  encoding: [0xd8,0xf8]
        fdivr %st(0), %st

// CHECK: fdiv	%st(0)
// CHECK:  encoding: [0xd8,0xf0]
        fdiv %st(0), %st

// radr://8017519
// CHECK: movl	%cs, %eax
// CHECK:  encoding: [0x8c,0xc8]
        movl %cs, %eax

// CHECK: movw	%cs, %ax
// CHECK:  encoding: [0x66,0x8c,0xc8]
        movw %cs, %ax

// CHECK: movl	%cs, (%eax)
// CHECK:  encoding: [0x8c,0x08]
        movl %cs, (%eax)

// CHECK: movw	%cs, (%eax)
// CHECK:  encoding: [0x66,0x8c,0x08]
        movw %cs, (%eax)

// CHECK: movl	%eax, %cs
// CHECK:  encoding: [0x8e,0xc8]
        movl %eax, %cs

// CHECK: movl	(%eax), %cs
// CHECK:  encoding: [0x8e,0x08]
        movl (%eax), %cs

// CHECK: movw	(%eax), %cs
// CHECK:  encoding: [0x66,0x8e,0x08]
        movw (%eax), %cs

// radr://8033374
// CHECK: movl	%cr0, %eax
// CHECK:  encoding: [0x0f,0x20,0xc0]
        movl %cr0,%eax

// CHECK: movl	%cr1, %eax
// CHECK:  encoding: [0x0f,0x20,0xc8]
        movl %cr1,%eax

// CHECK: movl	%cr2, %eax
// CHECK:  encoding: [0x0f,0x20,0xd0]
        movl %cr2,%eax

// CHECK: movl	%cr3, %eax
// CHECK:  encoding: [0x0f,0x20,0xd8]
        movl %cr3,%eax

// CHECK: movl	%cr4, %eax
// CHECK:  encoding: [0x0f,0x20,0xe0]
        movl %cr4,%eax

// CHECK: movl	%dr0, %eax
// CHECK:  encoding: [0x0f,0x21,0xc0]
        movl %dr0,%eax

// CHECK: movl	%dr1, %eax
// CHECK:  encoding: [0x0f,0x21,0xc8]
        movl %dr1,%eax

// CHECK: movl	%dr1, %eax
// CHECK:  encoding: [0x0f,0x21,0xc8]
        movl %dr1,%eax

// CHECK: movl	%dr2, %eax
// CHECK:  encoding: [0x0f,0x21,0xd0]
        movl %dr2,%eax

// CHECK: movl	%dr3, %eax
// CHECK:  encoding: [0x0f,0x21,0xd8]
        movl %dr3,%eax

// CHECK: movl	%dr4, %eax
// CHECK:  encoding: [0x0f,0x21,0xe0]
        movl %dr4,%eax

// CHECK: movl	%dr5, %eax
// CHECK:  encoding: [0x0f,0x21,0xe8]
        movl %dr5,%eax

// CHECK: movl	%dr6, %eax
// CHECK:  encoding: [0x0f,0x21,0xf0]
        movl %dr6,%eax

// CHECK: movl	%dr7, %eax
// CHECK:  encoding: [0x0f,0x21,0xf8]
        movl %dr7,%eax

// radr://8017522
// CHECK: wait
// CHECK:  encoding: [0x9b]
	fwait

// rdar://7873482
// CHECK: [0x65,0x8b,0x05,0x7c,0x00,0x00,0x00]
// FIXME: This is a correct bug poor encoding: Use 65 a1 7c 00 00 00 
        movl	%gs:124, %eax

// CHECK: pusha
// CHECK:  encoding: [0x60]
        	pusha

// CHECK: popa
// CHECK:  encoding: [0x61]
        	popa

// CHECK: pushal
// CHECK:  encoding: [0x60]
        	pushal

// CHECK: popal
// CHECK:  encoding: [0x61]
        	popal

// CHECK: jmpl *8(%eax)
// CHECK:   encoding: [0xff,0x60,0x08]
	jmp	*8(%eax)

// PR7465
// CHECK: lcalll $2, $4660
// CHECK:   encoding: [0x9a,0x34,0x12,0x00,0x00,0x02,0x00]
lcalll $0x2, $0x1234


// rdar://8061602
L1:
  jcxz L1
// CHECK: jcxz L1
// CHECK:   encoding: [0x67,0xe3,A]
  jecxz L1
// CHECK: jecxz L1
// CHECK:   encoding: [0xe3,A]

// rdar://8403974
iret
// CHECK: iretl
// CHECK: encoding: [0xcf]
iretw
// CHECK: iretw
// CHECK: encoding: [0x66,0xcf]
iretl
// CHECK: iretl
// CHECK: encoding: [0xcf]

// rdar://8403907
sysret
// CHECK: sysretl
// CHECK: encoding: [0x0f,0x07]
sysretl
// CHECK: sysretl
// CHECK: encoding: [0x0f,0x07]

// rdar://8018260
testl	%ecx, -24(%ebp)
// CHECK: testl	-24(%ebp), %ecx
testl	-24(%ebp), %ecx
// CHECK: testl	-24(%ebp), %ecx


// rdar://8407242
push %cs
// CHECK: pushl	%cs
// CHECK: encoding: [0x0e]
push %ds
// CHECK: pushl	%ds
// CHECK: encoding: [0x1e]
push %ss
// CHECK: pushl	%ss
// CHECK: encoding: [0x16]
push %es
// CHECK: pushl	%es
// CHECK: encoding: [0x06]
push %fs
// CHECK: pushl	%fs
// CHECK: encoding: [0x0f,0xa0]
push %gs
// CHECK: pushl	%gs
// CHECK: encoding: [0x0f,0xa8]

pushw %cs
// CHECK: pushw	%cs
// CHECK: encoding: [0x66,0x0e]
pushw %ds
// CHECK: pushw	%ds
// CHECK: encoding: [0x66,0x1e]
pushw %ss
// CHECK: pushw	%ss
// CHECK: encoding: [0x66,0x16]
pushw %es
// CHECK: pushw	%es
// CHECK: encoding: [0x66,0x06]
pushw %fs
// CHECK: pushw	%fs
// CHECK: encoding: [0x66,0x0f,0xa0]
pushw %gs
// CHECK: pushw	%gs
// CHECK: encoding: [0x66,0x0f,0xa8]

pop %ss
// CHECK: popl	%ss
// CHECK: encoding: [0x17]
pop %ds
// CHECK: popl	%ds
// CHECK: encoding: [0x1f]
pop %es
// CHECK: popl	%es
// CHECK: encoding: [0x07]

// rdar://8408129
pushfd
// CHECK: pushfl
popfd
// CHECK: popfl
pushfl
// CHECK: pushfl
popfl
// CHECK: popfl


// rdar://8416805
	setc	%bl
	setnae	%bl
	setnb	%bl
	setnc	%bl
	setna	%bl
	setnbe	%bl
	setpe	%bl
	setpo	%bl
	setnge	%bl
	setnl	%bl
	setng	%bl
	setnle	%bl

// PR8686
        setneb  %cl // CHECK: setne %cl
	setcb	%bl // CHECK: setb %bl
	setnaeb	%bl // CHECK: setb %bl


// CHECK: lcalll	$31438, $31438
// CHECK: lcalll	$31438, $31438
// CHECK: ljmpl	$31438, $31438
// CHECK: ljmpl	$31438, $31438

calll	$0x7ace,$0x7ace
lcalll	$0x7ace,$0x7ace
jmpl	$0x7ace,$0x7ace
ljmpl	$0x7ace,$0x7ace

// CHECK: lcalll	$31438, $31438
// CHECK: lcalll	$31438, $31438
// CHECK: ljmpl	$31438, $31438
// CHECK: ljmpl	$31438, $31438

call	$0x7ace,$0x7ace
lcall	$0x7ace,$0x7ace
jmp	$0x7ace,$0x7ace
ljmp	$0x7ace,$0x7ace

// rdar://8456370
// CHECK: calll a
 calll a

// CHECK:	incb	%al # encoding: [0xfe,0xc0]
	incb %al

// CHECK:	incw	%ax # encoding: [0x66,0x40]
	incw %ax

// CHECK:	incl	%eax # encoding: [0x40]
	incl %eax

// CHECK:	decb	%al # encoding: [0xfe,0xc8]
	decb %al

// CHECK:	decw	%ax # encoding: [0x66,0x48]
	decw %ax

// CHECK:	decl	%eax # encoding: [0x48]
	decl %eax

// CHECK: pshufw $14, %mm4, %mm0 # encoding: [0x0f,0x70,0xc4,0x0e]
pshufw $14, %mm4, %mm0

// CHECK: pshufw $90, %mm4, %mm0 # encoding: [0x0f,0x70,0xc4,0x5a]
// PR8288
pshufw $90, %mm4, %mm0

// rdar://8416805
// CHECK: aaa
// CHECK:  encoding: [0x37]
        	aaa

// CHECK: aad	$1
// CHECK:  encoding: [0xd5,0x01]
        	aad	$1

// CHECK: aad
// CHECK:  encoding: [0xd5,0x0a]
        	aad	$0xA

// CHECK: aad
// CHECK:  encoding: [0xd5,0x0a]
        	aad

// CHECK: aam	$2
// CHECK:  encoding: [0xd4,0x02]
        	aam	$2

// CHECK: aam
// CHECK:  encoding: [0xd4,0x0a]
        	aam	$0xA

// CHECK: aam
// CHECK:  encoding: [0xd4,0x0a]
        	aam

// CHECK: aas
// CHECK:  encoding: [0x3f]
        	aas

// CHECK: daa
// CHECK:  encoding: [0x27]
        	daa

// CHECK: das
// CHECK:  encoding: [0x2f]
        	das

// CHECK: retw	$31438
// CHECK:  encoding: [0x66,0xc2,0xce,0x7a]
        	retw	$0x7ace

// CHECK: lretw	$31438
// CHECK:  encoding: [0x66,0xca,0xce,0x7a]
        	lretw	$0x7ace

// CHECK: bound	2(%eax), %bx
// CHECK:  encoding: [0x66,0x62,0x58,0x02]
        	bound	2(%eax),%bx

// CHECK: bound	4(%ebx), %ecx
// CHECK:  encoding: [0x62,0x4b,0x04]
        	bound	4(%ebx),%ecx

// CHECK: arpl	%bx, %bx
// CHECK:  encoding: [0x63,0xdb]
        	arpl	%bx,%bx

// CHECK: arpl	%bx, 6(%ecx)
// CHECK:  encoding: [0x63,0x59,0x06]
        	arpl	%bx,6(%ecx)

// CHECK: lgdtw	4(%eax)
// CHECK:  encoding: [0x66,0x0f,0x01,0x50,0x04]
        	lgdtw	4(%eax)

// CHECK: lgdt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x50,0x04]
        	lgdt	4(%eax)

// CHECK: lgdt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x50,0x04]
        	lgdtl	4(%eax)

// CHECK: lidtw	4(%eax)
// CHECK:  encoding: [0x66,0x0f,0x01,0x58,0x04]
        	lidtw	4(%eax)

// CHECK: lidt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x58,0x04]
        	lidt	4(%eax)

// CHECK: lidt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x58,0x04]
        	lidtl	4(%eax)

// CHECK: sgdtw	4(%eax)
// CHECK:  encoding: [0x66,0x0f,0x01,0x40,0x04]
        	sgdtw	4(%eax)

// CHECK: sgdt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x40,0x04]
        	sgdt	4(%eax)

// CHECK: sgdt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x40,0x04]
        	sgdtl	4(%eax)

// CHECK: sidtw	4(%eax)
// CHECK:  encoding: [0x66,0x0f,0x01,0x48,0x04]
        	sidtw	4(%eax)

// CHECK: sidt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x48,0x04]
        	sidt	4(%eax)

// CHECK: sidt	4(%eax)
// CHECK:  encoding: [0x0f,0x01,0x48,0x04]
        	sidtl	4(%eax)

// CHECK: fcompi	%st(2)
// CHECK:  encoding: [0xdf,0xf2]
        	fcompi	%st(2), %st

// CHECK: fcompi	%st(2)
// CHECK:  encoding: [0xdf,0xf2]
        	fcompi	%st(2)

// CHECK: fcompi
// CHECK:  encoding: [0xdf,0xf1]
        	fcompi

// CHECK: fucompi	%st(2)
// CHECK:  encoding: [0xdf,0xea]
        	fucompi	%st(2),%st

// CHECK: fucompi	%st(2)
// CHECK:  encoding: [0xdf,0xea]
        	fucompi	%st(2)

// CHECK: fucompi
// CHECK:  encoding: [0xdf,0xe9]
        	fucompi

// CHECK: fldcw	32493
// CHECK:  encoding: [0xd9,0x2d,0xed,0x7e,0x00,0x00]
        	fldcww	0x7eed

// CHECK: fldcw	32493
// CHECK:  encoding: [0xd9,0x2d,0xed,0x7e,0x00,0x00]
        	fldcw	0x7eed

// CHECK: fnstcw	32493
// CHECK:  encoding: [0xd9,0x3d,0xed,0x7e,0x00,0x00]
        	fnstcww	0x7eed

// CHECK: fnstcw	32493
// CHECK:  encoding: [0xd9,0x3d,0xed,0x7e,0x00,0x00]
        	fnstcw	0x7eed

// CHECK: wait
// CHECK:  encoding: [0x9b]
        	fstcww	0x7eed

// CHECK: wait
// CHECK:  encoding: [0x9b]
        	fstcw	0x7eed

// CHECK: fnstsw	32493
// CHECK:  encoding: [0xdd,0x3d,0xed,0x7e,0x00,0x00]
        	fnstsww	0x7eed

// CHECK: fnstsw	32493
// CHECK:  encoding: [0xdd,0x3d,0xed,0x7e,0x00,0x00]
        	fnstsw	0x7eed

// CHECK: wait
// CHECK:  encoding: [0x9b]
        	fstsww	0x7eed

// CHECK: wait
// CHECK:  encoding: [0x9b]
        	fstsw	0x7eed

// CHECK: verr	32493
// CHECK:  encoding: [0x0f,0x00,0x25,0xed,0x7e,0x00,0x00]
        	verrw	0x7eed

// CHECK: verr	32493
// CHECK:  encoding: [0x0f,0x00,0x25,0xed,0x7e,0x00,0x00]
        	verr	0x7eed

// CHECK: wait
// CHECK:  encoding: [0x9b]
        	fclex

// CHECK: fnclex
// CHECK:  encoding: [0xdb,0xe2]
        	fnclex

// CHECK: ud2
// CHECK:  encoding: [0x0f,0x0b]
        	ud2

// CHECK: ud2
// CHECK:  encoding: [0x0f,0x0b]
        	ud2a

// CHECK: ud2b
// CHECK:  encoding: [0x0f,0xb9]
        	ud2b

// CHECK: loope 0
// CHECK: encoding: [0xe1,A]
	loopz 0

// CHECK: loopne 0
// CHECK: encoding: [0xe0,A]
	loopnz 0

// CHECK: outsb # encoding: [0x6e]
// CHECK: outsb
// CHECK: outsb
	outsb
	outsb	%ds:(%esi), %dx
	outsb	(%esi), %dx

// CHECK: outsw # encoding: [0x66,0x6f]
// CHECK: outsw
// CHECK: outsw
	outsw
	outsw	%ds:(%esi), %dx
	outsw	(%esi), %dx

// CHECK: outsl # encoding: [0x6f]
// CHECK: outsl
	outsl
	outsl	%ds:(%esi), %dx
	outsl	(%esi), %dx

// CHECK: insb # encoding: [0x6c]
// CHECK: insb
	insb
	insb	%dx, %es:(%edi)

// CHECK: insw # encoding: [0x66,0x6d]
// CHECK: insw
	insw
	insw	%dx, %es:(%edi)

// CHECK: insl # encoding: [0x6d]
// CHECK: insl
	insl
	insl	%dx, %es:(%edi)

// CHECK: movsb # encoding: [0xa4]
// CHECK: movsb
// CHECK: movsb
	movsb
	movsb	%ds:(%esi), %es:(%edi)
	movsb	(%esi), %es:(%edi)

// CHECK: movsw # encoding: [0x66,0xa5]
// CHECK: movsw
// CHECK: movsw
	movsw
	movsw	%ds:(%esi), %es:(%edi)
	movsw	(%esi), %es:(%edi)

// CHECK: movsd # encoding: [0xa5]
// CHECK: movsd
// CHECK: movsd
	movsl
	movsl	%ds:(%esi), %es:(%edi)
	movsl	(%esi), %es:(%edi)

// CHECK: lodsb # encoding: [0xac]
// CHECK: lodsb
// CHECK: lodsb
// CHECK: lodsb
// CHECK: lodsb
	lodsb
	lodsb	%ds:(%esi), %al
	lodsb	(%esi), %al
	lods	%ds:(%esi), %al
	lods	(%esi), %al

// CHECK: lodsw # encoding: [0x66,0xad]
// CHECK: lodsw
// CHECK: lodsw
// CHECK: lodsw
// CHECK: lodsw
	lodsw
	lodsw	%ds:(%esi), %ax
	lodsw	(%esi), %ax
	lods	%ds:(%esi), %ax
	lods	(%esi), %ax

// CHECK: lodsl # encoding: [0xad]
// CHECK: lodsl
// CHECK: lodsl
// CHECK: lodsl
// CHECK: lodsl
	lodsl
	lodsl	%ds:(%esi), %eax
	lodsl	(%esi), %eax
	lods	%ds:(%esi), %eax
	lods	(%esi), %eax

// CHECK: stosb # encoding: [0xaa]
// CHECK: stosb
// CHECK: stosb
	stosb
	stosb	%al, %es:(%edi)
	stos	%al, %es:(%edi)

// CHECK: stosw # encoding: [0x66,0xab]
// CHECK: stosw
// CHECK: stosw
	stosw
	stosw	%ax, %es:(%edi)
	stos	%ax, %es:(%edi)

// CHECK: stosl # encoding: [0xab]
// CHECK: stosl
// CHECK: stosl
	stosl
	stosl	%eax, %es:(%edi)
	stos	%eax, %es:(%edi)

// CHECK: strw
// CHECK: encoding: [0x66,0x0f,0x00,0xc8]
	str %ax

// CHECK: strl
// CHECK: encoding: [0x0f,0x00,0xc8]
	str %eax


// PR9378
// CHECK: fsubp
// CHECK: encoding: [0xde,0xe1]
fsubp %st,%st(1)

// PR9164
// CHECK: fsubp	%st(2)
// CHECK: encoding: [0xde,0xe2]
fsubp   %st, %st(2)

// PR10345
// CHECK: xchgl %eax, %eax
// CHECK: encoding: [0x90]
xchgl %eax, %eax

// CHECK: xchgw %ax, %ax
// CHECK: encoding: [0x66,0x90]
xchgw %ax, %ax

// CHECK: xchgl %ecx, %eax
// CHECK: encoding: [0x91]
xchgl %ecx, %eax

// CHECK: xchgl %ecx, %eax
// CHECK: encoding: [0x91]
xchgl %eax, %ecx
