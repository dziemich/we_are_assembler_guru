#include <stdio.h>
#include <stdlib.h>
extern long max_diff(long a, long b, long c, long d);


int main(){
  printf("%ld %d\n",max_diff(1, 2, 3, 4),3);
  printf("%ld %d\n",max_diff(-1, 2, 3, 4),3);
  return 0;
}
