#!/usr/bin/env python3
"""
FireWatch Pneumatic Gel-Capsule Valve Control Loop.
Monitors thermal telemetry and issues a precise 50ms solenoid release pulse.
"""

import time

class GelCapsuleDeploymentController:
    def __init__(self, node_id="B403"):
        self.node_id = node_id
        self.is_armed = False
        self.valve_channel = 5
        
    def check_thermal_thresholds(self, sensor_heat_c):
        """Monitors live micro-bolometer values for fire hazard markers."""
        # Check if localized heat exceeds a critical threshold (e.g., 75.0°C)
        if sensor_heat_c >= 75.0:
            print(f"[CRITICAL THERMAL EVENT] Spike detected on Node 0x{self.node_id}: {sensor_heat_c}°C")
            return True
        return False

    def execute_deployment_sequence(self):
        """Assembles the strict serial command to fire the pneumatic pulse valve."""
        if not self.is_armed:
            print(f"[REJECTED] Fire sequence blocked for Node 0x{self.node_id}. System is DISARMED.")
            return False
            
        # Compile the 15-byte control string to fire the valve solenoid over the USB data path
        # Draws its instantaneous actuation current entirely from the 2.1mm/5.5mm power jack sub-bus
        pulse_on_command  = f"#VAL40{self.valve_channel:02d}1"
        pulse_off_command = f"#VAL40{self.valve_channel:02d}0"
        
        print(f"[LAUNCH] Transmitting pneumatic valve actuation pulse: {pulse_on_command}")
        # In physical deployment: Write pulse_on, sleep 0.05 (50ms pulse), write pulse_off
        
        # Lock system down immediately post-discharge for inspection and maintenance reloading
        self.is_armed = False
        print(f"[STATUS] Node 0x{self.node_id} transitioned to: RELOAD_REQUIRED")
        return True

if __name__ == "__main__":
    controller = GelCapsuleDeploymentController(node_id="B403")
    
    # Simulate a critical fire hazard detection scenario
    controller.is_armed = True
    event_detected = controller.check_thermal_thresholds(78.4)
    
    if event_detected:
        controller.execute_deployment_sequence()
