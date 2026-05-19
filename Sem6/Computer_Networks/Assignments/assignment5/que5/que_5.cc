#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/applications-module.h"
#include "ns3/netanim-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("Lab5Question5");

int main (int argc, char *argv[])
{
  NodeContainer nodes;
  nodes.Create (2);

  PointToPointHelper p2p;
  p2p.SetDeviceAttribute ("DataRate", StringValue ("5Mbps"));
  p2p.SetChannelAttribute ("Delay", StringValue ("2ms"));

  NetDeviceContainer devices = p2p.Install (nodes);

  InternetStackHelper stack;
  stack.Install (nodes);

  Ipv4AddressHelper ip;
  ip.SetBase ("10.1.1.0", "255.255.255.0");
  Ipv4InterfaceContainer interfaces = ip.Assign (devices);

  uint16_t port1 = 9;

  UdpServerHelper server1 (port1);
  ApplicationContainer s1 = server1.Install (nodes.Get (1));
  s1.Start (Seconds (1.0));
  s1.Stop (Seconds (30.0));

  UdpClientHelper client1 (interfaces.GetAddress (1), port1);
  client1.SetAttribute ("MaxPackets", UintegerValue (100000000)); // Unlimited
  client1.SetAttribute ("Interval", TimeValue (Seconds (0.01)));   // 10ms
  client1.SetAttribute ("PacketSize", UintegerValue (1024));

  ApplicationContainer c1 = client1.Install (nodes.Get (0));
  c1.Start (Seconds (2.0));
  c1.Stop (Seconds (30.0));

  uint16_t port2 = 10;

  UdpEchoServerHelper server2 (port2);
  ApplicationContainer s2 = server2.Install (nodes.Get (1));
  s2.Start (Seconds (1.0));
  s2.Stop (Seconds (30.0));

  UdpEchoClientHelper client2 (interfaces.GetAddress (1), port2);
  client2.SetAttribute ("MaxPackets", UintegerValue (100000000));
  client2.SetAttribute ("Interval", TimeValue (Seconds (0.015)));
  client2.SetAttribute ("PacketSize", UintegerValue (1024));

  ApplicationContainer c2 = client2.Install (nodes.Get (0));
  c2.Start (Seconds (2.5));
  c2.Stop (Seconds (30.0));

  uint16_t port3 = 11;

  UdpServerHelper server3 (port3);
  ApplicationContainer s3 = server3.Install (nodes.Get (1));
  s3.Start (Seconds (1.0));
  s3.Stop (Seconds (30.0));

  UdpClientHelper client3 (interfaces.GetAddress (1), port3);
  client3.SetAttribute ("MaxPackets", UintegerValue (100000000));
  client3.SetAttribute ("Interval", TimeValue (Seconds (0.02)));
  client3.SetAttribute ("PacketSize", UintegerValue (512));

  ApplicationContainer c3 = client3.Install (nodes.Get (0));
  c3.Start (Seconds (3.0));
  c3.Stop (Seconds (30.0));

  p2p.EnablePcapAll ("que5");

  // Generates que_5.xml for NetAnim
  AnimationInterface anim ("que_5.xml");
  anim.SetConstantPosition (nodes.Get (0), 10.0, 10.0);
  anim.SetConstantPosition (nodes.Get (1), 40.0, 10.0);

  Simulator::Stop (Seconds (30.0));
  Simulator::Run ();
  Simulator::Destroy ();
  return 0;
}
