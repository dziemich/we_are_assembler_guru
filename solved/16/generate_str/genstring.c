#include <stdio.h>
#include <stdlib.h>


extern char*  generate_string(char*  s, char c, int n, int inc);

#define n 7

void printCharArray(char* c);

int main(){
  char* s = malloc((n + 1) * sizeof(char));

  char* str = generate_string(s, 'a', n, 1);
  printf("|%s|\n", s);
  printf("%p %p\n",s,str);
  printCharArray(s);

  str = generate_string(s, 'a', n-2, 0);
  printf("|%s|\n", s);
  printf("%p %p\n",s,str);
  printCharArray(s);
  return 0;
}

void printCharArray(char* c){
  for(int i = 0; i < n+3;i++){
    printf("%c %i\n",c[i], (int) c[i]);
  }
}
