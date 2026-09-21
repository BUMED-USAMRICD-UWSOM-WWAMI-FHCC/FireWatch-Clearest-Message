// Breakaway Stub Isolation Cover - Flexible Rubber Extrusion
$fn = 64;

// Footprint matches the internal snap-channel boundary rules
cap_outer_x  = 0.28; // Inches
cap_outer_y  = 0.28; // Inches
cap_depth    = 0.35; // Inches (Provides deep surface isolation)
cap_wall     = 0.04; // 1mm wall thickness for snug rubber compression fit

module protective_rubber_cap() {
    difference() {
        // 1. Solid Outer Cap Protective Body
        cube([cap_outer_x, cap_outer_y, cap_depth]);
        
        // 2. Hollow Internal Press-Fit Core Cavity
        // Snugly slides over the fractured sub-surface gold lattice backbone stub
        translate([cap_wall, cap_wall, cap_wall])
            cube([cap_outer_x - (cap_wall * 2), cap_outer_y - (cap_wall * 2), cap_depth]);
    }
}

protective_rubber_cap();
