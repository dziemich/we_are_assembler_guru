#include <stdlib.h>
#include <stdio.h>

extern char *binary_op(char *result, char* arg1, char *arg2, int operation );

//---------------------------------------------------------------
// funkcja realizuje operację binarną na argumentach w postaci ciągów
// znaków '0' i '1' i zwraca wynik w postaci takiego samego łańcucha
//
// parametry:
//    result     - bufor na łańcuch wynikowy
//    arg1, arg2 - argumenty operacji
//    operation  - rodzaj operacji (0=ADD, 1=AND, 2=OR, 3=XOR)
//
// W przypadku gdy długości arg1 i arg2 są różne, operację należy
// wykonać tak, jakby krótszy łańcuch zawierał z lewej strony
// odpowiednią liczbę zer.
//
// Wersja minimum : ADD dla argumentów o identycznych długościach
//---------------------------------------------------------------
void printCharArray(char* c){
  for(int i = 0; i < 12;i++){
    printf("%c %i\n",c[i], (int) c[i]);
  }
}


int main(){
  for(int oper = 0; oper < 4;oper++){
    char arg1[] = "011001";
    char arg2[] = "101010";
    char res[ 65 ];
    printf("Argument 1: %s\n", arg1 );
    printf("Argument 2: %s\n", arg2 );
    printf("Operation : %d\n", oper );
    printf("Result    : %s\n", binary_op( res, arg1, arg2, oper ) );
    printCharArray(res);
  }
  return 0;
}
