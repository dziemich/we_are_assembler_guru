.type check_div, @function

.globl check_div
.text

# long a		  %rdi
# long b			%rsi
# long c			%rdx
# return 		  %rax
check_div:
  CMPQ $0, %rdx
  JNE other
  MOVQ %rdi, %rax
  idivq %rsi
  CMPQ $0, %rdx
  JNE nie_pod
  MOVQ $1, %rax
  ret
nie_pod:
  MOVQ $0, %rax
  ret

other:
  MOVQ $0, %rcx
  MOVQ $64, %rbx
loop:
  CMPQ $0, %rbx
  JE end
  shlq $1, %rcx
  MOVQ $0, %rdx
  MOVQ %rdi, %rax
  idivq %rbx
  DECQ %rbx
  CMPQ $0, %rdx
  JNE loop
  or $1, %rcx
  JMP loop
end:
  MOVQ %rcx, %rax
  ret
