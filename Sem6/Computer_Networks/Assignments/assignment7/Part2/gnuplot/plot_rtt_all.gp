# plot_rtt_all.gp
# RTT vs time for all 4 TCP variants

set terminal pngcairo size 1200,700 enhanced font 'Arial,11'
set output 'plots/rtt_all_variants.png'

set title "RTT vs Time — All TCP Variants" font "Arial,14"
set xlabel "Time (seconds)"
set ylabel "RTT (seconds)"
set grid
set key top right

set style line 1 lc rgb "#e41a1c" lw 2 lt 1
set style line 2 lc rgb "#377eb8" lw 2 lt 2
set style line 3 lc rgb "#4daf4a" lw 2 lt 3
set style line 4 lc rgb "#984ea3" lw 2 lt 4

plot \
  'results/newreno_rtt.txt'   using 1:3 with lines ls 1 title 'NewReno',   \
  'results/highspeed_rtt.txt' using 1:3 with lines ls 2 title 'Highspeed', \
  'results/veno_rtt.txt'      using 1:3 with lines ls 3 title 'Veno',      \
  'results/vegas_rtt.txt'     using 1:3 with lines ls 4 title 'Vegas'
