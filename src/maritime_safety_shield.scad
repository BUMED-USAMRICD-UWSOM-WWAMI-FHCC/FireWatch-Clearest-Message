// Maritime Safety Infrastructure & Fleet Readiness Tracking Module
// Resolution for geometric roundings
$fn = 64; 

// Ruggedized Marine Form Factors (Engineered to withstand heavy sea spray and vibration)
casing_width   = 1.75; // Inches
casing_height  = 1.75; 
casing_length  = 1.20; 
hull_thickness = 0.12; // 3mm reinforced marine-grade protective shell

module maritime_safety_shield() {
    difference() {
        // 1. Primary Structural Chassis Basin (Molded in High-Visibility Safety Red)
        linear_extrude(height = casing_length) {
            polygon(points=[[0,0], [casing_width,0], [0,casing_height]]);
        }
        
        // 2. Sealed Internal Electronic Sanctuary Cavity (Isolates telemetry links)
        translate([hull_thickness, hull_thickness, hull_thickness])
            linear_extrude(height = casing_length - (hull_thickness * 2)) {
                polygon(points=[[0,0], [casing_width - 0.30, 0], [0, casing_height - 0.30]]);
            }
            
        // 3. Continuous Interlocking Gasket Labyrinth Track
        // Seats salt-resistant Viton rubber seals against high-pressure washdowns
        translate([0.06, 0.06, casing_length - 0.08])
            linear_extrude(height = 0.10) {
                polygon(points=[[0,0], [casing_width - 0.12, 0], [0, casing_height - 0.12]]);
            }

        // 4. IP68 Threaded Panel-Mount Data Port Clearance
        // Circular profile designed for heavy-duty threaded marine brass collars
        translate([0.60, 0.60, casing_length / 2])
            rotate([0, 0, -45])
                cylinder(h = 0.9, d = 0.70, center=true); // Sized for double-gasket bulkhead couplers
    }
    
    // 5. Heavy-Duty External Mounting Flanges (For bulkhead or equipment rack fastening)
    translate([-0.20, 0, 0])
        difference() {
            cube([0.20, 0.40, casing_length]);
            translate([0.10, 0.20, casing_length / 2])
                rotate([0, 90, 0])
                    cylinder(h = 0.3, d = 0.15, center=true); // Pass-through hole for marine fasteners
        }
}

// Render the completed maritime infrastructure geometry
maritime_safety_shield();
