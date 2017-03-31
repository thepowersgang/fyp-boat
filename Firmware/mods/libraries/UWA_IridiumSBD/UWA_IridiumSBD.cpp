/*
 * ArduPilot library providing telemetry updates via the Iridium sattelite network
 *
 * Based on the IridiumSBD libray (http://arduiniana.org/libraries/iridiumsbd/) and structured
 * to run within the APM codebase
 *
 * Note: The modem used by The UWA EE project is 19200 baud by default.
 */
#include "UWA_IridiumSBD.h"
#include <ctype.h>
#include <stdlib.h>

extern const AP_HAL::HAL& hal;

UWA_IridiumSBD::UWA_IridiumSBD(AP_HAL::BetterStream& serial, int sleep_pin):
    m_serial(serial),
    m_sleep_pin(sleep_pin),
    
    m_wait_for_at(serial)
{
}

bool UWA_IridiumSBD::update()
{
    switch(m_state)
    {
    case State::Idle:
        // Nothing to do
        break;
    case State::Error:
        // Nothing to do
        break;

    case State::WakingTimeout:
        if( m_timed_waiter.update() )
        {
            // Timed waiter complete.

            // - Give the modem a few mins to warm up. (wait, what?)
            m_timed_waiter.start( 240l * 1000 * 1000 ); // ISBD_STARTUP_MAX_TIME
            
            // - Send "AT\r"
            m_serial.print_P(PSTR("AT\r"));
            // - Wait for a reply
            m_wait_for_at.init();

            m_state = State::WakingWaitForAT;
        }
        break;
    case State::WakingWaitForAT:
        if( m_wait_for_at.update() )
        {
            if( ! m_wait_for_at.is_error() )
            {
                // Modem is alive!

                // - Send 'ATE1'
                m_serial.print_P(PSTR("ATE1\r"));
                m_wait_for_at.init();
                m_state = State::WakingSendInit0;
            }
            else
            {
                // Timeout on m_wait_for_at, try again
                m_wait_for_at.clear_error();
                m_serial.print_P(PSTR("AT\r"));
                m_wait_for_at.init();
            }
        }
        else if( m_timed_waiter.update() )
        {
            // Wake timed out, enter error state
            m_state = State::Error;
        }
        else
        {
            // No update, continue on
        }
        break;
    case State::WakingSendInit0:
        if( m_wait_for_at.update() )
        {
            if( ! m_wait_for_at.is_error() )
            {
                m_serial.print_P(PSTR("AT&D0\r"));
                m_wait_for_at.init();
                m_state = State::WakingSendInit1;
            }
            else
            {
                m_state = State::Error;
            }
        }
        break;
    case State::WakingSendInit1:
        if( m_wait_for_at.update() )
        {
            if( ! m_wait_for_at.is_error() )
            {
                m_serial.print_P(PSTR("AT&K0\r"));
                m_wait_for_at.init();
                m_state = State::WakingSendInit2;
            }
            else
            {
                m_state = State::Error;
            }
        }
        break;
    case State::WakingSendInit2:
        if( m_wait_for_at.update() )
        {
            if( m_wait_for_at.is_error() ) {
                m_state = State::Error;
                return false;
            }

            // Modem initialised!
            m_state = State::Idle;
        }
        break;

    // ---
    // Transmit / Receive
    // ---
    case State::TxAckSize:
        if( m_wait_for_at.update() )
        {
            if( m_wait_for_at.is_error() ) {
                m_state = State::Error;
                return false;
            }

            // TODO: This might take too long for the timeslice?
            uint16_t cksum = 0;
            for(size_t i = 0; i < m_tx_data_size; i++)
            {
                m_serial.write(m_tx_data[i]);
                cksum += (uint16_t)m_tx_data[i];
            }
            m_serial.write(cksum >> 8);
            m_serial.write(cksum & 0xFF);

            m_wait_for_at.init(nullptr, 0, nullptr, "0\r\n\r\nOK\r\n");
            m_state = State::TxAckData;
        }
        break;
    case State::TxAckData:
        if( m_wait_for_at.update() )
        {
            if( m_wait_for_at.is_error() ) {
                m_state = State::Error;
                return false;
            }

            this->sbdix_get_signal_strength();
            // ^ updates m_state
        }
        break;
    case State::SbdixGetSigWait:
        if( m_wait_for_at.update() )
        {
            if( m_wait_for_at.is_error() ) {
                m_state = State::Error;
                return false;
            }

            // 
            if( !isdigit(m_csq_response_buf[0]) ) {
                m_state = State::Error;
                return false;
            }

            int quality = atoi(m_csq_response_buf);

            if( quality >= m_minimium_csq )
            {
                // Sufficient signal quality to send
                this->sbdix_req();
            }
            else
            {
                this->sbdix_wait_retry(true);
            }
        }
        break;
    case State::SbdixWaitRsp:
        if( m_wait_for_at.update() )
        {
            if( m_wait_for_at.is_error() ) {
                m_state = State::Error;
                return false;
            }

            // Check SBDIX response data
            uint16_t moCode = 0, moMSN = 0, mtCode = 0, mtMSN = 0, mtLen = 0, mtRemaining = 0;
            uint16_t *values[6] = { &moCode, &moMSN, &mtCode, &mtMSN, &mtLen, &mtRemaining };
            for (int i=0; i<6; ++i)
            {
                char *p = strtok(i == 0 ? m_sbdix_response_buf : NULL, ", ");
                if (p == NULL) {
                    m_state = State::Error;
                    return false;
                }
                *values[i] = atol(p);
            }

            if( 0 <= moCode && moCode <= 4 )
            {
                // Success!
                if( mtCode == 1 )
                {
                    // Message downloaded into modem memory.
                }
                else
                {
                    // No message waiting.
                }
                m_state = State::Idle;
            }
            else if (moCode == 12 || moCode == 14 || moCode == 16)
            {
                // Fatal error: Retry would do nothing
                m_state = State::Error;
                return false;
            }
            else
            {
                this->sbdix_wait_retry(false);
            }
        }
        break;
    case State::SbdixWaitRetry:
        if( m_timed_waiter.update() )
        {
            // Timeout on retry, re-check the signal and re-try transmission
            this->sbdix_get_signal_strength();
        }
        break;

    // ---
    // Sleep
    // ---
    case State::SleepingWait:
        if( m_wait_for_at.update() )
        {
            if( ! m_wait_for_at.is_error() )
            {
                m_timed_waiter.start(2l * 1000 * 1000);
                m_state = State::SleepingWaitTime;
            }
            else
            {
                m_state = State::Error;
            }
        }
        break;
    case State::SleepingWaitTime:
        if( m_timed_waiter.update() )
        {
            hal.gpio->write(m_sleep_pin, 0);    // LOW indicates power off
            m_modem_sleeping = true;
            m_state = State::Idle;
        }
        break;
    }
    return m_state == State::Idle;
}

