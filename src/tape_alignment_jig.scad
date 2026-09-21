// Industrial USB Hub Infrastructure - Tape Application Alignment Jig
$fn = 64; 

// Form factor offsets to nest cleanly over the 1.2 in³ Corner Block Base
block_width    = 1.50; // Inches
block_height   = 1.50; // Inches
block_length   = 1.00; // Inches
wall           = 0.08; // 2mm wall thickness for the alignment template frame
tolerance      = 0.01; // Mechanical spacing clearance for easy tool removal

module adhesive_alignment_jig() {
    difference() {
        // 1. Master Exterior Alignment Jig Frame Block
        translate([-wall, -wall, -wall])
            cube([block_width + (wall * 2), block_height + (wall * 2), block_length + (wall * 2)]);
        
        // 2. Main Corner Block Positioning Cavity (Nests the module frame snugly)
        linear_extrude(height = block_length + tolerance) {
            polygon(points=[[-tolerance, -tolerance], 
                            [block_width + tolerance, -tolerance], 
                            [-tolerance, block_height + tolerance]]);
        }
        
        // 3. Bottom Plane Tape Alignment Window
        // Exposes the exact footprint for clean natural rubber-resin tape application
        translate([0.25, -wall - 0.02, 0.05])
            cube([block_width - 0.3, wall + 0.05, block_length - 0.1]);
            
        // 4. Back Plane Tape Alignment Window
        translate([-wall - 0.02, 0.25, 0.05])
            cube([wall + 0.05, block_height - 0.3, block_length - 0.1]);
            
        // 5. Solid Shields over Internal Channels
        // Completely masks the snap-channel and fluid-glue wells from tape placement
        translate([-tolerance, -tolerance, -wall - 0.01])
            cube([0.25 + tolerance, 0.25 + tolerance, wall + 0.05]);
    }
}

adhesive_alignment_jig();
