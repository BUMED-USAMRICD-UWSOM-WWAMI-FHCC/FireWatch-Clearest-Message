// FireWatch Industrial Tooling - Streamlined Tape Application Alignment Jig
// Explicitly scaled to mask and hold the 1.35" x 1.35" Calibrated Chassis
$fn = 64; 

// Form factor offsets to nest cleanly over the downscaled single-chamber module
block_width    = 1.35; // Inches
block_height   = 1.35; 
block_length   = 1.00; // Profile height for tool stabilization
wall           = 0.08; // 2mm ruggedized perimeter masking wall
tolerance      = 0.01; // Mechanical slip clearance margin

module streamlined_alignment_jig() {
    difference() {
        // 1. Primary Exterior Tooling Frame Block
        translate([-wall, -wall, -wall])
            cube([block_width + (wall * 2), block_height + (wall * 2), block_length + (wall * 2)]);
        
        // 2. Center Nosing Pocket (Nests the Standard Fire Red capsule launcher snugly)
        linear_extrude(height = block_length + tolerance) {
            polygon(points=[[-tolerance, -tolerance], 
                            [block_width + tolerance, -tolerance], 
                            [-tolerance, block_height + tolerance]]);
        }
        
        // 3. Bottom Plane Tape Application Slot
        // Exposes exact boundary tracks for the pre-cut natural tree-rubber tape
        translate([0.25, -wall - 0.02, 0.05])
            cube([block_width - 0.3, wall + 0.05, block_length - 0.1]);
            
        // 4. Back Plane Tape Application Slot
        translate([-wall - 0.02, 0.25, 0.05])
            cube([wall + 0.05, block_height - 0.3, block_length - 0.1]);
            
        // 5. High-Impact Internal Mask Shields
        // Protects the 0.222" micro-bore barrel paths from adhesive or residue transfer
        translate([-tolerance, -tolerance, -wall - 0.01])
            cube([0.25 + tolerance, 0.25 + tolerance, wall + 0.05]);
    }
}

// Instantiate the production tool layer
streamlined_alignment_jig();
