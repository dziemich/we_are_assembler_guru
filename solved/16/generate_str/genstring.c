#include <stdio.h>
#include <stdlib.h>

extern char*  generate_string(char*  s, char c, int n, int inc);
#define n 7

long foo(long a, long b, long c){
  return a / b + c;
}
void pp(char* c);
int main() {
	char* s = malloc((n + 1) * sizeof(char));
	// char s[n+1];
	char* str = generate_string(s, 'a', n, 1);
	printf("|%s|\n", s);
  printf("%p %p\n",s,str);
  pp(s);
	foo(1,2,3);
	return 0;
}

void pp(char* c){
  for(int i = 0; i < n+2;i++){
    printf("%c %i\n",c[i], (int) c[i]);
  }
}
