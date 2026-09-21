// Industrial USB Hub Infrastructure - Corner Block (KiCad 8.0 / Glue-Ready)
$fn = 64; 

// Structural Boundary Parameters (Under 1.2 Cubic Inches)
block_width    = 1.50; // Inches
block_height   = 1.50; // Inches
block_length   = 1.00; // Inches (Extrusion depth)
wall_thickness = 0.08; // 2mm high-durability wall

module glue_ready_corner_block() {
    difference() {
        // 1. Primary Structural Body (Standard Fire Red Profile)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }
        
        // 2. Deep Recessed Internal Snap-Channel 
        // Keeps the breakaway stub and its rubber protective cap sub-surface
        translate([-0.05, -0.05, -0.1])
            cube([0.25, 0.25, block_length + 0.2]);
            
        // 3. Pre-Cut Natural Tape Bed Recess
        translate([0.25, -0.01, -0.05])
            cube([block_width - 0.3, 0.02, block_length + 0.1]);
        translate([-0.01, 0.25, -0.05])
            cube([0.02, block_height - 0.3, block_length + 0.1]);

        // 4. Liquid-Glue Micro-Reservoirs (Dual Wall Retention Insets)
        // Traps expanding glue formulas so they do not breach the flush edge
        translate([0.5, 0.04, 0.1])
            cube([0.4, 0.05, block_length - 0.2]);
        translate([0.04, 0.5, 0.1])
            cube([0.05, 0.4, block_length - 0.2]);

        // 5. Standard USB-B Receptacle Port Interface (Industry Default Colorway)
        translate([0.45, 0.45, block_length / 2])
            rotate([0, 0, -45])
                union() {
                    cube([0.48, 0.47, 0.42], center=true); 
                    translate([0, 0.2, 0])
                        cube([0.55, 0.50, 0.50], center=true);
                }
    }
}

glue_ready_corner_block();
