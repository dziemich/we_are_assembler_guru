#----------------------------------------------------------------
# Program lab_3b.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_3b.o lab_3b.s
#  To link:    ld -o lab_3b lab_3b.o
#  To run:     ./lab_3b
#
#----------------------------------------------------------------

	.equ	open_64,	0x02	# open file function
	.equ	close_64,	0x03	# close file function
	.equ	read_64,	0x00	# read data from file function
	.equ	write_64,	0x01	# write data to file function
	.equ	exit_64,	0x3c	# exit program function
	.equ	stdout, 1 	#handle to stdout
	.equ	stderr, 2 

	.equ	mode,	0x180	# attributes for file creating
	.equ	flags,	0	# attributes for file opening !! w jakim trybie otwieramy plik

	.equ	tooval,	1
	.equ	errval,	2

	.data
	
file_n:				# file name (0 terminated)
	.string	"testfile.txt"

file_h:				# file handle
	.quad		0

buffer:				# buffer for file data
	.space		128, 0

bufsize:			# size of buffer
	.quad		( . - buffer )

b_read:				# size of read data
	.quad		0

errmsg:				# file error message
	.ascii	"File error!\n"

errlen:
	.quad		( . - errmsg )

toomsg:				# file too big error message
	.ascii	"File too big!\n"

toolen:
	.quad		( . - toomsg )

cntmsg:				# another message
	.ascii	"File contains following characters:\n"

cntlen:
	.quad		( . - cntmsg )

allokmsg:			# All OK message
	.ascii	"\nAll is OK - too hard to believe!\n"

alloklen:
	.quad		( . - allokmsg )

	.text
	.global _start
	
_start:
	MOV	$open_64,%rax	# open function
	MOV	$file_n,%rdi	# RDI points to file name
	MOV	$flags,%rsi	# flags of opened file in RSI
	MOV	$mode,%rdx	# mode of opened file in RDX
	SYSCALL

	CMP	$0,%rax
	# JL	error		# if RAX<0 then something went wrong



theend:
	MOV	$exit_64,%rax	# exit program function
	SYSCALL

