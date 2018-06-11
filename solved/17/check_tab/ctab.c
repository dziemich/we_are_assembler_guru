#include <stdlib.h>
#include <stdio.h>


extern unsigned int check_tab(int* tab, int n, int* max);

char *decimal_to_binary(int n);

int main(){
  int tab[10] = {1,2,3,3,3,4,4,6,7,7};
  int max = 0;
  unsigned int r = check_tab(tab,10,&max);
  printf("Max: %d\n%s\n", max, decimal_to_binary(r));
  return 0;
}

char *decimal_to_binary(int n){
   int c, d, count;
   char *pointer;

   count = 0;
   pointer = (char*)malloc(32+1);

   if (pointer == NULL)
      exit(EXIT_FAILURE);

   for (c = 31 ; c >= 0 ; c--)
   {
      d = n >> c;

      if (d & 1)
         *(pointer+count) = 1 + '0';
      else
         *(pointer+count) = 0 + '0';

      count++;
   }
   *(pointer+count) = '\0';

   return  pointer;
}
