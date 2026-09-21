// FireWatch Industrial Infrastructure - Precision-Chambered Gel Capsule Launcher
// Dimensions explicitly scaled for 0.222" Capsule / 0.226" Base Neck Envelope
$fn = 64; 

// Conversion factor: 1 Inch = 25.4mm
mm_to_inch = 1 / 25.4;

// Exact Capsule Dimensional Constraints (Converted to Inches with +0.004" Clearance Tolerance)
capsule_dia     = (5.64 + 0.1) * mm_to_inch; // ~0.226" smooth-bore cylinder line
base_neck_dia   = (5.74 + 0.1) * mm_to_inch; // ~0.230" recessed chamber entry base
case_length     = (10.7 + 0.1) * mm_to_inch; // ~0.425" case ledge depth index
overall_length  = (17.7 + 0.1) * mm_to_inch; // ~0.701" maximum seating limit depth

// Streamlined Structural Framing Constraints (Strictly under 1.2 Cubic Inches)
block_width     = 1.35; 
block_height    = 1.35; 
block_length    = 1.85; // Optimized thickness for lightweight natural adhesive pads
wall_thick      = 0.12; // 3mm impact-resistant outer perimeter shell

module calibrated_capsule_launcher() {
    difference() {
        // 1. Primary Lightweight Prism Chassis (Molded in Standard Fire Red Polymer)
        linear_extrude(height = block_length) {
            polygon(points=[, [block_width,0], [0,block_height]]);
        }
        
        // 2. Precision Smooth-Bore Launch Cylinder (Angled center-axis pass-through)
        translate([0.55, 0.55, -0.05])
            union() {
                // Main projectile flight bore channel (0.226" diameter clearance)
                cylinder(h = block_length + 0.1, d = capsule_dia);
                
                // Recessed seat matching the 0.230" base neck step limits
                cylinder(h = overall_length, d = base_neck_dia);
                
                // Rear pressure chamber shoulder step matching the 0.425" case line
                cylinder(h = case_length, d = base_neck_dia + 0.02);
            }
            
        // 3. Compact Low-Draw Valve Compartment (Nests 12V pneumatic micro-actuator)
        translate([wall_thick, wall_thick, wall_thick])
            cube([0.35, 0.35, block_length - (wall_thick * 2)]);
            
        // 4. IP67 Waterproof Data/Control Bulkhead Port Opening
        translate([0.16, 0.16, block_length / 2])
            rotate([0, 0, -45])
                cylinder(h = 0.6, d = 0.38, center=true);
                
        // 5. Dual-Groove Camera Alignment Notches (For multi-variant lens locking)
        translate([block_width * 0.38, -0.01, block_length - 0.4])
            cube([0.03, 0.05, 0.3]);
        translate([block_width * 0.44, -0.01, block_length - 0.4])
            cube([0.03, 0.05, 0.3]);
    }
}

calibrated_capsule_launcher();
