// Industrial 12-Node Hub - Indoor IP65 Sealed Server Junction Enclosure
$fn = 64;

// Physical dimensions adjusted for industrial gasket tracking
pcb_length     = 215.0 * 0.0393701; // Inches (~8.46")
pcb_width      = 30.0  * 0.0393701;  // Inches (~1.18")
internal_depth = 1.40;               // Additional cavity clearance for potted wiring
wall_thick     = 0.12;               // 3mm ruggedized flame-retardant walls

module ip65_server_junction_box() {
    difference() {
        // 1. Master Exterior Enclosure Tub (Molded in Standard Fire Red polymer)
        cube([pcb_length + (wall_thick * 2), pcb_width + (wall_thick * 2), internal_depth + wall_thick]);
        
        // 2. Sealed Internal Electronic Sanctuary Cavity
        translate([wall_thick, wall_thick, wall_thick])
            cube([pcb_length, pcb_width, internal_depth + 0.1]);
            
        // 3. Continuous Continuous O-Ring Gasket Track Along Rim Wall
        // Compresses flat to create an unbreachable indoor moisture boundary
        translate([wall_thick / 2, wall_thick / 2, internal_depth + wall_thick - 0.05])
            difference() {
                cube([pcb_length + wall_thick, pcb_width + wall_thick, 0.06]);
                translate([0.04, 0.04, -0.01])
                    cube([pcb_length + wall_thick - 0.08, pcb_width + wall_thick - 0.08, 0.08]);
            }
            
        // 4. Threaded IP67 Waterproof 2.1mm DC Power Feed Hole
        translate([-0.05, (pcb_width / 2) + wall_thick, 0.5])
            rotate([0, 90, 0])
                cylinder(h = wall_thick + 0.1, d = 0.45); // Sized for waterproof barrel bulkhead connectors
                
        // 5. Threaded IP67 Waterproof Host Data Link USB-B Hole
        translate([pcb_length + wall_thick - 0.05, (pcb_width / 2) + wall_thick, 0.5])
            rotate([0, 90, 0])
                cylinder(h = wall_thick + 0.1, d = 0.65); // Standard 16.5mm sealed bulkhead collar
    }
}

ip65_server_junction_box();
