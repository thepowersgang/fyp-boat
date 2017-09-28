/*
 * ArduPilot library providing telemetry updates via a NetComm M2M Serial Modem
 */
#include "UWA_M2MSerialModem.h"

extern const AP_HAL::HAL& hal;

UWA_M2MSerialModem::UWA_M2MSerialModem(AP_HAL::BetterStream& port, ::std::function<void(const void* data, size_t len)> handle_rx):
    m_serial(port),
    m_handle_rx(handle_rx)
{
}

bool UWA_M2MSerialModem::update()
{
    return true;
}
