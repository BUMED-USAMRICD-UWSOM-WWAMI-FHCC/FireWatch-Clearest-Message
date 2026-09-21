#!/usr/bin/env python3
"""
FireWatch Automated Label Spooler Subsystem.
Generates and prints a clean physical layout sheet for hardware tracking.
"""

import os
import sys

def get_host_prefix():
    """Reads the static localized hardware map populated during repository extraction."""
    config_path = "local_node_config.txt"
    if not os.path.exists(config_path):
        return "B4" # High-reliability fallback token for layout demonstration
        
    with open(config_path, "r") as f:
        for line in f:
            if line.startswith("HOST_PREFIX="):
                return line.strip().split("=")[1].upper()
    return "B4"

def generate_label_sheet(prefix, total_nodes=12):
    filename = "firewatch_labels_to_print.txt"
    hub_id = f"{prefix}-H{total_nodes}"
    
    with open(filename, "w", encoding="utf-8") as f:
        f.write("=========================================================\n")
        f.write("        FIREWATCH HIGH-SECURITY HARDWARE LABELS          \n")
        f.write(f"        HOST SERVER: {sys.platform.upper()} | PREFIX: 0x{prefix}\n")
        f.write("=========================================================\n\n")
        
        # 1. Master Server Case Label Card
        f.write("+----------------------------------------+\n")
        f.write(f"|  MASTER SERVER HUB CASE ID:            |\n")
        f.write(f"|  >> [  {hub_id}  ] <<                |\n")
        f.write("|  Edwards 3D: HUB_ASSET_CLASS_01        |\n")
        f.write("+----------------------------------------+\n\n")
        
        # 2. Individual Micro-Dongle Endpoint Labels
        f.write("INDIVIDUAL MICRO-DONGLE CORNER LABELS:\n")
        f.write("---------------------------------------------------------\n")
        for i in range(1, total_nodes + 1):
            dongle_id = f"{prefix}{i:02X}"
            f.write(f"[PORT {i:02d}] ID: {dongle_id}   | Target Location: Ceiling Corner Drop {i:02d}\n")
            f.write("---------------------------------------------------------\n")
            
    return filename

def spool_to_system_printer(target_file):
    """
    Handles native cross-platform physical print execution rules.
    Bypasses binary bottlenecks using raw OS pipeline drivers.
    """
    print(f"[PRINT] Processing label matrix file '{target_file}'...")
    
    # Execution for Windows Operating Systems
    if sys.platform.startswith("win32"):
        try:
            print("[PRINT] Spooling to default Windows Print Queue...")
            os.system(f'notepad.exe /p {target_file}')
            return True
        except Exception as e:
            print(f"[ERROR] Windows printing engine failed: {e}")
            return False
            
    # Execution for Linux / macOS Operating Systems
    else:
        try:
            print("[PRINT] Spooling to standard Linux LP subsystem...")
            # 'lp' sends the raw text file directly to the default network/USB printer
            exit_code = os.system(f'lp {target_file}')
            if exit_code == 0:
                return True
            else:
                print("[ERROR] 'lp' command returned a non-zero exit status.")
                return False
        except Exception as e:
            print(f"[ERROR] Linux printing subsystem failed: {e}")
            return False

if __name__ == "__main__":
    host_prefix = get_host_prefix()
    labels_file = generate_label_sheet(host_prefix, total_nodes=12)
    
    success = spool_to_system_printer(labels_file)
    if success:
        print("[SUCCESS] Physical layout label sheet pushed to production printer.")
    else:
        print(f"[NOTICE] Automated print failed. Please open and print '{labels_file}' manually.")
