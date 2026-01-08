// Ackermann Function Benchmark - C
// Tests deep recursion performance (reduced input to avoid stack overflow)

#include <stdio.h>
#include <stdint.h>

int64_t ackermann(int64_t m, int64_t n) {
    if (m == 0) return n + 1;
    if (n == 0) return ackermann(m - 1, 1);
    return ackermann(m - 1, ackermann(m, n - 1));
}

int main() {
    // ackermann(3, 10) = 8189 (manageable recursion depth)
    int64_t m = 3;
    int64_t n = 10;
    int64_t result = ackermann(m, n);
    printf("ackermann(%lld, %lld) = %lld\n", m, n, result);
    return 0;
}
