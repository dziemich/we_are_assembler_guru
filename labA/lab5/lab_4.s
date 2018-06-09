                                                                                                                                                                                                                                                                                                                    #----------------------------------------------------------------
# Program LAB_4.S - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_4.o lab_4.s
#  To link:    ld -o lab_4 lab_4.o
#  To run:     ./lab_4
#
#----------------------------------------------------------------                                                                                     

	.equ	write_64,	1
	.equ	exit_64,	60
	.equ	stdout,		1

	.equ	dig0,		'0'

#----------------------------------------------------------------

	.data

table:					# table of items
	.long	10,70,50,90,60,80,40,20,0,30,222
count:					# count of items
       .quad	( . - table ) >> 2   # przesunięcie bitowe o 2 (dzielenie przez 4 bo long ma 4 bajty)
events:	
	.quad	0                                                                     
item:	
	.string	"Item "                                                                                                                        
line_no:	
	.string	"   "
itemval:	
	.string	" = "
number:	
	.string	"     \n"
before:	
	.string	"\nBefore:\n"
after:	
	.string	"\nAfter:\n"
dataend:

	.equ	item_len, before - item
	.equ	bef_len, after - before
	.equ	aft_len, dataend - after

#----------------------------------------------------------------

	.text
	.global _start

_start:
	MOV	$write_64,%rax	# display message
	MOV	$stdout,%rdi
	MOV	$before,%rsi
	MOV	$bef_len,%rdx
	SYSCALL

	CALL	disp_table	# display content of table

	CALL	do_something	# do something with table

	MOV	$write_64,%rax	# display message
	MOV	$stdout,%rdi
	MOV	$after,%rsi
	MOV	$aft_len,%rdx
	SYSCALL

	CALL	disp_table	# display content of table

	MOV	events,%rdi	# exit program
	MOV	$exit_64,%rax
	SYSCALL

#----------------------------------------------------------------
#
#	Function:	do_something
#	Parameters:	none
#

	.type do_something,@function   #sortowanie babelkowe

do_something:
	MOV	count,%rdx		# outer loop counter
	MOVQ	$0,events		# events okresla entropie danych
outer:		
	DEC	%rdx
	XOR	%rsi,%rsi		# data index
	MOV	%rdx,%rcx		# inner loop counter
inner:		
	MOV	table(,%rsi,4),%eax
	CMP	table+4(,%rsi,4),%eax
	JAE	noswap
	XCHG	table+4(,%rsi,4),%eax
	MOV	%eax,table(,%rsi,4)
	INCQ	events
noswap:		
	INC	%rsi			# next element
	LOOP	inner			# { rcx--; if( rcx ) goto inner }
	CMP	$1,%rdx
	JNZ	outer

	RET

#----------------------------------------------------------------
#
#	Function:	disp_table
#	Parameters:	none
#

	.type disp_table,@function

disp_table:
	XOR	%rsi,%rsi		# data index - licznik indexu tablicy dlatego zerujemy (0-9)
	MOV	count,%rcx		# data count - tyle mamy elementow  rcx jest licznikiem petli

disp_item:
	MOV	table(,%rsi,4),%ebx	# get data  wartosc z tablicy mamy w %ebx 
	
	CALL	make_string		# convert to string

	MOV	$write_64,%rax		# call write function 
	MOV	$stdout,%rdi

	PUSH 	%rsi 		#najpozniej tu musimy zapisac rsi bo potem zapisujemy tam item
	MOV	$item,%rsi         #lancuch znakow mamy tu
	MOV	$item_len,%rdx
	PUSH	%rcx
	SYSCALL

	POP %rcx
	POP %rsi

	INC	%rsi			# next element
	LOOP	disp_item		# { rcx--; if( rcx ) goto disp_item }

	RET				# return to main program

#----------------------------------------------------------------
#
#	Function:	make_string
#	Parameters:	%esi - index of element
#			%ebx - value of element
#

	.type make_string,@function

make_string:    #przenosi parametry do rejestrow
	MOVL	$0x20202020,number	# czyscimy 4 bierwsze bajty
	MOVW	$0x2020,line_no		#2 pierwsze
	MOV	%esi,%eax		# convert index of table element to string
	MOV	$line_no + 2,%rdi  #line_no - zmeinna przeniesiona o 2 pozycje (czyli mozemy zapisac 3 cyfrowe liczby)
	CALL	n2str

	MOV	%ebx,%eax		# convert value of table element to string
	MOV	$number + 4,%rdi # 5 cyfrowe liczby
	CALL	n2str

	RET				# return to disp_table function

#----------------------------------------------------------------
#
#	Function:	n2str   zamiana na postać znakową
#	Parameters:	%eax - value
#			%rdi - address of last character
#

	.type n2str,@function
n2str:
	PUSH	%rbx		# save register on stack    ostatnie miejsce w buforze (adres) cos powiedzial ze eax
	PUSH	%rdx		# save register on stack
	MOV	$10,%ebx	# divisor in EBX, dividend in EAX
nextdig:			
	XOR	%edx,%edx	# EDX = 0 musimy wyzerowac bardziej znaczaca czesc! bo dzielenie by nie dzialalo (bo tam jest reszta z dzielenia)
	DIV	%ebx		# EDX(32bardziej znaczace bity):EAX(32 mniej znaczace bity) <- dzielna div EBX <- wynik
	ADD	$dig0,%dl	# convert remainder (in EDX) to character
	MOV	%dl,(%rdi)	# *(RDI) = character (decimal digit)
	CMP	$0,%eax		# quotient in EAX sprawdzamy wynik dzielenia
	JZ	empty
	DEC	%rdi		# RDI--
	JMP	nextdig		
empty:		
	POP	%rdx		# restore register from stack
	POP	%rbx		# restore register from stack

	RET			# return to make_string function

#----------------------------------------------------------------
