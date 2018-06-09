 
	.type mina, @function
	.global fiba

mina:	
	cmp %rdx, %rsi 
	jl ein
	cmp %rsi, %rdi
	jl drei
	mov %rdi, %rax
	ret

ein:
	cmp %rdx, %rdi
	jl zwei
	mov %rdi, %rax
	ret

zwei:
	mov %rdx, %rax
	ret

drei:
	mov %rsi, %rax
	ret



