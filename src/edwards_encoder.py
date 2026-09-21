#!/usr/bin/env python3
"""
FireWatch Unified Telemetry Encoder for Edwards FireWorks Integration.
Flattens multi-sensor data into fixed-width monitoring strings.
"""

import time
import random

class EdwardsTelemetryStream:
    def __init__(self, node_id=1):
        self.node_id = node_id
        print(f"[READY] Edwards Telemetry Line Active for Node #{self.node_id:02d}")

    def capture_and_flatten(self, raw_motion_pct, raw_audio_db, raw_max_heat_c, chassis_temp_c):
        """
        Converts live sensor readings into a strict, zero-overhead ASCII string
        that Edwards or Genetec systems can parse via regex/index instantly.
        """
        # 1. Clamp and format values to ensure strict character widths
        motion_val  = max(0, min(100, int(raw_motion_pct)))
        audio_val   = max(0, min(120, int(abs(raw_audio_db))))
        
        # Convert heat to integer tenths (e.g., 42.5 C -> 0425) to avoid decimal parsing
        heat_val    = max(0, min(9999, int(raw_max_heat_c * 10)))
        core_val    = max(0, min(150, int(chassis_temp_c)))
        
        # 2. Construct the fixed-width data sentence
        # Format string forces exact padding lengths (3 characters, 4 characters, etc.)
        telemetry_sentence = f"#FW{motion_val:03d}{audio_val:03d}{heat_val:04d}{core_val:03d}"
        return telemetry_sentence

    def run_live_stream(self):
        """Simulates live data being compiled and pushed every 100ms."""
        print("[STREAM] Initializing continuous data serialization loop...")
        try:
            while True:
                # Simulated nominal real-world environment metrics
                live_motion = random.uniform(2.0, 5.5)
                live_audio  = random.uniform(40.0, 45.0)
                live_heat   = random.uniform(22.4, 24.1) # Nominal room temperature
                internal_c  = 31.0
                
                # Unpack and encode
                data_packet = self.capture_and_flatten(live_motion, live_audio, live_heat, internal_c)
                
                # Output the exact format the Edwards Server captures via serial/TCP port
                print(f"NODE_{self.node_id:02d}_OUT: {data_packet}")
                time.sleep(0.1) # 100ms Cadence
                
        except KeyboardInterrupt:
            print("\n[STOP] Telemetry stream paused.")

if __name__ == "__main__":
    # Initialize deployment streaming test for the first module loop
    streamer = EdwardsTelemetryStream(node_id=1)
    streamer.run_live_stream()
