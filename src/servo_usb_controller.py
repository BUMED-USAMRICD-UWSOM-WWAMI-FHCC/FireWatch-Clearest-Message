#!/usr/bin/env python3
"""
FireWatch USB-to-I2C/PWM Automated Servo Controller Subsystem.
Translates geometric tracking angles into rigid serial control frames.
"""

import sys
import time
import random

class USBToI2CServoDriver:
    def __init__(self, target_com_port="COM3", i2c_address=0x40):
        """
        i2c_address: Default address for industrial PCA9685 16-Channel PWM controllers
        """
        self.port = target_com_port
        self.address = f"0x{i2c_address:02X}"
        self.pan_channel = 0
        self.tilt_channel = 1
        print(f"[INIT] Servo Subbus Active. Target: {self.port} | Controller Address: {self.address}")

    def calculate_pwm_ticks(self, target_angle):
        """
        Maps a physical 0-180 degree angle to standard 12-bit PWM ticks.
        (Industry Baseline: 150 ticks for 0 degrees, 600 ticks for 180 degrees at 50Hz)
        """
        clamped_angle = max(0, min(180, float(target_angle)))
        min_ticks = 150
        max_ticks = 600
        
        # Linear interpolation step
        ticks = min_ticks + (clamped_angle / 180.0) * (max_ticks - min_ticks)
        return int(ticks)

    def dispatch_servo_command(self, channel, angle):
        """
        Formats a zero-overhead serial execution packet for the USB data channel.
        Format matching: #I2C[ADDR][CHAN][4-DIGIT TICK VALUE]
        """
        pwm_ticks = self.calculate_pwm_ticks(angle)
        
        # Strip conversational padding; compile rigid 15-byte control string
        command_packet = f"#I2C{self.address[2:]}{channel:02d}{pwm_ticks:04d}"
        
        # In a deployment scenario, this string is pushed directly to the serial buffer:
        # self.serial_interface.write(command_packet.encode('utf-8'))
        return command_packet

    def execute_automatic_sweep_pattern(self):
        """Simulates automated facility guard sweeps and tracking re-alignments."""
        print("[AUTOMATION] Commencing active tracking and scan routines...")
        try:
            while True:
                # Simulate the server tracking a mock telemetry spike event
                target_pan  = random.uniform(30.0, 150.0)
                target_tilt = random.uniform(15.0, 75.0)
                
                # Encode commands for both robotic axes
                pan_frame  = self.dispatch_servo_command(self.pan_channel, target_pan)
                tilt_frame = self.dispatch_servo_command(self.tilt_channel, target_tilt)
                
                print(f"[PAN_CMD] Channel {self.pan_channel:02d} -> Angle: {target_pan:05.1f}° | Payload: {pan_frame}")
                print(f"[TLT_CMD] Channel {self.tilt_channel:02d} -> Angle: {target_tilt:05.1f}° | Payload: {tilt_frame}")
                
                time.sleep(1.0) # 1-second interval between automated tracking sweeps
                
        except KeyboardInterrupt:
            print("\n[STOP] Motor automation paused. Holding servos at safety lock positions.")

if __name__ == "__main__":
    # Cross-platform port assignment check
    assigned_port = "/dev/ttyUSB0" if sys.platform.startswith("linux") else "COM3"
    
    # Initialize driver loop matching your unzipped GitHub folder structures
    driver = USBToI2CServoDriver(target_com_port=assigned_port, i2c_address=0x40)
    driver.execute_automatic_sweep_pattern()
