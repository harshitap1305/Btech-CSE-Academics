# plot_cwnd_individual.gp
# Four separate cwnd plots (one per variant) in a 2x2 multiplot layout

set terminal pngcairo size 1400,900 enhanced font 'Arial,10'
set output 'plots/cwnd_individual.png'

set multiplot layout 2,2 title "Congestion Window vs Time — Individual Variants" font "Arial,13"

set grid
set xlabel "Time (seconds)"
set ylabel "cwnd (bytes)"

# ---- NewReno ----
set title "TCP NewReno"
set style line 1 lc rgb "#e41a1c" lw 1.5
plot 'results/newreno_cwnd.txt' using 1:3 with lines ls 1 notitle

# ---- Highspeed ----
set title "TCP Highspeed"
set style line 1 lc rgb "#377eb8" lw 1.5
plot 'results/highspeed_cwnd.txt' using 1:3 with lines ls 1 notitle

# ---- Veno ----
set title "TCP Veno"
set style line 1 lc rgb "#4daf4a" lw 1.5
plot 'results/veno_cwnd.txt' using 1:3 with lines ls 1 notitle

# ---- Vegas ----
set title "TCP Vegas"
set style line 1 lc rgb "#984ea3" lw 1.5
plot 'results/vegas_cwnd.txt' using 1:3 with lines ls 1 notitle

unset multiplot
