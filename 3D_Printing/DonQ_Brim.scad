$fn = 100; // Smooths out the circles (higher number = smoother)

// --- VARIABLES (in millimeters) ---
brim_diameter = 65;
brim_thickness = 4;
center_hole_diameter = 30;

notch_diameter = 30;
// How far the notch cuts into the brim (1/3 of its diameter)
notch_depth = notch_diameter / 3; 

// --- MODEL GENERATION ---
difference() {
    // 1. Main Brim Disk
    cylinder(d=brim_diameter, h=brim_thickness, center=true);
    
    // 2. Center Head Hole
    cylinder(d=center_hole_diameter, h=brim_thickness + 2, center=true);
    
    // 3. Historical Barber's Basin Notch
    // Positioned on the X-axis, shifting it inward by its radius minus the 1/3 depth
    translate([ (brim_diameter / 2) - (notch_diameter / 2) + notch_depth, 0, 0])
        cylinder(d=notch_diameter, h=brim_thickness + 2, center=true);
}
