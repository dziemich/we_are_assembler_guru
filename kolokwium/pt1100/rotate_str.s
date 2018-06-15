.type rotate_str, @function
.global rotate_str

.text

# char* str     %rdi
# int shift     %esi
# int op        %edx
# return cha*   %rax
rotate_str:
  MOVQ $0, %r8
  loop1:
    CMP $0, (%rdi,%r8,1)
    JE ex1
    INCQ %r8
    JMP loop1
  ex1:
  DECQ %r8
  CMPL $0, %esi
  JL loop4
  loop2:
    CMPL $0, %esi
    JE end
    MOVB (%rdi,%r8,1), %r10b
    MOVQ %r8, %rcx
    loop3:
      CMPQ $0, %rcx
      JE ex3
      MOVB -1(%rdi,%rcx,1), %al
      MOVB %al, (%rdi,%rcx,1)
      DECQ %rcx
      JMP loop3
    ex3:
    call char_test
    MOVB %r10b, (%rdi)
    DECL %esi
    JMP loop2
  loop4:
    CMPL $0, %esi
    JE end
    MOVB (%rdi), %r10b
    MOVQ $0, %rcx
    loop5:
      CMPQ %r8, %rcx
      JE ex5
      MOVB 1(%rdi,%rcx,1), %al
      MOVB %al, (%rdi,%rcx,1)
      INCQ %rcx
      JMP loop5
    ex5:
    call char_test
    MOVB %r10b, (%rdi,%r8,1)
    INCL %esi
    JMP loop4
end:
  MOVQ %rdi, %rax
  ret

.type char_test, @function
jtable:
  .quad cend , StoB, BtoS, BtoB

char_test:
  JMP *jtable(,%edx,8)

  StoB:
  CMPB $'a', %r10b
  JL cend
  CMPB $'z', %r10b
  JG cend
  SUBB $'a'-'A', %r10b
  JMP cend

  BtoS:
  CMPB $'A', %r10b
  JL cend
  CMPB $'Z', %r10b
  JG cend
  ADDB $'a'-'A', %r10b
  JMP cend

  BtoB:
  CMPB $'A', %r10b
  JL cend
  CMPB $'Z', %r10b
  JG StoB
  ADDB $'a'-'A', %r10b
  JMP cend

cend:
  ret
