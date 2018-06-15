//---------------------------------------------------------------
// Test program - grupa 4
//---------------------------------------------------------------

#include <stdlib.h>
#include <stdio.h>

long int sum_expr(int *tabA, int *tabB, int n, int operation );

//---------------------------------------------------------------
// funkcja wyznacza expectę wyrażeń których postać zależy od parametru
// operation. W wyrażeniach pojawiają się elementy tablic tabA i tabB
// - obie tablice mają ten sam rozmiar.
//
// Parametry:
//    tabA    - tablica (wektor) liczb
//    tabB    - tablica (wektor) liczb
//    n       - liczba elementów tablic (rozmiar tablicy)
//    operation - parametr określający postać expectowanych wyrażeń
//                 0 = sum i=0..n-1 tabA[i] * tabB[n-i-1]
//                 1 = sum i=0..n-1 tabA[i] * tabB[i]
//                 2 = sum i=0..n-1 tabA[i] - tabB[n-i-1]
//                 3 = sum i=0..n-1 tabA[i] - tabB[i]
//
// Wersja minimum : prawidłowe działanie dla operation = 0
//---------------------------------------------------------------

int main(){
  for(int operation = 0; operation < 4;operation++){ // Test dla wszytkich operacji
    int tabA[] = {0,-1,-2,-3,-1,-5,-6,-7,-8,-9};
    int tabB[] = {45,-8,-7,-7,-9,-4,-3,-3,-1,-0};
    int n = 10;
    int i;
    long expect = 0;
    for(int i = 0; i < n; i++) // Oblicz prawidłową wartość
    {
      switch (operation) {
        case 0:
          expect += tabA[i] * tabB[n-i-1];
          break;
        case 1:
          expect += tabA[i] * tabB[i];
          break;
        case 2:
          expect += tabA[i] - tabB[n-i-1];
          break;
        case 3:
          expect += tabA[i] - tabB[i];
          break;
      }
    }

    printf("Tab size = %d\n", n );
    for( i = 0; i < n; i++)
      printf("TabA[%2d] = %d  TabB[%2d] = %d\n", i, tabA[i], i, tabB[i] );
    printf("Operation = %d\n", operation );
    printf("Sum of expressions  = %ld expected %ld\n", sum_expr( tabA, tabB, n, operation ) , expect);
  }
    return 0;
}
