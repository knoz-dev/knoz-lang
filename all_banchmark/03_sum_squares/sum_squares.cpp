// Sum of Squares Benchmark - C++
// Simple arithmetic loop to test basic operations

#include <iostream>
#include <cstdint>

int main() {
    int64_t limit = 100000000;  // 100 million
    int64_t sum = 0;
    
    for (int64_t i = 1; i <= limit; i++) {
        sum += i * i;
    }
    
    std::cout << "Sum of squares 1 to " << limit << " = " << sum << std::endl;
    return 0;
}
