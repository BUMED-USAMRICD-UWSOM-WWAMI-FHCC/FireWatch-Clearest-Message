#!/usr/bin/env python3
"""
KiCad Netlist Array Generator for the 12-Node Industrial USB Quantum Hub.
Outputs standard nets mapping standard-colored USB-B nodes back to the server array.
"""

import sys

def generate_kicad_netlist(output_file, node_count=12):
    with open(output_file, 'w') as f:
        f.write(f"(export (version D) (source \"FireWatch-Quantum-Hub\")\n")
        f.write(f"  (components\n")
        
        # 1. Map Individual Standard USB-B Receptacles
        for i in range(1, node_count + 1):
            f.write(f"    (comp (ref J{i})\n")
            f.write(f"      (value \"USB_B_Standard_Color\")\n")
            f.write(f"      (footprint \"Connector_USB:USB_B_Female_Horizontal\")\n")
            f.write(f"      (tstamp \"node_cap_{i}\"))\n")
            
        # 2. Map Multi-Voltage Power Matrix Input (2.1mm/5.5mm Barrel Jack)
        f.write(f"    (comp (ref J_PWR1)\n")
        f.write(f"      (value \"Barrel_Jack_2.1mm_5.5mm\")\n")
        f.write(f"      (footprint \"Connector_BarrelJack:BarrelJack_Horizontal\")\n")
        f.write(f"      (tstamp \"pwr_input_main\"))\n")
        f.write(f"  )\n")
        
        # 3. Define Heavy-Duty Power Sub-Channels (2oz/3oz Copper Trace Assignments)
        f.write(f"  (nets\n")
        f.write(f"    (net (code 1) (name \"GND_BUS\")\n")
        f.write(f"      (node (ref J_PWR1) (pin 2))\n")
        for i in range(1, node_count + 1):
            f.write(f"      (node (ref J{i}) (pin 4))\n") # Pin 4: GND
        f.write(f"    )\n")
        
        f.write(f"    (net (code 2) (name \"VCC_5V_BUS\")\n")
        f.write(f"      (node (ref J_PWR1) (pin 1))\n")
        for i in range(1, node_count + 1):
            f.write(f"      (node (ref J{i}) (pin 1))\n") # Pin 1: VCC
        f.write(f"    )\n")
        
        # 4. Map Individual Data Lines Directly to High-Throughput Server Pins
        net_code = 3
        for i in range(1, node_count + 1):
            f.write(f"    (net (code {net_code}) (name \"DATA_P_NODE_{i}\")\n")
            f.write(f"      (node (ref J{i}) (pin 2))\n") # Pin 2: D-
            f.write(f"    )\n")
            net_code += 1
            f.write(f"    (net (code {net_code}) (name \"DATA_N_NODE_{i}\")\n")
            f.write(f"      (node (ref J{i}) (pin 3))\n") # Pin 3: D+
            f.write(f"    )\n")
            net_code += 1
            
        f.write(f"  )\n")
        f.write(f")\n")
    print(f"[SUCCESS] Netlist compiled containing {node_count} nodes mapped to '{output_file}'.")

if __name__ == "__main__":
    generate_kicad_netlist("usb_quantum_hub_12.net", 12)
