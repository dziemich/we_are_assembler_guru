#----------------------------------------------------------------
# Program lab_9b.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#   to compile & link:  gcc -no-pie -lm -o lab_9b lab_9b.s
#   to run:		./lab_9b
#
#----------------------------------------------------------------

	.data
two:				# constant/variable
	.long		2
a:				# coefficients of equation
	.double		1.0
b:
	.double		-1.0
c:
	.double		-2.0
delta:				# delta
	.double		0.0
x1:				# roots of eqation
	.double		0.0
x2:
	.double		0.0

coeff_fmt_str:
	.asciz	"Coefficients of equation:\nA = %lf  B = %lf  C = %lf\n"
delta_fmt_str:
	.asciz	"Delta = %lf\n"
noroots_fmt_str:
	.asciz	"No real roots\n"
oneroot_fmt_str:
	.asciz	"One double root\n"
tworoots_fmt_str:
	.asciz	"Two roots\n"
roots_fmt_str:
	.asciz	"Roots of equation:\nX1 = %lf  X2 = %lf\n"

	
	.text
	.global main
	
main:
	sub $8, %rsp		# align the stack

	FINIT			# FPU initialization
				#------------------------------
	movsd	c, %xmm2	# c -> ST(0)
	movsd	b, %xmm1	# b -> ST(0)
	movsd	a, %xmm0	# a -> ST(0)
	mov	$coeff_fmt_str, %rdi	# address of coeff_fmt_str
	mov	$3, %al
	CALL	printf
				#------------------------------
	FLDL	b		# b -> ST(0)
	FMULL	b		# b^2
	FLDL	a		# a -> ST(0), b^2 -> ST(1)
	FMULL 	c		# ac
	FADD	%ST(0)		# 2ac
	FADD	%ST(0)		# 4ac
	FCHS			# -4ac
	FADDP			# b^2-4ac -> ST(0)
	FSTPL	delta		# store result in variable

				#------------------------------
	movsd	delta, %xmm0
	mov	$delta_fmt_str, %rdi	# address of delta_fmt_str
	mov	$1, %al
	CALL	printf
				#------------------------------
	FLDZ			# 0 -> ST(0)	
	FLDL	delta		# delta -> ST(0), 0 in ST(1)
	FCOMI	%ST(1)		# delta ? 0
	FFREE	%ST(1)		# free ST(1)
	FFREE	%ST(0)		# free ST(0)
	JZ	zero
	JNC	greater_0

less_0:				#------------------------------
	mov	$noroots_fmt_str, %rdi	# address of noroots_fmt_str
	mov	$0, %al
	CALL	printf
	JMP the_end

zero:				#------------------------------
	mov	$oneroot_fmt_str, %rdi	# address of oneroot_fmt_str
	mov	$0, %al
	CALL	printf
	JMP compute_roots

greater_0:			#------------------------------
	mov	$tworoots_fmt_str, %rdi	# address of tworoots_fmt_str
	mov	$0, %al
	CALL	printf

compute_roots:			#------------------------------
	FLDL	delta		# delta -> ST(0)
	FSQRT			# sqrt( delta ) -> ST(0)
	FCHS			# -sqrt( delta )
	FSUBL	b		# -b - sqrt( delta ) -> ST(0)
	FDIVL	a		# ( -b - sqrt( delta ) ) / a -> ST(0)
	FIDIVL	two		# ( -b - sqrt( delta ) ) / 2a -> ST(0)
	FSTPL	x1		# store first root in variable
				#------------------------------
	FLDL	delta		# delta -> ST(0)
	FSQRT			# sqrt( delta ) -> ST(0)
	FSUBL	b		# -b + sqrt( delta ) -> ST(0)
	FDIVL	a		# ( -b + sqrt( delta ) ) / a -> ST(0)
	FIDIVL	two		# ( -b + sqrt( delta ) ) / 2a -> ST(0)
	FSTPL	x2		# store second root in variable

				#------------------------------
	movsd	x2, %xmm1	# x2 -> ST(0)
	movsd	x1, %xmm0	# x1 -> ST(0)
	mov	$roots_fmt_str, %rdi	# address of roots_fmt_str
	mov	$2, %al
	CALL	printf

the_end:			#------------------------------
	mov	$0, %rdi	# the end
	CALL	exit

