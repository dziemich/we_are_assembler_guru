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
		MOVL %edi, %eax		# eax = pierwszy
		CMPL %esi, %eax		# eax=pierwszy   >    drugi?	
		JG zad2			# większy to idź do zad2 eax = pierwsz
		MOVL %esi, %eax		# nie większy to eax = drugi
	zad2:
		CMPL %edx, %eax		# eax > adx=trzeci?				
		JG zad3			# większy to zad 3
		MOVL %edx, %eax		# nie eax = edx = trzeci
	zad3:
		CMPL %ecx, %eax		# eax > ecx = czwarty ?
		JG najmniejszy		# większe to skocz do sprawdzania najmniejszego
		MOVL %ecx, %eax		# jak nie to eax = ecx		

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
		MOVL %edx, %r10d		


	odejmowanie:
		SUBL %r10d, %eax		#odejmuję najmniejszą od największej
		ret
