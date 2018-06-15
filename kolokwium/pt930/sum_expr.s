
# int* tabA     %rdi
# int* tabB     %rsi
# int max       %edx
# int op        %ecx
# return long   %rax

.type sum_expr, @function
.global sum_expr

.text
jtable:
  .quad O0, O1, O2, O3 # Tablica skoków
sum_expr:
  MOVQ $0, %rax # Wyzeruj wynik
  MOVQ $-1, %r8 # Wyzeruj iterator do pętli (-1 bo INC na początku)
loop:
  INCQ %r8 # Następny element
  CMPL %r8d, %edx # Warunek stopu
  JLE end
  # Wyzrowanie Rejestrów
  MOVQ $0, %r9
  MOVQ $0, %r10
  MOVQ $0, %r11
  MOVSXD (%rdi,%r8,4), %r9 # Wybranie elementu z tablicy A
  JMP *jtable(,%ecx,8) # Wybranie operacji

  O0:
  # sum i=0..n-1 tabA[i] * tabB[n-i-1]
  # Wylicznie indeksu dal B do %r10
  MOVL %edx, %r10d
  DECL %r10d
  SUBL %r8d, %r10d
  MOVSXD (%rsi,%r10,4), %r11 # Wybranie elementu z tablicy B
  IMULQ %r11, %r9 # Operacja
  ADDQ %r9, %rax # Dodaj do sumy wyników
  JMP loop

  O1:
  # sum i=0..n-1 tabA[i] * tabB[i]
  MOVSXD (%rsi,%r8,4), %r11 # Wybranie elementu z tablicy B
  IMULQ %r11, %r9 # Operacja
  ADDQ %r9, %rax # Dodaj do sumy wyników
  JMP loop

  O2:
  # sum i=0..n-1 tabA[i] - tabB[n-i-1]
  # Wylicznie indeksu dla B do %r10
  MOVL %edx, %r10d
  DECL %r10d
  SUBL %r8d, %r10d
  MOVSXD (%rsi,%r10,4), %r11 # Wybranie elementu z tablicy B
  SUBQ %r11, %r9 # Operacja
  ADDQ %r9, %rax # Dodaj do sumy wyników
  JMP loop

  O3:
  # sum i=0..n-1 tabA[i] - tabB[i]
  MOVSXD (%rsi,%r8,4), %r11 # Wybranie elementu z tablicy B
  SUBQ %r11, %r9 # Operacja
  ADDQ %r9, %rax # Dodaj do sumy wyników
  JMP loop



end:
  ret # Wyjście z funkcji
