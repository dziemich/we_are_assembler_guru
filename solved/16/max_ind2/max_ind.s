.data

.type max_ind, @function
.globl max_ind

.text

# long long * tab           %rdi
# long long n               %rsi
# long long * evencount     %rdx
# long long * negcount      %rcx

max_ind:
    MOVQ    $0, %r8    # long long j = 0;
    MOVQ    $0, %r9    # long long bin_am = 0;
    MOVQ    $0, (%rdx) # (*evencount) = 0;
    MOVQ    $0, (%rcx) # (*negcount) = 0;
    MOVQ    $-1, %r10  # long long i
    PUSHQ   %r12
    PUSHQ   %r13
    PUSHQ   %r14
    MOVQ    %rdx, %r11 # save evencount state in r11

loop:
    INCQ    %r10
    CMPQ    %r10, %rsi # i < n
    JLE     end
# if (tab[i] % 2 == 0)
    MOVQ    $0, %rdx
    MOVQ    (%rdi,%r10,8), %rax
# start division to get a remainter
    PUSHQ   %rsi
    MOVQ    $2, %rsi
    DIVQ    %rsi
    POPQ    %rsi
# end division
    CMPQ    $0, %rdx
    JNE     next1
    INCQ    (%r11)
# endif

# if (tab[i] < 0)
next1:
    CMPQ    $0, (%rdi,%r10,8)
    JGE     next2
    INCQ    (%rcx)
# endif

next2:
    MOVQ    $0, %r12  # long long sum
# for (long long k = 0; k < 64; ++k)
    MOVQ    $-1, %r13  # long long k

loop2:
    INCQ    %r13        # k++
    CMPQ    $64, %r13   # k < 64
    JGE     next4
    MOVQ    (%rdi,%r10,8), %r14
    ANDQ    $1, %r14    # tab[i] & 1
    CMPQ    $0, %r14    # if (tab[i] & 1)
    JE      next3
    INCQ    %r12

next3:
    SHRQ    (%rdi,%r10,8)   # tab[i] = tab[i] >> 1
    JMP     loop2
#endfor

next4:
    CMPQ    %r12, %r9       # if (sum > bin_am)
    JGE     loop
    MOVQ    %r10, %r8       # j = i
    MOVQ    %r12, %r9       # bin_am = sum
    JMP     loop

end:
    POPQ    %r14
    POPQ    %r13
    POPQ    %r12
    MOVQ    %r11, %rdx
    MOVQ    %r8, %rax
    ret
