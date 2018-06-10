    .type check_div @function
    .global check_div

check_div:
    cmp $0, %rdx
    je a_divisible_by_b
    mov $2, %rax
    ret


a_divisible_by_b:
    mov %rdi, %rax
    idiv %rsi
    cmp $0, %rdx
    je return_zero
    mov $0, %rax
    ret

return_zero:
    mov $1, %rax
    ret
