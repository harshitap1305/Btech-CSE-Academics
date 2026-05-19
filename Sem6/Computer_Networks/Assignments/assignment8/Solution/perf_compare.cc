#include <fstream>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/internet-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/stats-module.h"
#include "ns3/tcp-harshita.h"

using namespace ns3;
NS_LOG_COMPONENT_DEFINE("PerfCompare");

class MyApp : public Application
{
  public:
    MyApp() : m_socket(nullptr) {}
    ~MyApp() override { m_socket = nullptr; }

    static TypeId GetTypeId()
    {
        static TypeId tid = TypeId("MyApp")
                                .SetParent<Application>()
                                .SetGroupName("Tutorial")
                                .AddConstructor<MyApp>();
        return tid;
    }

    void Setup(Ptr<Socket> socket, Address address,
               uint32_t packetSize, uint32_t nPackets, DataRate dataRate)
    {
        m_socket     = socket;
        m_peer       = address;
        m_packetSize = packetSize;
        m_nPackets   = nPackets;
        m_dataRate   = dataRate;
    }

  private:
    void StartApplication() override
    {
        m_running     = true;
        m_packetsSent = 0;
        m_socket->Bind();
        m_socket->Connect(m_peer);
        SendPacket();
    }
    void StopApplication() override
    {
        m_running = false;
        if (m_sendEvent.IsPending()) Simulator::Cancel(m_sendEvent);
        if (m_socket) m_socket->Close();
    }
    void SendPacket()
    {
        m_socket->Send(Create<Packet>(m_packetSize));
        if (++m_packetsSent < m_nPackets) ScheduleTx();
    }
    void ScheduleTx()
    {
        if (m_running)
        {
            Time t(Seconds(m_packetSize * 8.0 / m_dataRate.GetBitRate()));
            m_sendEvent = Simulator::Schedule(t, &MyApp::SendPacket, this);
        }
    }

    Ptr<Socket> m_socket;
    Address     m_peer;
    uint32_t    m_packetSize{0};
    uint32_t    m_nPackets{0};
    DataRate    m_dataRate{0};
    EventId     m_sendEvent;
    bool        m_running{false};
    uint32_t    m_packetsSent{0};
};

static void CwndChange(Ptr<OutputStreamWrapper> s, uint32_t o, uint32_t n)
{
    *s->GetStream() << Simulator::Now().GetSeconds()
                    << "\t" << o << "\t" << n << "\n";
}
static void RttChange(Ptr<OutputStreamWrapper> s, Time o, Time n)
{
    *s->GetStream() << Simulator::Now().GetSeconds()
                    << "\t" << o.GetSeconds()
                    << "\t" << n.GetSeconds() << "\n";
}
static void SsthreshChange(Ptr<OutputStreamWrapper> s, uint32_t o, uint32_t n)
{
    *s->GetStream() << Simulator::Now().GetSeconds()
                    << "\t" << o << "\t" << n << "\n";
}

static void ThroughputSample(Ptr<OutputStreamWrapper> s,
                              std::vector<Ptr<PacketSink>> sinks,
                              std::shared_ptr<std::vector<uint64_t>> prevBytes,
                              double interval,
                              double simTime)
{
    double now = Simulator::Now().GetSeconds();
    if (now > simTime) return;   // stop condition

    double total = 0.0;
    for (std::size_t i = 0; i < sinks.size(); ++i)
    {
        uint64_t cur    = sinks[i]->GetTotalRx();
        total          += (cur - (*prevBytes)[i]) * 8.0 / interval / 1e6;
        (*prevBytes)[i] = cur;
    }
    *s->GetStream() << now << "\t" << total << "\n";

    if (now + interval <= simTime)
    {
        Simulator::Schedule(Seconds(interval), &ThroughputSample,
                            s, sinks, prevBytes, interval, simTime);
    }
}

