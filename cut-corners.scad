$fn = 100;

size = 80;
cut = 20; //cut part, in percent of diagonal
fontSize = 13; //font size in percent of size
inset = 2;
epsilon = 0.05;
lineWidth = 1.5; //central symbol in percent of size
font = "Liberation Sans:style=bold";
// font = "Calibri:style=bold";



diagonal = sqrt(3) * size / 2;
cutAbs = cut * diagonal / 100;
fontSizeAbs = fontSize * size / 100;
lineWidthAbs = lineWidth * size / 100;

theta = 90 - asin(sqrt(2/3));
phi = 45;

difference() {
    color("lime", 0.5)
        cube(size, center = true);


    rotate([0,theta,phi])
        corner("χ");

    rotate([0,theta,-phi])
        corner("Ψ");

    rotate([0,-theta,phi])
        corner("H");

    rotate([0,-theta,-phi])
        corner("U");

    rotate([0,theta + 180,phi])
        corner("F");

    rotate([0,theta + 180,-phi])
        corner("G");

    rotate([0,-(theta + 180),phi])
        corner("Ω");

    rotate([0,-(theta + 180),-phi])
        corner("Ø");


    translate([0, 0, size / 2])
        wall("N", "out");

    rotate([-90, 0, 0])
        translate([0, 0, size / 2])
            wall("P", "out");

    rotate([90, 0, 0])
        translate([0, 0, size / 2])
            wall("V", "in");

    rotate([0, -90, 0])
        translate([0, 0, size / 2])
            wall("T", "in");   

    rotate([0, 90, 0])
        translate([0, 0, size / 2])
            wall("S", "out");   

    rotate([0, 180, 0])
        translate([0, 0, size / 2])
            wall("μ", "in");    

}

module inOut(dir) {
    if (dir == "in") {
        rotate([0, 0, 45])
            square(size=[lineWidthAbs, fontSizeAbs / 2], center=true);
        rotate([0, 0, -45])
            square(size=[lineWidthAbs, fontSizeAbs / 2], center=true);
    } else if (dir == "out") {
        circle(r = lineWidthAbs );
    }

    difference() {
        circle(r = fontSizeAbs / 2);
        circle(r = fontSizeAbs / 2 - lineWidthAbs);
    }

}

module wall (symbol, inOut, angle = 0) {
    rotate([0,0,angle])
        translate ([0, 0, -inset / 2])
            union(){
                translate([1.1 * fontSizeAbs / 2, 0, -inset / 2 - epsilon])
                    linear_extrude(inset + 2 * epsilon)
                        inOut(inOut);

                translate([-1.1 * fontSizeAbs / 2, 0, -inset / 2 - epsilon])
                    linear_extrude(inset + 2 * epsilon)
                        text(text = symbol, font = font, size = fontSizeAbs, halign = "center", valign = "center");
            }
}

module corner(symbol) {
    color("lime", 0.1)
    translate([size + diagonal - cutAbs , 0, 0])
        cube(2*size, center = true);


    color("blue", 0.5)
    translate([diagonal - cutAbs, 0, 0])
    rotate([90, 0, -90])
    scale([-1,1,1])
    translate([0 , 0, -epsilon])
        linear_extrude(inset + 2 * epsilon)
            text(text = symbol, font = font, size = fontSizeAbs, halign = "center", valign = "center");
}
