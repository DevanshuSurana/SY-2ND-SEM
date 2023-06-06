%macro rw 4
mov rax, %1
mov rdi, %2 
mov rsi, %3 
mov rdx, %4 
syscall
%endmacro
section .data
arr times 10 db 0
msg2 db "The elements of array: ", 10 
msg2len equ $-msg2
msg1 db "Sum of array is: ", 10 
msg1len equ $-msg1
cnt db 5
temp1 db 0
section .bss
sum1 resb 2
num resb 3 ;store entered number temp resb 2
section .text 
global _start
_start:
mov rbp, arr ;added nw
nextnum: rw 1, 1, msg2, msg2len
rw 0, 0, num, 3
mov rcx, 0
mov rax, 0
mov rsi, num
up: mov cl, byte[rsi]
cmp cl, 0Ah
je packed
cmp cl, 39h
jbe down
sub cl, 07h
down: sub cl, 30h
rol al, 4
add al, cl
inc rsi
jmp up
packed: mov byte[rbp], al 
inc rbp
dec byte[cnt]
jnz nextnum
mov rsi, arr
mov ax, 00h
mov bx, 00h
mov cx, 5
up2: mov bl, byte[rsi] 
add ax, bx
inc rsi
dec cx
jnz up2
mov word[sum1], ax
rw 1, 1, msg1, msg1len 
mov ax, word[sum1] 
mov bp, 4
up1: rol ax, 4 
mov bx, ax 
and ax, 0fh 
cmp al, 09 
jbe down1
add al, 07h
down1: add al, 30h 
mov byte[temp1], al 
rw 1, 1, temp1, 1
mov ax, bx
dec bp
jnz up1
rw 60, 0, 0, 0