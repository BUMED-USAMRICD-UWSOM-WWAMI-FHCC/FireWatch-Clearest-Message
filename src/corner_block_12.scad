// Industrial USB Hub Infrastructure - Corner Block Parameterization
// Resolution for rendering circles
$fn = 64; 

// Core Geometric Constraints (Fits under 1.2 Cubic Inches)
block_width  = 1.50; // Inches
block_height = 1.50; // Inches
block_length = 1.00; // Inches (Extrusion depth)
wall_thickness = 0.08; // 2mm ruggedized wall

module corner_block_node() {
    difference() {
        // 1. Core Right-Triangular Prism (Chassis Body)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }
        
        // 2. Recessed Internal Snap-Channel (Rear Wall Facing)
        // Drops the breakaway stub sub-surface so the rubber cap sits completely flush
        translate([-0.05, -0.05, -0.1])
            cube([0.25, 0.25, block_length + 0.2]);
            
        // 3. Pre-Cut Natural Tape Recess (Bottom and Back Planes)
        // Ensures the 100% natural tree-rubber adhesive sits perfectly aligned
        translate([0.25, -0.01, -0.05])
            cube([block_width - 0.3, 0.02, block_length + 0.1]);
        translate([-0.01, 0.25, -0.05])
            cube([0.02, block_height - 0.3, block_length + 0.1]);

        // 4. Standard USB-B Interface Receptacle Cutout
        // Angled out at 45-degrees for easy thumb-stick insertion
        translate([0.45, 0.45, block_length / 2])
            rotate([0, 0, -45])
                union() {
                    // Main port body footprint
                    cube([0.48, 0.47, 0.42], center=true); 
                    // Pass-through clearance for thumb stick seating
                    translate([0, 0.2, 0])
                        cube([0.55, 0.50, 0.50], center=true);
                }
    }
}

// Render node configuration
corner_block_node();
