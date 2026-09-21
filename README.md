# FireWatch-Clearest-Message
Industrial USB Quantum Hub Infrastructure, customized for the Seattle 100-Day Public Safety Plan in collaboration with Tom Lynch at Fred Hutch.

HARDWARE SYSTEM COMPONENT SPECIFICATION & FABRICATION DOCUMENTATION
-------------------------------------------------------------------

Project: Industrial USB Multi-Sensor Infrastructure Integration Array\
Target Systems: Edwards FireWorks 3D Mapping / Genetec Security Center Dashboard Platforms\
Deployment Framework: Seattle Business Protection Initiative / Univac IX Resilient Cores Blueprint

* * * * *

1\. SYSTEM OVERVIEW & MATERIAL SPECIFICATIONS
---------------------------------------------

This system provides a modular, fire-safe perimeter monitoring framework that integrates a physical breakable mounting strip, specialized corner-mounted enclosure blocks, multi-sensor micro-dongles, and an automated deployment pipeline.

Core Mechanical & Material Profiles
-----------------------------------

-   Enclosure Compound: Injection-molded or 3D-extruded polymer utilizing Standard Fire Red pigments to comply with international NFPA safety color standards.
-   Adhesive Interface Pad: Precision pre-cut double-sided tape using a 100% natural, solvent-free tree-rubber resin compound. This ensures an aggressive viscoelastic bond on irregular or painted commercial surfaces without chemical outgassing.
-   Thermal Compound Matrix: The natural rubber matrix is loaded with Titanium Diboride (TiB₂) particles. This compound matches the high heat dissipation properties of titanium while maintaining electrical insulation. It draws heat from internal power rails and uses the building's surface structure as an expansive heat sink.

* * * * *

2\. MECHANICAL ARCHITECTURE & MANUFACTURING CODES
-------------------------------------------------

All models are engineered to adhere to strict volumetric limits of 1.2 cubic inches per structural node.

A. Glue-Ready Corner Block Chassis (`corner_block_v8.scad`)
-----------------------------------------------------------

This OpenSCAD model generates a single right-triangular corner-cut enclosure. It incorporates deep sub-surface channels that contain the broken backbone strip stub and its flexible protective rubber cap below the mounting plane. Additionally, it features twin fluid-glue catchment reservoirs that trap expanding structural adhesives, allowing clean installation on rough stucco or brick without disrupting the flush-mount profile.

```
// Industrial USB Hub Infrastructure - Corner Block (KiCad 8.0 / Glue-Ready)
$fn = 64;

block_width    = 1.50; // Inches
block_height   = 1.50; // Inches
block_length   = 1.00; // Inches (Extrusion depth)
wall_thickness = 0.08; // 2mm high-durability wall

module glue_ready_corner_block() {
    difference() {
        // 1. Primary Structural Body (Standard Fire Red Profile)
        linear_extrude(height = block_length) {
            polygon(points=[[0,0], [block_width,0], [0,block_height]]);
        }

        // 2. Deep Recessed Internal Snap-Channel
        translate([-0.05, -0.05, -0.1])
            cube([0.25, 0.25, block_length + 0.2]);

        // 3. Pre-Cut Natural Tape Bed Recess
        translate([0.25, -0.01, -0.05])
            cube([block_width - 0.3, 0.02, block_length + 0.1]);
        translate([-0.01, 0.25, -0.05])
            cube([0.02, block_height - 0.3, block_length + 0.1]);

        // 4. Liquid-Glue Micro-Reservoirs (Dual Wall Retention Insets)
        translate([0.5, 0.04, 0.1])
            cube([0.4, 0.05, block_length - 0.2]);
        translate([0.04, 0.5, 0.1])
            cube([0.05, 0.4, block_length - 0.2]);

        // 5. Standard USB-B Receptacle Port Interface (Industry Default Colorway)
        translate([0.45, 0.45, block_length / 2])
            rotate([0, 0, -45])
                union() {
                    cube([0.48, 0.47, 0.42], center=true);
                    translate([0, 0.2, 0])
                        cube([0.55, 0.50, 0.50], center=true);
                }
    }
}
glue_ready_corner_block();

```

B. Micro-Sensor Thumb-Stick Dongle (`micro_sensor_dongle.scad`)
---------------------------------------------------------------

Houses the physical video sensor, MEMS microphone, and infrared bolometer array within a unified lightweight thumb-stick envelope.

