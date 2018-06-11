.data

tab:
	.fill 64,4,0
.type check_tab, @function

.globl check_tab

.text

# int* tab     %rdi
# int  n       %esi
# int* max     %rdx
# return uint  %eax
check_tab:
  MOVQ $0, %rax
loop1:
  MOVL $0, tab(,%rax,4)
  INCQ %rax
  CMP $64, %rax
  JNE loop1
  MOVQ $0, %rax
loop2:
  CMP %esi, %eax
  JE next
  MOVL (%rdi,%rax,4), %ebx
  INCQ %rax
  CMPL $0, %ebx
  JL loop2
  CMPL $63, %ebx
  JG loop2
  INCL tab(,%ebx,4)
  JMP loop2

next:
  MOVL $0, %ecx
  MOVL $0, %eax
  MOVQ $64, %r9
loop3:
  DEC %r9
  CMP $0, %r9
  JL end
  SHLL %eax
  CMPL $0, tab(,%r9,4)
  JE loop3
  ORL $1, %eax
  CMPL %ecx, tab(,%r9,4)
  JL loop3
  MOVL tab(,%r9,4), %ecx
  JMP loop3
end:
  MOVL %ecx, (%rdx)
  ret
