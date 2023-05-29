section .data
msg: db "Enter 5 64 bit numbers:"
len:equ $-msg

msg1: db "Numbes are:"
len1:equ $-msg1



section .bss
array resb 100
count resb 05


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

;to print 'Enter 5 64-bit  numbers'
rw 01,01,msg,len

;reading the numnbers
mov byte[count],05
mov rbx,array
up:
rw 00,00,rbx,17
add rbx,17
dec byte[count]
jnz up


;to print 'The numbers are: '
rw 01,01,msg1,len1

;to print the 5 numbers
mov byte[count],05
mov rbx,array
back:
rw 01,01,rbx,17
add rbx,17
dec byte[count]
jnz back

;exit syscall
mov rax,60
mov rdi,00
syscall
