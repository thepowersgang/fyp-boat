// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-

//
// Hackjob that sends telemetry updates via the Iridium SBD packets to a satellite modem
// 

#include "satellite_telemetry.h"
#include "Rover.h"

IridiumTelemtry::IridiumTelemtry(const Rover& rover_inst):
    m_rover(rover_inst),
    m_iridium(*hal.uartC),  // UART2
    m_ping_interval_min( 120 ),
    m_last_micros( hal.scheduler->micros() ),
    m_ms_since_ping(0),
    m_min_since_ping(0)
{
    // Set a sufficiently-large TX bufffer for a full message (prevents excessive tick times)
    hal.uartC->begin(19200, /*rxSpace=*/128, /*txSpace=*/256);
}

void IridiumTelemtry::update()
{
    switch( m_state )
    {
    case State::Idle:
        if( this->is_time_for_ping() )
        {
            m_iridium.req_wake();
            m_state = State::WaitWake;
        }
        break;
    case State::WaitWake:
        if( m_iridium.update() )
        {
            size_t telem_size = 1;
            m_telem_data[0] ++;
            m_iridium.req_tx_bin(m_telem_data, telem_size);
            m_state = State::WaitTx;
        }
        break;
    case State::WaitTx:
        if( m_iridium.update() )
        {
            m_iridium.req_sleep();
            m_state = State::WaitSleep;
        }
        break;
    case State::WaitSleep:
        if( m_iridium.update() )
        {
            m_ms_since_ping = 0;
            m_min_since_ping = 0;

            m_state = State::Idle;
        }
        break;
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

