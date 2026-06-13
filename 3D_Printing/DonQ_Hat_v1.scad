$fn = 100; // Smooths out the circles and spheres

// --- VARIABLES (in millimeters) ---
brim_diameter = 65;
brim_thickness = 4;
center_hole_diameter = 30;

notch_diameter = 30;
notch_depth = notch_diameter / 3; // 10mm deep cut

// --- NEW CROWN VARIABLES ---
crown_wall_thickness = 2; // Thickness of the hat walls
crown_height = 15;        // Height from the bottom of the brim to the top

// --- MODEL GENERATION ---
union() {
    // SECTION A: THE BRIM WITH NOTCH
    difference() {
        // Main Brim Disk
        cylinder(d=brim_diameter, h=brim_thickness, center=true);
        
        // Center Head Hole (cut completely through the brim)
        cylinder(d=center_hole_diameter, h=brim_thickness + 2, center=true);
        
        // Historical Barber's Basin Notch
        translate([ (brim_diameter / 2) - (notch_diameter / 2) + notch_depth, 0, 0])
            cylinder(d=notch_diameter, h=brim_thickness + 2, center=true);
    }

    // SECTION B: THE BOWL-SHAPED CROWN
    // We lift the crown so its base sits exactly aligned with the brim
    translate([0, 0, -brim_thickness/2]) {
        difference() {
            // 1. Outer Dome
            // We use scale() to stretch a sphere into a bowler/basin dome shape
            scale([1, 1, crown_height / (center_hole_diameter / 2)])
                sphere(r = center_hole_diameter / 2);

            // 2. Inner Dome Cutout (Hollows out the hat)
            scale([1, 1, (crown_height - crown_wall_thickness) / ((center_hole_diameter - (crown_wall_thickness * 2)) / 2)])
                sphere(r = (center_hole_diameter / 2) - crown_wall_thickness);

            // 3. Chop off the bottom half of the sphere
            // (OpenSCAD spheres center at 0,0,0, so we clear out everything below the brim)
            translate([0, 0, -crown_height])
                cube([brim_diameter + 10, brim_diameter + 10, crown_height * 2], center=true);
        }
    }
}
