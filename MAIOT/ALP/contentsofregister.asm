section .data
	gmsg db 10, 10, "The contents of GDTR are: "
	gmsglen equ $-gmsg
	lmsg db 10, 10, "The contents of LDTR are: "
	lmsglen equ $-lmsg
	imsg db 10, 10, "The contents of IDTR are: "
	imsglen equ $-imsg
	tmsg db 10, 10, "The contents of TR are: "
	tmsglen equ $-tmsg
	mmsg db 10, 10, "The contents of MDTR are: "
	mmsglen equ $-mmsg

	pro db 10, 10, "Protected mode: "
	prolen equ $-pro
	real db 10, 10, "Real Mode: "
	reallen equ $-real

	col db " : "
	collen equ $-col
	nline db 10, 10
	nlen equ $-nline


section .bss
	buff resb 4
	gdt1 resb 6
	idt1 resb 6
	ldt1 resw 1
	t1 resb 2
	msw1 resb 4

%macro rw 4
	mov rax, %1
	mov rdi, %2
	mov rsi, %3
	mov rdx, %4
	syscall
%endmacro

section .text
	global _start
_start:
	smsw eax
	mov [msw1], eax
	bt eax, 0
	jc protected
	rw 1, 1, real, reallen
	jmp end
	protected: rw 1, 1, pro, prolen
	sgdt [gdt1]
	sidt [idt1]
	sldt [ldt1]
	str [t1]
	rw 1, 1, gmsg, gmsglen
	mov bx, [gdt1+4]
	call ori_ascii
	mov bx, [gdt1+2]
	call ori_ascii
	rw 1, 1, col, collen
	mov bx, [gdt1]
	call ori_ascii

	rw 1, 1, lmsg, lmsglen
	mov bx, [ldt1]
	call ori_ascii

	rw 1, 1, imsg, imsglen
	mov bx, [idt1+4]
	call ori_ascii
	mov bx, [idt1+2]
	call ori_ascii
	rw 1, 1, col, collen
	mov bx, [idt1]
	call ori_ascii

	rw 1, 1, tmsg, tmsglen
	mov bx, [t1]
	call ori_ascii

	rw 1, 1, mmsg, mmsglen
	mov bx, [msw1+2]
	call ori_ascii
	mov bx, [msw1]
	call ori_ascii

	end: rw 1, 1, nline, nlen
	rw 60, 0, 0, 0

	ori_ascii:
	mov rax, 0
	mov rcx, 4
	mov rdi, buff
	up2: rol bx, 4
	mov dl, bl
	and dl, 0fh
	cmp dl, 09h
	jbe down2
	add dl, 07h
	down2: add dl, 30h
	mov [rdi], dl
	inc rdi
	loop up2
	rw 1, 1, buff, 4
	ret 
	   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   














   
   
   
   
   
   
   
   
   
   
   
