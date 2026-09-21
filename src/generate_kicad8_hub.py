#!/usr/bin/env python3
"""
Industrial USB Quantum Hub - KiCad 8.0 S-Expression Netlist Generator.
Compiles a 12-node standard USB-B array using 2oz/3oz thick copper bus layouts.
"""

def generate_kicad8_sexpr(filename="usb_quantum_hub_12.net"):
    with open(filename, 'w') as f:
        f.write("(export (version 20240108) (generator \"pcbnew\")\n")
        f.write("  (meta (generator \"KiCad\") (version \"8.0.0\"))\n")
        
        # 1. Component Registries (12 Standard USB-B Nodes + Power Barrel Jack)
        f.write("  (components\n")
        f.write("    (comp (ref \"J_PWR1\")\n")
        f.write("      (value \"Barrel_Jack_2.1mm_5.5mm\")\n")
        f.write("      (footprint \"Connector_BarrelJack:BarrelJack_Horizontal\")\n")
        f.write("      (property (name \"Reference\") (value \"J_PWR1\")))\n")
        
        for i in range(1, 13):
            f.write(f"    (comp (ref \"J{i}\")\n")
            f.write(f"      (value \"USB_B_Standard_Color\")\n")
            f.write(f"      (footprint \"Connector_USB:USB_B_Female_Horizontal\")\n")
            f.write(f"      (property (name \"Reference\") (value \"J{i}\")))\n")
        f.write("  )\n")
        
        # 2. Structural Net Connectivity Mappings
        f.write("  (nets\n")
        
        # Ground Bus Array
        f.write("    (net (code 1) (name \"GND_BUS\")\n")
        f.write("      (node (ref \"J_PWR1\") (pin \"2\") (pinfunction \"GND\"))\n")
        for i in range(1, 13):
            f.write(f"      (node (ref \"J{i}\") (pin \"4\") (pinfunction \"GND\"))\n")
        f.write("    )\n")
        
        # VCC 5V High-Throughput Power Bus (2oz/3oz Copper Optimization)
        f.write("    (net (code 2) (name \"VCC_5V_BUS\")\n")
        f.write("      (node (ref \"J_PWR1\") (pin \"1\") (pinfunction \"VCC\"))\n")
        for i in range(1, 13):
            f.write(f"      (node (ref \"J{i}\") (pin \"1\") (pinfunction \"VCC\"))\n")
        f.write("    )\n")
        
        # Individual High-Speed Differential Signal Pairs (D- / D+)
        net_idx = 3
        for i in range(1, 13):
            f.write(f"    (net (code {net_idx}) (name \"DATA_N_NODE_{i}\")\n")
            f.write(f"      (node (ref \"J{i}\") (pin \"2\") (pinfunction \"D-\"))\n")
            f.write("    )\n")
            net_idx += 1
            
            f.write(f"    (net (code {net_idx}) (name \"DATA_P_NODE_{i}\")\n")
            f.write(f"      (node (ref \"J{i}\") (pin \"3\") (pinfunction \"D+\"))\n")
            f.write("    )\n")
            net_idx += 1
            
        f.write("  )\n")
        f.write(")\n")
    print(f"[SUCCESS] KiCad 8.0 S-Expression compiled and exported to '{filename}'.")

if __name__ == "__main__":
    generate_kicad8_sexpr()
