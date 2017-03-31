/*
 * ArduPilot library providing telemetry updates via the Iridium sattelite network
 */
#ifndef _UWA_IRIDIUMSBD_H_
#define _UWA_IRIDIUMSBD_H_

#include <stdint.h>
#include <AP_HAL/AP_HAL.h>

class UWA_IridiumSBD
{
    
public:
    // Maximum amount of time a call to `do_update` can take (in microseconds)
    static const uint16_t   MAX_UPDATE_TIME_US;

private:
    AP_HAL::BetterStream& m_serial;
    int m_sleep_pin = -1;

    int m_minimium_csq = 2;

    bool m_modem_sleeping = false;

    enum class State
    {
        Idle,   // Idle state, waiting for a request to be commanded
        Error,  // Error state, something went wrong

        // - Wakeup request
        WakingTimeout,  // Wait 500ms for startup
        WakingWaitForAT,    // Sending AT and waiting for response
        WakingSendInit0, // 3 strings sent to wake the system
        WakingSendInit1, // 3 strings sent to wake the system
        WakingSendInit2, // 3 strings sent to wake the system

        // - Transmit Request
        TxAckSize,
        TxAckData,
        SbdixGetSigWait,
        SbdixWaitRsp,   // Wait for response to "AT+SBDIX" command
        SbdixWaitRetry, // wait for `n` seconds before retrying
        
        SleepingWait,
        SleepingWaitTime,
    } m_state = State::Idle;
    
    class TimedWaiter
    {
        uint32_t    m_start_time = 0;
        uint32_t    m_desired_elapsed = 0;
    
    public:
        void start(uint32_t us_from_now);
        bool update();
    } m_timed_waiter;

    class WaitForAt
    {
        AP_HAL::BetterStream& m_serial;

        enum class State
        {
            Idle,
            Error,
            LookingForPrompt,
            GatheringResponse,    
            LookingForTerminator,
        } m_state = State::Idle;

        uint32_t    m_op_start_time_ms = 0;
        
        const char* m_prompt = nullptr;
        const char* m_terminator = nullptr;
        char* m_response_buf = nullptr;
        size_t m_response_buf_size = 0;

        size_t m_match_pos = 0;

    public:
        WaitForAt(AP_HAL::BetterStream& serial):
            m_serial(serial)
        {
        }
        
        bool is_error() const { return m_state == State::Error; };
        void clear_error() { if(is_error()) m_state = State::Idle; }
        bool init(char* response_buf=nullptr, size_t response_size=0, const char* prompt=nullptr, const char* terminator="OK\r\n");
        bool update();
    } m_wait_for_at;

    size_t m_tx_data_size;
    const uint8_t* m_tx_data;

    char m_csq_response_buf[2];
    char m_sbdix_response_buf[32];

public:
    UWA_IridiumSBD(AP_HAL::BetterStream& port, int sleepPin=-1);

    // Returns `true` when in idle state after call
    bool update();

    // Requests that the modem be woken from low-power mode
    // RETURNS `true` if the request was started
    bool req_wake();
    // Request that the passed buffer be transmitte
    // NOTE: Buffer must be valid until `do_update` next returns `true`
    // RETURNS `true` if the request was started
    bool req_tx_bin(const void* data, size_t len);
    // Requests that the modem be put back into low-power mode
    // RETURNS `true` if the request was started
    bool req_sleep();

private:
    void sbdix_get_signal_strength();
    void sbdix_wait_retry();
    void sbdix_req();

};

#endif

