#!/usr/bin/env bash
# FireWatch Linux/macOS First-Run Identity Provisioner

echo "========================================================="
echo "[INIT] Extracting Hardware Identity Layer..."
echo "========================================================="

# Pull the primary interface MAC address, ignoring virtual loopback adapters
if [ -d /sys/class/net/eth0 ]; then
    RAW_MAC=$(cat /sys/class/net/eth0/address)
elif [ -d /sys/class/net/enp3s0 ]; then
    RAW_MAC=$(cat /sys/class/net/enp3s0/address)
else
    # Fallback cross-platform network query command
    RAW_MAC=$(ifconfig | grep -o -E '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' | head -n1)
fi

# Sanitize the MAC address and capture the lower-order byte
CLEAN_MAC=$(echo "${RAW_MAC//:/}" | tr '[:lower:]' '[:upper:]')
HOST_PREFIX="${CLEAN_MAC: -2}"

echo "[SUCCESS] Local System Hardware Fingerprint Captured."
echo "Host Computer Prefix Locked: 0x${HOST_PREFIX}"

# Save to the shared runtime environment configuration
echo "HOST_PREFIX=${HOST_PREFIX}" > local_node_config.txt
echo "CONFIG_TIMESTAMP=$(date)" >> local_node_config.txt

echo "[ONLINE] Target profile initialized. Launching data encoder..."
python3 src/node_data_encoder.py
