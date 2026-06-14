$fn = 100;

// --- VARIABLES ---
brim_diameter = 65;
brim_thickness = 4;
center_hole_diameter = 30;
notch_diameter = 20; 
notch_depth = notch_diameter / 3; 

// Updated for the statue's anatomy
crown_height = 25;        
crown_wall_thickness = 2; 

// Stepped mount dimensions
mount_peg_diameter = 18.5; // 19mm hole - 0.5mm clearance
mount_peg_height = 10;     // Depth of the peg
cavity_base_diameter = 28; // 27mm base + 1mm clearance

// --- MODEL GENERATION ---
union() {
    
    // SECTION A: THE BRIM
    // We remove the hole here because the crown will now be the base
    difference() {
        rotate_extrude() {
            translate([0, -brim_thickness/2, 0])
            hull() {
                square([center_hole_diameter/2, brim_thickness]);
                translate([(brim_diameter/2) - (brim_thickness/2), brim_thickness/2])
                    circle(r = brim_thickness/2);
            }
        }
        
        translate([ (brim_diameter / 2) - (notch_diameter / 2) + notch_depth, 0, 0])
            cylinder(d=notch_diameter, h=brim_thickness + 5, center=true);
    }

    // SECTION B: THE CROWN & INTERNAL CAVITY
    translate([0, 0, -brim_thickness/2]) {
        difference() {
            // Outer shape
            scale([1, 1, crown_height / (center_hole_diameter / 2)])
                sphere(r = center_hole_diameter / 2);

            // Internal Stepped Cavity (The "Negative" space)
            union() {
                // 1. The 19mm peg hole area
                cylinder(d=mount_peg_diameter, h=mount_peg_height);
                // 2. The 27mm base clearing area
                cylinder(d=cavity_base_diameter, h=5); 
            }
            
            // Clean base cut
            translate([0, 0, -crown_height/2])
                cube([brim_diameter*2, brim_diameter*2, crown_height], center=true);
        }
    }
}
