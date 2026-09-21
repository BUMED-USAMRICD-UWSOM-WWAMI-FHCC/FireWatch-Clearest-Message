#!/usr/bin/env python3
"""
FireWatch Dedicated USB-Data Encoder with Static Node Identification.
Outputs 20-byte fixed-width sentences optimized for direct Edwards ingestion.
"""

import time
import random

class UniqueNodeDataStream:
    def __init__(self, hex_node_id="00A7"):
        # Enforce strict 4-character uppercase hexadecimal formatting for the node address
        self.node_id = f"{int(hex_node_id, 16):04X}"
        print(f"[ONLINE] Dedicated USB-Data Core Active. Unique Node ID Assigned: 0x{self.node_id}")

    def compile_usb_frame(self, motion_pct, audio_db, max_heat_c, core_temp_c):
        """
        Compiles live telemetry metrics into a strict 20-character packet string.
        Isolates data streams completely away from the analog power pathways.
        """
        # Clamp inputs to preserve rigid byte positions
        m_val    = max(0, min(100, int(motion_pct)))
        a_val    = max(0, min(120, int(abs(audio_db))))
        h_val    = max(0, min(9999, int(max_heat_c * 10))) # Tenths of a degree Celsius
        c_val    = max(0, min(150, int(core_temp_c)))
        
        # Build the 20-byte packet sentence with explicit padding
        data_sentence = f"#FW{self.node_id}{m_val:03d}{a_val:03d}{h_val:04d}{c_val:03d}"
        return data_sentence

    def push_stream(self):
        """Simulates rapid data broadcast over the dedicated USB lines at a 100ms interval."""
        try:
            while True:
                # Simulated telemetry values captured from the front sensors
                raw_motion = random.uniform(0.0, 4.2)
                raw_audio  = random.uniform(38.5, 41.2)
                raw_heat   = random.uniform(21.8, 23.5)
                chassis_t  = 29.0
                
                # Format and output the data packet line over the USB-only link
                usb_packet = self.compile_usb_frame(raw_motion, raw_audio, raw_heat, chassis_t)
                print(f"{usb_packet}")
                
                time.sleep(0.1) # Strict 100ms telemetry cadence
                
        except KeyboardInterrupt:
            print("\n[STOP] Telemetry stream paused by operator command.")

if __name__ == "__main__":
    # Example deployment configuration using a static, unique device ID
    # This ID links directly to the specific floor room layout in the Edwards server map
    streamer = UniqueNodeDataStream(hex_node_id="00A7")
    streamer.run_live_stream = streamer.push_stream
    streamer.run_live_stream()
