$fn = 15;
t = 0.01;
clearance = 0.2;
wall = 1.5;

include <../3d-stuff/shapes.scad>

module pcb(no_clearance) {
    c = (no_clearance)? 0: clearance;
    pcb_size = [70.2, 30.1, 1.5];
    // pcb
    color("green")
    difference() {
        translate([-c, -c, -c])
        cube([pcb_size.x+c*2, pcb_size.y+c*2, pcb_size.z+c*2]);
        // mount holes
        mh_padding = 1 + 2.25/2;
        for (x = [mh_padding, pcb_size.x-mh_padding], y = [mh_padding, pcb_size.y - mh_padding]) {
            translate([x, y, -c-t])
            color("silver")
            cylinder(d = 2.25, h = pcb_size.z + c*2 + t*2);
        }
    }
    // sockets for reference
    translate([0, 0, pcb_size.z]) {
        // power
        color("yellow")
        translate([4.5, 10])
        cube([2.54, 2.54*3, 10]);
        // ir
        color("purple")
        translate([12, 2])
        cube([2.54*3, 2.54, 10]);
        // pir
        color("white")
        translate([20.5, 1])
        cube([10, 5.6, 8.3]);
        // leds
        color("lime")
        translate([32, 2])
        cube([2.54*4, 2.54, 10]);
        // piezo
        color("gold")
        translate([63, 2])
        cube([2.54, 2.54*2, 10]);
        // inductor
        color([0.2, 0.2, 0.2])
        translate([54, 4])
        cylinder(d = 10, h = 14.5);
    }
    // back soldering
    bs_h = 3;
    color([1, 1, 1, 0.5])
    translate([4-c, 0.2-c, -bs_h-c])
    cube([61.5+c*2, 29.6+c*2, bs_h+c]);
    // front parts
    fs_h = 15;
    color([1, 1, 1, 0.5])
    translate([3-c, -0.5-c, pcb_size.z+c])
    cube([64+c*2, 28.6+c*2, fs_h+c]);
}

module piezo(no_clearance) {
    c = (no_clearance)? 0: clearance;
    color("gold")
    translate([0, 0, -c])
    cylinder(d = 21+c*2, h = 0.1+c*2);
    color("silver")
    translate([0, 0, 0.1])
    cylinder(d = 15, h = 0.1+c);
}

module ir(no_clearance) {
    c = (no_clearance)? 0: clearance;
    // body
    color([0.2, 0.2, 0.2])
    translate([-c, -c, -c]) {
        cube([5+c*2, 2.4+c*2, 5+c*2]);
        cube([5+c*2, 3+c*2, 0.8+c*2]);
    }
    // legs
    l_h = 6;
    color("silver")
    translate([-0.25-c, 0.75-c, -l_h-c])
    cube([5.5+c*2, 0.5+c*2, l_h+c]);
    // input hole
    color([1, 1, 1, 0.5])
    translate([2.5, 0, 2.5])
    rotate(90, [1, 0, 0])
    cylinder(d1 = 2.5, d2 = 5, h = 5);
}

ir(false);
