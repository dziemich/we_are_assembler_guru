#include <stdio.h>
#include <stdlib.h>

char* genstring (char *s, int c, int n, int inc);

int main(){
    char* str = malloc ((8) * sizeof(char));

    char* ret = genstring(str, 'a', 6, 1);

    printCharArray(str);
}
void printCharArray(char* c){
  for(int i = 0; i < 7;i++){
    printf("%c %i\n",c[i], (int) c[i]);
  }
}