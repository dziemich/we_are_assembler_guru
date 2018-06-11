#sub - odejmowanie
# %rdi - pierwszy arg
# %rsi - drugi argument
# %rdx - trzeci arg
# %rcx - 4
# %rax - koncowy



.data
	.type maxdif function
	.globl maxdif

.text
	maxdif:						#szukam największej i wrzucam do %eax
		MOVL %edi, %eax		
		CMPL %esi, %eax			
		JG zad2
		MOVL %esi, %eax
	zad2:
		CMPL %edx, %esi			
		JG zad3
		MOVL %edx, %eax
	zad3:
		CMPL %ecx, %edx
		JG najmniejszy
		MOVL %edx, %eax				

	najmniejszy:				#szukam najmniejszej i wrzucam do %r10d
		MOVL %edi, %r10d		
		CMPL %esi, %r10d			
		JL zad4
		MOVL %esi, %r10d
	zad4:
		CMPL %edx, %r10d		
		JL zad5
		MOVL %edx, %r10d		
	zad5:
		CMPL %ecx, %r10d			
		JL odejmowanie
		MOVL %edx, %r10d		


	odejmowanie:
		SUBL %r10d, %eax		#odejmuję najmniejszą od największej
		ret
