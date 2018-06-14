#char* buf = %rdi
#char* a = %rsi
#char* b = %rdx




.data
	.type fun function
	.globl fun

.text

fun:
	movq %rdi, %rax

dodajLitere:
	mov (%rsi), %r8
	mov %r8, (%rdi)
	inc %rsi
	inc %rdi
	mov (%rdx), %r8
	mov %r8, (%rdi)
	inc %rdx
	inc %rdi
	
warunek:
	cmpq $0, (%rdx)
	JE koniec
	JMP dodajLitere

koniec:
	movb $0, (%rdi)
	ret
	
	
