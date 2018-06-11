#include <stdio.h>
#include <stdlib.h>

extern unsigned long check_div(long a, long b,long c);

int main(){

	printf("%ld\n", check_div(130, 6, 1));
	return 0;
}
