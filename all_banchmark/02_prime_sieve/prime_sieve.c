// Prime Sieve Benchmark - C
// Sieve of Eratosthenes to test array access and bit operations

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Trial division to match Knoz implementation
int main() {
    int64_t limit = 100000;  // 100K to match Knoz
    int64_t count = 0;
    
    for (int64_t n = 2; n <= limit; n++) {
        int is_prime = 1;
        for (int64_t d = 2; d * d <= n; d++) {
            if (n % d == 0) {
                is_prime = 0;
                break;
            }
        }
        if (is_prime) count++;
    }
    
    printf("Primes up to %lld: %lld\n", limit, count);
    return 0;
}