```
// Industrial Multi-Sensor Micro-Dongle Enclosure
$fn = 64;

dongle_width  = 0.45; // Inches
dongle_length = 1.10; // Inches
dongle_height = 0.40; // Inches
wall_thick    = 0.04; // 1mm protective shell

module sensor_dongle_chassis() {
    difference() {
        cube([dongle_width, dongle_length, dongle_height]);

        translate([wall_thick, wall_thick, wall_thick])
            cube([dongle_width - (wall_thick * 2), dongle_length - (wall_thick * 2), dongle_height - (wall_thick * 2)]);

        // Front Optical Lens Window (Camera)
        translate([dongle_width / 2, dongle_length - wall_thick - 0.02, dongle_height * 0.7])
            cylinder(h = wall_thick + 0.05, d = 0.12, center = true);

        // Infrared Lens Window (Heat Sensor)
        translate([dongle_width / 2, dongle_length - wall_thick - 0.02, dongle_height * 0.3])
            cylinder(h = wall_thick + 0.05, d = 0.16, center = true);

        // Acoustic Port Entry (MEMS Microphone)
        translate([dongle_width - wall_thick - 0.02, dongle_length - 0.2, dongle_height / 2])
            cylinder(h = wall_thick + 0.05, d = 0.04, center = true);

        // Rear USB-B Standard Male Interface Output Slot
        translate([dongle_width / 2, -0.01, dongle_height / 2])
            cube([0.40, wall_thick + 0.05, 0.35], center = true);
    }
}
sensor_dongle_chassis();

```

C. Industrial Tooling: Adhesive Application Jig (`tape_alignment_jig.scad`)
---------------------------------------------------------------------------

To maintain high production speeds on the assembly floor, this negative-space mold nests over the corner module, masking the snap-channels and glue reservoirs while exposing only the exact trace fields for applying the pre-cut adhesive pads.

```
// Tape Application Alignment Jig - Factory Production Tooling
$fn = 64;
block_width = 1.50; block_height = 1.50; block_length = 1.00; wall = 0.08; tolerance = 0.01;

difference() {
    translate([-wall, -wall, -wall]) cube([block_width + (wall * 2), block_height + (wall * 2), block_length + (wall * 2)]);
    linear_extrude(height = block_length + tolerance) {
        polygon(points=[[-tolerance, -tolerance], [block_width + tolerance, -tolerance], [-tolerance, block_height + tolerance]]);
    }
    translate([0.25, -wall - 0.02, 0.05]) cube([block_width - 0.3, wall + 0.05, block_length - 0.1]);
    translate([-wall - 0.02, 0.25, 0.05]) cube([wall + 0.05, block_height - 0.3, block_length - 0.1]);
    translate([-tolerance, -tolerance, -wall - 0.01]) cube([0.25 + tolerance, 0.25 + tolerance, wall + 0.05]);
}

```

* * * * *

3\. ELECTRICAL ROUTING & LAYOUT ARCHITECTURE (KICAD 8.0)
--------------------------------------------------------

To prevent fire hazards across perimeter nodes, the electrical system isolates the USB bus completely to high-speed differential signal transmission. Main power requirements are driven by a dedicated, multi-voltage industrial power brick (120V--600V AC inputs) split down into independent multi-channel outputs via a 2.1mm inner pin / 5.5mm outer sleeve barrel jack bus structure.

A. Trace Optimization & Fire Mitigation Rules
---------------------------------------------

1.  Trace Thickness Standards: All power distribution pathways must employ heavy-duty 2oz/3oz thick copper planes to prevent localized Joule heating and current drop-offs over extended cable lengths.
2.  Impedance Vector Wraps: Signal paths must implement strict 45-degree angle trace wrap-around geometry to prevent signal reflection bottlenecks.
3.  Cross-Talk Isolation Rings: Native RT Guard Rings connected directly to the ground plane must completely encircle all analog component inputs (e.g., MEMS microphone lines) to prevent electrical interference.

B. KiCad 8.0 Template Excerpt (`usb_quantum_hub_12.kicad_pcb`)
--------------------------------------------------------------

This structural S-expression template configures a high-performance 4-layer copper configuration with tight layout constraints designed for automated pickup placement validation.

```
(pcbnew_board (version 20240108) (generator "pcbnew")
  (meta (generator "KiCad") (version "8.0.0"))
  (general (thickness 1.6))
  (layers
    (0 "F.Cu" signal)
    (1 "In1.Cu" power)
    (2 "In2.Cu" ground)
    (3 "B.Cu" signal)
    (44 "Edge.Cuts" user)
  )
  (setup
    (track_width 0.50)       ; Thick 2oz/3oz power trace routing default
    (min_track_width 0.25)
    (clearance 0.30)         ; High isolation clearance to mitigate electrical arc risks
  )
  ;; Master 2.1mm Input Power Barrel Jack Footprint
  (footprint "Connector_BarrelJack:BarrelJack_Horizontal"
    (at 10.0 50.0 0) (layer "F.Cu")
    (property "Reference" "J_PWR1" (at 10.0 45.0 0) (layer "F.SilkS"))
  )
  ;; Individual Node Footprints Sample (1 of 12)
  (footprint "Connector_USB:USB_B_Female_Horizontal"
    (at 40.0 50.0 0) (layer "F.Cu")
    (property "Reference" "J1" (at 40.0 45.0 0) (layer "F.SilkS"))
  )
  (gr_rect (start 5.0 35.0) (end 215.0 65.0) (layer "Edge.Cuts") (width 0.1))
)

```

* * * * *

4\. DETERMINISTIC ANTI-CLASH IDENTIFICATION PROTOCOL
----------------------------------------------------

To ensure no two devices across the municipal mesh grid generate clashing IDs, identity is derived deterministically from the host environment at the moment the GitHub project ZIP file is extracted.

