# Socket Programming - Assignment 10 (Part 2)

This directory contains the solutions for Part 2 of Assignment 10, split into three sub-questions:
* **Q1**: RTT Echo Client and Server
* **Q2**: Throughput (`iperf`-like) Test Client and Graph Generator
* **Q3**: Traceroute Implementation

## Execution Instructions

### Q1: RTT Server and Client

This section implements a basic UDP Echo Server and an RTT (Round Trip Time) Echo Client.

**1. Compilation:**
```bash
cd Q1
gcc rtt_server.c -o rtt_server
gcc rtt_client.c -o rtt_client
```

**2. Running the Server:**
The server listens for UDP packets on a specified port and echoes them back exactly.
```bash
# In Terminal 1
./rtt_server <port>

# Example:
./rtt_server 8001
```

**3. Running the Client:**
The client sends packets containing a sequence number and timestamp, waits for echoes, and computes RTT.
```bash
# In Terminal 2
./rtt_client <server_ip> <port> <num_messages> <interval_ms> <packet_size>

# Example (sending 10 packets to localhost:8001, every 1000ms, 64 bytes each):
./rtt_client 127.0.0.1 8001 10 1000 64
```

---

### Q2: iperf-like Client and Metrics

The `iperf`-like client tests the throughput and average delay of the network by sending a flood of non-blocking datagrams.

**Dependency Note:** **The Q2 Client relies on the `rtt_server` built in Q1!** Please ensure the server from Q1 is running before running the client for Q2.

**1. Compilation:**
```bash
cd Q2
gcc iperf_client.c -o iperf_client
```

**2. Start the Server (if not already running):**
```bash
# In Terminal 1
cd ../Q1
./rtt_server 8001
```

**3. Run the iperf Client:**
```bash
# In Terminal 2
cd ../Q2
./iperf_client <server_ip> <port> <duration_sec> <packet_size>

# Example (testing throughput to localhost:8001 for 10 seconds, 1024 bytes per packet):
./iperf_client 127.0.0.1 8001 10 1024
```
*This will perform the throughput test and automatically generate a file named `iperf_metrics.csv`.*

**4. Generate Graphs:**
```bash
# In Terminal 3 (or after the iperf_client finishes)
# Requires matplotlib (pip install matplotlib)
python3 plot_throughput.py
```
*This script will read `iperf_metrics.csv` and generate `throughput_delay_graph.png`, showing throughput and delay over time.*

---

### Q3: Traceroute

A basic custom traceroute tool that uses UDP probes and raw sockets to catch ICMP Time Exceeded / Destination Unreachable messages to trace network hops.

**1. Compilation:**
```bash
cd Q3
gcc traceroute.c -o traceroute
```

**2. Running Traceroute:**
Since this program uses raw ICMP sockets (`IPPROTO_ICMP`) to receive data, it requires administrative capabilities (`sudo`).
```bash
sudo ./traceroute <destination_ip_or_domain>

# Example:
sudo ./traceroute google.com
```
