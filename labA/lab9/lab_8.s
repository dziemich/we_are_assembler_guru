#----------------------------------------------------------------
# Program lab_8.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
# To compile:	as -o lab_8.o lab_8.s
# To link:	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o lab_8 lab_8.o
# To run:	./lab_8
#
#----------------------------------------------------------------

	.data
argc_s:
	.asciz "argc = %d\n"
args_s:
	.asciz "%s\n"
sep_s:
	.asciz "----------------------------\n"
argc:
	.quad 0
argv:
	.quad 0
env:
	.quad 0


	.text
	.global _start

_start:

	mov (%rsp), %rax	# argc is here
	mov %rax, argc		# store value of argc

	mov $argc_s,%rdi
	mov argc, %rsi
	mov $0, %al
	call printf		# display value of argc

	mov %rsp, %rbx		# use rbx as a pointer
	add $8, %rbx		# argv[] is here
	mov %rbx, argv		# store address of argv[]

	mov argc, %r12		# get value of argc

next_argv:

	mov $args_s, %rdi
	mov (%rbx), %rsi
	mov $0, %al
	call printf		# display value of argv[i]

	add $8,%rbx		# address of argv[i+1]

	dec %r12
	jnz next_argv

	mov $sep_s, %rdi
	mov $0, %al
	call printf		# display separator

	add $8, %rbx		# env[] is here - skip zero/NULL
	mov %rbx, env		# store address of env[]

next_env:

	cmp $0,(%rbx)		# is env[i] == NULL
	je finish		# yes

	mov $args_s, %rdi
	mov (%rbx), %rsi	# no
	mov $0, %al
	call printf		# displays value of env[i]

	add $8,%rbx		# address of env[i+1]
	jmp next_env

finish:
	mov $0,%rdi		# this is the end...
	call exit

