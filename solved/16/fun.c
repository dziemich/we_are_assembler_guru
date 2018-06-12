#include <stdio.h>
#include <stdlib.h>

extern char* fun(char* buf ,  char* a ,  char* b);


int main(){
	char* a = "kpdp";
	char* b = "uaua";
	char* buf = malloc(sizeof(b)+sizeof(a));
	char* str = fun(buf, a, b);
	int i = 0;
	for(i;i<sizeof(buf)/sizeof(char);i++){
		printf("%c",str[i]);
	}
	printf("\n");
return 0;
}
