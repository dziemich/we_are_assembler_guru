.data

.type encode, @function

.globl encode


.text

# char* buf     %rdi
# uint mask     %esi
# int op        %edx
# int c         %ecx
# return char*  %rax
encode:
  MOVL %ecx, %r11d
  CMPL $0, %edx
  JLE end
  CMPL $3, %edx
  JG end
  MOVQ $-1, %r8
loop:
  INCQ %r8
  CMPB $0, (%rdi,%r8,1)
  JE end
  CMPB $48, (%rdi,%r8,1)
  JL loop
  CMPB $57, (%rdi,%r8,1)
  JG loop
  MOVL %esi, %eax
  MOVB (%rdi,%r8,1), %cl
  SUBB $48, %cl
  SHRL %cl, %eax
  ANDL $1, %eax
  CMPL $0, %eax
  JE loop
  CMPL $1, %edx
  JE op1
  CMPL $2, %edx
  JE op2
  JMP op3
op1:
  MOVQ %r8, %r9
loop2:
  CMPB $0, (%rdi,%r9,1)
  JE loop
  INCQ %r9
  MOVB (%rdi,%r9,1), %r10b
  DECQ %r9
  MOVB %r10b, (%rdi,%r9,1)
  INCQ %r9
  JMP loop2

op2:
  MOVB $48+9, %r10b
  SUBB %cl, %r10b
  MOVB %r10b, (%rdi,%r8,1)
  JMP loop
op3:
  MOVB %r11b, (%rdi,%r8,1)
  JMP loop
end:
  MOVQ %rdi, %rax
  ret
