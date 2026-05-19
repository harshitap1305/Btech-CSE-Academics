#!/usr/bin/env bash
# run_experiments.sh
#
# Usage:
#   cd <NS3_ROOT>
#   cp /path/to/run_experiments.sh .
#   bash run_experiments.sh

set -euo pipefail

# ── Configuration
NS3_ROOT="${NS3_ROOT:-$(pwd)}"  
PYTHON="${PYTHON:-python3}"

echo "============================================================"
echo "  TcpHarshita Assignment 8 – Experiment Runner"
echo "  NS3_ROOT = ${NS3_ROOT}"
echo "============================================================"

# ── Step 1: Configure and build 
echo ""
echo "[1/4] Configuring and building ns-3 …"
cd "${NS3_ROOT}"
./ns3 configure --enable-examples --enable-tests 2>&1 | tail -5
./ns3 build 2>&1 | tail -10
echo "  Build complete."

# ── Step 2: Performance comparison (Task 3)
echo ""
echo "[2/4] Running performance comparison (NewReno vs Harshita) …"
cd "${NS3_ROOT}"

echo "  → Running TcpNewReno …"
./ns3 run "perf_compare --tcpVariant=0 --simTime=30"

echo "  → Running TcpHarshita …"
./ns3 run "perf_compare --tcpVariant=1 --simTime=30"

echo "  Performance traces written."

# Move output files to a dedicated folder
mkdir -p results/performance
mv -f newreno-*.txt harshita-*.txt results/performance/ 2>/dev/null || true
echo "  Files moved to results/performance/"

# ── Step 3: Fairness evaluation (Task 4) 
echo ""
echo "[3/4] Running Jain's Fairness Index experiments …"
cd "${NS3_ROOT}"

for N in 4 8 16 20; do
    echo "  → nFlows=${N}  scenario=allNewReno"
    ./ns3 run "fairness_eval --nFlows=${N} --mixed=0 --simTime=30"
    echo "  → nFlows=${N}  scenario=mixed"
    ./ns3 run "fairness_eval --nFlows=${N} --mixed=1 --simTime=30"
done

mkdir -p results/fairness
mv -f fairness-*.txt results/fairness/ 2>/dev/null || true
echo "  Fairness files moved to results/fairness/"

# ── Step 4: Generate plots 
echo ""
echo "[4/4] Generating plots …"

# Performance plots
cd "${NS3_ROOT}/results/performance"
"${PYTHON}" "../../plot_metrics.py"

# Fairness plots
cd "${NS3_ROOT}/results/fairness"
"${PYTHON}" "../../plot_fairness.py"

echo ""
echo "============================================================"
echo "  All done!  Output plots:"
echo "  results/performance/plot_cwnd.png"
echo "  results/performance/plot_ssthresh.png"
echo "  results/performance/plot_rtt.png"
echo "  results/performance/plot_throughput.png"
echo "  results/performance/plot_dashboard.png"
echo "  results/fairness/plot_fairness.png"
echo "  results/fairness/fairness_table.txt"
echo "============================================================"
