// Fibonacci Benchmark - C
// Recursive Fibonacci to test function call overhead

#include <stdio.h>
#include <stdint.h>

int64_t fibonacci(int64_t n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int64_t n = 40;
    int64_t result = fibonacci(n);
    printf("fibonacci(%lld) = %lld\n", n, result);
    return 0;
}
