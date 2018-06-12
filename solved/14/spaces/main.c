#include <stdio.h>

extern char * spaces(char * string);

int main() {
    char string[20] = "Abcd efg  hij   klm";
    char * ret = spaces(string);

    printf("%s\n", string);

    return 0;
}
