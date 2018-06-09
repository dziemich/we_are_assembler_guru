 #----------------------------------------------------------------
# Program lab_8.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#               gcc -o lab_8x lab_8x.s
# To run:	./lab_8x
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
	.global main

main:

	mov %rdi, argc	# argc is here
	mov %rsi, argv		# store value of argc
	mov %rdx, env

	mov $argc_s,%rdi
	mov argc, %rsi
	mov $0, %al
	call printf		# display value of argc

	mov argv, %rbx
	#mov %rsp, %rbx		# use rbx as a pointer
	#add $8, %rbx		# argv[] is here
	#mov %rbx, argv		# store address of argv[]

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

	mov env, %rbx
	#add $8, %rbx		# env[] is here - skip zero/NULL
	#mov %rbx, env		# store address of env[]

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

