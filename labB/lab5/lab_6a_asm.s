#----------------------------------------------------------------
# Funkcja do programu lab_6a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
                             #ogolnie rax to wynik rdi to argument

	.text
	.type facta, @function
	.global facta	

facta:	mov $1, %rax         #zapis 1 do wynikowego

	cmp %rax, %rdi       #sprawdzamy czy rdi(czyli wproqwadzony argument jest mniejszy badz rowny od jedynki)
	jbe f_e              #jesli tak to wyrzucamy wynik (czyli rax)

	push %rdi            #wyrzucamy na stos zeby nie zgubic

	dec %rdi             #dekrementacja
	call facta           # wywolanie z zmniejszonym rdi
		
	pop %rdi             #pobranie ze stosu rdi	

	mul %rdi             #tu mnozymy z rax z rdi

f_e:	ret

