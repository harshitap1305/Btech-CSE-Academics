#!/bin/bash
# =============================================================================
# CSL351 - Assignment 7, Part 2
# run.sh  —  Automation script
#
# HOW IT WORKS:
#   - Takes Demo_2.cc as-is (completely unchanged from what was provided)
#   - For each TCP variant, patches ONLY the SocketType line + filenames
#     using sed, copies to NS3 scratch/, builds, and runs
#   - All results saved to ./results/
#   - tshark computes average throughput from pcap files
#   - gnuplot generates all plots
#
# USAGE:
#   1. chmod +x run.sh
#   2. ./run.sh 
#      directory: ~/ns-allinone-3.44/ns-3.44
# =============================================================================

set -e

# ---- Configurable paths ----
NS3_DIR="${1:-$HOME/ns-allinone-3.44/ns-3.44}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEMO_SRC="$SCRIPT_DIR/scratch/Demo_2.cc"
RESULTS_DIR="$SCRIPT_DIR/results"
PLOTS_DIR="$SCRIPT_DIR/plots"
GNUPLOT_DIR="$SCRIPT_DIR/gnuplot"
SIM_TIME=20

section() {
  echo ""
  echo "======================================================"
  echo "  $*"
  echo "======================================================"
}

# ---- Validate ----
section "Checking setup"

if [ ! -d "$NS3_DIR" ]; then
  echo "ERROR: NS-3 not found at: $NS3_DIR"
  echo "Usage: ./run.sh /path/to/ns-3.xx"
  exit 1
fi
if [ ! -f "$DEMO_SRC" ]; then
  echo "ERROR: Demo_2.cc not found at: $DEMO_SRC"
  echo "Demo_2.cc must be in the same folder as run.sh"
  exit 1
fi

echo "NS-3    : $NS3_DIR"
echo "Demo_2  : $DEMO_SRC"
echo "Results : $RESULTS_DIR"
mkdir -p "$RESULTS_DIR" "$PLOTS_DIR"

# ============================================================
# HELPER: patch Demo_2.cc for a given variant+params, build, run
#
#   $1 = NS3 TypeId class name   e.g. TcpNewReno
#   $2 = short label             e.g. newreno
#   $3 = bandwidth               e.g. 5Mbps   (default 5Mbps)
#   $4 = delay                   e.g. 2ms     (default 2ms)
#   $5 = extra file suffix       e.g. _bw10   (default empty)
# ============================================================
run_demo() {
  local TYPEID="$1"
  local LABEL="$2"
  local BW="${3:-5Mbps}"
  local DELAY="${4:-2ms}"
  local SUFFIX="${5:-}"
  local TAG="${LABEL}${SUFFIX}"

  local SCRATCH="$NS3_DIR/scratch/demo2_${TAG}.cc"

  echo ""
  echo "  --> $TYPEID | BW=$BW | delay=$DELAY | output prefix: $TAG"

  # ----------------------------------------------------------
  # Patch Demo_2.cc with sed (Demo_2.cc itself is never changed)
  # Changes made:
  #   1. TCP variant TypeId
  #   2. Three output trace filenames
  #   3. PCAP prefix
  #   4. DataRate and Delay of the P2P link
  # ----------------------------------------------------------
  sed \
    -e "s|TcpNewReno::GetTypeId()|${TYPEID}::GetTypeId()|g" \
    -e "s|\"seventh.cwnd\"|\"${RESULTS_DIR}/${TAG}_cwnd.txt\"|g" \
    -e "s|\"seventh_rtt.txt\"|\"${RESULTS_DIR}/${TAG}_rtt.txt\"|g" \
    -e "s|\"seventh-ssthresh.txt\"|\"${RESULTS_DIR}/${TAG}_ssthresh.txt\"|g" \
    -e "s|EnablePcapAll (\"seventh-file\")|EnablePcapAll (\"${RESULTS_DIR}/${TAG}\")|g" \
    -e "s|StringValue (\"5Mbps\")|StringValue (\"${BW}\")|g" \
    -e "s|StringValue (\"2ms\")|StringValue (\"${DELAY}\")|g" \
    "$DEMO_SRC" > "$SCRATCH"

  # Build
  cd "$NS3_DIR"
  ./ns3 build scratch/demo2_${TAG} 2>&1 \
    | grep -E "error:|Built target|Compiling" | head -5 || true

  # Run
  ./ns3 run scratch/demo2_${TAG} 2>&1 | tail -2 || true

  echo "      Done: $TAG"
}

# ============================================================
# Q1/Q2/Q3/Q6 — 4 base variants at standard 5Mbps / 2ms
# ============================================================
section "Running 4 TCP variants (base: 5Mbps, 2ms)"

run_demo "TcpNewReno"   "newreno"
run_demo "TcpHighSpeed" "highspeed"
run_demo "TcpVeno"      "veno"
run_demo "TcpVegas"     "vegas"

# ============================================================
# Q4 — Bandwidth variation (NewReno)
# ============================================================
section "Q4: Bandwidth variation — NewReno"

for BW in "1Mbps" "5Mbps" "10Mbps" "50Mbps"; do
  BTAG="${BW/Mbps/}"
  run_demo "TcpNewReno" "newreno" "$BW" "2ms" "_bw${BTAG}"
done

# ============================================================
# Q4 — Delay (latency) variation (NewReno)
# ============================================================
section "Q4: Delay variation — NewReno"

