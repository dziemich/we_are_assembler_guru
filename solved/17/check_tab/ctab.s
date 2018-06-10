.data

tab:
	.long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.type check_tab, @function

.globl check_tab

.text

# int* tab		%rdi
# int n			  %esi
# int* max		%rdx
# return 		  %eax
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
  MOVQ $64, %rbx
loop3:
  DEC %rbx
  CMP $0, %rbx
  JL end
  SHLL %eax
  CMPL $0, tab(,%rbx,4)
  JE loop3
  ORL $1, %eax
  CMPL %ecx, tab(,%rbx,4)
  JL loop3
  MOVL tab(,%rbx,4), %ecx
  JMP loop3
end:
  MOVL %ecx, (%rdx)
  ret
