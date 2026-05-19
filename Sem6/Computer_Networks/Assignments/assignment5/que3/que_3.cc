#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/applications-module.h"
#include "ns3/netanim-module.h"
#include "ns3/flow-monitor-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("Lab5Que3");

int
main (int argc, char *argv[])
{
  // Default values
  std::string bandwidth = "5Kbps";
  std::string latency = "15ms";
  uint32_t maxPackets = 100; 
  std::string interval = "1s";
  uint32_t packetSize = 1024;
  bool enableAnim = false; 
  double simulationTime = 60.0; 

  CommandLine cmd;
  cmd.AddValue ("bandwidth", "Link bandwidth", bandwidth);
  cmd.AddValue ("latency", "Link latency", latency);
  cmd.AddValue ("maxPackets", "Max packets to send", maxPackets);
  cmd.AddValue ("interval", "Packet interval", interval);
  cmd.AddValue ("packetSize", "Packet size in bytes", packetSize);
  cmd.AddValue ("enableAnim", "Enable NetAnim XML generation", enableAnim);
  cmd.Parse (argc, argv);

  Time::SetResolution (Time::NS);

  NS_LOG_UNCOND ("Configuring Simulation...");

  NodeContainer nodes;
  nodes.Create (2);

  PointToPointHelper pointToPoint;
  pointToPoint.SetDeviceAttribute ("DataRate", StringValue (bandwidth));
  pointToPoint.SetChannelAttribute ("Delay", StringValue (latency));

  NetDeviceContainer devices;
  devices = pointToPoint.Install (nodes);

  InternetStackHelper stack;
  stack.Install (nodes);

  Ipv4AddressHelper address;
  address.SetBase ("10.1.1.0", "255.255.255.0");
  Ipv4InterfaceContainer interfaces = address.Assign (devices);

  uint16_t port = 9;

  UdpServerHelper server (port);
  ApplicationContainer serverApps = server.Install (nodes.Get (1));
  serverApps.Start (Seconds (1.0));
  serverApps.Stop (Seconds (simulationTime));

  UdpClientHelper client (interfaces.GetAddress (1), port);
  
  if (maxPackets > 0) {
      client.SetAttribute ("MaxPackets", UintegerValue (maxPackets));
  } else {
      client.SetAttribute ("MaxPackets", UintegerValue (4000000000)); // Huge number for "Unlimited"
  }
  
  client.SetAttribute ("Interval", TimeValue (Time (interval)));
  client.SetAttribute ("PacketSize", UintegerValue (packetSize));

  ApplicationContainer clientApps = client.Install (nodes.Get (0));
  clientApps.Start (Seconds (2.0));
  clientApps.Stop (Seconds (simulationTime));

  // Animation (Only runs if you add --enableAnim=true)
  AnimationInterface *anim = 0;
  if (enableAnim) {
      anim = new AnimationInterface ("que_3.xml");
      anim->SetConstantPosition(nodes.Get(0), 10.0, 10.0);
      anim->SetConstantPosition(nodes.Get(1), 30.0, 10.0);
  }

  FlowMonitorHelper flowmon;
  Ptr<FlowMonitor> monitor = flowmon.InstallAll ();

  NS_LOG_UNCOND ("Starting Simulation (60s)...");
  Simulator::Stop(Seconds(simulationTime + 1.0)); 
  Simulator::Run ();
  NS_LOG_UNCOND ("Simulation Finished. Processing Stats...");

  // Throughput Calculation
  monitor->CheckForLostPackets ();
  Ptr<Ipv4FlowClassifier> classifier = DynamicCast<Ipv4FlowClassifier> (flowmon.GetClassifier ());
  std::map<FlowId, FlowMonitor::FlowStats> stats = monitor->GetFlowStats ();

  bool found = false;
  for (std::map<FlowId, FlowMonitor::FlowStats>::const_iterator i = stats.begin (); i != stats.end (); ++i)
    {
      Ipv4FlowClassifier::FiveTuple t = classifier->FindFlow (i->first);
      
      NS_LOG_UNCOND ("----------------------------------");
      NS_LOG_UNCOND ("Flow " << i->first << " (" << t.sourceAddress << " -> " << t.destinationAddress << ")");
      NS_LOG_UNCOND ("  Tx Packets: " << i->second.txPackets);
      NS_LOG_UNCOND ("  Rx Packets: " << i->second.rxPackets);
      
      double timeDiff = i->second.timeLastRxPacket.GetSeconds() - i->second.timeFirstTxPacket.GetSeconds();
      
      if (timeDiff > 0) {
          double throughputBps = (i->second.rxBytes * 8.0) / timeDiff; 
          
          if (throughputBps >= 1000000000) {
              NS_LOG_UNCOND ("  Throughput: " << throughputBps / 1000000000 << " Gbps");
          } else if (throughputBps >= 1000000) {
              NS_LOG_UNCOND ("  Throughput: " << throughputBps / 1000000 << " Mbps");
          } else if (throughputBps >= 1000) {
              NS_LOG_UNCOND ("  Throughput: " << throughputBps / 1000 << " Kbps");
          } else {
              NS_LOG_UNCOND ("  Throughput: " << throughputBps << " bps");
          }
      } else {
          NS_LOG_UNCOND ("  Throughput: 0 bps (Not enough packets received)");
      }
      NS_LOG_UNCOND ("----------------------------------");
      found = true;
    }
  if (!found) {
      NS_LOG_UNCOND ("No flows detected! (Check if packets are being dropped or blocked)");
  }

  if (anim) delete anim;
  Simulator::Destroy ();
  return 0;
}
