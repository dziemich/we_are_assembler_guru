#include <stdio.h>
#include <stdlib.h>

extern long long max_ind(long long * tab, long long n, long long * evencount, long long * negcount);

int main() {
    long long tab[7] = {-1, 2, -3, 4, 5, -6, -7};

    long long * a = malloc(sizeof(long long));
    long long * b = malloc(sizeof(long long));
    long long max = max_ind(tab, 7, a, b);

    printf("%lld, %lld, %lld", *a, *b, max);

    free(a);
    free(b);

    return 0;
}
