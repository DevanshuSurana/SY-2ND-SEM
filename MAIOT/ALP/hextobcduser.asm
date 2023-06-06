%macro rw 4
    mov rax,%1
    mov rdi,%2
    mov rsi,%3
    mov rdx,%4
    syscall
   %endmacro
   
section .data
	msg1 db"Enter the hex number: ",10
	msg1len equ $-msg1
	msg2 db"BCD equivalent number is : ",10
	msg2len equ $-msg2
	
section .bss
	a resb 1
	num resb 5

section .code
    global _start
    
_start:
	rw 1,1,msg1,msg1len
	rw 0,0,num,5
	mov rsi,num
	mov rbp, 00
	
	mov ax, 00h
again:	
	mov bl,byte[rsi]
	cmp bl, 0ah
	je htob
	cmp bl, 39h
	jbe sub30h
	sub bl, 07h
sub30h:	
	sub bl, 30h
	rol  ax,4
	add al,bl
	inc rsi
	jmp again
	
htob:
	mov dx, 00
	mov bx, 0ah
	div bx
	push dx
	inc rbp
	cmp eax,00
	jnz htob
	rw 1,1,msg2,msg2len
	
prnt:	pop dx

nxt1:	add dx, 30h
	mov [a],dl
	rw 1,1,a,1
	dec rbp
	jnz prnt
	
exit:
	mov rax,60
	mov rdi,0
	syscall
