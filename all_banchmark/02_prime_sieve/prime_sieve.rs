// Prime Sieve Benchmark - Rust
// Sieve of Eratosthenes to test array access and bit operations

// Trial division to match Knoz implementation
fn main() {
    let limit: i64 = 100_000;  // 100K to match Knoz
    let mut count: i64 = 0;
    
    let mut n: i64 = 2;
    while n <= limit {
        let mut is_prime = true;
        let mut d: i64 = 2;
        while d * d <= n {
            if n % d == 0 {
                is_prime = false;
                break;
            }
            d += 1;
        }
        if is_prime {
            count += 1;
        }
        n += 1;
    }
    
    println!("Primes up to {}: {}", limit, count);
}
