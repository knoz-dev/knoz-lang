// Fibonacci Benchmark - Rust
// Recursive Fibonacci to test function call overhead

fn fibonacci(n: i64) -> i64 {
    if n <= 1 {
        n
    } else {
        fibonacci(n - 1) + fibonacci(n - 2)
    }
}

fn main() {
    let n: i64 = 40;
    let result = fibonacci(n);
    println!("fibonacci({}) = {}", n, result);
}
