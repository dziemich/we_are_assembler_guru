#include <stdio.h>
#include <string.h>

extern char * encode(char * buf, unsigned int mask, int operation, int character);

int main() {
    char str1[] = "abcd1a2bcd";
    printf("operation = 0; %d; %s\n", strcmp(encode(str1, 0b10, 0, (int) 'a'), "abcd1a2bcd"), str1);

    char str2[] = "abcd1a2bcd";
    printf("operation = 1; %d; %s\n", strcmp(encode(str2, 0b10, 1, (int) 'a'), "abcda2bcd"), str2);

    char str3[] = "abcd1a2bcd";
    printf("operation = 2; %d; %s\n", strcmp(encode(str3, 0b10, 2, (int) 'a'), "abcd8a2bcd"), str3);

    char str4[] = "abcd1a2bcd";
    printf("operation = 3; %d; %s\n", strcmp(encode(str4, 0b10, 3, (int) 'a'), "abcdaa2bcd"), str4);

    return 0;
}
