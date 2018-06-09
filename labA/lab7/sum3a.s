
	.type sum3a, @function
	.globl sum3a

sum3a:	
	mov %rdi,%rax
	add %rsi,%rax
	add %rdx,%rax
	ret
