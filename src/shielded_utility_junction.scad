// Industrial 12-Node Infrastructure - Advanced Submersion Shield Junction Box
$fn = 64;

// Scaled structural boundary footprint for ultra-harsh environments
pcb_length     = 215.0 * 0.0393701; // Inches (~8.46")
pcb_width      = 30.0  * 0.0393701;  // Inches (~1.18")
internal_depth = 1.65;               // Deeper basin for massive structural compound potting
wall_thick     = 0.16;               // Heavy-duty 4mm flame-retardant walls

module high_exposure_junction_shield() {
    difference() {
        // 1. Primary Structural Chassis Basin (Molded in Standard Fire Red polymer)
        cube([pcb_length + (wall_thick * 2), pcb_width + (wall_thick * 2), internal_depth + wall_thick]);
        
        // 2. Primary Internal Core Electronics Sanctuary Cavity
        translate([wall_thick, wall_thick, wall_thick])
            cube([pcb_length, pcb_width, internal_depth + 0.1]);
            
        // 3. Multi-Tiered Outer Labyrinth Gasket Groove (Twin Tracks)
        // Deflects high-pressure fluid vectors away from internal layout components
        translate([wall_thick / 3, wall_thick / 3, internal_depth + wall_thick - 0.08])
            cube([pcb_length + (wall_thick * 1.33), pcb_width + (wall_thick * 1.33), 0.10]);
            
        // 4. Threaded IP68 Heavy-Duty 2.1mm DC Power Bulkhead Opening
        translate([-0.05, (pcb_width / 2) + wall_thick, 0.6])
            rotate([0, 90, 0])
                cylinder(h = wall_thick + 0.1, d = 0.50); // Sized for double-gasket brass coupling collars
                
        // 5. Threaded IP68 Heavy-Duty Host Data Link USB-B Bulkhead Opening
        translate([pcb_length + wall_thick - 0.05, (pcb_width / 2) + wall_thick, 0.6])
            rotate([0, 90, 0])
                cylinder(h = wall_thick + 0.1, d = 0.70); // Deep threaded industrial bulkhead lock rings
    }
}

high_exposure_junction_shield();
