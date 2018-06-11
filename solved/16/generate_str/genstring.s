.type generate_string, @function

.globl generate_string

.text

# char* s       %rdi
# char c        %esi
# int n         %edx
# int inc       %ecx
# return cahr*  %rax

generate_string:
  MOVL %esi, %eax
  MOVQ %rdi, %r9
  MOVL $0, %r10d
loop:
  INCL  %r10d
  JMP chars_the_same

back:
  CMPL  %edx, %r10d
  JL  loop
  MOVB $0, (%rdi)
  MOVQ  %r9, %rax
  ret

chars_the_same:
  MOVB  %al, (%rdi)
  INCQ  %rdi
  CMPL  $0, %ecx
  JE  back
  ADDB  $1, %al
  JMP  back
