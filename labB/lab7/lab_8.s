#----------------------------------------------------------------
# Program lab_8.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
# To compile:	as -o lab_8.o lab_8.s
# To link:	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o lab_8 lab_8.o
# To run:	./lab_8
#
#----------------------------------------------------------------

	.data
argc_s:
	.asciz "argc = %d\n"
args_s:
	.asciz "%s\n"
sep_s:
	.asciz "----------------------------\n"
argc:
	.quad 0
argv:
	.quad 0
env:
	.quad 0


	.text
	.global _start

_start:

	mov (%rsp), %rax	# argc is here
	mov %rax, argc		# store value of argc              || przenosimy ilość arguemntów żeby zapamiętać

	mov $argc_s,%rdi
	mov argc, %rsi
	mov $0, %al
	call printf		# display value of argc            || wyswietlamy printfem ilosc argumentów

	mov %rsp, %rbx		# use rbx as a pointer             || wykorzystujemy rbx jako wskaznik do danych na stosie
	add $8, %rbx		# argv[] is here                   || przenosimy o 8 aby wskazywać na 1 argument
	mov %rbx, argv		# store address of argv[]          || zapamietujemy argument

	mov argc, %r12		# get value of argc                || licznik pętli r12

next_argv:

	mov $args_s, %rdi
	mov (%rbx), %rsi
	mov $0, %al
	call printf		# display value of argv[i]         || znowu printujemy łancuch formatujący i cos do wyswietlenia

	add $8,%rbx		# address of argv[i+1]             || kolejny argument

	dec %r12					           || dekrementacja licznika pętli			
	jnz next_argv

	mov $sep_s, %rdi 
	mov $0, %al
	call printf		# display separator                || wyswietlamy sepereator

	add $8, %rbx		# env[] is here - skip zero/NULL   || przeskakujemy to "0" miedzy argumentami a zmiennymi srodowiskowymi
	mov %rbx, env		# store address of env[]           || i teraz szukamy zmiennych srodowiskowych (pętla while)

next_env:

	cmp $0,(%rbx)		# is env[i] == NULL                || tak dlugo aż znajdziemy to "0" - warunek stopu
	je finish		# yes				   || jesli tak to wychodzimy  

	mov $args_s, %rdi
	mov (%rbx), %rsi	# no
	mov $0, %al
	call printf		# displays value of env[i]         || wypisujemy zmienne

	add $8,%rbx		# address of env[i+1]		   || przekakujemy na kolejne miejsce w pamieci czyli do kolejnej zmiennej
	jmp next_env						   || a potem kolejna iteracja

finish:
	mov $0,%rdi		# this is the end...Hold your breath and count to ten Feel the Earth move and then Hear my heart burst again
	call exit                                                  ||kod zakończenia i koniec

