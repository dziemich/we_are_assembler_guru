.type encode, @function

.globl encode

.text


# str w rdi
# charset w rsi
# case w rdx

encode:
    mov $-1, %r8 # iterator
    xor %r9b, %r9b # przechowywanie znaku
    mov $25, %r10b
    mov $9, %r11b

loop1:
    inc %r8
    mov (%rdi, %r8, 1), %r9b
    cmp $0, %r9b
    je end
    cmp $0, %rsi
    je letters_only
    cmp $1, %rsi
    je digits_only
    jmp both

end:
    mov %rdi, %rax
    ret

letters_only:
    cmp $122, %r9b
    jg loop1
    cmp $65, %r9b # sprawdzam po kodzie ascii, czy nalezy do A-Z, A=65, Z=90
    jl loop1
    cmp $91, %r9b # brutalnie lecz skutecznie, eliminuje kody ascii ktore nie sa literami
    je  loop1
    cmp $91, %r9b
    je loop1
    cmp $92, %r9b
    je loop1
    cmp $93, %r9b
    je loop1
    cmp $94, %r9b
    je loop1
    cmp $95, %r9b
    je loop1
    cmp $96, %r9b
    je loop1
    # tutaj oznacza, ze naleza do przedzialu a-z, A-Z
    jmp determine_size

determine_size:    
    cmp $97, %r9b
    jl large_switch
    sub $97, %r9b
    sub %r9b, %r10b
    add $97, %r10b
    cmp $1, %rdx
    je small_switch_size
    mov %r10b, (%rdi, %r8, 1)
    mov $25, %r10b
    jmp loop1

small_switch_size:
    sub $32, %r10b
    mov %r10b, (%rdi, %r8, 1)
    mov $25, %r10b
    jmp loop1


large_switch:
    sub $65, %r9b
    sub %r9b, %r10b
    add $65, %r10b
    cmp $2, %rdx
    je large_switch_size
    mov %r10b, (%rdi, %r8, 1)
    mov $25, %r10b
    jmp loop1

 large_switch_size:
    add $32, %r10b
    mov %r10b, (%rdi, %r8, 1)
    mov $25, %r10b
    jmp loop1   

    
digits_only:
    cmp $48, %r9b # sprawdzam po kodzie ascii, czy nalezy do 0-9, 0=48, z=57 
    jl loop1
    cmp $57, %r9b
    jg loop1
    jmp digit_switch

digit_switch:
    sub $48, %r9b
    sub %r9b, %r11b
    add $48, %r11b
    mov %r11b, (%rdi, %r8, 1)
    mov $9, %r11b
    jmp loop1

both:
    cmp $48, %r9b # tutaj znów jestem brutalny
    jl loop1
    cmp $48, %r9b
    je digit_switch
    cmp $49, %r9b
    je digit_switch
    cmp $50, %r9b
    je digit_switch
    cmp $51, %r9b
    je digit_switch
    cmp $52, %r9b
    je digit_switch
    cmp $53, %r9b
    je digit_switch
    cmp $54, %r9b
    je digit_switch
    cmp $55, %r9b
    je digit_switch
    cmp $56, %r9b
    je digit_switch
    cmp $57, %r9b
    je digit_switch
    jmp letters_only