.data
	bit_result: .quad 0 # rezulatat koncowy
    counter: .quad 0 # licznik od przesuniecia bitowego
        
    .type check_div @function
    .global check_div

   # rejestry argumentow funkcji z C kolejno: rdi, rsi, rdx, rcx, r8, r9

.text

check_div:
    cmp $0, %rdx # sprawdzenie, czy c jest 0
    je a_divisible_by_b # jesli tak, dzielimy a przez b
    # funkcja
    # potrzebuje jakiegos radosnego rejestru, ktory bedzie sie zajmowal petla i tylko nia
    mov $1, %r8 # r8 jest naszym dzielnikiem
    jmp perform_the_hard_part

a_divisible_by_b:
    mov %rdi, %rax # przygotowanie do dzielenia, dzielna musi byc w rax a jest w rax
    idiv %rsi # w rsi jest b. dzielenie, rax / rsi. Wynik idzie do rax, reszta do rdx
    cmp $0, %rdx # sprawdzenie podzielności
    je return_one # jezeli podzielne, zwroc jedynke
    mov $0, %rax # jezeli niepodzielne, zwroc dwojke
    ret

return_one:
    mov $1, %rax # zwroc jedynke
    ret

perform_the_hard_part:
    cmp $64, %r8 # warunek petli, r8 mniejsze od 64
    je finish
    # a siedzi w rdi, przesuwam dzielna do rax
    mov %rdi, %rax 
    # rbx bedzie dzielnikiem
    mov %r8, %rbx # przesuwam obecna wartosc dzielnika do rbx
    cmp $0, %rbx # nie wolno dzielic przez 0
    je jest_zero
    xor %rdx, %rdx # zerowanie rejestru rdx, BARDZO WAZNE
    div %rbx # dzielenie rax/rbx, czyli a/obecna iteracje
    cmp $0, %rdx
    # jezeli jest podzielny, to musze zmienic bit, w innym przypadku zostawiam w spokoju
    je shift_bit
    add $1, %r8
    add $1, counter
    jmp perform_the_hard_part

jest_zero:
    mov $404, %rax
    ret

shift_bit:
    # jakims cudem ustawic dobry bit
    mov counter, %cl # ustawiam ile bitow musze przesunac w lewo
    mov $1, %rbx # to jest ta jedynka, ktora bedzie wstawiana do bit_result
    shl %cl, %rbx # przesuwam o tyle miejsc ta jedynke, ile trzeba
    mov bit_result, %rsi 
    or %rsi, %rbx # dodaje bitowo, dotychczasowy rezultat z tym nowym
    # przyklad rsi: 0101 rbi: 1000 -> 1101
    mov %rbx, bit_result # aktualizacja zmiennej wynikowej
    inc %r8 # inkrementacja r8
    add $1, counter # inkrementacja licznika
    jmp perform_the_hard_part # powrot do petli

finish:
    mov bit_result, %rax # zwrocenie wyniku
    ret