# plot_rtt_individual.gp
# 2x2 multiplot of RTT for all variants

set terminal pngcairo size 1400,900 enhanced font 'Arial,10'
set output 'plots/rtt_individual.png'

set multiplot layout 2,2 title "RTT vs Time — Individual Variants" font "Arial,13"
set grid
set xlabel "Time (seconds)"
set ylabel "RTT (seconds)"

set title "TCP NewReno"
plot 'results/newreno_rtt.txt' using 1:3 with lines lc rgb "#e41a1c" lw 1.5 notitle

set title "TCP Highspeed"
plot 'results/highspeed_rtt.txt' using 1:3 with lines lc rgb "#377eb8" lw 1.5 notitle

set title "TCP Veno"
plot 'results/veno_rtt.txt' using 1:3 with lines lc rgb "#4daf4a" lw 1.5 notitle

set title "TCP Vegas"
plot 'results/vegas_rtt.txt' using 1:3 with lines lc rgb "#984ea3" lw 1.5 notitle

unset multiplot
