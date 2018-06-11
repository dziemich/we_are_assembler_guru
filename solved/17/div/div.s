.type check_div, @function

.globl check_div
.text

# long a         %rdi
# long b         %rsi
# long c         %rdx
# return ulong   %rax
check_div:
  CMPQ $0, %rdx
  JNE other
  MOVQ %rdi, %rax
  IDIVQ %rsi
  CMPQ $0, %rdx
  JNE nie_pod
  MOVQ $1, %rax
  ret
nie_pod:
  MOVQ $0, %rax
  ret

other:
  MOVQ $0, %rcx
  MOVQ $64, %r9
loop:
  CMPQ $0, %r9
  JE end
  SHLQ $1, %rcx
  MOVQ $0, %rdx
  MOVQ %rdi, %rax
  IDIVQ %r9
  DECQ %r9
  CMPQ $0, %rdx
  JNE loop
  or $1, %rcx
  JMP loop
end:
  MOVQ %rcx, %rax
  ret
