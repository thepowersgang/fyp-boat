/*
 * ArduPilot library providing telemetry updates via the Iridium sattelite network
 */
#ifndef _UWA_M2MSERIALMODEM_H_
#define _UWA_M2MSERIALMODEM_H_

#include <stdint.h>
#include <AP_HAL/AP_HAL.h>

class UWA_M2MSerialModem
{
public:
    // Maximum amount of time a call to `do_update` can take (in microseconds)
    static const uint16_t   MAX_UPDATE_TIME_US;

private:
    AP_HAL::BetterStream& m_serial;
    ::std::function<void(const void* data, size_t len)> m_handle_rx;

    // - Transmission buffer
    size_t m_tx_data_size;
    const uint8_t* m_tx_data;

public:
    UWA_M2MSerialModem(AP_HAL::BetterStream& port, ::std::function<void(const void* data, size_t len)> handle_rx);

    // Returns `true` when in idle state after call (when ready for a new command)
    bool update();

    // Request that the passed buffer be transmitted
    // NOTE: Buffer must be valid until `do_update` next returns `true`
    // RETURNS `true` if the request was started
    bool req_tx_bin(const void* data, size_t len);
};

#endif

