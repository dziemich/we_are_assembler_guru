char * spaces(char * string) {
    for (int i = 0; string[i] != '\0'; i++) {
        if (string[i] == 32 && string[i + 1] == 32) {
            for (int j = i; string[j] != '\0'; j++) {
                string[j] = string[j + 1];
            }

            i--;
        }
    }

    return string;
}