int main(int argc, char* argv[])
{
    uint32_t tcpVariant = 0;    
    double   simTime    = 30.0;
    uint32_t nFlows     = 4;
    double   sampInt    = 0.5;  

    CommandLine cmd(__FILE__);
    cmd.AddValue("tcpVariant", "0=TcpNewReno  1=TcpHarshita", tcpVariant);
    cmd.AddValue("simTime",    "Simulation duration (s)",       simTime);
    cmd.Parse(argc, argv);

    std::string prefix;
    if (tcpVariant == 0)
    {
        Config::SetDefault("ns3::TcpL4Protocol::SocketType",
                           TypeIdValue(TcpNewReno::GetTypeId()));
        prefix = "newreno";
        NS_LOG_UNCOND("Running with TcpNewReno");
    }
    else
    {
        Config::SetDefault("ns3::TcpL4Protocol::SocketType",
                           TypeIdValue(TcpHarshita::GetTypeId()));
        prefix = "harshita";
        NS_LOG_UNCOND("Running with TcpHarshita");
    }

    NodeContainer leftNodes, rightNodes, routers;
    leftNodes.Create(nFlows);
    rightNodes.Create(nFlows);
    routers.Create(2);

    PointToPointHelper leafLink;
    leafLink.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    leafLink.SetChannelAttribute("Delay",   StringValue("2ms"));

    PointToPointHelper bottleneck;
    bottleneck.SetDeviceAttribute("DataRate", StringValue("2Mbps"));
    bottleneck.SetChannelAttribute("Delay",   StringValue("5ms"));

    NetDeviceContainer leftDevs;
    for (uint32_t i = 0; i < nFlows; ++i)
        leftDevs.Add(leafLink.Install(leftNodes.Get(i), routers.Get(0)));

    NetDeviceContainer routerDevs = bottleneck.Install(routers.Get(0), routers.Get(1));

    NetDeviceContainer rightDevs;
    for (uint32_t i = 0; i < nFlows; ++i)
        rightDevs.Add(leafLink.Install(routers.Get(1), rightNodes.Get(i)));

    InternetStackHelper stack;
    stack.Install(leftNodes);
    stack.Install(rightNodes);
    stack.Install(routers);

    Ipv4AddressHelper addr;
    Ipv4InterfaceContainer rightInterfaces; 

    for (uint32_t i = 0; i < nFlows; ++i)
    {
        std::ostringstream ss;
        ss << "10.1." << (i + 1) << ".0";
        addr.SetBase(ss.str().c_str(), "255.255.255.0");
        NetDeviceContainer pair;
        pair.Add(leftDevs.Get(i * 2));     
        pair.Add(leftDevs.Get(i * 2 + 1)); 
        addr.Assign(pair);
    }

    addr.SetBase("10.100.0.0", "255.255.255.0");
    addr.Assign(routerDevs);

    for (uint32_t i = 0; i < nFlows; ++i)
    {
        std::ostringstream ss;
        ss << "10.2." << (i + 1) << ".0";
        addr.SetBase(ss.str().c_str(), "255.255.255.0");
        NetDeviceContainer pair;
        pair.Add(rightDevs.Get(i * 2));      
        pair.Add(rightDevs.Get(i * 2 + 1)); 
        Ipv4InterfaceContainer ifc = addr.Assign(pair);
        rightInterfaces.Add(ifc.Get(1));   
    }

    Ipv4GlobalRoutingHelper::PopulateRoutingTables();

    // ---- Sinks ----
    uint16_t basePort = 9000;
    std::vector<Ptr<PacketSink>> sinks(nFlows);
    for (uint32_t i = 0; i < nFlows; ++i)
    {
        uint16_t port = basePort + i;
        PacketSinkHelper sinkHelper(
            "ns3::TcpSocketFactory",
            InetSocketAddress(Ipv4Address::GetAny(), port));
        ApplicationContainer sinkApp = sinkHelper.Install(rightNodes.Get(i));
        sinkApp.Start(Seconds(0.0));
        sinkApp.Stop(Seconds(simTime));
        sinks[i] = DynamicCast<PacketSink>(sinkApp.Get(0));
    }

    // ---- Flow 0: MyApp with socket trace ----
    Ptr<Socket> tracedSocket =
        Socket::CreateSocket(leftNodes.Get(0), TcpSocketFactory::GetTypeId());
    {
        Address sinkAddr(InetSocketAddress(rightInterfaces.GetAddress(0), basePort));
        Ptr<MyApp> app = CreateObject<MyApp>();
        app->Setup(tracedSocket, sinkAddr, 1040, 10000000, DataRate("5Mbps"));
        leftNodes.Get(0)->AddApplication(app);
        app->SetStartTime(Seconds(1.0));
        app->SetStopTime(Seconds(simTime));
    }

    // ---- Flows 1..N-1: OnOffHelper ----
    for (uint32_t i = 1; i < nFlows; ++i)
    {
        uint16_t port = basePort + i;
        Address  sinkAddr(InetSocketAddress(rightInterfaces.GetAddress(i), port));

        OnOffHelper client("ns3::TcpSocketFactory", sinkAddr);
        client.SetAttribute("OnTime",
                            StringValue("ns3::ConstantRandomVariable[Constant=1]"));
        client.SetAttribute("OffTime",
                            StringValue("ns3::ConstantRandomVariable[Constant=0]"));
        client.SetAttribute("DataRate",   DataRateValue(DataRate("5Mbps")));
        client.SetAttribute("PacketSize", UintegerValue(1040));

        ApplicationContainer cApp = client.Install(leftNodes.Get(i));
        cApp.Start(Seconds(1.0 + 0.1 * i));
        cApp.Stop(Seconds(simTime));
    }

    // ---- Socket traces (flow 0 only) ----
    AsciiTraceHelper ascii;

    auto cwndStream = ascii.CreateFileStream(prefix + "-cwnd.txt");
    tracedSocket->TraceConnectWithoutContext(
        "CongestionWindow", MakeBoundCallback(&CwndChange, cwndStream));

    auto ssthStream = ascii.CreateFileStream(prefix + "-ssthresh.txt");
    tracedSocket->TraceConnectWithoutContext(
        "SlowStartThreshold", MakeBoundCallback(&SsthreshChange, ssthStream));

    auto rttStream = ascii.CreateFileStream(prefix + "-rtt.txt");
    tracedSocket->TraceConnectWithoutContext(
        "RTT", MakeBoundCallback(&RttChange, rttStream));

    // ---- Periodic throughput ----
    auto tputStream = ascii.CreateFileStream(prefix + "-throughput.txt");
    auto prevBytes = std::make_shared<std::vector<uint64_t>>(nFlows, 0);
    Simulator::Schedule(Seconds(sampInt), &ThroughputSample,
                        tputStream, sinks, prevBytes, sampInt, simTime);

    // ---- Run ----
    Simulator::Stop(Seconds(simTime + 0.5));
    Simulator::Run();
    Simulator::Destroy();

    // ---- Summary ----
    double measWindow = simTime - 1.0;
    double total = 0.0;
    NS_LOG_UNCOND("\n===== Final Per-Flow Throughput [" << prefix << "] =====");
    for (uint32_t i = 0; i < nFlows; ++i)
    {
        double mbps = sinks[i]->GetTotalRx() * 8.0 / measWindow / 1e6;
        NS_LOG_UNCOND("  Flow " << i << ": " << mbps << " Mbps");
        total += mbps;
    }
    NS_LOG_UNCOND("  Total : " << total << " Mbps");

    return 0;
}
