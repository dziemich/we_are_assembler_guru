# assembly

#we are assembler guru


# Spis treści

## KONWENCJA 64 BIT TOC

- [Rejestry 64 bitowe i ich podział](#rejestry-64-bitowe-i-ich-podział)
- [Argumenty przekazywane do funkcji](#argumenty-przekazywane-do-funkcji)
- [Chronione rejestry](#chronione-rejestry)
- [Jakich rejestrów używać bez pszypexu](#jakich-rejestrów-używać-bez-pszypexu)

## KONWENCJA 34 BIT TOC

- [Argumenty przekazywane do funkcji](#argumenty-przekazywane-do-funkcji)
- [STOSU CIĄG DALSZY](#stosu-ciĄg-DALSZY)
- [Chronione rejestry32](#chronione-rejestry-32)
- [Jakich rejestrów używać bez pszypexu](#jakich-rejestrów-używać-bez-pszypexu)
- [BARE MINIMUM](#bare-MINIMUM)
- [Podstawowy wykaz funkcji](#podstawowy-wykaz-funkcji)
    - [Warunkowe signed czyli zwykle te używamy)](#warunkowe-signed-czyli-zwykle-te-używamy)
    - [Warunkowe unsigned](#warunkowe-unsigned)
    - [Pozostałe](#pozostałe)
    - [Wykaz wszystkich instrukcji](#wykaz-wszystkich-instrukcji )
- [32 bit HOWTO](#32-bit-HOWTO)
    - [Przykładowy kod 32bit](#przykładowy-kod-32bit)
    - [offset](#offset)


# KONWENCJA 64 BIT

## Rejestry 64 bitowe i ich podział


```
64-bit register | Lower 32 bits | Lower 16 bits | Lower 8 bits
==============================================================
rax             | eax           | ax            | al
rbx             | ebx           | bx            | bl
rcx             | ecx           | cx            | cl
rdx             | edx           | dx            | dl
rsi             | esi           | si            | sil
rdi             | edi           | di            | dil
rbp             | ebp           | bp            | bpl
rsp             | esp           | sp            | spl
r8              | r8d           | r8w           | r8b
r9              | r9d           | r9w           | r9b
r10             | r10d          | r10w          | r10b
r11             | r11d          | r11w          | r11b
r12             | r12d          | r12w          | r12b
r13             | r13d          | r13w          | r13b
r14             | r14d          | r14w          | r14b
r15             | r15d          | r15w          | r15b
```

## Argumenty przekazywane do funkcji:

1. arg - rdi
2. arg - rsi
3. arg - rdx
4. arg - rcx
5. arg - r8
6. arg - r9

Jakby kogoś poje@ało i chciał więcej przekazać to reszta argumentów jest na stosie

## Chronione rejestry 
(ich wartość ma być taka sama na początku funkcji jak na końcu)

 - rbp
 - rbx
 - r12-r15

## Jakich rejestrów używać bez pszypexu?

Jeśli funkcja używa mniej niż 6 argumntów można użyć wolnych rejestrów,
czyli np. dla 4 argumentów funkcji r8 i r9 pozostają wolne.

Można też użyć r10 i r11

rax również jest free to use, trzeba tylko pamiętać,
że na końcu ma się tu znaleźć zwracana wartość

zostaje nam rsp którego raczej nie używałbym do przechowywania czegoś,
bo jest to wskaźnik na górę stosu

# KONWENCJA 32 BIT

```
32 bit register | Lower 16 bits | Lower 8 bits
==============================================
eax           | ax            | al
ebx           | bx            | bl
ecx           | cx            | cl
edx           | dx            | dl
esi           | si            | sil
edi           | di            | dil
ebp           | bp            | bpl
esp           | sp            | spl
```

## Argumenty przekazywane do funkcji:

Argument przekazywane są na stos w takiej kolejność, że na górze znajduje się
ostatni argument funkcji.

Dla foo(int foo, int boo, int coo, int doo) stos w funkcji będzie wyglądał tak:

Stos jest na "dole" programu wiec rośnie w gore dlatego odwołujemy się dodając a nie odejmując adres

```
   ^ tak rośnie stos
   |
---------
return address - esp
---------
foo           - esp + 4 (+ 4 a nie 1 no bo 32 bity to 4 bajty)
---------
boo        - esp + 8
---------
coo           - esp + 12
---------
doo           - esp + 16
---------
```

##STOSU CIĄG DALSZY

Należy pamiętać że na szczycie stosu przed argumentami będzie adres powrotu

## Chronione rejestry32
(ich wartość ma być taka sama na początku funkcji jak na końcu)

 - ebx
 - esi
 - edi
 - ebp

## Jakich rejestrów używać bez pszypexu?

Zostają tylko ecx i edx

Można też na lajcie użyć eax ale potem i tak będzie to wartość zwracana



## BARE MINIMUM
```
.text
.type nazwafunkcji, @function
.global nazwafunkcji

nazwafunkcji:
  ret
--------------------------------------------------------------------------------
```

## Podstawowy wykaz funkcji

 - mov src dst - zapisuje src w dst
 - push src - umieszcza src na stosie i zwiększa rejestr esp (stack pointer)
 - pop dst - popiera z góry stosu i zmniejsza esp
 - cmp arg1 arg2 - porównuje arg2 z arg1 (nie na odwrót!)
```
  przykład: cmp 1 2 -> jg skok -> WYKONA SKOK! bo 2>1
```
 - jmp lbl - skok bezwarunkowy do podanego lbl-a

### Warunkowe signed (czyli zwykle te używamy):
- JE/JZ 	Jump Equal or Jump Zero
- JNE/JNZ 	Jump not Equal or Jump Not Zero
- JG/JNLE 	Jump Greater or Jump Not Less/Equal
- JGE/JNL 	Jump Greater/Equal or Jump Not Less
- JL/JNGE 	Jump Less or Jump Not Greater/Equal
- JLE/JNG 	Jump Less/Equal or Jump Not Greater

### Warunkowe unsigned:

- JE/JZ 	Jump Equal or Jump Zero
- JNE/JNZ 	Jump not Equal or Jump Not Zero
- JA/JNBE 	Jump Above or Jump Not Below/Equal
- JAE/JNB 	Jump Above/Equal or Jump Not Below
- JB/JNAE 	Jump Below or Jump Not Above/Equal
- JBE/JNA 	Jump Below/Equal or Jump Not Above

### Pozostałe:

- ret - powrót z funkcji
- inc src - inkrementacja src
- dec src - dekrementacja src

- add src dst - dodaje dst = dst + src
- sub src dst - odejmuje dst = dst - src
- idiv mianownik - pojebane dzielenie całkowite - licznik musi by w rax, mianownik musi by w jakimś innym rejestrze,
                 wynik dzielenia będzie w rax, reszta z dzielenia w rdx | RDX MUSI BYC WYZEROWANE
- imul src dst - mnoży dst = dst * src
- xor src dst - dst = dst xor src
- and src dst - dst = dst and src
- or src dst - dst = dst or src

### Wykaz wszystkich instrukcji 
http://www.felixcloutier.com/x86/

## 32 bit HOWTO

1. Instalujecie 32 bitowe biblioteki

```
sudo apt-get install libx32gcc-4.8-dev
sudo apt-get install libc6-dev-i386
```

2. I kompilujecie

```
gcc -m32 -Wall -Wextra test32.c bit32.s
```

### Przykładowy kod 32 bit

```
--------------------------test32.c----------------------------
void bit32();

int main() {
  bit32();
  return 0;
}
--------------------------bit32.s-----------------------------
  .text
  .type bit32, @function
  .global bit32

bit32:
  push %edi
  pop %edi
  ret

--------------------------------------------------------------------------------
```

### offset
```
(adres bazowy, rejestr przesunięcia, o ile bitów przesuwać?)
```

```
-4(%rsi, %rdi, 2) czyli pobieramy wartość spod wskaźnika %rsi - 4 + %rdi*2
```

ta ostatnia wartość to jaki rozmiar danych ma tablica

- dla char to 1
- dla int to 4
- dla long long 8

### floating point info

```
64 bit
jest spoko
argumenty sa w tych xmm0
xmm1
xmm2
xmm3
wiecej to juz stos, ale nie bedzie wiecej
przesuwasz movsd
addsd dodawanie itp
serknij se
ucomisd porownanie
ale uwaga odnosisz sie do tego
jak do unsigned
jak dasz jl to nie zadziała
musi byc ja
no i tyle
a
wartosc zwracana
jesli to double
to xmm0
```

```
32
w skrócie masz na stosie 4 32 bajtowym 64 bajtowe arg
musisz sie zabawiać z ładowaniem ich na stos FPU
uzywac funkcji z postfixam
i zwracasz jako %ST(0)
```
