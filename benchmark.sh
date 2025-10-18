#!/usr/bin/env bash
set -e  # Exit on first error
set -o pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <optimization_name>"
  exit 1
fi

OPT_NAME=$1
ROOT_DIR="results_${OPT_NAME}"

# Create root directory
mkdir -p "$ROOT_DIR"

# ------------------------------
# 1. Matmul Ciphertext * Plaintext
# ------------------------------
BENCH_DIR="$ROOT_DIR/matmul_cp"
mkdir -p "$BENCH_DIR"
echo "[*] Building matmul_cp..."
make bench_matmul.exe > "$BENCH_DIR/build.log" 2>&1
echo "[*] Running matmul_cp..."
perf stat -o "$BENCH_DIR/perf.txt" ./bench_matmul.exe 0 16 > "$BENCH_DIR/output.txt" 2>&1
#----------------------------------
# BENCH_DIR="$ROOT_DIR/matmul_cp"
# mkdir -p "$BENCH_DIR"
# echo "[*] Building matmul_cp..."
# make bench_matmul.exe > "$BENCH_DIR/build.log" 2>&1
# echo "[*] Running matmul_cp..."
# perf stat -o "$BENCH_DIR/perf.txt" ./bench_matmul.exe 1 16 > "$BENCH_DIR/output.txt" 2>&1

# ------------------------------
# 2. Matmul Ciphertext * Ciphertext
# ------------------------------
BENCH_DIR="$ROOT_DIR/matmul_cc"
mkdir -p "$BENCH_DIR"
echo "[*] Building matmul_cc..."
make bench_matmul.exe > "$BENCH_DIR/build.log" 2>&1
echo "[*] Running matmul_cc..."
perf stat -o "$BENCH_DIR/perf.txt" ./bench_matmul.exe 1 32 > "$BENCH_DIR/output.txt" 2>&1
#-------------------------------
# BENCH_DIR="$ROOT_DIR/matmul_cc"
# mkdir -p "$BENCH_DIR"
# echo "[*] Building matmul_cc..."
# make bench_matmul.exe > "$BENCH_DIR/build.log" 2>&1
# echo "[*] Running matmul_cc..."
# perf stat -o "$BENCH_DIR/perf.txt" ./bench_matmul.exe 0 32 > "$BENCH_DIR/output.txt" 2>&1

# ------------------------------
# 3. Black & White Converter
# ------------------------------
BENCH_DIR="$ROOT_DIR/bw_converter"
mkdir -p "$BENCH_DIR"
echo "[*] Building bw_converter..."
make bench_bw.exe > "$BENCH_DIR/build.log" 2>&1
echo "[*] Running bw_converter..."
perf stat -o "$BENCH_DIR/perf.txt" ./bench_bw.exe inputs/bird.jpg > "$BENCH_DIR/output.txt" 2>&1
#------------------------------
# BENCH_DIR="$ROOT_DIR/bw_converter"
# mkdir -p "$BENCH_DIR"
# echo "[*] Building bw_converter..."
# make bench_bw.exe > "$BENCH_DIR/build.log" 2>&1
# echo "[*] Running bw_converter..."
# perf stat -o "$BENCH_DIR/perf.txt" ./bench_bw.exe inputs/dolphin.jpg > "$BENCH_DIR/output.txt" 2>&1
#-------------------------------
# BENCH_DIR="$ROOT_DIR/bw_converter"
# mkdir -p "$BENCH_DIR"
# echo "[*] Building bw_converter..."
# make bench_bw.exe > "$BENCH_DIR/build.log" 2>&1
# echo "[*] Running bw_converter..."
# perf stat -o "$BENCH_DIR/perf.txt" ./bench_bw.exe inputs/objects.jpg > "$BENCH_DIR/output.txt" 2>&1

# ------------------------------
# 4. Sobel Filter
# ------------------------------
BENCH_DIR="$ROOT_DIR/sobel_filter"
mkdir -p "$BENCH_DIR"
echo "[*] Building sobel_filter..."
make bench_sobel.exe > "$BENCH_DIR/build.log" 2>&1
echo "[*] Running sobel_filter..."
perf stat -o "$BENCH_DIR/perf.txt" ./bench_sobel.exe inputs/bird.jpg > "$BENCH_DIR/output.txt" 2>&1
#------------------------------
# BENCH_DIR="$ROOT_DIR/sobel_filter"
# mkdir -p "$BENCH_DIR"
# echo "[*] Building sobel_filter..."
# make bench_sobel.exe > "$BENCH_DIR/build.log" 2>&1
# echo "[*] Running sobel_filter..."
# perf stat -o "$BENCH_DIR/perf.txt" ./bench_sobel.exe inputs/dolphin.jpg > "$BENCH_DIR/output.txt" 2>&1
#------------------------------
# BENCH_DIR="$ROOT_DIR/sobel_filter"
# mkdir -p "$BENCH_DIR"
# echo "[*] Building sobel_filter..."
# make bench_sobel.exe > "$BENCH_DIR/build.log" 2>&1
# echo "[*] Running sobel_filter..."
# perf stat -o "$BENCH_DIR/perf.txt" ./bench_sobel.exe inputs/objects.jpg > "$BENCH_DIR/output.txt" 2>&1

echo "All benchmarks completed. Results stored in: $ROOT_DIR/"
echo
