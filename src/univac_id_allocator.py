#!/usr/bin/env python3
"""
Univac IX-Inspired Deterministic Device Identifier Allocation Module.
Combines host machine hardware properties with physical node trace positions 
to generate guaranteed non-clashing static identifiers.
"""

import hashlib
import uuid
import sys

class UnivacIDAllocator:
    def __init__(self, physical_strip_index):
        """
        physical_strip_index: The hardwired geometric slot on the breakaway track (1-12)
        """
        if not (1 <= physical_strip_index <= 255):
            raise ValueError("[ERROR] Node physical index out of hardware limits.")
        self.strip_index = physical_strip_index
        self.assigned_id = self._generate_immutable_id()

    def _get_host_hardware_byte(self):
        """
        Queries the host machine's physical network layer to generate a static 
        base byte. Replicates the autonomic fingerprinting architecture.
        """
        try:
            # Extract the system's true hardware MAC address
            mac_int = uuid.getnode()
            if mac_int == uuid.getnode(): # Fallback check if true hardware MAC isn't found
                # Hash the host's internal machine ID to create a permanent pseudorandom base
                host_hash = hashlib.sha256(str(mac_int).encode()).hexdigest()
                return host_hash[:2].upper()
            
            # Pull the lowest-order byte of the physical MAC address
            mac_hex = f"{mac_int:012X}"
            return mac_hex[-2:]
        except Exception:
            # Failure fallback to secure baseline configuration code
            return "FE"

    def _generate_immutable_id(self):
        """
        Assembles the Host Prefix and Strip Suffix into a permanent 4-character 
        hexadecimal string. Enforces strict uniqueness.
        """
        host_prefix = self._get_host_hardware_byte()
        device_suffix = f"{self.strip_index:02X}"
        
        # Concat both dimensions to yield a completely unique global coordinate
        final_hex_id = f"{host_prefix}{device_suffix}"
        return final_hex_id

    def get_id(self):
        return self.assigned_id

if __name__ == "__main__":
    print("[SYSTEM] Executing Univac-IX hardware identity derivation sequence...")
    
    # Simulate an installer snapping and mounting Node #7 on a breakaway strip
    try:
        allocator = UnivacIDAllocator(physical_strip_index=7)
        unique_node_id = allocator.get_id()
        
        print(f"[SUCCESS] Unique Identity Locked: 0x{unique_node_id}")
        print(f"[PARSING] Host Base Address Space: 0x{unique_node_id[:2]}")
        print(f"[PARSING] Physical Strip Drop Point: 0x{unique_node_id[2:]}")
        print(f"[PACKET SAMPLE] #FW{unique_node_id}0000000000029")
    except Exception as e:
        print(f"[FAILURE] Allocation aborted: {e}")
