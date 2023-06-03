section .data
	count db 5
	
	endl db 0xA,0xD
	
	arr dq 0000000000000012h,0000000000000010h,-0000000000000034h,-0000000000000040h, 0000000000000009h
	
	posMsg db "Positive numbers count is:"
	lenPos equ $-posMsg
		
	negMsg db "Negative numbers count is:"
	lenNeg equ $-negMsg
	
	%macro scall 4
		mov rax,%1
		mov rdi,%2
		mov rsi,%3
		mov rdx,%4
		syscall
	%endmacro
	
section .bss
	count1 resb 20
	posC resb 16
	negC resb 16
	output resb 100
	
section .text
	global _start
		_start: 
		
		;print array
		mov rsi,arr
			
		up1:	mov rax,qword[rsi]
		      mov rbx,rax
		      push rsi
		      call disp
		      pop rsi
		      add rsi,8
			dec byte[count]
			jnz up1
		
		;positive/negative logic
		      xor rax,rax
			mov rsi,arr
			mov byte[count],5
			
		up:	mov rax,rsi
			bt qword[rax],63
			jc neg
			
			inc byte[posC]
			jmp down
			
		neg:	inc byte[negC]
		
		down: add rsi,8
			dec byte[count]
			jnz up
						
			scall 1,1,posMsg,lenPos
			mov rbx,qword[posC] 	
			call disp
			;scall 1,1,posC,1
		
			scall 1,1,endl,1
			
			scall 1,1,negMsg,lenNeg
			mov rbx,qword[negC]
			call disp
			;scall 1,1,negC,1
			
			scall 1,1,endl,1
			
			mov rax,60
			mov rdi,00
			syscall
			
		disp:	mov BYTE[count1],16
			mov rsi,output
			above:
				rol rbx, 04
				mov dl,bl
				and dl,0Fh
				cmp dl,09h
				jbe next
				add dl,07h
			next:
				add dl,30h
				mov BYTE[rsi],dl
				inc rsi
				dec BYTE[count1] ;dec count
				jnz above
				scall 1,1,output,16
				scall 1,1,endl,1
				ret
				
		arry_no: mov rbx,rax
		           ;push rsi
		           call disp
		           ;pop rsi
		           ret
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
