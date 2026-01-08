#!/bin/bash

ITERATIONS=20
RESULTS_FILE="benchmark_results_ns.csv"

PROGRAMS=(
  ackermann_c ackermann_cpp ackermann_rust ackermann_knoz
  collatz_c collatz_cpp collatz_rust collatz_knoz
  fibonacci_c fibonacci_cpp fibonacci_rust fibonacci_knoz
  sum_squares_c sum_squares_cpp sum_squares_rust sum_squares_knoz
)

echo "program,language,algorithm,iteration,elapsed_ns,max_rss_kb" > "$RESULTS_FILE"

get_language() {
  case "$1" in
    *_c) echo "C" ;;
    *_cpp) echo "C++" ;;
    *_rust) echo "Rust" ;;
    *_knoz) echo "Knoz" ;;
    *) echo "Unknown" ;;
  esac
}

get_algorithm() {
  echo "$1" | cut -d'_' -f1
}

run_benchmark() {
  local program="$1"
  local lang
  local algo

  lang=$(get_language "$program")
  algo=$(get_algorithm "$program")

  for i in $(seq 1 $ITERATIONS); do
    echo "▶ $program | iteration $i"

    python3 - <<EOF >> "$RESULTS_FILE"
import subprocess
import time

program = "$program"
lang = "$lang"
algo = "$algo"
iteration = $i

start = time.perf_counter_ns()

proc = subprocess.Popen(
    ["./" + program],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.PIPE,
)

_, stderr = proc.communicate()

end = time.perf_counter_ns()
elapsed_ns = end - start

rss = ""
for line in stderr.decode().splitlines():
    if "maximum resident set size" in line:
        rss = line.split()[-1]

print(f"{program},{lang},{algo},{iteration},{elapsed_ns},{rss}")
EOF

  done
}

for prog in "${PROGRAMS[@]}"; do
  run_benchmark "$prog"
done

echo "✅ Nanosecond benchmark complete"
echo "📄 Results saved to $RESULTS_FILE"
