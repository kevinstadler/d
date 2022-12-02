th = 16; // material
fr = 8; // drillbit size
screw = 4; // screwhole diameter

h = 50;
nhooks = 1;
hookdist = 60;
l = nhooks * hookdist;

hookdepth = 6; // hook/thin thickness
hookangle = 75; // 90 = up, 0 = flat

//translate([0, - h - fr, 0])
translate([-l - fr, 0, 0])
difference() {
    cube([l, h, th]);
    for (i = [0:nhooks]) {
        xdist = (l - (nhooks-1)*hookdist)/2 + i * hookdist;
        translate([xdist, -5, th]) cube([th, h, th], true);
        translate([xdist, 0, th/2]) cube([th, 2*hookdepth, 2*th], true);
        
        if (i == 0 || i == nhooks) {
            translate([xdist, h/2, -th/2]) cylinder(2*th, screw/2, screw/2, $fn=16);
        }
    }
}

for (i = [1:nhooks]) {
    translate([(i-1) * (3*th/2+fr), 0, 0])
    union() {
    cube([th/2, h/2-5, th]); // back hook
    cube([th+hookdepth, hookdepth, th]); // top
    translate([th, 0, 0]) cube([hookdepth, h, th]); // down
    translate([th, h-hookdepth, 0]) cube([3*hookdepth, hookdepth, th]); // bottom
    translate([th+2*hookdepth, h-2*hookdepth, 0]) cube([hookdepth, 2*hookdepth, th]); // hanger
    }
}