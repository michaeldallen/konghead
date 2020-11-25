po8 = 25.4 / 8;

thickitude = 2;
rounditude = 0.25;

plate_width = 20;
plate_length = 100;
plate_thickness = po8 * thickitude;
        
// set to zero for final render
//flash = 0;
flash = 0.001;

A = 80;
B = 90;
C = 10;

a = plate_width / 2;
b = sin(B) * (a/sin(A));
c = sin(C) * (a/sin(A));


echo("a: ", a);
echo("A: ", A);

echo("b: ", b);
echo("B: ", B);

echo("c: ", c);
echo("C: ", C);


$fn = 25;
module fishbone(length = plate_length, rounditude = 0) {
    minkowski() {
        difference() {
            translate([0, 0, rounditude]) {
                linear_extrude(height = plate_thickness - (rounditude * 2)) {
                    polygon(
                        points = [
                            [rounditude, rounditude],
                            [a, c + rounditude],
                            [(a * 2) - rounditude, rounditude],
                            [(a * 2) - rounditude, plate_length- rounditude], 
                            [rounditude, plate_length - rounditude]
                        ]
                    );
                }
            }

        
            for(offset = [po8 * 2 : po8 * 2 : plate_length - (po8 * 2)]) {
                translate([0, offset, 0]) {
                    for(tb = [0, thickitude - 0.5]) {
                        for(lr = [0, plate_width - po8]) {
                            translate([lr - flash, -flash, (po8 * tb) - flash]) {
                                translate([-rounditude, -rounditude, -rounditude]) {
                                    cube([po8 + (flash * 2) + (rounditude * 2), po8 + (flash * 2) + (rounditude * 2), po8/2 + (flash * 2) + (rounditude * 2)]);
                                }
                            }
                        }
                    }
                }
            }
        }
        sphere(r = rounditude);
    }

}

//color("red") fishbone(length = 30);

//translate([flash, flash, flash]) 
    color("orange") fishbone(rounditude = rounditude);