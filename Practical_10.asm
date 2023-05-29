section .data
	msgFact: db 'Factorial is:',0xa
	msgFactSize: equ $-msgFact
	msg1 db "The Number is:",0xa
	len equ $-len
	newLine: db 10
section .bss

	%macro print 2
	mov rax,01
	mov rdi,01
	mov rsi,%1
	mov rdx,%2
	syscall
       %endmacro
       
	fact: resb 8
	num: resb 2

section .txt
global _start
	_start:
	 pop rbx 
	 pop rbx 
	 
	 pop rbx 
	 
	 mov [num],rbx

	 mov rax,1    ;print number accepted from command line

	 print msg1,len
	 print [num],2
	 
	 
	 mov rsi,[num]
	 mov rcx,02
	 xor rbx,rbx
	 call aToH
	 
	 mov rax,rbx
	 
	 call factP

	 
	 mov rcx,08
	 mov rdi,fact
	 xor bx,bx
	 mov ebx,eax
	 call hToA

	 print newLine,1

	 print msgFact,msgFactsize
	 print fact,8
	 
	
	 mov rax,60
	 mov rdi,0
	 syscall
	 
	 print newLine,1


factP:
	 dec rbx
	 cmp rbx,01
	 je comeOut
	 cmp rbx,00
	 je comeOut
	 mul rbx
	 call factP
comeOut:
 	ret
 	
 	
aToH:
up1: rol bx,04
	 mov al,[rsi]
	 cmp al,39H
	 jbe A2
	 sub al,07H
A2: sub al,30H
	 add bl,al
	 inc rsi
	 loop up1
ret


hToA:   
    d:  rol ebx,4
	 mov ax,bx
	 and ax,0fH 
	 cmp ax,09H 
	 jbe ii 
	 add ax,07H
 
 ii: add ax,30H
	 mov [rdi],ax
	 inc rdi
	 loop d
	 ret
 
