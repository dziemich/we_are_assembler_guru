#----------------------------------------------------------------
# Program lab_0a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0a.o lab_0a.s
#  To link:    ld -o lab_0a lab_0a.o
#  To run:     ./lab_0a
#
#----------------------------------------------------------------

	.data
	
dummy:				# some data
	.byte	0x00

	.text
	.global _start		# entry point
	
_start:
	JMP	_start
