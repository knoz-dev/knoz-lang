// Collatz Conjecture Benchmark - Rust
// Tests branching and loop performance

fn collatz_length(mut n: i64) -> i64 {
    let mut length: i64 = 1;
    while n != 1 {
        if n % 2 == 0 {
            n = n / 2;
        } else {
            n = 3 * n + 1;
        }
        length += 1;
    }
    length
}

fn main() {
    let limit: i64 = 1_000_000;  // 1 million
    let mut max_length: i64 = 0;
    let mut max_start: i64 = 0;
    
    let mut i: i64 = 1;
    while i <= limit {
        let length = collatz_length(i);
        if length > max_length {
            max_length = length;
            max_start = i;
        }
        i += 1;
    }
    
    println!("Longest Collatz sequence up to {}: start={}, length={}", 
             limit, max_start, max_length);
}
