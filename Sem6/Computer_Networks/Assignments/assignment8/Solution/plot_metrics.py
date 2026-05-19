#!/usr/bin/env python3
"""
plot_metrics.py
===============
Generates all performance-comparison plots for the TcpHarshita vs TcpNewReno
assignment.

Expected input files (produced by perf_compare.cc):
  newreno-cwnd.txt        harshita-cwnd.txt
  newreno-ssthresh.txt    harshita-ssthresh.txt
  newreno-rtt.txt         harshita-rtt.txt
  newreno-throughput.txt  harshita-throughput.txt

Output PNG files:
  plot_cwnd.png
  plot_ssthresh.png
  plot_rtt.png
  plot_throughput.png

Usage:
  python3 plot_metrics.py
  (run from the directory containing the .txt output files)
"""

import os
import sys
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

plt.rcParams.update({
    "figure.dpi":        150,
    "figure.figsize":    (9, 4.5),
    "axes.grid":         True,
    "grid.alpha":        0.35,
    "lines.linewidth":   1.6,
    "font.size":         11,
    "axes.titlesize":    13,
    "axes.labelsize":    12,
    "legend.fontsize":   10,
})

COLORS = {"newreno": "#d62728", "harshita": "#1f77b4"}
LABELS = {"newreno": "TCP NewReno", "harshita": "TCP Harshita (NewReno + HyStart)"}

def load_two_col(path):
    """Return (time_array, value_array) for files with format  t  old  new."""
    rows = []
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            parts = line.split()
            if len(parts) >= 3:
                rows.append((float(parts[0]), float(parts[2])))
            elif len(parts) == 2:
                rows.append((float(parts[0]), float(parts[1])))
    if not rows:
        return np.array([]), np.array([])
    arr = np.array(rows)
    return arr[:, 0], arr[:, 1]


def load_tput(path):
    """Return (time_array, throughput_Mbps_array) from throughput file."""
    rows = []
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            parts = line.split()
            if len(parts) >= 2:
                rows.append((float(parts[0]), float(parts[1])))
    if not rows:
        return np.array([]), np.array([])
    arr = np.array(rows)
    return arr[:, 0], arr[:, 1]


def file_ok(path):
    return os.path.isfile(path) and os.path.getsize(path) > 0


# ─── Plot 1: Congestion Window ────────────────────────────────────────────────
def plot_cwnd():
    fig, ax = plt.subplots()
    for variant in ("newreno", "harshita"):
        path = f"{variant}-cwnd.txt"
        if not file_ok(path):
            print(f"  [WARN] {path} not found – skipping")
            continue
        t, v = load_two_col(path)
        ax.plot(t, v / 1024, color=COLORS[variant], label=LABELS[variant], alpha=0.85)

    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Congestion Window (KB)")
    ax.set_title("Congestion Window vs Time")
    ax.legend()
    ax.yaxis.set_major_formatter(ticker.FormatStrFormatter("%.1f"))
    fig.tight_layout()
    fig.savefig("plot_cwnd.png")
    plt.close(fig)
    print("  Saved: plot_cwnd.png")


# ─── Plot 2: Slow-Start Threshold ────────────────────────────────────────────
def plot_ssthresh():
    fig, ax = plt.subplots()
    for variant in ("newreno", "harshita"):
        path = f"{variant}-ssthresh.txt"
        if not file_ok(path):
            print(f"  [WARN] {path} not found – skipping")
            continue
        t, v = load_two_col(path)
        # Clip very large initial values (default ssthresh = MAX_INT)
        v_clipped = np.clip(v / 1024, 0, 5000)
        ax.step(t, v_clipped, where="post",
                color=COLORS[variant], label=LABELS[variant], alpha=0.85)

    ax.set_xlabel("Time (s)")
    ax.set_ylabel("ssThresh (KB)")
    ax.set_title("Slow-Start Threshold vs Time")
    ax.legend()
    fig.tight_layout()
    fig.savefig("plot_ssthresh.png")
    plt.close(fig)
    print("  Saved: plot_ssthresh.png")


# ─── Plot 3: RTT ──────────────────────────────────────────────────────────────
def plot_rtt():
    fig, ax = plt.subplots()
    for variant in ("newreno", "harshita"):
        path = f"{variant}-rtt.txt"
        if not file_ok(path):
            print(f"  [WARN] {path} not found – skipping")
            continue
        t, v = load_two_col(path)
        ax.plot(t, v * 1000, color=COLORS[variant], label=LABELS[variant], alpha=0.75)

    ax.set_xlabel("Time (s)")
    ax.set_ylabel("RTT (ms)")
    ax.set_title("Round-Trip Time vs Time")
    ax.legend()
    fig.tight_layout()
    fig.savefig("plot_rtt.png")
    plt.close(fig)
    print("  Saved: plot_rtt.png")


# ─── Plot 4: Throughput ───────────────────────────────────────────────────────
def plot_throughput():
    fig, ax = plt.subplots()
    for variant in ("newreno", "harshita"):
        path = f"{variant}-throughput.txt"
        if not file_ok(path):
            print(f"  [WARN] {path} not found – skipping")
            continue
        t, v = load_tput(path)
        ax.plot(t, v, color=COLORS[variant], label=LABELS[variant], alpha=0.85)

    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Aggregate Throughput (Mbps)")
    ax.set_title("Total Throughput vs Time (all 4 flows)")
    ax.legend()
    fig.tight_layout()
    fig.savefig("plot_throughput.png")
    plt.close(fig)
    print("  Saved: plot_throughput.png")


# ─── Plot 5: Combined 2×2 Dashboard ──────────────────────────────────────────
def plot_dashboard():
    fig, axes = plt.subplots(2, 2, figsize=(14, 9))
    fig.suptitle("TcpHarshita vs TcpNewReno – Performance Dashboard", fontsize=14)

    loaders = [
        (axes[0, 0], "cwnd",       "Congestion Window (KB)", "load_two_col", 1/1024),
        (axes[0, 1], "ssthresh",   "ssThresh (KB)",          "load_two_col", 1/1024),
        (axes[1, 0], "rtt",        "RTT (ms)",               "load_two_col", 1000),
        (axes[1, 1], "throughput", "Throughput (Mbps)",      "load_tput",    1.0),
    ]

    for ax, key, ylabel, loader_name, scale in loaders:
        for variant in ("newreno", "harshita"):
            path = f"{variant}-{key}.txt"
            if not file_ok(path):
                continue
            if loader_name == "load_two_col":
                t, v = load_two_col(path)
            else:
                t, v = load_tput(path)
            v = v * scale
            if key == "ssthresh":
                v = np.clip(v, 0, 5000)
            ax.plot(t, v, color=COLORS[variant], label=LABELS[variant], alpha=0.8)
        ax.set_xlabel("Time (s)")
        ax.set_ylabel(ylabel)
        ax.set_title(ylabel.split("(")[0].strip())
        ax.legend(fontsize=8)
        ax.grid(True, alpha=0.3)

    fig.tight_layout()
    fig.savefig("plot_dashboard.png", dpi=150)
    plt.close(fig)
    print("  Saved: plot_dashboard.png")


# ─── main ────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("Generating performance plots …")
    plot_cwnd()
    plot_ssthresh()
    plot_rtt()
    plot_throughput()
    plot_dashboard()
    print("Done.")
