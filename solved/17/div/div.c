#include <stdlib.h>
#include <stdio.h>

extern unsigned long check_div(long a, long b,long c);

char *decimal_to_binary(long n);

int main(){
    printf("%lu\n", check_div(4,2,0));
    printf("%lu\n", check_div(4,3,0));
    printf("%s\n", decimal_to_binary(check_div(4,3,1)));
    printf("%s\n", decimal_to_binary(check_div(64,3,1)));
  return 0;
}

char *decimal_to_binary(long n){
   long c, d, count;
   char *pointer;

   count = 0L;
   pointer = (char*)malloc(32+1);

   if (pointer == NULL)
      exit(EXIT_FAILURE);

   for (c = 63L ; c >= 0 ; c--)
   {
      d = n >> c;

      if (d & 1L)
         *(pointer+count) = 1 + '0';
      else
         *(pointer+count) = 0 + '0';

      count++;
   }
   *(pointer+count) = '\0';

   return  pointer;
}
