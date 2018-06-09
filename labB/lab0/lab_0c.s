#----------------------------------------------------------------
# Program lab_0c.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0c.o lab_0c.s
#  To link:    ld -o lab_0c lab_0c.o
#  To run:     ./lab_0c
#
#----------------------------------------------------------------

	.equ	kernel,0x80	#Linux system functions entry
	.equ	write,0x04	#write data to file function
	.equ	exit,0x01	#exit program function

	.data
	
starttxt:			#first message
	.ascii	"Start\n"
endtxt:				#last message
	.ascii	"Finish\n"
gurutxt:
	.ascii	"Aj em assembler guru\n"	#other message

	.text
	.global _start
	
_start:
	MOVL	$write,%eax	#write first message
	MOVL	$1,%ebx
	MOVL	$starttxt,%ecx
	MOVL	$6,%edx
	INT	$kernel

	NOP

	MOVL	$write,%eax	#write other message
	MOVL	$1,%ebx
	MOVL	$gurutxt,%ecx
	MOVL	$21,%edx
	INT	$kernel

	NOP

	MOVL	$write,%eax	#write last message
	MOVL	$1,%ebx
	MOVL	$endtxt,%ecx
	MOVL	$7,%edx
	INT	$kernel

	NOP

theend:
	MOVL	$exit,%eax	#exit program
	INT	$kernel
