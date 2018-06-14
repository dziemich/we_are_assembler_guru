.data

.type spaces, @function
.globl spaces

.text

spaces:
    MOVL $-1, %r8d

loop:
    INCL %r8d
    CMPB $0, (%rdi,%r8,1)
    JE   end
# if
    CMPB $32, (%rdi,%r8,1)
    JNE  loop
    MOVL %r8d, %r9d
    INCL %r9d
    CMPB $32, (%rdi,%r9,1)
    JNE  loop
# endif
    MOVL %r9d, %r10d
    DECL %r10d

loop2:
    INCL %r10d
    CMPB $0, (%rdi,%r10,1)
    JE   dec_and_loop
# substitute
    INCL %r10d
    MOVB (%rdi,%r10,1), %r11b
    DECL %r10d
    MOVB %r11b, (%rdi,%r10,1)
# endsubstitute
    JMP loop2

dec_and_loop:
    DECL %r8d
    JMP  loop

end:
    MOVQ %rdi, %rax
    ret
