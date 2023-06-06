%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
number dw 019CFH
msg db 10d,13d,"Given Hex's Equivalent BCD Number is :"
msglen equ $-msg

section .bss
num resb 5

section .code
global _start
_start:
mov ax,word[number]
mov bx,0AH
mov rdi,num+4

loop3:
mov dx,0
div bx
add dl,30h
mov [rdi],dl
dec rdi
cmp ax,0
jne loop3

rw 1,1,msg,msglen
rw 1,1,num,5

rw 60,0,0,0