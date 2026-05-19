#!/usr/bin/env python3
"""
plot_fairness.py
================
Reads the output files produced by fairness_eval.cc and generates:
  1. A formatted table (printed to console + saved as fairness_table.txt)
  2. A grouped bar chart  →  plot_fairness.png

Input files expected (one per (nFlows, scenario) combination):
  fairness-4-allnewreno.txt
  fairness-4-mixed.txt
  fairness-8-allnewreno.txt
  fairness-8-mixed.txt
  fairness-16-allnewreno.txt
  fairness-16-mixed.txt
  fairness-20-allnewreno.txt
  fairness-20-mixed.txt

Usage:
  python3 plot_fairness.py
"""

import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

plt.rcParams.update({
    "figure.dpi":     150,
    "figure.figsize": (9, 5),
    "font.size":      11,
    "axes.grid":      True,
    "grid.alpha":     0.35,
})

FLOW_COUNTS = [4, 8, 16, 20]
SCENARIOS   = {"allnewreno": "NewReno (baseline)",
               "mixed":      "NewReno + Harshita"}

# ─── Parse one output file
def parse_fairness_file(path):
    """Return (jain_index, [throughputs]) or None if file missing."""
    if not os.path.isfile(path):
        return None
    throughputs = []
    jain = None
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            parts = line.split()
            if parts[0] == "JAIN_INDEX":
                jain = float(parts[1])
            elif len(parts) == 4 and parts[0].isdigit():
                throughputs.append(float(parts[3]))
    return jain, throughputs


# ─── Collect results
results = {}  

for scenario in SCENARIOS:
    results[scenario] = {}
    for n in FLOW_COUNTS:
        path = f"fairness-{n}-{scenario}.txt"
        parsed = parse_fairness_file(path)
        if parsed:
            jain, tputs = parsed
            results[scenario][n] = jain
            print(f"  Loaded {path}  →  Jain = {jain:.4f}")
        else:
            print(f"  [WARN] {path} not found – using placeholder 0.0")
            results[scenario][n] = 0.0

# ─── Print table 
header = f"{'Number of flows':>22}  {'4':>8}  {'8':>8}  {'16':>8}  {'20':>8}"
sep    = "-" * len(header)

print("\n" + sep)
print(header)
print(sep)
for scenario, label in SCENARIOS.items():
    row = f"{label:>22}"
    for n in FLOW_COUNTS:
        v = results[scenario].get(n, 0.0)
        row += f"  {v:>8.4f}"
    print(row)
print(sep)

# Save table to file
with open("fairness_table.txt", "w") as f:
    f.write(sep + "\n")
    f.write(header + "\n")
    f.write(sep + "\n")
    for scenario, label in SCENARIOS.items():
        row = f"{label:>22}"
        for n in FLOW_COUNTS:
            v = results[scenario].get(n, 0.0)
            row += f"  {v:>8.4f}"
        f.write(row + "\n")
    f.write(sep + "\n")
print("\n  Saved: fairness_table.txt")

# ─── Bar chart 
fig, ax = plt.subplots()

x      = np.arange(len(FLOW_COUNTS))
width  = 0.35
colors = {"allnewreno": "#d62728", "mixed": "#1f77b4"}

for idx, (scenario, label) in enumerate(SCENARIOS.items()):
    vals = [results[scenario].get(n, 0.0) for n in FLOW_COUNTS]
    offset = (idx - 0.5) * width
    bars = ax.bar(x + offset, vals, width, label=label,
                  color=colors[scenario], alpha=0.8, edgecolor="black", linewidth=0.6)
    # Value labels on bars
    for bar, v in zip(bars, vals):
        if v > 0:
            ax.text(bar.get_x() + bar.get_width() / 2.0,
                    bar.get_height() + 0.005,
                    f"{v:.3f}",
                    ha="center", va="bottom", fontsize=8)

ax.set_xticks(x)
ax.set_xticklabels([str(n) for n in FLOW_COUNTS])
ax.set_xlabel("Number of Flows")
ax.set_ylabel("Jain's Fairness Index")
ax.set_title("Jain's Fairness Index: NewReno vs NewReno+Harshita")
ax.set_ylim(0, 1.12)
ax.axhline(y=1.0, color="green", linestyle="--", linewidth=1.0, alpha=0.6,
           label="Perfect fairness (J=1)")
ax.legend()

fig.tight_layout()
fig.savefig("plot_fairness.png", dpi=150)
plt.close(fig)
print("  Saved: plot_fairness.png")
print("Done.")
