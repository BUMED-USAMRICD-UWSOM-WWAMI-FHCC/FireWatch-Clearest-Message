// Industrial 12-Node Quantum Hub - Master Rack-Mountable Case
$fn = 64;

// Board & Case Dimensions (Matches the 215mm x 30mm KiCad 8.0 Edge.Cuts Profile)
pcb_length   = 215.0 * 0.0393701; // Convert mm to Inches (~8.46")
pcb_width    = 30.0  * 0.0393701; // Convert mm to Inches (~1.18")
case_height  = 1.25;               // Inches (Low-profile space management)
wall         = 0.10;               // Inches (Ruggedized wall thickness)

module master_server_enclosure() {
    difference() {
        // 1. Solid Outer Chassis Box (Printed in Standard Fire Red)
        cube([pcb_length + (wall * 2), pcb_width + (wall * 2), case_height], center=false);
        
        // 2. Main Internal Electronic Cavity
        translate([wall, wall, wall])
            cube([pcb_length, pcb_width, case_height]);
            
        // 3. Flush 2.1mm Input Power Barrel Jack Pass-Through Hole
        translate([-0.05, (pcb_width / 2) + wall, 0.4])
            rotate([0, 90, 0])
                cylinder(h = wall + 0.1, d = 0.32); // 8.1mm outer clearance thread diameter
                
        // 4. Flush Host Data Link USB-B Face Cutout
        // Eliminates loose external cabling directly at the server shelf boundary
        translate([pcb_length + wall - 0.05, (pcb_width / 2) + wall, 0.5])
            cube([wall + 0.2, 0.55, 0.50], center=true);
            
        // 5. Open Perimeter Ventilation Slots
        // Enhances structural thermal bleed from the 2oz/3oz thick copper bus
        for (slot = [1 : 1 : 8]) {
            translate([slot * (pcb_length / 9), -0.05, case_height - 0.25])
                cube([0.4, wall + 0.1, 0.15]);
        }
    }
    
    // 6. Internal Slide-Lock PCB Mounting Rails
    translate([wall, wall, wall])
        difference() {
            cube([pcb_length, 0.06, 0.12]);
            translate([-0.05, -0.01, 0.04])
                cube([pcb_length + 0.1, 0.08, 0.08]); // Recessed groove for PCB slide-in
        }
}

master_server_enclosure();
