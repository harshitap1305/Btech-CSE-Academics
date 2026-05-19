#include <cmath>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/internet-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/tcp-harshita.h"

using namespace ns3;
NS_LOG_COMPONENT_DEFINE("FairnessEval");

double
JainFairnessIndex(const std::vector<double>& x)
{
    double sumX = 0.0, sumX2 = 0.0;
    for (double v : x) { sumX += v; sumX2 += v * v; }
    if (sumX2 == 0.0) return 1.0;
    return (sumX * sumX) / (static_cast<double>(x.size()) * sumX2);
}

int
main(int argc, char* argv[])
{
    uint32_t nFlows  = 4;
    uint32_t mixed   = 0;    // 0 = all NewReno, 1 = half NewReno + half Harshita
    double   simTime = 30.0;

    CommandLine cmd(__FILE__);
    cmd.AddValue("nFlows",  "Total TCP flows (4/8/16/20)",         nFlows);
    cmd.AddValue("mixed",   "0=all NewReno  1=half Harshita",      mixed);
    cmd.AddValue("simTime", "Simulation duration (s)",              simTime);
    cmd.Parse(argc, argv);

    std::string scenario = (mixed == 0) ? "allnewreno" : "mixed";
    NS_LOG_UNCOND("=== Fairness Eval: nFlows=" << nFlows
                  << "  scenario=" << scenario << " ===");

    // ---- Topology ----
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

    NetDeviceContainer routerDevs =
        bottleneck.Install(routers.Get(0), routers.Get(1));

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
        pair.Add(rightDevs.Get(i * 2));      // R1 device
        pair.Add(rightDevs.Get(i * 2 + 1)); // rightNode[i] device
        Ipv4InterfaceContainer ifc = addr.Assign(pair);
        rightInterfaces.Add(ifc.Get(1));    // rightNode's IP
    }

    Ipv4GlobalRoutingHelper::PopulateRoutingTables();

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

    uint32_t nNewReno  = (mixed == 0) ? nFlows : (nFlows / 2);
    uint32_t nHarshita = nFlows - nNewReno;

    auto installSender = [&](uint32_t flowIdx, TypeId cca)
    {
        std::ostringstream nodePath;
        nodePath << "/NodeList/" << leftNodes.Get(flowIdx)->GetId()
                 << "/$ns3::TcpL4Protocol/SocketType";
        Config::Set(nodePath.str(), TypeIdValue(cca));

        NS_LOG_UNCOND("  Flow " << flowIdx << " → node "
                      << leftNodes.Get(flowIdx)->GetId()
                      << " CCA: "
                      << (cca == TcpNewReno::GetTypeId() ? "TcpNewReno" : "TcpHarshita"));

        uint16_t port = basePort + flowIdx;
        Address  sinkAddr(InetSocketAddress(
            rightInterfaces.GetAddress(flowIdx), port));

        OnOffHelper client("ns3::TcpSocketFactory", sinkAddr);
        client.SetAttribute("OnTime",
                            StringValue("ns3::ConstantRandomVariable[Constant=1]"));
        client.SetAttribute("OffTime",
                            StringValue("ns3::ConstantRandomVariable[Constant=0]"));
        client.SetAttribute("DataRate",   DataRateValue(DataRate("5Mbps")));
        client.SetAttribute("PacketSize", UintegerValue(1040));

        ApplicationContainer cApp = client.Install(leftNodes.Get(flowIdx));
        cApp.Start(Seconds(1.0 + 0.05 * flowIdx));
        cApp.Stop(Seconds(simTime));
    };

    NS_LOG_UNCOND("CCA assignments:");

    for (uint32_t i = 0; i < nNewReno; ++i)
        installSender(i, TcpNewReno::GetTypeId());

    for (uint32_t i = nNewReno; i < nNewReno + nHarshita; ++i)
        installSender(i, TcpHarshita::GetTypeId());

   
    Simulator::Stop(Seconds(simTime + 0.5));
    Simulator::Run();
    Simulator::Destroy();

    double measWindow = simTime - 1.0;
    std::vector<double> throughputs(nFlows);
    for (uint32_t i = 0; i < nFlows; ++i)
        throughputs[i] = sinks[i]->GetTotalRx() * 8.0 / measWindow / 1e6;

    double jfi = JainFairnessIndex(throughputs);

    std::ostringstream fname;
    fname << "fairness-" << nFlows << "-" << scenario << ".txt";
    {
        std::ofstream ofs(fname.str());
        ofs << "# flowId  type  bytes  throughput_Mbps\n";
        for (uint32_t i = 0; i < nFlows; ++i)
        {
            std::string type = (i < nNewReno) ? "NewReno" : "Harshita";
            ofs << i << "\t" << type << "\t"
                << sinks[i]->GetTotalRx() << "\t"
                << throughputs[i] << "\n";
        }
        ofs << "JAIN_INDEX\t" << jfi << "\n";
    }

    NS_LOG_UNCOND("\n  Per-flow throughputs (Mbps):");
    for (uint32_t i = 0; i < nFlows; ++i)
    {
        std::string type = (i < nNewReno) ? "NewReno " : "Harshita";
        NS_LOG_UNCOND("    Flow " << i << " [" << type << "]: "
                      << throughputs[i] << " Mbps");
    }
    NS_LOG_UNCOND("  Jain's Fairness Index = " << jfi);
    NS_LOG_UNCOND("  Output written to: " << fname.str());

    return 0;
}
