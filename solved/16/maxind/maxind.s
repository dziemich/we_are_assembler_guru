#sub - odejmowanie
# %rdi - pierwszy arg
# %rsi - drugi argument
# %rdx - trzeci arg
# %rcx - 4
# %rax - koncowy



.data
	.type maxind function
	.globl maxind

.text

maxind:
		MOVL %edi, %eax					# eax = pierwszy
		MOVL $1, %r10d
		CMPL %esi, %eax				# eax=pierwszy   >    drugi?	
		JG zad2									# większy to idź do zad2 eax = pierwsz
		MOVL %esi, %eax						# nie większy to eax = drugi
		inc %r10d
	zad2:
		CMPL %edx, %eax					# eax > adx=trzeci?				
		JG zad3									# większy to zad 3
		MOVL %edx, %eax					# nie eax = edx = trzeci
		inc %r10d
	zad3:
		CMPL %ecx, %eax						# eax > ecx = czwarty ?
		JG czyTeSame						# większe to skocz do sprawdzania najmniejszego
		MOVL %ecx, %eax
		inc %r10d
		
czyTeSame:
	CMPL %edi, %esi
	JE tesame
	CMPL %edi, %edx
	JE tesame
	CMPL %edi, %ecx
	JE tesame
	CMPL %esi, %edx
	JE tesame
	CMPL %esi, %ecx
	JE tesame
	CMPL %ecx, %edx
	JE tesame
	
koniec:
		movl %r10d, %eax
		ret
	
tesame:
	movl $0, %eax
	ret
		

