# %rdi - pierwszy arg
# %rsi - drugi argument
# %rdx - trzeci arg
# %rax - koncowy
# %rax - dzielna musi w nim być, idiv dzielenie wynik idzie do rax, reszta do rdx...

.data
	.type check_div function
	.globl check_div

.text



check_div:
	CMPQ $0, %rdx
	JG cWieksze0
	MOVQ %rdi, %rax
	IDIV %rsi 					#rax/rsi, reszta do rdx
	cmp $0, %rdx
	JG zwroc0					#jeśli wieksze od 0 czyli niepodzielne zwróć 0
	MOVQ $1, %rax				#podzielne to zwroc 1
	ret
	
zwroc0:
	MOVQ $0, %rax
	ret

cWieksze0:
	XORQ %r9, %r9			#zmienna która będzie przechowywać bity
	MOVQ $1, %r10			#iterator
	JMP warunekPetli

warunekPetli:
	CMPQ $64,%r10				
	JG koniec					#r10>64 skocz do konca
	JMP petla

petla:
	MOVQ %rdi, %rax				#przenieś a do końcowego czyli do miejsca, gdzie ma byc dzielna!
	XORQ %rdx, %rdx				#WYZERUJ MIEJSCE NA RESZTE, INACZEJ ERROR
	IDIV %r10					#dzielę przez r10 czyli przez iterator
	INCQ %r10	
	CMPQ $0,%rdx				#inkrementuje iterator
	JE podzielna
	shlq $1, %r9				#przesuwam o jeden bit w lewo (np. 11111 -> 11110)
	JMP warunekPetli			#wracam do miejsca sprawdzenia pętli

podzielna:
	addq $1, %r9				#dodaje na koniec bit 1 czyli po prostu inkrementuje
	JMP warunekPetli			#wracam do sprawdzania warunku

koniec:
	MOVQ %r9, %rax
	ret
