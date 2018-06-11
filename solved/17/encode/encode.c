#include <stdio.h>
#include <string.h>

extern char * encode(char * buf, unsigned int mask, int operation, int character);

#define CHECK(A,B) strcmp(A,B) == 0 ? "Ok":"Fail"

int main() {
    printf("Original string:    abcd1a2bcd\n");
    char str1[] = "abcd1a2bcd";
    printf("operation = -1; %s; %s\n", CHECK(encode(str1, 0b10,  0, (int) 'a'), "abcd1a2bcd"), str1);
    printf("operation =  0; %s; %s\n", CHECK(encode(str1, 0b10, -1, (int) 'a'), "abcd1a2bcd"), str1);
    printf("operation =  4; %s; %s\n", CHECK(encode(str1, 0b10,  4, (int) 'a'), "abcd1a2bcd"), str1);

    char str2[] = "abcd1a2bcd";
    printf("operation =  1; %s; %s\n", CHECK(encode(str2, 0b10, 1, (int) 'a'), "abcda2bcd"), str2);

    char str3[] = "abcd1a2bcd";
    printf("operation =  2; %s; %s\n", CHECK(encode(str3, 0b10, 2, (int) 'a'), "abcd8a2bcd"), str3);

    char str4[] = "abcd1a2bcd";
    printf("operation =  3; %s; %s\n", CHECK(encode(str4, 0b10, 3, (int) 'a'), "abcdaa2bcd"), str4);

    return 0;
}
