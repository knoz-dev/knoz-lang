// Ackermann Function Benchmark - Rust
// Tests deep recursion performance (reduced input to avoid stack overflow)

fn ackermann(m: i64, n: i64) -> i64 {
    if m == 0 {
        n + 1
    } else if n == 0 {
        ackermann(m - 1, 1)
    } else {
        ackermann(m - 1, ackermann(m, n - 1))
    }
}

fn main() {
    // ackermann(3, 10) = 8189 (manageable recursion depth)
    let m: i64 = 3;
    let n: i64 = 10;
    let result = ackermann(m, n);
    println!("ackermann({}, {}) = {}", m, n, result);
}
