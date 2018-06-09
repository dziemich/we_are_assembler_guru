	.type najmn, @function
	.global najmn

najmn:	
	mov %rdi, %rax
	cmp %rsi, %rax
	jg f0
	cmp %rdx, %rax
	jg f1
	jmp st

f0:
	mov %rsi, %rax

f1:
	mov %rdx, %rax

st:
	ret
