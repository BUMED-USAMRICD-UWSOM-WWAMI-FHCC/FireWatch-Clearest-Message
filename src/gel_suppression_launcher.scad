// FireWatch Industrial Infrastructure - Pneumatic Gel-Capsule Suppression Launcher
$fn = 64; 

// Structural Form Factors (Reinforced for Pneumatic Pressure Containment)
block_width     = 1.80; // Inches (Enlarged chassis body)
block_height    = 1.80; 
block_length    = 2.20; // Extended length for the pneumatic launch cylinder
wall_thick      = 0.18; // 4.5mm thick impact-modified walls
barrel_diameter = 0.35; // Internal bore diameter sized for the hard shell gel capsule (~9mm/.35")

module gel_suppression_launcher() {
    difference() {
        // 1. Primary Ruggedized Body (Standard Fire Red High-Impact Polymer)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }
        
        // 2. Smooth-Bore Launch Cylinder (Chamber for the hard plastic gel capsule)
        // Positioned at a 45-degree angle to point downward from ceiling corners
        translate([0.65, 0.65, -0.05])
            cylinder(h = block_length + 0.1, d = barrel_diameter);
            
        // 3. Recessed Valve Compartment (Nests the electromechanical solenoid valve)
        translate([wall_thick, wall_thick, wall_thick])
            cube([0.45, 0.45, block_length - (wall_thick * 2)]);
            
        // 4. IP67 Waterproof Power/Control Bulkhead Port
        translate([0.20, 0.20, block_length / 2])
            rotate([0, 90, 45])
                cylinder(h = 0.8, d = 0.45, center=true); // Sized for waterproof solenoid control wiring
                
        // 5. Exterior Mechanical Alignment Notch (Sightline reference for the camera)
        translate([block_width * 0.4, -0.01, block_length - 0.5])
            cube([0.05, 0.05, 0.4]);
    }
    
    // 6. External Heavy-Duty Load-Bearing Flanges (For flush ceiling/wall anchoring)
    translate([-0.25, 0, 0])
        difference() {
            cube([0.25, 0.60, block_length]);
            translate([0.12, 0.30, block_length / 2])
                rotate([0, 90, 0])
                    cylinder(h = 0.6, d = 0.20, center=true); // Pass-through for heavy-gauge anchor screws
        }
}

gel_suppression_launcher();
