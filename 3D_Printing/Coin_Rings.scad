// Ring parameters [ID, OD, Height]
rings = [
    [25.0, 36.0, 1.5],
    [28.0, 30.0, 1.5],
    [21.0, 24.0, 1.5],
    [17.0, 18.0, 1.5],
    [19.0, 21.0, 1.5]
];

// Loop to render all 5 rings side-by-side
for (i = [0 : len(rings)-1]) {
    translate([i * 40, 0, 0]) 
    make_ring(rings[i][0], rings[i][1], rings[i][2]);
}

// Module to create a single ring
module make_ring(id, od, h) {
    difference() {
        cylinder(d = od, h = h, $fn = 100);
        translate([0, 0, -0.5]) 
            cylinder(d = id, h = h + 1, $fn = 100);
    }
}
