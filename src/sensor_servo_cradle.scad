// Industrial Sensor Infrastructure - Motorized Pan-Tilt Articulating Cradle
$fn = 64;

// Structural Dimensions for Lightweight Servo Frame
cradle_width   = 0.65; // Inches
cradle_length  = 1.20; // Inches
cradle_height  = 0.50; // Inches
wall_thick     = 0.06; // 1.5mm structural ribbing

module articulating_servo_cradle() {
    difference() {
        // 1. Core Framework Bracket
        cube([cradle_width, cradle_length, cradle_height]);
        
        // 2. Central Structural Sleeve (Nests the Multi-Sensor Micro-Dongle snugly)
        translate([wall_thick, wall_thick, -0.05])
            cube([cradle_width - (wall_thick * 2), cradle_length - (wall_thick * 2), cradle_height + 0.1]);
            
        // 3. Primary Horizontal Actuator Mounting Ring (Pan Servo Connector)
        translate([cradle_width / 2, -0.01, cradle_height / 2])
            rotate([-90, 0, 0])
                cylinder(h = wall_thick + 0.05, d = 0.10, center = true); // Fits industry-standard micro-servo horns
                
        // 4. Secondary Vertical Actuator Pivot Index (Tilt Servo Pin)
        translate([-0.01, cradle_length / 2, cradle_height / 2])
            rotate([0, 90, 0])
                cylinder(h = wall_thick + 0.05, d = 0.08, center = true);
    }
}

articulating_servo_cradle();
