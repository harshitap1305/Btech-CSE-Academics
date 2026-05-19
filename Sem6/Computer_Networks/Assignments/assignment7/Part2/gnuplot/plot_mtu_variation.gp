# plot_mtu_variation.gp
# Effect of MTU size on cwnd (NewReno)
# Reads: results/newreno_mtu512_cwnd.txt, newreno_mtu1024_cwnd.txt, etc.

set terminal pngcairo size 1200,700 enhanced font 'Arial,11'
set output 'plots/mtu_variation_cwnd.png'

set title "Effect of MTU Size on cwnd (TCP NewReno)" font "Arial,14"
set xlabel "Time (seconds)"
set ylabel "cwnd (bytes)"
set grid
set key top left

plot \
  'results/newreno_mtu512_cwnd.txt'  using 1:3 with lines lw 2 title 'MTU=512  (MSS=472)',  \
  'results/newreno_mtu1024_cwnd.txt' using 1:3 with lines lw 2 title 'MTU=1024 (MSS=984)',  \
  'results/newreno_mtu1500_cwnd.txt' using 1:3 with lines lw 2 title 'MTU=1500 (MSS=1460)', \
  'results/newreno_mtu4096_cwnd.txt' using 1:3 with lines lw 2 title 'MTU=4096 (MSS=4056)', \
  'results/newreno_mtu9000_cwnd.txt' using 1:3 with lines lw 2 title 'MTU=9000 (MSS=8960)'
