#include "tcp-harshita.h"

#include "ns3/log.h"
#include "ns3/simulator.h"

namespace ns3
{

NS_LOG_COMPONENT_DEFINE("TcpHarshita");
NS_OBJECT_ENSURE_REGISTERED(TcpHarshita);


TypeId
TcpHarshita::GetTypeId()
{
    static TypeId tid =
        TypeId("ns3::TcpHarshita")
            .SetParent<TcpNewReno>()
            .SetGroupName("Internet")
            .AddConstructor<TcpHarshita>()
            // ---- HyStart attributes ----
            .AddAttribute("HyStart",
                          "Enable HyStart hybrid slow-start exit mechanism.",
                          BooleanValue(true),
                          MakeBooleanAccessor(&TcpHarshita::m_hystart),
                          MakeBooleanChecker())
            .AddAttribute("HyStartLowWindow",
                          "Minimum cwnd (segments) required for HyStart to activate.",
                          UintegerValue(8),
                          MakeUintegerAccessor(&TcpHarshita::m_hystartLowWindow),
                          MakeUintegerChecker<uint32_t>())
            .AddAttribute("HyStartDetect",
                          "HyStart detection mode: PACKET_TRAIN, DELAY, or BOTH.",
                          EnumValue(TcpHarshita::BOTH),
                          MakeEnumAccessor<TcpHarshita::HaSSDetectionMode>(
                              &TcpHarshita::m_hystartDetect),
                          MakeEnumChecker(TcpHarshita::PACKET_TRAIN, "PACKET_TRAIN",
                                          TcpHarshita::DELAY,        "DELAY",
                                          TcpHarshita::BOTH,         "BOTH"))
            .AddAttribute("HyStartMinSamples",
                          "RTT samples per round needed for delay-based detection.",
                          UintegerValue(8),
                          MakeUintegerAccessor(&TcpHarshita::m_hystartMinSamples),
                          MakeUintegerChecker<uint8_t>())
            .AddAttribute("HyStartAckDelta",
                          "Maximum inter-ACK spacing that still counts as a 'train'.",
                          TimeValue(MilliSeconds(2)),
                          MakeTimeAccessor(&TcpHarshita::m_hystartAckDelta),
                          MakeTimeChecker())
            .AddAttribute("HyStartDelayMin",
                          "Minimum HyStart delay threshold.",
                          TimeValue(MilliSeconds(2)),
                          MakeTimeAccessor(&TcpHarshita::m_hystartDelayMin),
                          MakeTimeChecker())
            .AddAttribute("HyStartDelayMax",
                          "Maximum HyStart delay threshold.",
                          TimeValue(MilliSeconds(1000)),
                          MakeTimeAccessor(&TcpHarshita::m_hystartDelayMax),
                          MakeTimeChecker());
    return tid;
}

TcpHarshita::TcpHarshita()
    : TcpNewReno(),
      m_hystart(true),
      m_hystartDetect(BOTH),
      m_hystartLowWindow(8),
      m_hystartAckDelta(MilliSeconds(2)),
      m_hystartDelayMin(MilliSeconds(2)),
      m_hystartDelayMax(MilliSeconds(1000)),
      m_hystartMinSamples(8),
      m_found(false),
      m_roundStart(Time::Min()),
      m_endSeq(0),
      m_lastAck(Time::Min()),
      m_currRtt(Time::Min()),
      m_sampleCnt(0),
      m_delayMin(Time::Min())
{
    NS_LOG_FUNCTION(this);
}

TcpHarshita::TcpHarshita(const TcpHarshita& sock)
    : TcpNewReno(sock),
      m_hystart(sock.m_hystart),
      m_hystartDetect(sock.m_hystartDetect),
      m_hystartLowWindow(sock.m_hystartLowWindow),
      m_hystartAckDelta(sock.m_hystartAckDelta),
      m_hystartDelayMin(sock.m_hystartDelayMin),
      m_hystartDelayMax(sock.m_hystartDelayMax),
      m_hystartMinSamples(sock.m_hystartMinSamples),
      m_found(sock.m_found),
      m_roundStart(sock.m_roundStart),
      m_endSeq(sock.m_endSeq),
      m_lastAck(sock.m_lastAck),
      m_currRtt(sock.m_currRtt),
      m_sampleCnt(sock.m_sampleCnt),
      m_delayMin(sock.m_delayMin)
{
    NS_LOG_FUNCTION(this);
}

std::string
TcpHarshita::GetName() const
{
    return "TcpHarshita";
}

void
TcpHarshita::IncreaseWindow(Ptr<TcpSocketState> tcb, uint32_t segmentsAcked)
{
    NS_LOG_FUNCTION(this << tcb << segmentsAcked);

    if (m_hystart && tcb->m_cWnd < tcb->m_ssThresh)
    {
        if (tcb->m_lastAckedSeq > m_endSeq)
        {
            NS_LOG_DEBUG("HyStart: new round (lastAcked=" << tcb->m_lastAckedSeq
                         << " endSeq=" << m_endSeq << "), resetting.");
            HystartReset(tcb);
        }
    }

    TcpNewReno::IncreaseWindow(tcb, segmentsAcked);
}

void
TcpHarshita::PktsAcked(Ptr<TcpSocketState> tcb, uint32_t segmentsAcked, const Time& rtt)
{
    NS_LOG_FUNCTION(this << tcb << segmentsAcked << rtt);

    if (rtt.IsZero())
    {
        return;
    }

    if (m_delayMin == Time::Min() || m_delayMin > rtt)
    {
        m_delayMin = rtt;
    }

    if (m_hystart &&
        tcb->m_cWnd <= tcb->m_ssThresh &&
        tcb->m_cWnd >= m_hystartLowWindow * tcb->m_segmentSize)
    {
        HystartUpdate(tcb, rtt);
    }
}

void
TcpHarshita::CongestionStateSet(Ptr<TcpSocketState> tcb,
                                 const TcpSocketState::TcpCongState_t newState)
{
    NS_LOG_FUNCTION(this << tcb << newState);

    if (newState == TcpSocketState::CA_LOSS)
    {
        m_delayMin = Time::Min();
        m_found    = false;
        HystartReset(tcb);
    }

    TcpNewReno::CongestionStateSet(tcb, newState);
}

Ptr<TcpCongestionOps>
TcpHarshita::Fork()
{
    NS_LOG_FUNCTION(this);
    return CopyObject<TcpHarshita>(this);
}

void
TcpHarshita::HystartReset(Ptr<const TcpSocketState> tcb)
{
    NS_LOG_FUNCTION(this);

    m_roundStart = m_lastAck = Simulator::Now();
    m_endSeq     = tcb->m_highTxMark;
    m_currRtt    = Time::Min();
    m_sampleCnt  = 0;
}

void
TcpHarshita::HystartUpdate(Ptr<TcpSocketState> tcb, const Time& delay)
{
    NS_LOG_FUNCTION(this << delay);

    if (m_found)
    {
        return; 
    }

    Time now = Simulator::Now();

    // ---- Signal 1: ACK-train detection ----
    if ((now - m_lastAck) <= m_hystartAckDelta)
    {
        m_lastAck = now;

        if ((now - m_roundStart) > m_delayMin)
        {
            if (m_hystartDetect == PACKET_TRAIN || m_hystartDetect == BOTH)
            {
                m_found = true;
                NS_LOG_DEBUG("HyStart: ACK-train signal fired at t="
                             << now.GetSeconds() << "s  cwnd=" << tcb->m_cWnd);
            }
        }
    }

    // ---- Signal 2: Delay-based detection ----
    if (m_sampleCnt < m_hystartMinSamples)
    {
        if (m_currRtt == Time::Min() || m_currRtt > delay)
        {
            m_currRtt = delay;
        }
        ++m_sampleCnt;
    }
    else
    {
        if (m_currRtt > m_delayMin + HystartDelayThresh(m_delayMin))
        {
            if (m_hystartDetect == DELAY || m_hystartDetect == BOTH)
            {
                m_found = true;
                NS_LOG_DEBUG("HyStart: Delay signal fired at t="
                             << now.GetSeconds() << "s  cwnd=" << tcb->m_cWnd
                             << "  currRtt=" << m_currRtt.GetMilliSeconds() << "ms"
                             << "  delayMin=" << m_delayMin.GetMilliSeconds() << "ms");
            }
        }
    }

    // ---- Act on detection ----
    if (m_found)
    {
        NS_LOG_INFO("HyStart EXIT slow start: ssThresh = cWnd = " << tcb->m_cWnd);
        tcb->m_ssThresh = tcb->m_cWnd;
    }
}

Time
TcpHarshita::HystartDelayThresh(const Time& t) const
{
    NS_LOG_FUNCTION(this << t);

    if (t > m_hystartDelayMax)
    {
        return m_hystartDelayMax;
    }
    if (t < m_hystartDelayMin)
    {
        return m_hystartDelayMin;
    }
    return t;
}

} // namespace ns3
