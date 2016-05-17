$fn = 500;
// h = 19
// diff = 17

objectdiameter = 31;
objectheight = 36;

innerdiameter = 16;
innerheight = 33;

insidediameter = 12;
insideheight = 19;

module main() {
    difference() {
        // Main cylinder
        cylinder(d = objectdiameter, h = objectheight);

        // 1mm indent on top
        translate([0, 0, objectheight - 1]) {
            cylinder(d = 27, h = 1);
        }
               
        // Inner cyclinder, 2mm bottom-thickness
        translate([0, 0, 2.5]) {
            cylinder(d = innerdiameter, h = innerheight);
        }

        // Square on bottom
        translate([-3.5, -3.5, 0]) {
            cube([7, 7, 2]);
        }
        
        // Screwhole
        translate([0, 0, 2]) {
            cylinder(d = 4, h = 0.5);
        }
    }

    // Inside cyclinder with square hole
    translate([0, 0, 2.5]) {
        difference() {
            cylinder(d = insidediameter, h = insideheight);
            translate([-3.5, -3.5, 0]) {
                cube([7, 7, insideheight + 1]);
            }
        }
    }
}

module outer() {
    remove = 5;

    // General removal under the rim
    difference() {
        cylinder(d = objectdiameter, h = objectheight - 3);
        cylinder(d = 26, h = objectheight - 3);
    }
    
    // Flat section 1
    translate([0, (objectdiameter - remove) / 2, 0]) {
        translate([objectdiameter / -2, remove / -2, 0]) {
            cube([objectdiameter, remove, innerheight]);
        }
    }
    
    // Flat section 2
    translate([0, (objectdiameter - remove) / -2, 0]) {
        translate([objectdiameter / -2, remove / -2, 0]) {
            cube([objectdiameter, remove, innerheight]);
        }
    }
    
    // Cutout right
    translate([2.5 + 10, 0, 0]) {
        translate([-2.5, -2, 0]) {
            cube([5, 4, innerheight]);
        }
    }

    // Cutout left
    translate([(2.5 + 10) * -1, 0, 0]) {
        translate([-2.5, -2, 0]) {
            cube([5, 4, innerheight]);
        }
    }
    
    // Small circular cutouts
    circularcoutout();
    mirror([1, 0, 0]) circularcoutout();
    
    mirror([0, 1, 0]) {
        circularcoutout();
        mirror([1, 0, 0]) circularcoutout();
    }

    // Shape for bracket
    translate([0, 0, 23]) {
        difference() {
            cylinder(d = 26, h = 2);
            cylinder(d = 20, h = 2);
        }
    }

    // Cutouts for bracket
    translate([0, 0, 23]) {
        difference() {
            cylinder(d = 26, h = 2);
            translate([-14/2, -19/2, 0]) {
                cube([14, 19, 2]);
            }
        }
    }
}

module circularcoutout() {
    translate([0, 0, 2]) {
        intersection() {
            difference() {
                cylinder(d = 26, h = objectheight - 5);
                cylinder(d = 21, h = objectheight - 5);
            }
            
            translate([0, 2 + 1.5, 0]) {
                cube([15, 5, objectheight - 3]);
            }
        }
    }
}

difference() {
    main();
    outer();
}



/*
projection(cut = true) {
    translate([0, 0, -2.5]) {
        
    }
}
*/