for DL in "1ms" "2ms" "10ms" "50ms"; do
  DTAG="${DL/ms/}"
  run_demo "TcpNewReno" "newreno" "5Mbps" "$DL" "_delay${DTAG}"
done

# ============================================================
# Q5 — MTU / segment-size variation (NewReno)
#      We patch Demo_2.cc and also inject a SegmentSize config line
# ============================================================
section "Q5: MTU variation — NewReno"

for MTU in 512 1024 1500 4096 9000; do
  MSS=$((MTU - 40))
  SCRATCH="$NS3_DIR/scratch/demo2_newreno_mtu${MTU}.cc"
  echo ""
  echo "  --> MTU=$MTU  MSS=$MSS"

  # Patch filenames + inject SegmentSize config after the SocketType line
  sed \
    -e "s|\"seventh.cwnd\"|\"${RESULTS_DIR}/newreno_mtu${MTU}_cwnd.txt\"|g" \
    -e "s|\"seventh_rtt.txt\"|\"${RESULTS_DIR}/newreno_mtu${MTU}_rtt.txt\"|g" \
    -e "s|\"seventh-ssthresh.txt\"|\"${RESULTS_DIR}/newreno_mtu${MTU}_ssthresh.txt\"|g" \
    -e "s|EnablePcapAll (\"seventh-file\")|EnablePcapAll (\"${RESULTS_DIR}/newreno_mtu${MTU}\")|g" \
    "$DEMO_SRC" > "$SCRATCH"

  # Insert SegmentSize line immediately after the SocketType Config line
  sed -i "/TcpNewReno::GetTypeId()/a\\        Config::SetDefault(\"ns3::TcpSocket::SegmentSize\", UintegerValue(${MSS}));" \
      "$SCRATCH"

  cd "$NS3_DIR"
  ./ns3 build scratch/demo2_newreno_mtu${MTU} 2>&1 \
    | grep -E "error:|Built" | head -3 || true
  ./ns3 run  scratch/demo2_newreno_mtu${MTU}  2>&1 | tail -2 || true
  echo "      Done: MTU=$MTU"
done

# ============================================================
# Throughput via tshark on pcap files
# ============================================================
section "Average throughput (tshark on pcap files)"

if ! command -v tshark &>/dev/null; then
  echo "tshark not found — install with: sudo apt-get install tshark"
  echo "Skipping throughput calculation."
else
  TFILE="$RESULTS_DIR/throughput_summary.txt"
  printf "%-12s %-15s %-20s\n" "Variant" "Bytes_sent" "AvgThroughput_Mbps" > "$TFILE"
  printf "%-12s %-15s %-20s\n" "-------" "----------" "------------------" >> "$TFILE"

  for V in newreno highspeed veno vegas; do
    # NS3 names pcap files: <prefix>-<nodeId>-<devId>.pcap
    # Node 0 device 0 is the sender side
    PCAP="$RESULTS_DIR/${V}-0-0.pcap"
    if [ ! -f "$PCAP" ]; then
      printf "%-12s %-15s %-20s\n" "$V" "pcap_missing" "N/A" >> "$TFILE"
      echo "  $V: pcap not found at $PCAP"
      continue
    fi
    # Sum all frame lengths (layer-2 bytes including headers)
    BYTES=$(tshark -r "$PCAP" -T fields -e frame.len 2>/dev/null \
            | awk '{s+=$1} END{printf "%d",s+0}')
    # Duration = simTime - appStartTime = 20 - 1 = 19 seconds
    DURATION=$((SIM_TIME - 1))
    TP=$(echo "scale=4; $BYTES * 8 / $DURATION / 1000000" | bc -l 2>/dev/null || echo "N/A")
    printf "%-12s %-15s %-20s\n" "$V" "$BYTES" "$TP" >> "$TFILE"
    echo "  $V : $BYTES bytes → $TP Mbps"
  done

  echo ""
  echo "--- Throughput Summary ---"
  cat "$TFILE"
fi

# ============================================================
# Count cwnd reductions per variant
# ============================================================
section "cwnd reduction counts"

printf "\n%-12s | %s\n" "Variant" "cwnd_reductions"
printf "%-12s-+-%s\n"   "------------" "---------------"
for V in newreno highspeed veno vegas; do
  F="$RESULTS_DIR/${V}_cwnd.txt"
  if [ -f "$F" ]; then
    CNT=$(awk '{if($3 < $2) c++} END{print c+0}' "$F")
    printf "%-12s | %d\n" "$V" "$CNT"
  else
    printf "%-12s | (file missing)\n" "$V"
  fi
done

# ============================================================
# Generate all gnuplot graphs
# ============================================================
section "Generating plots with gnuplot"

if ! command -v gnuplot &>/dev/null; then
  echo "gnuplot not found — install with: sudo apt-get install gnuplot"
else
  cd "$SCRIPT_DIR"
  for GP in "$GNUPLOT_DIR"/*.gp; do
    echo "  gnuplot $(basename $GP)"
    gnuplot "$GP" 2>&1 || echo "  WARNING: $(basename $GP) failed"
  done
  echo ""
  echo "Plots written to: $PLOTS_DIR"
  ls "$PLOTS_DIR"/*.png 2>/dev/null | xargs -I{} basename {} || true
fi

# ============================================================
section "ALL DONE"
# ============================================================
echo ""
echo "  Results : $RESULTS_DIR"
echo "  Plots   : $PLOTS_DIR"
echo ""
echo "  Trace files generated:"
ls "$RESULTS_DIR"/*.txt 2>/dev/null | xargs -I{} basename {} | column || true