bool UWA_IridiumSBD::req_wake()
{
    if( m_state != State::Idle )
        return false;

    if( m_sleep_pin != -1 && m_modem_sleeping )
    {
        // Enable power to the modem
        hal.gpio->write(m_sleep_pin, 1);    // High indicates power on
        m_modem_sleeping = false;
        // Enter 500ms wait
        m_timed_waiter.start( 500l * 1000 );
        m_state = State::WakingTimeout;
    }

    return true;
}
bool UWA_IridiumSBD::req_tx_bin(const void* data, size_t len)
{
    if( m_state != State::Idle )
        return false;

    // Send datasize
    m_serial.print_P(PSTR("AT+SBDWB="));
    m_serial.print(len);
    m_serial.print_P(PSTR("\r"));
    
    m_wait_for_at.init(nullptr, 0, nullptr, "READY\r\n");
    m_state = State::TxAckSize;

    return true;
}
bool UWA_IridiumSBD::req_sleep()
{
    if( m_state != State::Idle )
        return false;

    if( m_sleep_pin != -1 && ! m_modem_sleeping )
    {
        m_serial.print_P(PSTR("AT*F\r"));
        m_wait_for_at.init();
        m_state = State::SleepingWait;
    }

    return true;
}


void UWA_IridiumSBD::sbdix_get_signal_strength()
{
    m_serial.print_P(PSTR("AT+CSQ\r"));
    m_wait_for_at.init(m_csq_response_buf, sizeof(m_csq_response_buf), "+CSQ:");
    m_state = State::SbdixGetSigWait;
}
void UWA_IridiumSBD::sbdix_wait_retry(bool is_signal)
{
    if(is_signal)
    {
        m_timed_waiter.start( 10l*1000*1000 );
    }
    else
    {
        m_timed_waiter.start( 30l*1000*1000 );
    }
    m_state = State::SbdixWaitRetry;
}
void UWA_IridiumSBD::sbdix_req()
{
    m_serial.print_P(PSTR("AT+SBDIX\r"));
    m_wait_for_at.init(m_sbdix_response_buf, sizeof(m_sbdix_response_buf), "+SBDIX: ");
    m_state = State::SbdixWaitRsp;
}

