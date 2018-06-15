//---------------------------------------------------------------
// Test program - grupa 5
//---------------------------------------------------------------

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char *rotate_str(char *str, int shift, int casey );

//---------------------------------------------------------------
// funkcja realizuje obrót (przesunięcie cykliczne) ciągu znaków
// z możliwością zmiany wielkości liter
//
// Parametry:
//    str   - łańcuch znaków (wejściowy/wynikowy)
//    shift - przesunięcie
//              shift>0 przesunięcie o shift znaków w prawo
//              shift<0 przesunięcie o |shift| znaków w lewo
//            UWAGA: shift może być większe od długości napisu!
//    casey  - zmiana wielkości liter
//              0 = brak ingerencji w wielkość liter
//              1 = zmiana małych liter na wielkie
//              2 = zmiana wielkich liter na małe
//              3 = zmiana wielkości liter na przeciwne
//
// Wersja minimum : shift>0 dla casey=0
//---------------------------------------------------------------

void printCharArray(char* c, int len){
  for(int i = 0; i < len+2;i++){
    printf("%c %i\n",c[i], (int) c[i]);
  }
}

#define txt "AbCdEfGhIjKlMnO"

int main(){
    int len = strlen(txt);
    char *str = malloc((len+4)*sizeof(char));
    for(int shift = -8; shift < 8+16;shift+=16)
      for(int casey = 0; casey < 4;casey++ ){
        strcpy(str, txt);
        printf("Original string:%s\n", str );
        printf("Shift = %d\n", shift );
        printf("Case  = %d\n", casey );
        printf("Rotated string :%s\n", rotate_str( str, shift, casey ) );
        printCharArray(str, len);
      }
    return 0;
}
