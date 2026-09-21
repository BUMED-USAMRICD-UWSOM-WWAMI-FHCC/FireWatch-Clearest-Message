#!/usr/bin/env python3
"""
FireWatch Advanced Servo Management Engine.
Features manual operator override controls and automatic return-to-home timeouts.
"""

import sys
import time
import threading

class AdvancedServoManager:
    def __init__(self, node_id="B403", timeout_seconds=10.0):
        self.node_id = node_id
        self.timeout_duration = timeout_seconds
        
        # Operational limits & calibration centers
        self.pan_home = 90.0
        self.tilt_home = 45.0
        self.current_pan = self.pan_home
        self.current_tilt = self.tilt_home
        
        # State tracking parameters
        self.last_activity_time = time.time()
        self.manual_override_active = False
        self.is_running = True
        
        print(f"[SYSTEM] Advanced Controller Loaded for Node 0x{self.node_id}")
        print(f"[CONFIG] Return-To-Home Safety Timeout Set to {self.timeout_duration}s")

    def format_i2c_packet(self, channel, angle):
        """Compiles a clean 15-byte serial command frame for the dedicated USB channel."""
        clamped_angle = max(0, min(180, float(angle)))
        # Map 0-180 degrees to standard 12-bit PCA9685 ticks (150-600)
        ticks = int(150 + (clamped_angle / 180.0) * (600 - 150))
        return f"#I2C40{channel:02d}{ticks:04d}"

    def update_hardware_position(self):
        """Dispatches the updated coordinate configuration down the data line."""
        pan_frame = self.format_i2c_packet(channel=0, angle=self.current_pan)
        tilt_frame = self.format_i2c_packet(channel=1, angle=self.current_tilt)
        print(f"[SEND_DATA] Pan Frame: {pan_frame} | Tilt Frame: {tilt_frame}")

    def process_manual_input(self):
        """Asynchronous keyboard capture loop running inside an independent worker thread."""
        print("\n=========================================================")
        print(" MANUAL KEYBOARD OVERRIDE ENGAGED                        ")
        print(" Controls: [W/S] Tilt Up/Down | [A/D] Pan Left/Right     ")
        print(" Press [ESC] then Enter to Release Override Control      ")
        print("=========================================================\n")
        
        while self.is_running:
            user_key = input("Enter Direction (W/A/S/D) & Press Enter: ").strip().lower()
            
            if user_key == '\x1b' or user_key == 'esc':
                print(f"[CONTROL] Operator released control of Node 0x{self.node_id}. Re-engaging automation.")
                self.manual_override_active = False
                break
                
            self.manual_override_active = True
            self.last_activity_time = time.time() # Reset clock step
            
            if user_key == 'a':   # Pan Left
                self.current_pan = max(0.0, self.current_pan - 15.0)
            elif user_key == 'd': # Pan Right
                self.current_pan = min(180.0, self.current_pan + 15.0)
            elif user_key == 'w': # Tilt Up
                self.current_tilt = min(90.0, self.current_tilt + 10.0)
            elif user_key == 's': # Tilt Down
                self.current_tilt = max(0.0, self.current_tilt - 10.0)
            else:
                continue
                
            print(f"[MANUAL] Steering -> Pan: {self.current_pan}°, Tilt: {self.current_tilt}°")
            self.update_hardware_position()

    def run_safety_watchdog(self):
        """Main background loop checking for telemetry activity and timing out idle units."""
        print("[WATCHDOG] Active safety monitor loop started.")
        
        # Spawn user input thread to ensure non-blocking terminal processing
        input_thread = threading.Thread(target=self.process_manual_input, daemon=True)
        input_thread.start()
        
        try:
            while self.is_running:
                current_time = time.time()
                elapsed_idle = current_time - self.last_activity_time
                
                # Check if the node has sat idle without tracking spikes or overrides
                if not self.manual_override_active and elapsed_idle >= self.timeout_duration:
                    if self.current_pan != self.pan_home or self.current_tilt != self.tilt_home:
                        print(f"\n[TIMEOUT ALERT] Node 0x{self.node_id} idle for {int(elapsed_idle)}s. Returning to safety home position...")
                        
                        self.current_pan = self.pan_home
                        self.current_tilt = self.tilt_home
                        self.update_hardware_position()
                        
                time.sleep(1.0) # Check system cadence once per second
                
        except KeyboardInterrupt:
            print("\n[SHUTDOWN] Exiting advanced controller loop.")
            self.is_running = False

if __name__ == "__main__":
    # Launch testing deployment loop for Node 0xB403 with a 10-second idle window
    manager = AdvancedServoManager(node_id="B403", timeout_seconds=10.0)
    manager.run_safety_watchdog()
