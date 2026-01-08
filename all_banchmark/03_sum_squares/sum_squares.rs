// Sum of Squares Benchmark - Rust
// Simple arithmetic loop to test basic operations

fn main() {
    let limit: i64 = 100_000_000;  // 100 million
    let mut sum: i64 = 0;
    
    let mut i: i64 = 1;
    while i <= limit {
        sum += i * i;
        i += 1;
    }
    
    println!("Sum of squares 1 to {} = {}", limit, sum);
}
