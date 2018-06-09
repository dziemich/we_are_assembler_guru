#----------------------------------------------------------------
# Funkcja do programu lab_7b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.type fiba, @function
	.global fiba

fiba:	push %rbx

	mov $0, %rbx
	mov $1, %rcx	

	cmp %rbx, %rdi
	jz	f_0
	cmp %rcx, %rdi
	jz	f_1

next:
	mov %rbx, %rax
	add %rcx, %rax
	mov %rcx, %rbx
	mov %rax, %rcx
	dec %rdi
	cmp $1, %rdi
	ja next	

f_e:	pop %rbx
	ret

f_0:
	mov %rbx, %rax
	jmp f_e

f_1:
	mov %rcx, %rax
	jmp f_e
