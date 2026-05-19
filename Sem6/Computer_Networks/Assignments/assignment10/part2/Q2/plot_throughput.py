import csv
import matplotlib.pyplot as plt

# read the data from the CSV file
times = []
throughputs = []
delays = []

print("Reading iperf_metrics.csv...")
try:
    with open('iperf_metrics.csv', 'r') as file:
        reader = csv.reader(file)
        next(reader)  
        for row in reader:
            times.append(int(row[0]))
            throughputs.append(float(row[1]))
            delays.append(float(row[2]))
except FileNotFoundError:
    print("Error: Could not find iperf_metrics.csv. Did you run the C client first?")
    exit(1)

# Create the plot with two y-axes
fig, ax1 = plt.subplots(figsize=(10, 5))

# Plot Throughput on the left Y-axis
color = 'tab:blue'
ax1.set_xlabel('Time (s)')
ax1.set_ylabel('Throughput (Mbps)', color=color)
ax1.plot(times, throughputs, color=color, marker='o', linewidth=2, label='Throughput')
ax1.tick_params(axis='y', labelcolor=color)
ax1.grid(True, linestyle='--', alpha=0.6)

# Create a second Y-axis for the Delay
ax2 = ax1.twinx()
color = 'tab:red'
ax2.set_ylabel('Average Delay (ms)', color=color)
ax2.plot(times, delays, color=color, marker='x', linewidth=2, linestyle='--', label='Avg Delay')
ax2.tick_params(axis='y', labelcolor=color)

# Add titles and layout
plt.title('Network Throughput and Average Delay vs Time')
fig.tight_layout()

# Save the plot to an image file (useful for the assignment report!)
plt.savefig('throughput_delay_graph.png', dpi=300)
print("Graph generated and saved successfully as 'throughput_delay_graph.png'!")

plt.show()