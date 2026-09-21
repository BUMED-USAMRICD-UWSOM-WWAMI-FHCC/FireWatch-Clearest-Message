// Industrial Multi-Sensor Micro-Dongle Enclosure
$fn = 64;

// Enclosure Dimensions (Thumb-stick form factor)
dongle_width  = 0.45; // Inches (Fits cleanly into the 45° corner block port)
dongle_length = 1.10; // Inches
dongle_height = 0.40; // Inches
wall_thick    = 0.04; // 1mm protective shell

module sensor_dongle_chassis() {
    difference() {
        // 1. Core Exterior Shell Body
        cube([dongle_width, dongle_length, dongle_height]);
        
        // 2. Internal Component Cavity (Protects PCB and sensors)
        translate([wall_thick, wall_thick, wall_thick])
            cube([dongle_width - (wall_thick * 2), dongle_length - (wall_thick * 2), dongle_height - (wall_thick * 2)]);
            
        // 3. Front Optical Lens Window (Camera Aperture)
        translate([dongle_width / 2, dongle_length - wall_thick - 0.02, dongle_height * 0.7])
            rotate([90, 0, 0])
                cylinder(h = wall_thick + 0.05, d = 0.12, center = true);
                
        // 4. Infrared Lens Window (Flir Lepton / Heat Sensor Aperture)
        translate([dongle_width / 2, dongle_length - wall_thick - 0.02, dongle_height * 0.3])
            rotate([90, 0, 0])
                cylinder(h = wall_thick + 0.05, d = 0.16, center = true);
                
        // 5. Acoustic Port Entry (MEMS Microphone Port Hole)
        translate([dongle_width - wall_thick - 0.02, dongle_length - 0.2, dongle_height / 2])
            rotate([0, 90, 0])
                cylinder(h = wall_thick + 0.05, d = 0.04, center = true);
                
        // 6. Rear USB-B Standard Male Interface Connector Output Slot
        translate([dongle_width / 2, -0.01, dongle_height / 2])
            cube([0.40, wall_thick + 0.05, 0.35], center = true);
    }
}

sensor_dongle_chassis();
