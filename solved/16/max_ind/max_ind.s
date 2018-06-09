
    .type max_ind @function
    .global max_ind

    # rejestry argumentow funkcji z C kolejno: rdi, rsi, rdx, rcx, r8, r9


max_ind:
    cmp %rdi, %rsi
    jle h_comp_rdi_rdx # jle arg1 >= arg2
    cmp %rsi, %rdx
    jle h_comp_rsi_rcx
    cmp %rcx, %rdx
    jle mov_rcx_to_highest
    mov $3, %rax    
    ret

h_comp_rdi_rdx:
    cmp %rdi, %rdx
    jle h_comp_rdi_rcx
    cmp %rdx, %rcx
    jge mov_rcx_to_highest
    mov $3, %rax
    ret

h_comp_rdi_rcx:
    cmp %rdi, %rcx
    jge mov_rcx_to_highest
    mov $1, %rax
    ret

h_comp_rsi_rcx:
    cmp %rsi, %rcx
    jge mov_rcx_to_highest
    mov $2, %rax
    ret

mov_rcx_to_highest:
    mov $4, %rax
    ret
