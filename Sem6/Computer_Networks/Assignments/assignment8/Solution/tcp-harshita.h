#ifndef TCP_HARSHITA_H
#define TCP_HARSHITA_H

#include "tcp-congestion-ops.h"
#include "ns3/sequence-number.h"
#include "ns3/nstime.h"

namespace ns3
{

class TcpHarshita : public TcpNewReno
{
  public:
   
    enum HaSSDetectionMode : uint8_t
    {
        PACKET_TRAIN = 0x1, 
        DELAY        = 0x2, 
        BOTH         = 0x3, 
    };

    static TypeId GetTypeId();

    TcpHarshita();
    TcpHarshita(const TcpHarshita& sock);
    ~TcpHarshita() override = default;

    std::string          GetName()    const override;
    void                 IncreaseWindow(Ptr<TcpSocketState> tcb,
                                        uint32_t segmentsAcked) override;
    void                 PktsAcked  (Ptr<TcpSocketState> tcb,
                                     uint32_t segmentsAcked,
                                     const Time& rtt) override;
    void                 CongestionStateSet(Ptr<TcpSocketState> tcb,
                                           const TcpSocketState::TcpCongState_t newState) override;
    Ptr<TcpCongestionOps> Fork()     override;

  private:
    // ---- HyStart helpers ----
    void HystartReset (Ptr<const TcpSocketState> tcb);
    void HystartUpdate(Ptr<TcpSocketState>       tcb, const Time& delay);
    Time HystartDelayThresh(const Time& t) const;

    // ---- HyStart configuration attributes ----
    bool              m_hystart          {true};
    HaSSDetectionMode m_hystartDetect    {BOTH};
    uint32_t          m_hystartLowWindow {8};           
    Time              m_hystartAckDelta  {MilliSeconds(2)};
    Time              m_hystartDelayMin  {MilliSeconds(2)};
    Time              m_hystartDelayMax  {MilliSeconds(1000)};
    uint8_t           m_hystartMinSamples{8};

    // ---- HyStart runtime state ----
    bool             m_found      {false};
    Time             m_roundStart {Time::Min()};
    SequenceNumber32 m_endSeq     {};
    Time             m_lastAck   {Time::Min()};
    Time             m_currRtt   {Time::Min()};
    uint32_t         m_sampleCnt {0};
    Time             m_delayMin  {Time::Min()};
};

} // namespace ns3

#endif // TCP_HARSHITA_H
