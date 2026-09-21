#!/usr/bin/env python3
"""
FireWatch Global Asset Tracking Ledger & Manifest Logging Engine.
Maintains a permanent, non-volatile audit history of printed device labels.
"""

import os
import sys
import csv
import time
import getpass
import platform

def get_host_prefix():
    """Reads the static localized hardware map populated during repository extraction."""
    config_path = "local_node_config.txt"
    if os.path.exists(config_path):
        with open(config_path, "r", encoding="utf-8") as f:
            for line in f:
                if line.startswith("HOST_PREFIX="):
                    return line.strip().split("=")[1].upper()
    return "B4" # High-reliability fallback token for layout demonstration

def append_to_manifest_log(prefix, total_nodes=12, log_filename="firewatch_global_manifest.csv"):
    """
    Appends high-security structural tracking data to a unified CSV manifest sheet.
    Captures deep environment variables for cross-platform network compliance.
    """
    file_exists = os.path.exists(log_filename)
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
    current_user = getpass.getuser()
    os_profile = f"{platform.system()} {platform.release()}"
    hub_id = f"{prefix}-H{total_nodes}"
    
    # Core structural header fields matching Edwards 3D and Visio ingest keys
    fields = [
        "Timestamp", "Host_Prefix", "Asset_Class", "Unique_Hardware_ID", 
        "Parent_Hub_ID", "Physical_Port_Slot", "Operating_System", "Operator_User"
    ]
    
    records_logged = 0
    try:
        with open(log_filename, mode="a", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=fields)
            
            # Initialize structure file headers if creating a fresh audit log
            if not file_exists:
                writer.writeheader()
                
            # 1. Log Master Enclosure Tray Layer Entry
            writer.writerow({
                "Timestamp": timestamp,
                "Host_Prefix": prefix,
                "Asset_Class": "HUB_MASTER_STRIP",
                "Unique_Hardware_ID": hub_id,
                "Parent_Hub_ID": "NONE",
                "Physical_Port_Slot": "00",
                "Operating_System": os_profile,
                "Operator_User": current_user
            })
            records_logged += 1
            
            # 2. Log Individual Micro-Dongle Endpoint Entries
            for i in range(1, total_nodes + 1):
                dongle_id = f"{prefix}{i:02X}"
                writer.writerow({
                    "Timestamp": timestamp,
                    "Host_Prefix": prefix,
                    "Asset_Class": "SENSOR_NODE_DONGLE",
                    "Unique_Hardware_ID": dongle_id,
                    "Parent_Hub_ID": hub_id,
                    "Physical_Port_Slot": f"{i:02d}",
                    "Operating_System": os_profile,
                    "Operator_User": current_user
                })
                records_logged += 1
                
        print(f"[LOGGED] Securely appended {records_logged} new asset trails to '{log_filename}'.")
        return True
    except IOError as e:
        print(f"[ERROR] Failed to write to secure digital manifest log: {e}")
        return False

if __name__ == "__main__":
    print("[SYSTEM] Executing secure digital manifest archiving sequence...")
    host_prefix = get_host_prefix()
    append_to_manifest_log(host_prefix, total_nodes=12)
