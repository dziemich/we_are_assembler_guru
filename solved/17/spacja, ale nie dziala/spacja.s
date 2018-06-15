.type spacja @function

.global spacja

.text   

spacja:
    mov $-1, %r8 # iterator
    xor %r9, %r9
    mov %rdi, %r9
    xor %r10, %r10
    xor %r11, %r11

loop1:
    inc %r8d
    mov (%r9, %r8, 1), %r10b
    cmp $0, %r10
    je end
    cmp $32, %r10
    jne adding
    jmp loop1

adding:
    mov %r10, (%rdi, %r11, 1)
    inc %r11
    jmp loop1

end:
    mov %r9, %rax
    ret
    