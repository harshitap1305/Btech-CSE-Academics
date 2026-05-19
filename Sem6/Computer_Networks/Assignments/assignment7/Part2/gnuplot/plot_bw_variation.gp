# plot_bw_variation.gp
# Effect of bandwidth variation on cwnd (NewReno)

set terminal pngcairo size 1200,700 enhanced font 'Arial,11'
set output 'plots/bw_variation_cwnd.png'

set title "Effect of Bandwidth on cwnd (TCP NewReno)" font "Arial,14"
set xlabel "Time (seconds)"
set ylabel "cwnd (bytes)"
set grid
set key top left

plot \
  'results/newreno_bw1_cwnd.txt'  using 1:3 with lines lw 2 title '1 Mbps',  \
  'results/newreno_bw5_cwnd.txt'  using 1:3 with lines lw 2 title '5 Mbps',  \
  'results/newreno_bw10_cwnd.txt' using 1:3 with lines lw 2 title '10 Mbps', \
  'results/newreno_bw50_cwnd.txt' using 1:3 with lines lw 2 title '50 Mbps'
