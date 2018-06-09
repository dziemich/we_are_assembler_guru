
    .type maxdiff @function
    .global maxdiff

    # rejestry argumentow funkcji z C kolejno: rdi, rsi, rdx, rcx, r8, r9

maxdiff:
    cmp %rdi, %rsi
    jle comp_rdi_rdx
    cmp %rdx, %rsi
    jle comp_rdi_rcx
    cmp %rcx, %rsi
    # rcx najwieksze
    jle movrcx
    # rsi najwieksze
    mov %rsi,%rbx

    jmp final

movrcx:
    mov %rcx, %rbx
    jmp final

comp_rdi_rdx:
    cmp %rdi, %rdx
    jle comp_rdi_rcx
    cmp %rdx, %rcx
    # rdx najwieksze
    jge movrcx
    mov %rdx, %rbx
    jmp final

comp_rdi_rcx:
    cmp %rdi, %rcx
    jge movrcx
    mov %rdi, %rbx
    jmp final

final:
    mov $10, %rbp
    sub %rbp, %rbx
    mov %rbx, %rax
    ret