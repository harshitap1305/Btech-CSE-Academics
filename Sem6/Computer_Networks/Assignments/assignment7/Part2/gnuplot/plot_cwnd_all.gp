# plot_cwnd_all.gp
# Plots cwnd vs time for all 4 TCP variants on a single figure
# Run from the assignment root: gnuplot gnuplot/plot_cwnd_all.gp

set terminal pngcairo size 1200,700 enhanced font 'Arial,11'
set output 'plots/cwnd_all_variants.png'

set title "Congestion Window vs Time — All TCP Variants" font "Arial,14"
set xlabel "Time (seconds)"
set ylabel "Congestion Window (bytes)"
set grid
set key top left

set style line 1 lc rgb "#e41a1c" lw 2 lt 1   # NewReno   — red
set style line 2 lc rgb "#377eb8" lw 2 lt 2   # Highspeed — blue
set style line 3 lc rgb "#4daf4a" lw 2 lt 3   # Veno      — green
set style line 4 lc rgb "#984ea3" lw 2 lt 4   # Vegas     — purple

plot \
  'results/newreno_cwnd.txt'   using 1:3 with lines ls 1 title 'NewReno',   \
  'results/highspeed_cwnd.txt' using 1:3 with lines ls 2 title 'Highspeed', \
  'results/veno_cwnd.txt'      using 1:3 with lines ls 3 title 'Veno',      \
  'results/vegas_cwnd.txt'     using 1:3 with lines ls 4 title 'Vegas'
