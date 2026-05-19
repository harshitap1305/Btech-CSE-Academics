# plot_delay_variation.gp
# Effect of delay variation on cwnd (NewReno)

set terminal pngcairo size 1200,700 enhanced font 'Arial,11'
set output 'plots/delay_variation_cwnd.png'

set title "Effect of Propagation Delay on cwnd (TCP NewReno)" font "Arial,14"
set xlabel "Time (seconds)"
set ylabel "cwnd (bytes)"
set grid
set key top left

plot \
  'results/newreno_delay1_cwnd.txt'  using 1:3 with lines lw 2 title 'delay=1ms',  \
  'results/newreno_delay2_cwnd.txt'  using 1:3 with lines lw 2 title 'delay=2ms',  \
  'results/newreno_delay10_cwnd.txt' using 1:3 with lines lw 2 title 'delay=10ms', \
  'results/newreno_delay50_cwnd.txt' using 1:3 with lines lw 2 title 'delay=50ms'
