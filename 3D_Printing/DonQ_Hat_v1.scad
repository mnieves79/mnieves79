$fn = 100; // High resolution for smooth curves

// --- VARIABLES (Updated per your requests) ---
brim_diameter = 65;
brim_thickness = 4;
center_hole_diameter = 30;

// Request 2: Reduced notch diameter by 10mm (30mm -> 20mm)
notch_diameter = 20; 
notch_depth = notch_diameter / 3; 

// Request 1: Increased crown height by 5mm (15mm -> 20mm)
crown_height = 20;        
crown_wall_thickness = 2; 

// --- MODEL GENERATION ---
union() {
    
    // SECTION A: THE BRIM WITH ROUNDED OUTER EDGE
    difference() {
        
        // Request 3: Rounded outer edge
        // We create a 2D profile of a rectangle with a rounded outer edge 
        // and spin it 360 degrees using rotate_extrude.
        rotate_extrude() {
            translate([0, -brim_thickness/2, 0]) // Center vertically
            hull() {
                // Inner flat boundary (extends past the center hole)
                square([center_hole_diameter/2, brim_thickness]);
                
                // Outer edge rounded by a small circle
                translate([(brim_diameter/2) - (brim_thickness/2), brim_thickness/2])
                    circle(r = brim_thickness/2);
            }
        }
        
        // Center Head Hole
        cylinder(d=center_hole_diameter, h=brim_thickness + 2, center=true);
        
        // Historical Barber's Basin Notch (cuts cleanly through the rounded edge)
        translate([ (brim_diameter / 2) - (notch_diameter / 2) + notch_depth, 0, 0])
            cylinder(d=notch_diameter, h=brim_thickness + 2, center=true);
    }

    // SECTION B: THE BOWL-SHAPED CROWN (Taller)
    translate([0, 0, -brim_thickness/2]) {
        difference() {
            // 1. Outer Dome (Scaled to the new 20mm height)
            scale([1, 1, crown_height / (center_hole_diameter / 2)])
                sphere(r = center_hole_diameter / 2);

            // 2. Inner Dome Cutout
            scale([1, 1, (crown_height - crown_wall_thickness) / ((center_hole_diameter - (crown_wall_thickness * 2)) / 2)])
                sphere(r = (center_hole_diameter / 2) - crown_wall_thickness);

            // 3. Clear out everything below the brim base
            translate([0, 0, -crown_height])
                cube([brim_diameter + 10, brim_diameter + 10, crown_height * 2], center=true);
        }
    }
}
