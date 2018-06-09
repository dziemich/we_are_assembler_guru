#----------------------------------------------------------
# Funkcja do programu lab_9c
#
# Compute Pi (Leibniz formula) using SSE instructions
#----------------------------------------------------------

	.data
	.align 16

denom:	
	.double	1.0, 3.0	# first & second denominators
numer:	
	.double	4.0, -4.0	# first & second numerators
add4:	
	.double	4.0, 4.0	# difference between denominators
zero:	
	.double	0.0, 0.0	# sums starting values
#----------------------------------------------------------

denom_f:	
	.float	1.0, 3.0, 5.0, 7.0	# first, second, third and fourth denominators
numer_f:	
	.float	4.0, -4.0, 4.0, -4.0	# first, second, third and fourth numerators
add8_f:	
	.float	8.0, 8.0, 8.0, 8.0	# difference between denominators
zero_f:	
	.float	0.0, 0.0, 0.0, 0.0	# sums starting values
#----------------------------------------------------------

	.text
	.type fun_a, @function
	.global fun_a

fun_a:
	shr $1, %rdi		# two terms are computed in parallel
	inc %rdi		# half of iterations is enough
	
	movdqa	denom, %xmm5	# denominators to xmm5
	movdqa	numer, %xmm2	# numerators to xmm2
	movdqa	add4, %xmm3	# differences to xmm3
	movdqa	%xmm2, %xmm4	# numerators to xmm4
	movdqa	zero, %xmm1	# zeros to xmm1

next:
	divpd	%xmm5, %xmm2	# xmm2 /= xmm5
	addpd	%xmm2, %xmm1	# xmm1 += xmm2
	movdqa	%xmm4, %xmm2	# xmm2 = xmm4
	addpd	%xmm3, %xmm5	# xmm5 += xmm3

	dec %rdi
	jnz next

	haddpd	%xmm1, %xmm1	# horizontal sums of low & high parts
	movsd	%xmm1, %xmm0	# low part to xmm0

	ret			# that's all

	.type fun_b, @function
	.global fun_b
#----------------------------------------------------------

fun_b:
	shr $2, %rdi		# four terms are computed in parallel
	inc %rdi		# quarter of iterations is enough

	movaps	denom_f, %xmm5	# denominators to xmm5
	movaps	numer_f, %xmm2	# numerators to xmm2
	movaps	add8_f, %xmm3	# differences to xmm3
	movaps	%xmm2, %xmm4	# numerators to xmm4
	movaps	zero_f, %xmm1	# zeros to xmm1

next_a:
	divps	%xmm5, %xmm2	# xmm2 /= xmm5
	addps	%xmm2, %xmm1	# xmm1 += xmm2
	movaps  %xmm4, %xmm2	# xmm2 = xmm4
	addps	%xmm3, %xmm5	# xmm5 += xmm3

	dec %rdi
	jnz next_a

	haddps	%xmm1, %xmm1	# horizontal sums of low & high parts
	haddps	%xmm1, %xmm1	# horizontal sums of low & high parts
	movdqa  zero, %xmm0	# clear xmm0 as two doubles
	cvtss2sd %xmm1, %xmm0	# low part to xmm0

	ret			# that's all


