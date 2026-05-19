#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/applications-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("Lab5Que4");

int
main (int argc, char *argv[])
{
 
  NodeContainer nodes;
  nodes.Create (2);

  PointToPointHelper pointToPoint;
  pointToPoint.SetDeviceAttribute ("DataRate", StringValue ("5Mbps"));
  pointToPoint.SetChannelAttribute ("Delay", StringValue ("2ms"));

  NetDeviceContainer devices;
  devices = pointToPoint.Install (nodes);

  InternetStackHelper stack;
  stack.Install (nodes);

  Ipv4AddressHelper address;
  address.SetBase ("10.1.1.0", "255.255.255.0");
  Ipv4InterfaceContainer interfaces = address.Assign (devices);

  uint16_t port1 = 9;

  UdpServerHelper server1 (port1);
  ApplicationContainer serverApps1 = server1.Install (nodes.Get (1));
  serverApps1.Start (Seconds (1.0));
  serverApps1.Stop (Seconds (10.0));

  UdpClientHelper client1 (interfaces.GetAddress (1), port1);
  client1.SetAttribute ("MaxPackets", UintegerValue (320));
  client1.SetAttribute ("Interval", TimeValue (Seconds (0.05)));
  client1.SetAttribute ("PacketSize", UintegerValue (1024));

  ApplicationContainer clientApps1 = client1.Install (nodes.Get (0));
  clientApps1.Start (Seconds (2.0));
  clientApps1.Stop (Seconds (10.0));

  uint16_t port2 = 10;

  UdpEchoServerHelper server2 (port2);
  ApplicationContainer serverApps2 = server2.Install (nodes.Get (1));
  serverApps2.Start (Seconds (1.0));
  serverApps2.Stop (Seconds (10.0));

  UdpEchoClientHelper client2 (interfaces.GetAddress (1), port2);
  client2.SetAttribute ("MaxPackets", UintegerValue (5)); // Send 5 echo packets
  client2.SetAttribute ("Interval", TimeValue (Seconds (1.0)));
  client2.SetAttribute ("PacketSize", UintegerValue (1024));

  ApplicationContainer clientApps2 = client2.Install (nodes.Get (0));
  clientApps2.Start (Seconds (2.0));
  clientApps2.Stop (Seconds (10.0));
  

  pointToPoint.EnablePcapAll ("que4");

  NS_LOG_UNCOND ("Que 4: Running Two Applications.");
  NS_LOG_UNCOND ("  1. Standard UDP Flow on Port " << port1);
  NS_LOG_UNCOND ("  2. UDP Echo Flow on Port " << port2 << " (No Conflict)");
  NS_LOG_UNCOND ("  PCAP traces enabled (prefix: que4)");

  Simulator::Run ();
  Simulator::Destroy ();
  return 0;
}
