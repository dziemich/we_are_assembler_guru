#----------------------------------------------------------------
# Program lab_9a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#   to compile & link:  gcc -no-pie -lm -o lab_9a lab_9a.s
#   to run: 		./lab_9a
#
#----------------------------------------------------------------

	.data
i:				# loop counter
	.long		1
x:				# function argument
	.double		0.0
y:
	.double		0.0
sqr_a:				# function result (x87)
	.double		0.0
sqr_b:				# function result (SSE)
	.double		0.0
sqr_c:				# function result (x87 software approximation)
	.double		0.0

two:				# constant but variable
	.long		2
fmt_str:
	.asciz	"Square root of %lf = %.20lf\n"

	
	.text
	.global main
	
main:
	FINIT			# FPU initialization
next:
	FILDL	i		# i -> ST(0)
	FSTPL	x		# ST(0) -> x & pop from stack
				#------------------------------
	FLDL	x		# function argument -> ST(0)
	FSQRT			# sqrt( ST(0) ) -> ST(0)
	FSTPL	sqr_a		# ST(0) -> sqr_a  & pop from stack
				#------------------------------
	FLDL	sqr_a		# load & display first result
	FSTPL	y
	CALL	disp

	MOVSD	x, %xmm1	# function argument -> xmm1
	SQRTSD	%xmm1, %xmm0	# sqrt( xmm1 ) -> xmm0
	MOVSD	%xmm0, sqr_b	# xmm0 -> sqr_b

	MOVSD	%xmm0, y	# load & display second result
	CALL	disp
				#------------------------------
	FLDL	x		# first approximation (a0) -> ST(0)

iter:	FLDL	x		# function argument -> ST(0), ak in ST(1)
	FDIV	%ST(1), %ST(0)	# ST(0)/ST(1) -> ST(0)    x/ak
	FADD	%ST(1), %ST(0)	# ST(0)+ST(1) -> ST(0)    ak+x/ak
	FIDIVL	two		# ST(0)/two -> ST(0)      (ak+x/ak)/2  musimy zrobic zmienna "two" bo nie mozna uzywac stalych
	FCOMI	%ST(1)		# ST(1) ? ST(0)           ak ? ak+1
	FSTP	%ST(1)		# ST(0) -> ST(1) & pop from stack
	JNZ	iter		# test of convergence

	FSTPL	sqr_c		# ST(0) -> sqr_b & pop from stack
				#------------------------------
	FLDL	sqr_c		# load & display second result
	FSTPL	y
	CALL	disp
				#------------------------------

	INCL	i		# next argument
	CMPL	$100, i		# enough ?
	JBE	next
				#------------------------------
	mov 	$0, %rdi	# the end
	CALL	exit
	

	.type	disp, @function	# printf( fmt_str, x, y )
disp:
	movq	x, %xmm0    	#inne rejestry wymaga printf dla zmiennoprzecinkowych
	movq	y, %xmm1
	mov	$fmt_str, %rdi	# address of fmt_str rdi bo całkowita
	mov 	$2, %al   	#ilosc zmiennoprzecinkowych, musimy to printfowi 
	CALL	printf
	RET

