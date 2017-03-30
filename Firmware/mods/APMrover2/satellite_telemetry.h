#ifndef _SATELLITE_TELEMETRY_H_
#define _SATELLITE_TELEMETRY_H_

#include <stdint.h>

class Rover;

class IridiumTelemtry
{
    const Rover& m_rover;
public:
    IridiumTelemtry(const Rover& rover);

    bool maybe_send_ping();

private:
    bool is_time_for_ping();
    void send_ping();

    // Configuration
    const uint32_t m_ping_interval_min;
    
    uint32_t    m_last_micros;
    uint32_t    m_ms_since_ping;    // Maxes out at 60,000
    uint32_t    m_min_since_ping;   // No programmed upper limit
};

#endif
