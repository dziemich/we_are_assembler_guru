
.type sum_ascii, @function

.globl sum_ascii

.text
jtable:
  .quad count, o1, o2, o3, o4

# char* str     %rdi
# int a         %esi
# int b         %edx
# int op        %ecx
# int* count    %r8
# return long   %rax

sum_ascii:
  MOVQ $0, %rax
  MOVL $0, (%r8)
  MOVQ $0, %r9
  CMPL $0, %ecx
  JL end
  CMPL $4, %ecx
  JG end
  MOVQ $0, %r10
  test:
    CMPL %r10d, %esi
    JE loop
    CMPQ $0, (%rdi,%r10,1)
    JE end
    INCL %r10d
    JMP test
loop:
  CMPL %esi, %edx
  JLE end
  MOVB (%rdi,%rsi,1), %r9b
  CMPB $0, %r9b
  JE end
  JMP *jtable(,%ecx,8)
  o1:
    CMPB $'0', %r9b
    JL ex
    CMPB $'9', %r9b
    JG ex
    JMP count
  o2:
    CMPB $'A', %r9b
    JL ex
    CMPB $'Z', %r9b
    JG ex
    JMP count
  o4:
    CMPB $'A', %r9b
    JL ex
    CMPB $'Z', %r9b
    JG o3
    JMP count
  o3:
    CMPB $'a', %r9b
    JL ex
    CMPB $'z', %r9b
    JG ex
    INCL (%r8)
  count:
  ADDQ %r9, %rax
  ex:
  INCL %esi
  JMP loop
end:
  ret
