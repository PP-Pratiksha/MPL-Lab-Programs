section .data
	array db 0000000000000001h,0000000000000023h,0000000000000010h,0000000000000031h,0000000000000005h
	msg1 db 'Practical No-3',10,10
	len1 equ $-msg1
	msg db 'The Greatest Number is:'
        len equ $-msg
        end1 db "",10,13

section .bss
	count resb 2
	output resb 200
result resb 10

section .text
	global _start
		_start:
		
		%macro write 2
			mov rax,1
			mov rdi,1
			mov rsi,%1
			mov rdx,%2
			syscall
		%endmacro
		
		write msg1,len1
   		mov byte[count],05
    		xor rbx,rbx
    		mov rsi,array
    		
	up: cmp bl,BYTE[rsi]
   		ja down
    		mov bl,BYTE[rsi]
    		
	down:inc rsi
     		dec byte[count]
     		jnz up
     		
     		
    	 
    
    
    	write msg,len    ;to print 'The Greatest Number is:'
     


        mov BYTE[count],16
        mov rsi,output
       above:rol rbx, 04
            mov dl,bl
	and dl, 0Fh
	cmp dl,09h
	jbe next
	add dl,07h
	
	next:add dl,30h
	mov BYTE[rsi],dl
	inc rsi
	dec BYTE[count] ;dec count
	jnz above
	;to print the contents of bl

	write output,16
	write end1,1

	;exit syscall
	mov rax,60
	mov rdi,00
	syscall


