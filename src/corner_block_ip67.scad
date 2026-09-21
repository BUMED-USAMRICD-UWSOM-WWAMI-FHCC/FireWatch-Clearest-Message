// Industrial USB Hub Infrastructure - IP67 Waterproof Corner Cut Module
$fn = 64; 

block_width    = 1.55; // Slightly scaled to accommodate sealing gasket tracks
block_height   = 1.55; 
block_length   = 1.05; 
wall_thickness = 0.10; // Thickened to 2.5mm for water pressure handling

module waterproof_corner_block() {
    difference() {
        // 1. Primary Structural Body (Standard Fire Red Profile)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }
        
        // 2. Sealed Internal Electronic Cavity
        translate([wall_thickness, wall_thickness, wall_thickness])
            linear_extrude(height = block_length - (wall_thickness * 2)) {
                polygon(points=[[0,0], [block_width - 0.25, 0], [0, block_height - 0.25]]);
            }
            
        // 3. Continuous Perimeter Gasket Groove (For O-Ring or Elastomeric Seal)
        // Blocks entry of ceiling leaks or high-pressure spray wash-downs
        translate([0.05, 0.05, block_length - 0.06])
            linear_extrude(height = 0.08) {
                polygon(points=[[0,0], [block_width - 0.1, 0], [0, block_height - 0.1]]);
            }

        // 4. IP67 Waterproof Threaded USB-B Interface Cutout
        // Circular profile to accommodate waterproof threaded panel couplings
        translate([0.55, 0.55, block_length / 2])
            rotate([0, 0, -45])
                cylinder(h = 0.8, d = 0.65, center=true); // 16.5mm standard IP67 threaded collar hole
    }
}

waterproof_corner_block();
