// Industrial 12-Node Quantum Hub - Heavy-Duty Dust-Proof Locking Lid
$fn = 64;

// Matches the 215mm x 30mm PCB footprint constraints
pcb_length   = 215.0 * 0.0393701; // Inches (~8.46")
pcb_width    = 30.0  * 0.0393701; // Inches (~1.18")
wall         = 0.10;               // Wall thickness 
lid_thickness = 0.08;              // Core lid thickness
snap_clearance = 0.01;             // Mechanical tolerance allowance

module industrial_locking_lid() {
    union() {
        // 1. Primary Lid Protective Shield Plate
        cube([pcb_length + (wall * 2), pcb_width + (wall * 2), lid_thickness], center=false);
        
        // 2. Continuous Internal Dual-Lip Dust Gasket Channel
        // Seals out industrial overspray and particulate matter
        translate([wall + snap_clearance, wall + snap_clearance, -0.06])
            difference() {
                cube([pcb_length - (snap_clearance * 2), pcb_width - (snap_clearance * 2), 0.06]);
                translate([0.04, 0.04, -0.01])
                    cube([pcb_length - (snap_clearance * 2) - 0.08, pcb_width - (snap_clearance * 2) - 0.08, 0.08]);
            }
            
        // 3. Heavy-Duty Side Locking Tabs (Snaps into Main Chassis Base)
        // Positioned symmetrically to distribute locking pressure evenly
        for (tab_x = [0.5, pcb_length / 2, pcb_length - 0.5]) {
            // Front side locking tabs
            translate([tab_x + wall, wall - 0.02, -0.15])
                cube([0.40, 0.04, 0.15]);
            // Rear side locking tabs
            translate([tab_x + wall, pcb_width + wall - 0.02, -0.15])
                cube([0.40, 0.04, 0.15]);
        }
    }
}

industrial_locking_lid();
