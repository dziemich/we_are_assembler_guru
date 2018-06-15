.type binary_op, @function

.globl binary_op

.text
jtable:
  .quad o0, o1, o2, o3
# char* ret     %rdi
# char* arg1    %rsi
# char* arg2    %rdx
# int op        %ecx
# return char*  %rax

binary_op:
  push %r12
  enter $20,$0
  movq %rdi, -8(%rbp)  # -8(%rbp)  ret
  movq %rdx, -16(%rbp) # -24(%rbp) arg2
  movl %ecx, -20(%rbp) # -28(%rbp) op
  movq %rsi, %rdi # char*  str
  movq $0, %rsi   # char** endptr
  movl $2, %edx   # int    base
  call strtol
  movq %rax, %r12
  movq -16(%rbp), %rdi # char*  str
  movq $0, %rsi        # char** endptr
  movl $2, %edx        # int    base
  call strtol
  movl -20(%rbp), %ecx
  jmp *jtable(,%ecx,8)
  o0:
  addq %r12, %rax
  jmp end
  o1:
  andq %r12, %rax
  jmp end
  o2:
  orq %r12, %rax
  jmp end
  o3:
  xorq %r12, %rax
end:
  MOVQ -8(%rbp), %r8
  MOVQ $-1, %r9
  CMPQ $0, %rax
  JNE loop1
  MOVQ $'0', (%r8)
  JMP ex2
  loop1:
    INCQ %r9
    SHL %rax
    JNC loop1
  MOVQ $'1', (%r8)
  loop2:
    CMP $63, %r9
    JE ex2
    INCQ %r9
    INCQ %r8
    SHL %rax
    JC one
    MOVQ $'0', (%r8)
    JMP loop2
    one:
    MOVQ $'1', (%r8)
    JMP loop2
  ex2:
  MOVQ $0, 1(%r8)
  MOVQ -8(%rbp), %rax
  leave
  pop %r12
  ret
