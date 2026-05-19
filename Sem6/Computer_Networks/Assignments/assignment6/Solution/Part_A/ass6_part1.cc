#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/applications-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/flow-monitor-module.h"
#include "ns3/netanim-module.h"

using namespace ns3;

int main(int argc, char *argv[])
{
    Time::SetResolution(Time::NS);

    // -------------------- CREATE NODES --------------------

    NodeContainer left;     // n0,n1,n2
    left.Create(3);

    NodeContainer right1;   // n3,n4,n5
    right1.Create(3);

    NodeContainer right2;   // n6,n7
    right2.Create(2);

    NodeContainer routers;  // router0, router1, router2
    routers.Create(3);

    // -------------------- INTERNET STACK --------------------

    InternetStackHelper stack;
    stack.Install(left);
    stack.Install(right1);
    stack.Install(right2);
    stack.Install(routers);

    // -------------------- LINK CONFIG --------------------

    PointToPointHelper access;
    access.SetDeviceAttribute("DataRate", StringValue("10Mbps"));
    access.SetChannelAttribute("Delay", StringValue("2ms"));

    PointToPointHelper r0r1;
    r0r1.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    r0r1.SetChannelAttribute("Delay", StringValue("10ms"));

    PointToPointHelper r0r2;
    r0r2.SetDeviceAttribute("DataRate", StringValue("2Mbps"));
    r0r2.SetChannelAttribute("Delay", StringValue("20ms"));

    // -------------------- INSTALL LINKS --------------------

    NetDeviceContainer d_n0 = access.Install(left.Get(0), routers.Get(0));
    NetDeviceContainer d_n1 = access.Install(left.Get(1), routers.Get(0));
    NetDeviceContainer d_n2 = access.Install(left.Get(2), routers.Get(0));

    NetDeviceContainer d_r0r1 = r0r1.Install(routers.Get(0), routers.Get(1));
    NetDeviceContainer d_r0r2 = r0r2.Install(routers.Get(0), routers.Get(2));

    NetDeviceContainer d_n3 = access.Install(right1.Get(0), routers.Get(1));
    NetDeviceContainer d_n4 = access.Install(right1.Get(1), routers.Get(1));
    NetDeviceContainer d_n5 = access.Install(right1.Get(2), routers.Get(1));

    NetDeviceContainer d_n6 = access.Install(right2.Get(0), routers.Get(2));
    NetDeviceContainer d_n7 = access.Install(right2.Get(1), routers.Get(2));

    // -------------------- IP ASSIGNMENT --------------------

    Ipv4AddressHelper address;

    address.SetBase("10.0.1.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n0 = address.Assign(d_n0);

    address.SetBase("10.0.2.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n1 = address.Assign(d_n1);

    address.SetBase("10.0.3.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n2 = address.Assign(d_n2);

    address.SetBase("10.0.4.0", "255.255.255.0");
    Ipv4InterfaceContainer i_r0r1 = address.Assign(d_r0r1);

    address.SetBase("10.0.5.0", "255.255.255.0");
    Ipv4InterfaceContainer i_r0r2 = address.Assign(d_r0r2);

    address.SetBase("10.0.6.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n3 = address.Assign(d_n3);

    address.SetBase("10.0.7.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n4 = address.Assign(d_n4);

    address.SetBase("10.0.8.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n5 = address.Assign(d_n5);

    address.SetBase("10.0.9.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n6 = address.Assign(d_n6);

    address.SetBase("10.0.10.0", "255.255.255.0");
    Ipv4InterfaceContainer i_n7 = address.Assign(d_n7);

    // -------------------- ROUTING --------------------

    Ipv4GlobalRoutingHelper::PopulateRoutingTables();

    Ptr<OutputStreamWrapper> routingStream =
        Create<OutputStreamWrapper>("routing-tables.txt", std::ios::out);

    Ipv4GlobalRoutingHelper g;
    g.PrintRoutingTableAllAt(Seconds(0.5), routingStream);

    // -------------------- TCP n7 -> n4 --------------------

    uint16_t port1 = 5000;

    PacketSinkHelper sink1("ns3::TcpSocketFactory",
        InetSocketAddress(Ipv4Address::GetAny(), port1));

    ApplicationContainer appSink1 = sink1.Install(right1.Get(1));
    appSink1.Start(Seconds(1.0));
    appSink1.Stop(Seconds(10.0));

    OnOffHelper client1("ns3::TcpSocketFactory",
        InetSocketAddress(i_n4.GetAddress(0), port1));

    client1.SetAttribute("OnTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    client1.SetAttribute("OffTime", StringValue("ns3::ConstantRandomVariable[Constant=0]"));
    client1.SetAttribute("DataRate", DataRateValue(DataRate("1Mbps")));
    client1.SetAttribute("PacketSize", UintegerValue(1024));

    ApplicationContainer appClient1 = client1.Install(right2.Get(1));
    appClient1.Start(Seconds(2.0));
    appClient1.Stop(Seconds(10.0));

    // -------------------- UDP n1 -> n5 --------------------

    uint16_t port2 = 6000;

    PacketSinkHelper sink2("ns3::UdpSocketFactory",
        InetSocketAddress(Ipv4Address::GetAny(), port2));

    ApplicationContainer appSink2 = sink2.Install(right1.Get(2));
    appSink2.Start(Seconds(1.0));
    appSink2.Stop(Seconds(10.0));

    OnOffHelper client2("ns3::UdpSocketFactory",
        InetSocketAddress(i_n5.GetAddress(0), port2));

    client2.SetAttribute("OnTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
    client2.SetAttribute("OffTime", StringValue("ns3::ConstantRandomVariable[Constant=0]"));
    client2.SetAttribute("DataRate", DataRateValue(DataRate("500kbps")));
    client2.SetAttribute("PacketSize", UintegerValue(1024));

    ApplicationContainer appClient2 = client2.Install(left.Get(1));
    appClient2.Start(Seconds(2.0));
    appClient2.Stop(Seconds(10.0));

    // -------------------- TCP n2 -> n6 --------------------

    uint16_t port3 = 7000;

    PacketSinkHelper sink3("ns3::TcpSocketFactory",
        InetSocketAddress(Ipv4Address::GetAny(), port3));

    ApplicationContainer appSink3 = sink3.Install(right2.Get(0));
    appSink3.Start(Seconds(1.0));
    appSink3.Stop(Seconds(10.0));

    OnOffHelper client3("ns3::TcpSocketFactory",
        InetSocketAddress(i_n6.GetAddress(0), port3));

    client3.SetAttribute("DataRate", DataRateValue(DataRate("2Mbps")));
    client3.SetAttribute("PacketSize", UintegerValue(1024));

    ApplicationContainer appClient3 = client3.Install(left.Get(2));
    appClient3.Start(Seconds(2.0));
    appClient3.Stop(Seconds(10.0));

    // -------------------- TCP n0 -> n3 --------------------

    uint16_t port4 = 8000;

    PacketSinkHelper sink4("ns3::TcpSocketFactory",
        InetSocketAddress(Ipv4Address::GetAny(), port4));

    ApplicationContainer appSink4 = sink4.Install(right1.Get(0));
    appSink4.Start(Seconds(1.0));
    appSink4.Stop(Seconds(10.0));

    OnOffHelper client4("ns3::TcpSocketFactory",
        InetSocketAddress(i_n3.GetAddress(0), port4));

    client4.SetAttribute("DataRate", DataRateValue(DataRate("3Mbps")));
    client4.SetAttribute("PacketSize", UintegerValue(1024));

    ApplicationContainer appClient4 = client4.Install(left.Get(0));
    appClient4.Start(Seconds(2.0));
    appClient4.Stop(Seconds(10.0));

    // -------------------- FLOW MONITOR --------------------

    FlowMonitorHelper flowmon;
    Ptr<FlowMonitor> monitor = flowmon.InstallAll();

    // -------------------- PCAP --------------------

    access.EnablePcapAll("assignment6");

    // -------------------- NETANIM --------------------

    AnimationInterface anim("assignment6_partA.xml");
    anim.SetConstantPosition(left.Get(0), 10, 50);
anim.SetConstantPosition(left.Get(1), 10, 40);
anim.SetConstantPosition(left.Get(2), 10, 30);

anim.SetConstantPosition(routers.Get(0), 30, 40);
anim.SetConstantPosition(routers.Get(1), 50, 50);
anim.SetConstantPosition(routers.Get(2), 50, 30);

anim.SetConstantPosition(right1.Get(0), 70, 60);
anim.SetConstantPosition(right1.Get(1), 70, 50);
anim.SetConstantPosition(right1.Get(2), 70, 40);

anim.SetConstantPosition(right2.Get(0), 70, 30);
anim.SetConstantPosition(right2.Get(1), 70, 20);

    // -------------------- RUN --------------------

    Simulator::Stop(Seconds(10.0));
    Simulator::Run();

    monitor->SerializeToXmlFile("flowmon.xml", true, true);

    Simulator::Destroy();

    return 0;
}
