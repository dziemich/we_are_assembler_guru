#----------------------------------------------------------------
# Program lab_6c.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile&link: gcc -o lab_6c lab_6c.s
#  To run: 	    ./lab_6c
#
#----------------------------------------------------------------

	.data
fmt:
	.asciz	 "Value = %ld\n"
value:
	.quad	15
	
	.text
	.global main
	
main:
	mov value, %rsi
	mov $fmt, %rdi
	mov $0, %rax
	call printf

	mov $0,%rdi
	call exit
