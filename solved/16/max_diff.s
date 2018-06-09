
    .type maxdiff @function
    .global maxdiff

    # rejestry argumentow funkcji z C kolejno: rdi, rsi, rdx, rcx, r8, r9

    # rejestr rbx przechowuje najmniejsza wartosc
    # rejestr rbp przechowuje najwieksza wartosc

maxdiff:

  # szukam najmniejszej
    cmp %rdi, %rsi
    jge l_comp_rdi_rdx # jge arg1 <= arg2
    cmp %rsi, %rdx
    jge l_comp_rsi_rcx
    cmp %rcx, %rdx
    jge mov_rcx_to_lowest
    mov %rdx, %rbx
    jmp largest

    # szukam najwiekszej
largest:    
    cmp %rdi, %rsi
    jle h_comp_rdi_rdx # jle arg1 >= arg2
    cmp %rsi, %rdx
    jle h_comp_rsi_rcx
    cmp %rcx, %rdx
    jle mov_rcx_to_highest
    mov %rdx, %rbp    
    jmp final

l_comp_rdi_rdx:
    cmp %rdi, %rdx
    jge l_comp_rdi_rcx
    cmp %rdx, %rcx
    # rdx najwieksze
    jle mov_rcx_to_lowest
    mov %rdx, %rbx
    jmp largest

l_comp_rdi_rcx:
    cmp %rdi, %rcx
    jle mov_rcx_to_lowest
    mov %rdi, %rbx
    jmp largest

l_comp_rsi_rcx:
    cmp %rsi, %rcx
    jle mov_rcx_to_lowest
    mov %rsi, %rbx
    jmp largest

mov_rcx_to_lowest:
    mov %rcx, %rbx
    jmp largest

h_comp_rdi_rdx:
    cmp %rdi, %rdx
    jle h_comp_rdi_rcx
    cmp %rdx, %rcx
    jge mov_rcx_to_highest
    mov %rdx, %rbp
    jmp final

h_comp_rdi_rcx:
    cmp %rdi, %rcx
    jge mov_rcx_to_highest
    mov %rdi, %rbp
    jmp final

h_comp_rsi_rcx:
    cmp %rsi, %rcx
    jge mov_rcx_to_highest
    mov %rsi, %rbp
    jmp final

mov_rcx_to_highest:
    mov %rcx, %rbp
    jmp final


final:
    sub %rbx, %rbp
    mov %rbp, %rax
    ret