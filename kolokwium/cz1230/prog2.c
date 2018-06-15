//---------------------------------------------------------------
// Test program - grupa 2
//---------------------------------------------------------------

#include <stdlib.h>
#include <stdio.h>

long int sum_ascii(char *str, int a, int b, int charset, int *count );

//---------------------------------------------------------------
// funkcja wyznacza sum� kod�w ASCII znak�w �a�cucha str (o ile
// znajduj� si� na odpowiednich pozycjach i pasuj� do wybranego
// zbioru znak�w) oraz zwraca liczb� uwzgl�dnionych w sumie znak�w
//
// Parametry:
//    str     - �a�cuch znak�w
//    a       - pozycja pocz�tkowa sprawdzanych znak�w (0<=a<=length(str)-1)
//    b       - pozycja ko�cowa sprawdzanych znak�w (0<=b i a<=b); je�eli
//              b >= length(str), to obliczenia nale�y wykona� tak,
//              jakby b by�o r�wne length(str)-1
//    charset - 0 = dowolne znaki
//              1 = ['0'..'9'] (uwzgl�dniane s� tylko cyfry)
//              2 = ['A'..'Z']
//              3 = ['a'..'z']
//              4 = ['A'..'Z','a'..'z']
//    count  - liczba znak�w uwzgl�dnionych w trakcie sumowania
//             (pasuj�cych do charset i na pozycjach z zakresu [a,b]
//
// W przypadku gdy str ma d�ugo�� np. 10, to dla parametr�w a=0, b=9
// i a=0, b=100 funkcja powinna zwraca� identyczne warto�ci
//
// Wersja minimum : prawid�owe dzia�anie dla charset = 0
//---------------------------------------------------------------
 
int main(){
    char str[] = "352";
    int a = 0;
    int b = 5;
    int charset = 0;
    int count;

    printf("String      = %s\n", str );
    printf("Start pos   = %d\n", a );
    printf("End pos     = %d\n", b );
    printf("Charset     = %d\n", charset );
    printf("ASCII sum   = %ld\n", sum_ascii( str, a, b, charset, &count ) );
    printf("Chars count = %d\n", count );
    return 0;
}

