#----------------------------------------------------------------
# Funkcja do programu lab_7a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type facta, @function
	.globl facta	

facta:	mov $1, %rax # bo albo zwracamy albo mnozymy przez 1

next:	cmp $1, %rdi
	jbe f_e
	mul %rdi   	# nasz parametr
	dec %rdi	#zmniejszamy parametr
	jmp next	# domykamy petle

f_e:	ret

