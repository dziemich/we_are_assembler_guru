.data

# string:
# 	.ascii ""
tab:
	.long 0,0,0,0

.type max_diff, @function

.globl max_diff

.text

# long a		  %rdi
# long b			%rsi
# long c			%rdx
# long d		%rcx
# return 		  %rax

max_diff:
  MOVQ %rdi, tab  # tab(,0,8)
  MOVQ %rsi, tab+8 # tab(,1,8)
  MOVQ %rdx, tab+16
  MOVQ %rcx, tab+24
  MOVQ $0, %rax
  MOVQ $-1, %rsi
loop1:
  INCQ %rsi
  CMPQ $4, %rsi
  JE end
  MOVQ tab(,%rsi,8), %rbx
loop2_init:
  MOVQ $0, %rdx
loop2:
  CMPQ $4, %rdx
  JE loop1
  MOVQ tab(,%rdx,8), %rcx
  SUBQ %rbx, %rcx
  CMPQ $0, %rcx
  JG positiv
  imulq $-1, %rcx
positiv:
  INCQ %rdx
  CMPQ %rax, %rcx
  JL loop2
  MOVQ %rcx, %rax
  JMP loop2
end:
  ret
