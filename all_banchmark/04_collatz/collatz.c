// Collatz Conjecture Benchmark - C
// Tests branching and loop performance

#include <stdio.h>
#include <stdint.h>

int64_t collatz_length(int64_t n) {
    int64_t length = 1;
    while (n != 1) {
        if (n % 2 == 0) {
            n = n / 2;
        } else {
            n = 3 * n + 1;
        }
        length++;
    }
    return length;
}

int main() {
    int64_t limit = 1000000;  // 1 million
    int64_t max_length = 0;
    int64_t max_start = 0;
    
    for (int64_t i = 1; i <= limit; i++) {
        int64_t length = collatz_length(i);
        if (length > max_length) {
            max_length = length;
            max_start = i;
        }
    }
    
    printf("Longest Collatz sequence up to %lld: start=%lld, length=%lld\n", 
           limit, max_start, max_length);
    return 0;
}
