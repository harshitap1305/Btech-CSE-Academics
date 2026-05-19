#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/applications-module.h"
#include "ns3/error-model.h"
#include "ns3/flow-monitor-module.h"

using namespace ns3;

// Global counter for dropped packets 
uint32_t g_dropCount = 0;

static void RxDrop(Ptr<const Packet> p)
{
    g_dropCount++;
}

int main(int argc, char *argv[])
{
    double errorRate = 0.0;
    int rngRun = 1;
    std::string errorUnit = "ERROR_UNIT_PACKET"; 

    CommandLine cmd;
    cmd.AddValue("errorRate", "Error rate for RateErrorModel", errorRate);
    cmd.AddValue("errorUnit", "Error unit (ERROR_UNIT_PACKET, ERROR_UNIT_BIT, ERROR_UNIT_BYTE)", errorUnit);
    cmd.AddValue("RngRun", "Seed run value", rngRun);
    cmd.Parse(argc, argv);

    RngSeedManager::SetRun(rngRun);

    // ---------------- NODE CREATION ----------------
    NodeContainer left;     left.Create(3);
    NodeContainer right1;   right1.Create(3);
    NodeContainer right2;   right2.Create(2);
    NodeContainer routers;  routers.Create(3);

    InternetStackHelper stack;
    stack.Install(left);
    stack.Install(right1);
    stack.Install(right2);
    stack.Install(routers);

    // ---------------- LINK CONFIG ----------------
    PointToPointHelper access;
    access.SetDeviceAttribute("DataRate", StringValue("10Mbps"));
    access.SetChannelAttribute("Delay", StringValue("2ms"));

    PointToPointHelper r0r1;
    r0r1.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    r0r1.SetChannelAttribute("Delay", StringValue("10ms"));

    PointToPointHelper r0r2;
    r0r2.SetDeviceAttribute("DataRate", StringValue("2Mbps"));
    r0r2.SetChannelAttribute("Delay", StringValue("20ms"));

    // ---------------- INSTALL LINKS ----------------
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

    // ---------------- IP ASSIGNMENT ----------------
    Ipv4AddressHelper address;

    address.SetBase("10.0.1.0","255.255.255.0"); Ipv4InterfaceContainer i_n0 = address.Assign(d_n0);
    address.SetBase("10.0.2.0","255.255.255.0"); Ipv4InterfaceContainer i_n1 = address.Assign(d_n1);
    address.SetBase("10.0.3.0","255.255.255.0"); Ipv4InterfaceContainer i_n2 = address.Assign(d_n2);
    address.SetBase("10.0.4.0","255.255.255.0"); Ipv4InterfaceContainer i_r0r1 = address.Assign(d_r0r1);
    address.SetBase("10.0.5.0","255.255.255.0"); Ipv4InterfaceContainer i_r0r2 = address.Assign(d_r0r2);
    address.SetBase("10.0.6.0","255.255.255.0"); Ipv4InterfaceContainer i_n3 = address.Assign(d_n3);
    address.SetBase("10.0.7.0","255.255.255.0"); Ipv4InterfaceContainer i_n4 = address.Assign(d_n4);
    address.SetBase("10.0.8.0","255.255.255.0"); Ipv4InterfaceContainer i_n5 = address.Assign(d_n5);
    address.SetBase("10.0.9.0","255.255.255.0"); Ipv4InterfaceContainer i_n6 = address.Assign(d_n6);
    address.SetBase("10.0.10.0","255.255.255.0"); Ipv4InterfaceContainer i_n7 = address.Assign(d_n7);

    Ipv4GlobalRoutingHelper::PopulateRoutingTables();

    // ---------------- UNIQUE ERROR MODELS ----------------
    ObjectFactory factory;
    factory.SetTypeId("ns3::RateErrorModel");
    factory.Set("ErrorRate", DoubleValue(errorRate));
    factory.Set("ErrorUnit", StringValue(errorUnit)); 

    Ptr<ErrorModel> em1 = factory.Create<ErrorModel>();
    Ptr<ErrorModel> em2 = factory.Create<ErrorModel>();
    Ptr<ErrorModel> em3 = factory.Create<ErrorModel>();
    Ptr<ErrorModel> em4 = factory.Create<ErrorModel>();

    d_r0r1.Get(0)->SetAttribute("ReceiveErrorModel", PointerValue(em1));
    d_r0r1.Get(1)->SetAttribute("ReceiveErrorModel", PointerValue(em2));
    d_r0r2.Get(0)->SetAttribute("ReceiveErrorModel", PointerValue(em3));
    d_r0r2.Get(1)->SetAttribute("ReceiveErrorModel", PointerValue(em4));

    // Connect drop tracing
    d_r0r1.Get(0)->TraceConnectWithoutContext("PhyRxDrop", MakeCallback(&RxDrop));
    d_r0r1.Get(1)->TraceConnectWithoutContext("PhyRxDrop", MakeCallback(&RxDrop));
    d_r0r2.Get(0)->TraceConnectWithoutContext("PhyRxDrop", MakeCallback(&RxDrop));
    d_r0r2.Get(1)->TraceConnectWithoutContext("PhyRxDrop", MakeCallback(&RxDrop));

    // ---------------- UDP ECHO FLOWS ----------------
    uint32_t packetSize = 1024;
    uint32_t maxPackets = 100;
    Time interval = Seconds(0.05);

    // Flow 1: n7 -> n4
    uint16_t port1 = 5000;
    UdpEchoServerHelper server1(port1);
    ApplicationContainer s1 = server1.Install(right1.Get(1)); // n4
    s1.Start(Seconds(1)); s1.Stop(Seconds(10));

    UdpEchoClientHelper client1(i_n4.GetAddress(0), port1);
    client1.SetAttribute("MaxPackets", UintegerValue(maxPackets));
    client1.SetAttribute("Interval", TimeValue(interval));
    client1.SetAttribute("PacketSize", UintegerValue(packetSize));
    ApplicationContainer c1 = client1.Install(right2.Get(1)); // n7
    c1.Start(Seconds(2)); c1.Stop(Seconds(10));

    // Flow 2: n1 -> n5
    uint16_t port2 = 6000;
    UdpEchoServerHelper server2(port2);
    ApplicationContainer s2 = server2.Install(right1.Get(2)); // n5
    s2.Start(Seconds(1)); s2.Stop(Seconds(10));

    UdpEchoClientHelper client2(i_n5.GetAddress(0), port2);
    client2.SetAttribute("MaxPackets", UintegerValue(maxPackets));
    client2.SetAttribute("Interval", TimeValue(interval));
    client2.SetAttribute("PacketSize", UintegerValue(packetSize));
    ApplicationContainer c2 = client2.Install(left.Get(1)); // n1
    c2.Start(Seconds(2)); c2.Stop(Seconds(10));

    // Flow 3: n2 -> n6
    uint16_t port3 = 7000;
    UdpEchoServerHelper server3(port3);
    ApplicationContainer s3 = server3.Install(right2.Get(0)); // n6
    s3.Start(Seconds(1)); s3.Stop(Seconds(10));

    UdpEchoClientHelper client3(i_n6.GetAddress(0), port3);
    client3.SetAttribute("MaxPackets", UintegerValue(maxPackets));
    client3.SetAttribute("Interval", TimeValue(interval));
    client3.SetAttribute("PacketSize", UintegerValue(packetSize));
    ApplicationContainer c3 = client3.Install(left.Get(2)); // n2
    c3.Start(Seconds(2)); c3.Stop(Seconds(10));

    // Flow 4: n0 -> n3
    uint16_t port4 = 8000;
    UdpEchoServerHelper server4(port4);
    ApplicationContainer s4 = server4.Install(right1.Get(0)); // n3
    s4.Start(Seconds(1)); s4.Stop(Seconds(10));

    UdpEchoClientHelper client4(i_n3.GetAddress(0), port4);
    client4.SetAttribute("MaxPackets", UintegerValue(maxPackets));
    client4.SetAttribute("Interval", TimeValue(interval));
    client4.SetAttribute("PacketSize", UintegerValue(packetSize));
    ApplicationContainer c4 = client4.Install(left.Get(0)); // n0
    c4.Start(Seconds(2)); c4.Stop(Seconds(10));

    // ---------------- PDR MEASUREMENT ----------------
    FlowMonitorHelper flowmon;
    Ptr<FlowMonitor> monitor = flowmon.InstallAll();

    // ---------------- RUN ----------------
    Simulator::Stop(Seconds(10));
    Simulator::Run();

    uint64_t R_Total = 0;
    uint64_t T_Total = 0;
    
    std::map<FlowId, FlowMonitor::FlowStats> stats = monitor->GetFlowStats();
    for (auto const &stat : stats) {
        T_Total += stat.second.txPackets;
        R_Total += stat.second.rxPackets;
    }
    
    double pdr = 0.0;
    if (T_Total > 0) {
        pdr = (double)R_Total / (double)T_Total;
    }

    // Output just the PDR value to stdout so our python automation script can easily read it
    std::cout << pdr << std::endl;

    Simulator::Destroy();

    return 0;
}
