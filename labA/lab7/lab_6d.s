#----------------------------------------------------------------
# Program lab_6d.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile&link: gcc -o lab_6d lab_6d.s
#  To run: 	    ./lab_6d
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
	mov value(%rip), %rsi
	lea fmt(%rip), %rdi
	mov $0, %rax
	call *printf@GOTPCREL(%rip)

	mov $0,%rdi
	call *exit@GOTPCREL(%rip)
