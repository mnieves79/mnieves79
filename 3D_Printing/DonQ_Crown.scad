$fn = 100;

// --- VARIABLES ---
crown_outer_diameter = 30; 
crown_height = 28;         
crown_wall = 2;            

// Cavity variables
mount_base_clearance = 30.5; // Room for the 30mm base
mount_peg_depth = 12;        // Depth of the mounting hole

// --- CROWN MODEL ---
difference() {
    // 1. Solid Outer Dome
    scale([1, 1, crown_height / (crown_outer_diameter / 2)])
        sphere(d = crown_outer_diameter);

    // 2. Hollow out the inside (The "Hat" interior)
    // We create a slightly smaller sphere to leave a 2mm wall
    scale([1, 1, (crown_height - crown_wall) / ((crown_outer_diameter - (crown_wall * 2)) / 2)])
        sphere(d = crown_outer_diameter - (crown_wall * 2));
    
    // 3. Ensure the mount area is cleared out
    // (This ensures the cavity connects correctly to the mounting base)
    cylinder(d = mount_base_clearance, h = mount_peg_depth);

    // 4. Flat bottom cut
    translate([0, 0, -crown_height/2])
        cube([crown_outer_diameter * 2, crown_outer_diameter * 2, crown_height], center=true);
}