// --------------------------------------------------------------------
// Timed waiter
// --------------------------------------------------------------------
void UWA_IridiumSBD::TimedWaiter::start(uint32_t us_from_now)
{
    m_start_time = hal.scheduler->micros();
    m_desired_elapsed = us_from_now;
}
bool UWA_IridiumSBD::TimedWaiter::update()
{
    if( hal.scheduler->micros() - m_start_time >= m_desired_elapsed )
    {
        return true;
    }
    else
    {
        return false;
    }
}

// --------------------------------------------------------------------
// Wait for reply
// --------------------------------------------------------------------
bool UWA_IridiumSBD::WaitForAt::init(char* response_buf, size_t response_size, const char* prompt, const char* terminator)
{
    if( m_state != State::Idle )
        return false;

    m_response_buf = response_buf;
    m_response_buf_size = response_size;
    m_prompt = prompt;
    m_terminator = terminator;

    // Only find prompt+response if there's a prompt provided
    m_state = (prompt ? State::LookingForPrompt : State::LookingForTerminator);
    m_match_pos = 0;
    
    m_op_start_time_ms = hal.scheduler->millis();
    return true;
}
bool UWA_IridiumSBD::WaitForAt::update()
{
    switch(m_state)
    {
    case State::Idle:
        break;
    case State::Error:
        break;
    default:
        if( hal.scheduler->millis() - m_op_start_time_ms > 30*1000 )
        {
            m_state = State::Error;
            return true;
        }
        const uint32_t MAX_CYCLE_MS = 10;
        uint32_t start = hal.scheduler->millis();
        while( m_serial.available() > 0 && hal.scheduler->millis() - start < MAX_CYCLE_MS )
        {
            char c = m_serial.read();
            switch(m_state)
            {
            case State::Idle:   break;
            case State::Error:  break;
            case State::LookingForPrompt:
                if( c == m_prompt[m_match_pos] )
                {
                    m_match_pos ++;
                    if(m_prompt[m_match_pos] == '\0')
                    {
                        m_match_pos = 0;
                        m_state = (m_response_buf_size ? State::GatheringResponse : State::LookingForTerminator);
                    }
                }
                else
                {
                    m_match_pos = (c == m_prompt[0] ? 1 : 0);
                }
                break;
            case State::GatheringResponse:
                if(c == '\r')
                {
                    m_state = State::LookingForTerminator;
                }
                else
                {
                    *m_response_buf++ = c;
                    m_response_buf_size --;
                    if(m_response_buf_size == 0)
                    {
                        //m_response_overflowed = true;
                        m_state = State::LookingForTerminator;
                    }
                }
                break;
            case State::LookingForTerminator:
                if( c == m_terminator[m_match_pos] )
                {
                    m_match_pos ++;
                    if(m_prompt[m_match_pos] == '\0')
                    {
                        m_match_pos = 0;
                        m_state = State::Idle;
                        return true;
                    }
                }
                else
                {
                    m_match_pos = (c == m_terminator[0] ? 1 : 0);
                }
                break;
            }
        }
    }
    return m_state == State::Idle;
}

