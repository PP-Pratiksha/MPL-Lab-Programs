section .data
	msg: db "Enter the String : "
	len: equ $-msg
	msg1: db "The length of String is : "
	len1:equ $-msg1
section .bss
	str: resb 100
	count: resb 16
section .text
global _start
_start:
    %macro rw 4
    mov rax,%1
    mov rdi,%2
    mov rsi,%3
    mov rdx,%4
    syscall
    %endmacro
    
	rw 01,01,msg,len
	rw 00,00,str,100
	
	
	dec al
	mov BYTE[count],al
	cmp  byte[count],09
	jbe next2
	add byte[count],7H

	next2:add byte[count],30H
	
	rw 01,01,msg1,len1
	rw 01,01,count,1
	
mov rax,60
mov rdi,0
syscall
