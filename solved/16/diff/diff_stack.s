
.type max_diff, @function

.globl max_diff

.text

# long a        %rdi
# long b        %rsi
# long c        %rdx
# long d        %rcx
# return long   %rax

max_diff:
  push %rbp
  MOVQ %rsp, %rbp
  SUBQ $4*8, %rsp
  MOVQ %rdi, -0(%rbp)
  MOVQ %rsi, -8(%rbp)
  MOVQ %rdx, -16(%rbp)
  MOVQ %rcx, -24(%rbp)
  MOVQ $0, %rax
  MOVQ $1, %rsi
loop1:
  DECQ %rsi
  CMPQ $-4, %rsi
  JE end
  MOVQ (%rbp,%rsi,8), %r9
loop2_init:
  MOVQ $0, %rdx
loop2:
  CMPQ %rsi, %rdx
  JE loop1
  MOVQ (%rbp,%rdx,8), %rcx
  SUBQ %r9, %rcx
  CMPQ $0, %rcx
  JG positiv
  NEGQ %rcx
positiv:
  DECQ %rdx
  CMPQ %rax, %rcx
  JL loop2
  MOVQ %rcx, %rax
  JMP loop2
end:
  MOVQ %rbp, %rsp
  POP %rbp
  ret
