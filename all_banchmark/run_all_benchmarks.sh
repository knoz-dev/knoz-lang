#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KNOZ_COMPILER="${SCRIPT_DIR}/../target/release/knoz"
RUNS=3

echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║     Knoz vs C vs C++ vs Rust - Comprehensive Benchmark           ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""

# Check if Knoz compiler exists
if [[ ! -x "$KNOZ_COMPILER" ]]; then
    echo "Building Knoz compiler..."
    cd "$SCRIPT_DIR/.." && cargo build --release
fi

# Function to compile all versions of a benchmark
compile_benchmark() {
    local dir="$1"
    local name="$2"
    
    echo "📦 Compiling $name..."
    cd "$dir"
    
    # C
    if [[ -f "${name}.c" ]]; then
        clang -O3 -o "${name}_c" "${name}.c" 2>/dev/null || gcc -O3 -o "${name}_c" "${name}.c"
    fi
    
    # C++
    if [[ -f "${name}.cpp" ]]; then
        clang++ -O3 -o "${name}_cpp" "${name}.cpp" 2>/dev/null || g++ -O3 -o "${name}_cpp" "${name}.cpp"
    fi
    
    # Rust
    if [[ -f "${name}.rs" ]]; then
        rustc -C opt-level=3 -o "${name}_rust" "${name}.rs"
    fi
    
    # Knoz
    if [[ -f "${name}.كنز" ]]; then
        "$KNOZ_COMPILER" ترجم "${name}.كنز" -o "${name}_knoz" -O3 2>/dev/null
    fi
    
    cd "$SCRIPT_DIR"
}

# Function to run benchmark and measure time
run_benchmark() {
    local binary="$1"
    local runs="$2"
    
    if [[ ! -x "$binary" ]]; then
        echo "N/A"
        return
    fi
    
    local total=0
    for _ in $(seq 1 "$runs"); do
        local time_output
        time_output=$( { time -p "$binary" >/dev/null 2>&1; } 2>&1 )
        local real
        real=$(echo "$time_output" | awk '/^real/ {print $2}')
        total=$(awk "BEGIN {print $total + $real}")
    done
    
    awk "BEGIN {printf \"%.3f\", $total / $runs}"
}

# Benchmark directories
BENCHMARKS=(
    "01_fibonacci:fibonacci"
    "02_prime_sieve:prime_sieve"
    "03_sum_squares:sum_squares"
    "04_collatz:collatz"
    "05_ackermann:ackermann"
)


echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "                     Performance Comparison"
echo "═══════════════════════════════════════════════════════════════════"
echo ""

printf "%-20s %12s %12s %12s %12s\n" "Benchmark" "vs C" "vs C++" "vs Rust" "Knoz Time"
printf "%-20s %12s %12s %12s %12s\n" "─────────────────" "───────────" "───────────" "───────────" "───────────"

for i in "${!BENCH_NAMES[@]}"; do
    name="${BENCH_NAMES[$i]}"
    c="${C_TIMES[$i]}"
    cpp="${CPP_TIMES[$i]}"
    rust="${RUST_TIMES[$i]}"
    knoz="${KNOZ_TIMES[$i]}"
    
    if [[ "$knoz" != "N/A" && "$c" != "N/A" && "$cpp" != "N/A" && "$rust" != "N/A" ]]; then
        vs_c=$(awk "BEGIN {printf \"%.2fx\", $c / $knoz}")
        vs_cpp=$(awk "BEGIN {printf \"%.2fx\", $cpp / $knoz}")
        vs_rust=$(awk "BEGIN {printf \"%.2fx\", $rust / $knoz}")
        printf "%-20s %12s %12s %12s %12ss\n" "$name" "$vs_c" "$vs_cpp" "$vs_rust" "$knoz"
    fi
done

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "                     Benchmark Complete!"
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "Note: Values > 1.0x mean Knoz is faster, < 1.0x means slower"
