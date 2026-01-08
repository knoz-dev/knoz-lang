// Prime Sieve Benchmark - C++
// Sieve of Eratosthenes to test array access and bit operations

#include <iostream>
#include <vector>
#include <cstdint>

// Trial division to match Knoz implementation
int main() {
    int64_t limit = 100000;  // 100K to match Knoz
    int64_t count = 0;
    
    for (int64_t n = 2; n <= limit; n++) {
        bool is_prime = true;
        for (int64_t d = 2; d * d <= n; d++) {
            if (n % d == 0) {
                is_prime = false;
                break;
            }
        }
        if (is_prime) count++;
    }
    
    std::cout << "Primes up to " << limit << ": " << count << std::endl;
    return 0;
}
