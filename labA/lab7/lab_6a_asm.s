#----------------------------------------------------------------
# Funkcja do programu lab_6a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type facta, @function
	.globl facta	

facta:	mov $1, %rax

	cmp %rax, %rdi
	jbe f_e

	push %rdi

	dec %rdi
	call facta

	pop %rdi

	mul %rdi

f_e:	ret

