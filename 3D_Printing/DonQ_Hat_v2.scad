$fn = 100; // High resolution for smooth curves

// --- VARIABLES ---
brim_diameter = 65;
brim_thickness = 4;
center_hole_diameter = 30;
notch_diameter = 20; 
notch_depth = notch_diameter / 3; 
crown_height = 20;        
crown_wall_thickness = 2; 

// New variable for the mounting plug
mount_diameter = 19.0; 
mount_height = 10; // Depth of the plug into the head

// --- MODEL GENERATION ---
union() {
    
    // SECTION A: THE BRIM
    difference() {
        rotate_extrude() {
            translate([0, -brim_thickness/2, 0])
            hull() {
                square([center_hole_diameter/2, brim_thickness]);
                translate([(brim_diameter/2) - (brim_thickness/2), brim_thickness/2])
                    circle(r = brim_thickness/2);
            }
        }
        cylinder(d=center_hole_diameter, h=brim_thickness + 2, center=true);
        
        translate([ (brim_diameter / 2) - (notch_diameter / 2) + notch_depth, 0, 0])
            cylinder(d=notch_diameter, h=brim_thickness + 2, center=true);
    }

    // SECTION B: THE BOWL-SHAPED CROWN & MOUNT
    translate([0, 0, -brim_thickness/2]) {
        // 1. The Mounting Plug (Added)
        cylinder(d=mount_diameter, h=mount_height);

        // 2. The Crown
        difference() {
            scale([1, 1, crown_height / (center_hole_diameter / 2)])
                sphere(r = center_hole_diameter / 2);

            scale([1, 1, (crown_height - crown_wall_thickness) / ((center_hole_diameter - (crown_wall_thickness * 2)) / 2)])
                sphere(r = (center_hole_diameter / 2) - crown_wall_thickness);

            translate([0, 0, -crown_height])
                cube([brim_diameter + 10, brim_diameter + 10, crown_height * 2], center=true);
        }
    }
}
