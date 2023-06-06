section .data
	msg db "The sorted array is : ",10
	msglen equ $-msg
	arr db 07h,0A1h,75h,0D3h,12h

%macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .bss
	result resb 15

section .text
	global _start
_start:
	mov edi,arr
	mov bl,5 ;outer loop runs n times

	loop_outer:

	mov cl,4 ;inner loop runs n-1 times
	mov esi,arr

	up:

	mov al,byte[esi]
	cmp al,byte[esi+1]
	jbe only_inc ;no swapping

	xchg al,byte[esi+1]
	mov byte[esi],al

	only_inc:
	inc esi
	dec cl ;decrementing inner loop
	jnz up

	dec bl ;decrementing outer loop
	jnz loop_outer

	rw 1,1,msg,msglen ;sorted array is

	;unpacking
	mov edi,arr
	mov esi,result
	mov dl,10 ;for one number there are two digits

	disp_loop:
	mov cl,2
	mov al,[edi]

	againx:
	rol al,4
	mov bl,al
	and al,0Fh
	cmp al,09h
	jbe down
	add al,07h

	down:
	add al,30h
	mov byte[esi],al
	mov al,bl
	inc esi
	dec cl
	jnz againx

	mov byte[esi],0Ah
	inc esi
	inc edi
	dec dl
	jnz disp_loop
	rw 1,1,result,15

	rw 60,0,0,0
