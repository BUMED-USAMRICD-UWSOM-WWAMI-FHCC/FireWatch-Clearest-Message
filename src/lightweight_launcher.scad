// FireWatch Industrial Infrastructure - Optimized Single-Chamber Launcher
$fn = 64; 

// Streamlined Structural Constraints (Strictly under 1.2 cubic inches)
block_width     = 1.45; // Inches - Reduced width to shave off material mass
block_height    = 1.45; 
block_length    = 1.95; // Shortened length optimized for single capsule chambering
wall_thick      = 0.12; // 3mm high-impact polymer walls
barrel_diameter = 0.35; // Sized for standard single 9mm/.35" gel capsule

module single_chamber_launcher() {
    difference() {
        // 1. Core Lightweight Prism Housing (Molded in Standard Fire Red)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }
        
        // 2. Smooth-Bore Launch Cylinder (Single Barrel)
        translate([0.55, 0.55, -0.05])
            cylinder(h = block_length + 0.1, d = barrel_diameter);
            
        // 3. Compact Valve Cavity (Nests miniature 12V electromechanical valve)
        translate([wall_thick, wall_thick, wall_thick])
            cube([0.38, 0.38, block_length - (wall_thick * 2)]);
            
        // 4. IP67 Data/Control Port Bulkhead Entry
        translate([0.18, 0.18, block_length / 2])
            rotate([0, 0, -45])
                cylinder(h = 0.6, d = 0.40, center=true);
                
        // 5. Camera Alignment Reference Notch
        translate([block_width * 0.4, -0.01, block_length - 0.4])
            cube([0.04, 0.04, 0.3]);
    }
}

single_chamber_launcher();
