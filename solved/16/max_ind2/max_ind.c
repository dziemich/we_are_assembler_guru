long long max_ind(
    long long * tab,
    long long n,
    long long * evencount,
    long long * negcount
) {
    long long j = 0;
    long long bin_am = 0;

    (*evencount) = 0;
    (*negcount) = 0;

    for (long long i = 0; i < n; ++i) {
        if (tab[i] % 2 == 0) {
            (*evencount)++;
        }

        if (tab[i] < 0) {
            (*negcount)++;
        }

        long long sum = 0;

        for (long long k = 0; k < 64; ++k) {
            if (tab[i] & 1) {
                sum += 1;
            }
            tab[i] = tab[i] >> 1;
        }

        if (sum > bin_am) {
            j = i;
            bin_am = sum;
        }
    }

    return j;
}