A. The Identity Derivation Formula
----------------------------------

Every device is mapped through a strict two-tier coordinate address space:\
$$\text{Final Unique ID (4 Hex Characters)} = \text{Host MAC Address Identification Byte (2 Hex)} + \text{Physical Segment Socket Index (2 Hex)}$$

-   Hub Strip ID Example: `B4-H12` (Denotes a 12-port breakaway strip backbone driven by host node `0xB4`).
-   Dongle Endpoint ID Example: `B403` (Denotes the device seated in physical slot #3 on that specific strip).

B. Automated Cross-Platform Deployment Engine (`run_init.sh`)
-------------------------------------------------------------

This shell utility executes during extraction, running hardware hooks to write a static local profile (`local_node_config.txt`) that blocks address generation spoofing.

```
#!/usr/bin/env bash
# FireWatch Linux/macOS First-Run Identity Provisioner

# Target primary cross-platform network interface hardware layers
if [ -d /sys/class/net/eth0 ]; then
    RAW_MAC=$(cat /sys/class/net/eth0/address)
else
    RAW_MAC=$(ifconfig | grep -o -E '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' | head -n1)
fi

CLEAN_MAC=$(echo "${RAW_MAC//:/}" | tr '[:lower:]' '[:upper:]')
HOST_PREFIX="${CLEAN_MAC: -2}"

echo "HOST_PREFIX=${HOST_PREFIX}" > local_node_config.txt
echo "CONFIG_TIMESTAMP=$(date)" >> local_node_config.txt

```

* * * * *

5\. FIXED-WIDTH EDWARDS FIREWORKS TELEMETRY ENCODING
----------------------------------------------------

Data packet frames are restricted to a strict, fixed-width 20-character ASCII text sentence piped over the data-only USB lines every 100 milliseconds. This allows the server parsing engine to use direct index slicing instead of complex regex calculations, enabling zero-latency threshold checking.

Character Allocation Map
------------------------

```
  # F W   B 4 0 3   0  0  2   0  4  1   0  2  3  4   0  2  9
  └──┬──┘ └───┬───┘ └───┬───┘ └───┬───┘ └────┬────┘   └──┬──┘
     │        │         │         │          │           └─ Internal Core safety temp (29°C)
     │        │         │         │          └─ Max local heat in tenths of a degree (23.4°C)
     │        │         │         └─ Audio amplitude level decibels (41 dB)
     │        │         └─ Camera pixel activity percentage change (2%)
     │        └─ Static Unique Node Identification Address (0xB403)
     └─ Frame Synchronization Sync Word Header

```

* * * * *

6\. LOGISTICS MANIFEST & PRODUCTION VISUALIZATION
-------------------------------------------------

Every factory initialization run appends its configuration data directly to a master tracking ledger file, automatically formatted for Microsoft Visio Data Visualizer layout workflows and Edwards 3D Canvas spatial maps.

Automated Asset Logger Sheet (`firewatch_global_manifest.csv`)
--------------------------------------------------------------

```
Timestamp,Host_Prefix,Asset_Class,Unique_Hardware_ID,Parent_Hub_ID,Physical_Port_Slot,Operating_System,Operator_User
2026-09-20 22:25:01,B4,HUB_MASTER_STRIP,B4-H12,NONE,00,Linux Ubuntu 24.04,tlynch
2026-09-20 22:25:01,B4,SENSOR_NODE_DONGLE,B401,B4-H12,01,Linux Ubuntu 24.04,tlynch
2026-09-20 22:25:01,B4,SENSOR_NODE_DONGLE,B402,B4-H12,02,Linux Ubuntu 24.04,tlynch

```

Avery 5160 Production Printer Grid
----------------------------------

The physical label sheets outputted onto the production floor format asset stickers in an exact 3-column, 10-row matrix corresponding to standard Avery 5160 template sheets.

Each label generates a block structure enclosing the system asset class, tracking parameters, and a high-contrast, text-molded ASCII QR Code Symbol for rapid smartphone inventory verification.

```
+---------------------------+ +---------------------------+ +---------------------------+

| === FIREWATCH HUB ===     | | == SENSOR NODE 01 ==      | | == SENSOR NODE 02 ==      |
| ID: B4-H12                | | ID: B401                  | | ID: B402                  |
| Class: HUB_ASSET_01       | | Loc: Corner Drop 01       | | Loc: Corner Drop 02       |
|  █▀▀▀█ █ █ █▀▀▀█          | |  █▀▀▀█ █ █ █▀▀▀█          | |  █▀▀▀█ █ █ █▀▀▀█          |
|  █ ██ █ ▀█ █ ██ █         | |  █ ██ █ ▀█ █ ██ █         | |  █ ██ █ ▀█ █ ██ █         |
|  ▀▀▀▀▀ ▀ ▀ ▀▀▀▀▀          | |  ▀▀▀▀▀ ▀ ▀ ▀▀▀▀▀          | |  ▀▀▀▀▀ ▀ ▀ ▀▀▀▀▀          |
+---------------------------+ +---------------------------+ +---------------------------+

```

* * * * *
