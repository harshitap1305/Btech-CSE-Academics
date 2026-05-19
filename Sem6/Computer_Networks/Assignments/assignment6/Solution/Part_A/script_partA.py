import xml.etree.ElementTree as ET
import matplotlib.pyplot as plt

tree = ET.parse("flowmon.xml")
root = tree.getroot()

# Step 1: Build FlowId → FiveTuple map
flow_info = {}

for classifier in root.iter("Ipv4FlowClassifier"):
    for flow in classifier.iter("Flow"):
        flow_id = flow.get("flowId")
        src = flow.get("sourceAddress")
        dst = flow.get("destinationAddress")
        flow_info[flow_id] = (src, dst)

# Define intended senders

intended_senders = [
    "10.0.10.1",  # n7
    "10.0.2.1",   # n1
    "10.0.3.1",   # n2
    "10.0.1.1"    # n0
]

flows = []
throughput = []
goodput = []
loss = []

for flow in root.iter("FlowStats"):
    for f in flow.iter("Flow"):
        flowId = f.get("flowId")

        if flowId not in flow_info:
            continue

        src, dst = flow_info[flowId]

        # Filter only forward flows
        if src not in intended_senders:
            continue

        tx = int(f.get("txPackets"))
        rx = int(f.get("rxPackets"))
        rxBytes = int(f.get("rxBytes"))

        timeFirst = float(f.get("timeFirstRxPacket").replace("ns",""))/1e9
        timeLast = float(f.get("timeLastRxPacket").replace("ns",""))/1e9

        duration = timeLast - timeFirst
        if duration <= 0:
            continue

        thr = (rxBytes * 8) / duration / 1e6  # Mbps
        gp = (rx * 1024 * 8) / duration / 1e6
        lost = tx - rx

        flows.append(flowId)
        throughput.append(thr)
        goodput.append(gp)
        loss.append(lost)

# Create labels for each flow (Source → Destination)

labels = [f"{src}->{dst}" for src, dst in [flow_info[fid] for fid in flows]]

# -------------------- Throughput --------------------
plt.bar(labels, throughput)
plt.xlabel("Flow (Source → Destination)")
plt.ylabel("Throughput (Mbps)")
plt.title("Flow vs Throughput")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("throughput.png")
plt.clf()

# -------------------- Goodput --------------------
plt.bar(labels, goodput)
plt.xlabel("Flow (Source → Destination)")
plt.ylabel("Goodput (Mbps)")
plt.title("Flow vs Goodput")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("goodput.png")
plt.clf()

# -------------------- Packet Loss --------------------
plt.bar(labels, loss)
plt.xlabel("Flow (Source → Destination)")
plt.ylabel("Packets Lost")
plt.title("Flow vs Packet Loss")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("loss.png")
plt.clf()
