.data

# string:
# 	.ascii ""
iter:
	.long 0

.type generate_string, @function

.globl generate_string

.text

# char * s		%rdi
# char c			%esi
# int n			%edx
# int inc		%ecx
# return 		%rax

generate_string:
	# XOR %rdi, %rdi # wyzeruj string
	MOVL %esi, %eax
	MOVQ %rdi, %rbx
loop:
	INCL 	iter
	JMP chars_the_same

back:
	CMP 	%edx, iter
	JLE		loop
	MOVB $0, (%rdi)
	MOVQ	%rbx, %rax
	ret

chars_the_same:
	MOVB		%al, (%rdi)
	INC 	%rdi
	CMP		$0, %ecx
	JE		back
	ADDB  $1, %al
	JMP		back

# chars_incremented:
# 	JMP 	back
