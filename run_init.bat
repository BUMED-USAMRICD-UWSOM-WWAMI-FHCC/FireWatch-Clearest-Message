@echo off
TITLE FireWatch Local ID Initializer
echo =========================================================
echo [INIT] Initializing FireWatch Node Identity From GitHub
echo =========================================================

:: Query the physical MAC address using standard Windows command utilities
for /f "tokens=3 delims=," %%A in ('getmac /v /fo csv ^| findstr /i "Ethernet Wi-Fi"') do (
    set RAW_MAC=%%A
    goto :process
)

:process
:: Clean quotes from the MAC string
set CLEAN_MAC=%RAW_MAC:"=%
:: Strip formatting characters to extract raw characters
set BASE_MAC=%CLEAN_MAC:-=%
:: Isolate the lowest byte (last two characters) as the Host Prefix
set HOST_PREFIX=%BASE_MAC:~-2%

echo [SUCCESS] Local System Hardware Fingerprint Captured.
echo Host Computer Prefix Locked: 0x%HOST_PREFIX%

:: Generate local configuration file for the USB-Data layer encoder
echo HOST_PREFIX=%HOST_PREFIX% > local_node_config.txt
echo CONFIG_TIMESTAMP=%DATE%-%TIME% >> local_node_config.txt

echo [ONLINE] Config file created successfully. Starting local encoder...
python src\node_data_encoder.py
pause
