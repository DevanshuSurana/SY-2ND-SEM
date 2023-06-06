%macro rw 4
    mov rax,%1
    mov rdi,%2
    mov rsi,%3
    mov rdx,%4
    syscall
   %endmacro
   
section .data
    Number dw 9999d
    msg db 10d,13d,"Given Hex's equivalent BCD value is: "
    msglen equ $-msg
    
section .bss
    num resb 5

section .code
    global _start
_start:
	mov ax,word[Number]
		mov bx,0Ah
		mov rdi,num+4
	
	loop3:
		mov dx,0
		div bx
		cmp dl,09h
		jbe down1
		add dl,07h
	down1:	add dl,30h
	mov[rdi],dl
	dec rdi
	cmp ax,0
	jne loop3

	rw 1,1,msg,msglen
	rw 1,1,num,5	
	
exit:
mov rax,60
mov rdx,0
syscall
