#include<stdio.h>
#include<stdlib.h>

unsigned int check_tab (int *tab, int n, int*max);

void main(void){
    int table[4] = {6,4,2,1};
    int* t = (int*) malloc(4); 
    t= table;
    int* max;

    printf("%ld", check_tab(table, 1, max));


}