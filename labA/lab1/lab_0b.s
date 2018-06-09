#----------------------------------------------------------------
# Program lab_0b.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0b.o lab_0b.s
#  To link:    ld -o lab_0b lab_0b.o
#  To run:     ./lab_0b
#
#----------------------------------------------------------------

	.data
	
dummy:				# some data
	.byte	0x00

	.text
	.global _start		# entry point
	
_start:
	MOV	$1, %eax	# exit function
	INT	$0x80		# system interrupt
