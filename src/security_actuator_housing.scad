// FireWatch Industrial Infrastructure - Reinforced Actuator & Solenoid Housing
// Resolution for cylindrical holes
$fn = 64; 

// Heavy-Duty Geometric Constraints (Reinforced to absorb mechanical recoil forces)
block_width   = 1.75; // Inches (Slightly widened for heavy actuator frames)
block_height  = 1.75; 
block_length  = 1.40; // Deepened to accommodate industrial push/pull solenoids
wall_thick    = 0.16; // 4mm ultra-rugged structural walls

module reinforced_actuator_housing() {
    difference() {
        // 1. Primary Structural Chassis (Molded in Standard Fire Red Polymer)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }
        
        // 2. Heavy Internal Cavity (Nests the electromechanical launch assembly)
        translate([wall_thick, wall_thick, wall_thick])
            linear_extrude(height = block_length - (wall_thick * 2)) {
                polygon(points=[[0,0], [block_width - 0.35, 0], [0, block_height - 0.35]]);
            }
            
        // 3. Threaded IP67 Waterproof Data/Control Port Opening
        // Circular profile to accommodate waterproof threaded panel couplings or wiring harnesses
        translate([0.65, 0.65, block_length / 2])
            rotate([0, 0, -45])
                cylinder(h = block_length + 0.1, d = 0.65, center=true); // 16.5mm standard panel-mount hole

        // 4. Front Aperture Output Slot (For mechanical solenoid plunge or tether-line exit)
        translate([block_width * 0.4, block_height * 0.4, block_length - wall_thick - 0.05])
            rotate([0, 0, -45])
                cube([0.50, 0.25, wall_thick + 0.2], center=true);
    }
    
    // 5. Reinforced Screw Pillars (Molded inside the cavity to bolt down hardware)
    translate([wall_thick + 0.1, wall_thick + 0.1, wall_thick])
        difference() {
            cylinder(h = block_length - (wall_thick * 3), d = 0.25);
            translate([0, 0, -0.05])
                cylinder(h = block_length, d = 0.11); # Standard #4 industrial machine screw thread channel
        }
        
    // 6. External Heavy-Duty Load-Bearing Flanges (For flush surface mechanical fastening)
    translate([-0.25, 0, 0])
        difference() {
            cube([0.25, 0.50, block_length]);
            translate([0.12, 0.25, block_length / 2])
                rotate([90, 0, 0])
                    cylinder(h = 0.6, d = 0.18, center=true); // Clean pass-through for heavy-gauge fasteners
        }
}

// Render the completed reinforced utility structure
reinforced_actuator_housing();
