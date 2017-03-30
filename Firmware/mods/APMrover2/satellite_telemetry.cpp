// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-

#include "satellite_telemetry.h"
#include "Rover.h"

IridiumTelemtry::IridiumTelemtry(const Rover& rover_inst):
    m_rover(rover_inst),
    m_ping_interval_min( 120 ),
    m_last_micros( hal.scheduler->micros() ),
    m_ms_since_ping(0),
    m_min_since_ping(0)
{
}

bool IridiumTelemtry::maybe_send_ping()
{
    // This is called quite often, reduce the rate.
    if( this->is_time_for_ping() )
    {
        this->send_ping();
        return true;
    }
    else
    {
        return false;
    }
}

bool IridiumTelemtry::is_time_for_ping()
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

    if( m_min_since_ping >= m_ping_interval_min )
    {
        return true;
    }
    else
    {
        return false;
    }
}

void IridiumTelemtry::send_ping()
{
    // 1. Enable radio
    
    m_ms_since_ping = 0;
    m_min_since_ping = 0;
}

