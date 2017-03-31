#ifndef _SATELLITE_TELEMETRY_H_
#define _SATELLITE_TELEMETRY_H_

#include <stdint.h>
#include <UWA_IridiumSBD/UWA_IridiumSBD.h>

class Rover;

class IridiumTelemtry
{
    const Rover& m_rover;
    UWA_IridiumSBD  m_iridium;
public:
    IridiumTelemtry(const Rover& rover);

    void update();

private:
    bool is_time_for_ping();

    // Configuration
    const uint32_t m_ping_interval_min;
    
    uint8_t m_telem_data[128];
    
    uint32_t    m_last_micros;
    uint32_t    m_ms_since_ping;    // Maxes out at 60,000
    uint32_t    m_min_since_ping;   // No programmed upper limit

    enum class State
    {
        Idle,
        WaitWake,
        WaitTx,
        WaitSleep,
    } m_state;
};

#endif
