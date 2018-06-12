.type genstring, @function

.globl genstring

.text

# char* s       %rdi
# char c        %esi
# int n         %edx
# int inc       %ecx
# return cahr*  %rax

genstring:
    mov %rdi, %r9
    mov $0, %r8d
    cmp $0, %ecx
    je not_inc
    jmp incr

not_inc:
    cmp %edx, %r8d
    je end
    mov %esi, (%rdi)
    inc %r8d
    inc %rdi
    jmp not_inc

incr:
    cmp %edx, %r8d
    je end
    inc %esi
    mov %esi, (%rdi)
    inc %r8d
    inc %rdi
    jmp incr

end:
    mov %r9, %rax
    ret



