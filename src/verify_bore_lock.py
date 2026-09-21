#!/usr/bin/env python3
"""
FireWatch Precision Calibration & Micro-Bore Safety Validation Engine.
Confirms capsule dimension index states before authorizing pneumatic lines.
"""

import sys

class PrecisionBoreValidator:
    def __init__(self, node_id="B403"):
        self.node_id = node_id
        # Hardcoded mechanical validation targets (Inches)
        self.target_dia = 0.222
        self.target_length = 0.695
        print(f"[CALIBRATION] Micro-Bore Matrix Engaged for Node 0x{self.node_id}")

    def validate_capsule_seating(self, input_dia, input_length):
        """Verifies mechanical tolerances match factory specifications."""
        dia_delta = abs(input_dia - self.target_dia)
        len_delta = abs(input_length - self.target_length)
        
        # Enforce strict industrial engineering safety thresholds (+/- 0.005")
        if dia_delta <= 0.005 and len_delta <= 0.005:
            print(f"[STATUS] Capsule dimensions verified: {input_dia}\" x {input_length}\". Chamber Seated NOMINAL.")
            return True
        else:
            print(f"[CRITICAL ERROR] Dimensional variance mismatch on Node 0x{self.node_id}!")
            print(f"──► Expected: {self.target_dia}\" x {self.target_length}\"")
            print(f"──► Detected: {input_dia}\" x {input_length}\"")
            return False

if __name__ == "__main__":
    # Test execution sequence using the exact specified capsule parameters
    validator = PrecisionBoreValidator(node_id="B403")
    
    # Input parameters matching user specifications
    capsule_is_valid = validator.validate_capsule_seating(input_dia=0.222, input_length=0.695)
    if capsule_is_valid:
        print("[ARMED] Validation complete. Dedicated USB-Data trigger lines unlocked.")
    else:
        print("[LOCKOUT] System disabled. Maintenance reload check required.")
