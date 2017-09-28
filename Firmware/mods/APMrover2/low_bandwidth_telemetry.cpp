
#include "low_bandwidth_telemetry.h"
#include "Rover.h"

LowBandwidthTelemetry::LowBandwidthTelemetry(GCS_MAVLINK& gcs):
    m_gcs(gcs),
    m_ping_interval_min(0),
    m_ping_interval_ms(10000),   // 10s
    m_send_index(0),
    m_last_micros( hal.scheduler->micros() ),
    m_ms_since_ping(0),
    m_min_since_ping(0)
{
}


// Called periodically.
void LowBandwidthTelemetry::update()
{
    static const enum ap_message MESSAGES[] = { MSG_LOCATION, MSG_LOCAL_POSITION, MSG_NAV_CONTROLLER_OUTPUT, MSG_HWSTATUS };
    static const int NUM_MESSAGES = sizeof(MESSAGES) / sizeof(MESSAGES[0]);
    if( this->m_send_index != 0 || this->check_timer() )
    {
        while(this->m_send_index < NUM_MESSAGES)
        {
            // TODO: This is private...
            if( ! this->m_gcs.try_send_message(MESSAGES[this->m_send_index]) )
            {
                break;
            }
            this->m_send_index ++;
        }
        if( this->m_send_index == NUM_MESSAGES )
        {
            this->m_send_index = 0;
            this->reset_timer();
        }
    }
}

bool LowBandwidthTelemetry::check_timer()
{
    uint32_t timer = hal.scheduler->micros();

    uint32_t elapsed = timer - m_last_micros;
    m_last_micros = timer;

    // Count elapsed milliseconds
    while(elapsed >= 1000)
    {
        m_ms_since_ping ++;
        if( m_ms_since_ping == 60000 )
            m_min_since_ping ++;
        elapsed -= 1000;
    }
    // - Offset last_micros by the number of microseconds not converted to whole milliseconds
    m_last_micros -= elapsed;

    // If it's been more minutes since the ping interval, OR it's been the right number of minutes and more ms since the required interval
    // - Allows arbitary intervals
    if( m_min_since_ping > m_ping_interval_min || (m_min_since_ping == m_ping_interval_min && m_ms_since_ping > m_ping_interval_ms) )
    {
        return true;
    }
    else
    {
        return false;
    }
}

void LowBandwidthTelemetry::reset_timer()
{
    m_min_since_ping = 0;
    m_ms_since_ping = 0;
}

