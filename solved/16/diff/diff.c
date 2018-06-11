#include <stdio.h>
#include <stdlib.h>

extern long max_diff(long a, long b, long c, long d);

int main(){
  printf("%ld %d\n",max_diff(1, 2, 3, 4),3);
  printf("%ld %d\n",max_diff(-1, 2, 3, 4),5);
  printf("%ld %d\n",max_diff(4, 3, 2, 1),3);
  printf("%ld %d\n",max_diff(4, 3, 2, -1),5);
  return 0;
}
