#ifndef _LOW_BANDWIDTH_TELEMETRY_H_
#define _LOW_BANDWIDTH_TELEMETRY_H_

#include <stdint.h>

class GCS_MAVLINK;

class LowBandwidthTelemetry
{
    GCS_MAVLINK&  m_gcs;
public:
    LowBandwidthTelemetry(GCS_MAVLINK& gcs);

    void setup();
    void update();

private:
    bool check_timer();
    void reset_timer();

    // Configuration
    const uint32_t m_ping_interval_min;
    const uint32_t m_ping_interval_ms;

    int m_send_index;
    
    uint32_t    m_last_micros;
    uint32_t    m_ms_since_ping;    // Maxes out at 60,000
    uint32_t    m_min_since_ping;   // No programmed upper limit
};

#endif

