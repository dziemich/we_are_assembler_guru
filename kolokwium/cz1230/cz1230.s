# autor Dziedzic Michał

# NIE JESTEM Z NIEGO DUMNY ALE WSZYSTKO DZIALA XD

.type sum_ascii @function

.data 
    count : .quad 0

.global sum_ascii

.text


# char* str             %rdi
# int a                 %rsi
# int b                 %rdx
# int charset           %rcx
# int count             %r8
# return long int       %rax


sum_ascii:

    mov $-1, %r9  # licznik petli
    mov $0, %r10
    mov $0, %r11
    mov $0, %r12
    jmp loop1

loop1:
    inc %r9
    cmp %rsi, %r9  # sprawdzam czy wieksze od a
    jl loop1
    cmp %rdx, %r9 # sprawdzam czy mniejsze od b
    jg end
    mov (%rdi, %r9, 1), %r10b
    cmp $0, %r10
    je end
    cmp $0, %rcx
    je sum_all
    cmp $1, %rcx
    je sum_0_9
    cmp $2, %rcx
    je sum_A_Z
    cmp $3, %rcx
    je sum_a_z
    jmp sum_a_z_A_Z



sum_all:
    add %r10, %r11 # w %r11 przechowuje ostateczny wynik
    add $1, %r12b # tutaj liczone jest int *count
    jmp loop1

sum_0_9:
    cmp $48, %r10 # sprawdzam po kodzie ascii, czy nalezy do 0-9, 0=48, z=57 
    jl loop1
    cmp $57, %r10
    jg loop1
    jmp sum_all


sum_a_z:
    cmp $97, %r10 # sprawdzam po kodzie ascii, czy nalezy do a-z, a=97, z=122
    jl loop1
    cmp $122, %r10
    jg loop1
    jmp sum_all

sum_A_Z:
    cmp $65, %r10 # sprawdzam po kodzie ascii, czy nalezy do A-Z, A=65, Z=90
    jl loop1
    cmp $90, %r10
    jg loop1
    jmp sum_all

sum_a_z_A_Z:
    cmp $122, %r10
    jg loop1
    cmp $65, %r10 # sprawdzam po kodzie ascii, czy nalezy do A-Z, A=65, Z=90
    jl loop1
    cmp $91, %r10 # brutalnie lecz skutecznie, eliminuje kody ascii ktore nie sa literami
    je  loop1
    cmp $91, %r10
    je loop1
    cmp $92, %r10
    je loop1
    cmp $93, %r10
    je loop1
    cmp $94, %r10
    je loop1
    cmp $95, %r10
    je loop1
    cmp $96, %r10
    je loop1
    jmp sum_all



end:
    mov %r11, %rax
    mov %r12, (%r8)
    ret 
# koniec



