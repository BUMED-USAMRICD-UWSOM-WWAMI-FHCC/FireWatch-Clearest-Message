#!/usr/bin/env python3
"""
Dynamic Node Data Encoder powered by Local Configuration Profiles.
Loads host hardware variables mapped during first-run unzipping scripts.
"""

import os
import sys
import time
import random

def load_assigned_prefix():
    """Reads the static localized hardware map populated during repository extraction."""
    config_path = "local_node_config.txt"
    if not os.path.exists(config_path):
        print(f"[FATAL ERROR] Run 'run_init' first to map local system MAC interfaces.")
        sys.exit(1)
        
    with open(config_path, "r") as f:
        for line in f:
            if line.startswith("HOST_PREFIX="):
                return line.strip().split("=")[1].upper()
    return "A1" # High-reliability fallback token

if __name__ == "__main__":
    # 1. Pull the unique host computer ID generated at unzip
    host_prefix = load_assigned_prefix()
    
    # 2. Simulate monitoring loop tracking breakaway position #5 on this machine
    physical_strip_slot = 5
    unique_hex_id = f"{host_prefix}{physical_strip_slot:02X}"
    
    print(f"[ONLINE] Unified USB Data Lane Engaged. Unique Device Address: 0x{unique_hex_id}")
    
    try:
        while True:
            # Simulate real-time monitoring variations across all three internal tools
            motion_delta = random.uniform(1.2, 3.5)
            mic_decibels = random.uniform(41.0, 43.8)
            surface_heat = random.uniform(23.2, 24.5)
            chassis_temp = 30.0
            
            # Format strict 20-character fixed-width string for Edwards 3D map engine routing
            usb_packet = f"#FW{unique_hex_id}{int(motion_delta):03d}{int(mic_decibels):03d}{int(surface_heat*10):04d}{int(chassis_temp):03d}"
            
            print(f"{usb_packet}")
            time.sleep(0.1) # 100ms continuous reporting cadence
            
    except KeyboardInterrupt:
        print("\n[STOP] Node data stream terminated safely by operator interface.")
