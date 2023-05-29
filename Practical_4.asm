%macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro rw

section .bss
	ascarr resb 2
	ans resb 20
	choice resb 2
       

section .data

	count1 db 16
	mystr db "********** MENU ********** ",10,13,"1.Addition",10,13,"2.Subtraction",10,13,"3.Division",10,13,"4.Multiplication",10,13,"5.Exit",10,13
	len equ $-mystr
	msg db "Enter Choice",10,13
	len1 equ $-msg


	m1 db "Sum is  :"
	l1 equ $-m1
	
	m2 db "Difference is :"
	l2 equ $-m2

	m3 db "Quotient is  :"
	l3 equ $-m3

	m4 db "Product is :"
	l4 equ $-m4

	nl db 10,13
	l5 equ $-nl

	num1 db 0000000000000006h
	num2 db 0000000000000002h
	
	
section .text
	global _start
			_start:

      up:rw 1,1,mystr,len
	rw 1,1,msg,len1
	rw 0,0,choice,2
	;sub byte[choice],30h

	cmp byte[choice],'1'
	je addition

	cmp byte[choice],'2'
	je subtraction

	cmp byte[choice],'3'
	je division

	cmp byte[choice],'4'
	je multiplication

	cmp byte[choice],'5'
	je exitprog

addition: rw 1,1,m1,l1
	  call adds
          jmp up

subtraction: rw 1,1,m2,l2
 	call subs
	jmp up

division: rw 1,1,m3,l3
	call divs
	jmp up

multiplication: rw 1,1,m4,l4
	call muls
	jmp up


exitprog:mov rax,60
	mov rdi,00
	syscall


adds:
	mov al,byte[num1]
	mov bl,byte[num2]
	add al,bl
	mov byte[ans],al
	call hextoasc
        ret

subs:
	mov al,byte[num1]
	mov bl,byte[num2]
	sub al,bl
	mov byte[ans],al
	call hextoasc
ret

divs:
	mov al,byte[num1]
	mov bl,byte[num2]
	div bl
	mov byte[ans],al
	call hextoasc
ret
muls:
	mov al,byte[num1]
	mov bl,byte[num2]
	mul bl
	mov byte[ans],al
	call hextoasc
ret

hextoasc:

        mov rsi,ascarr
        mov al,byte[ans]

again1:rol rax,04h
       mov rbx,rax
       and rbx,0Fh
       cmp rbx,09
       jbe next1
       add rbx,07h
next1: add rbx,30h

       mov [rsi],rbx
       inc rsi
       dec byte[count1]
       jnz again1
	rw 1,1,ascarr,16
	rw 1,1,nl,l5

ret
