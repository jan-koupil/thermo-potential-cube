$fn = 100;

size = 80;
separation = 12.5; //symbol centre from side, in percent of size
fontSize = 13; //font size in percent of size
inset = 2;
epsilon = 0.05;
lineWidth = 1.5; //central symbol in percent of size
font = "Liberation Sans:style=bold";

fontSizeAbs = fontSize * size / 100;
lineWidthAbs = lineWidth * size / 100;

difference() {
    cube(size, center = true);

    translate([0, 0, size / 2])
        wall("N", "G", "H", "F", "U", "out");

    rotate([-90, 0, 0])
        translate([0, 0, size / 2])
            wall("P", "Ø", "χ", "G", "H", "out");

    rotate([90, 0, 0])
        translate([0, 0, size / 2])
            wall("V", "F", "U", "Ω", "Ψ", "in");

    rotate([0, -90, 0])
        translate([0, 0, size / 2])
            wall("T", "Ø", "G", "Ω", "F", "in");   

    rotate([0, 90, 0])
        translate([0, 0, size / 2])
            wall("S", "H", "χ", "U", "Ψ", "out");   

    rotate([0, 180, 0])
        translate([0, 0, size / 2])
            wall("μ", "χ", "Ø", "Ψ", "Ω", "in");    

}               

module wall (center, topLeft, topRight, bottomLeft, bottomRight, inOut) {
    translate ([0, 0, -inset / 2])
//    difference(){
    union(){
        //cube(size = [size, size, inset], center = true);

        translate([1.1 * fontSizeAbs / 2, 0, -inset / 2 - epsilon])
            linear_extrude(inset + 2 * epsilon)
                inOut(inOut);

        translate([-1.1 * fontSizeAbs / 2, 0, -inset / 2 - epsilon])
            linear_extrude(inset + 2 * epsilon)
                text(text = center, font = font, size = fontSizeAbs, halign = "center", valign = "center");

        translate([-size / 2 + separation * size / 100, size / 2 - separation * size / 100, -inset / 2 - epsilon])
            linear_extrude(inset + 2 * epsilon)
                text(text = topLeft, font = font, size = fontSizeAbs, halign = "center", valign = "center");
            
        translate([size / 2 - separation * size / 100, size / 2 - separation * size / 100, -inset / 2 - epsilon])
            linear_extrude(inset + 2 * epsilon)
                text(text = topRight, font = font, size = fontSizeAbs, halign = "center", valign = "center");

        translate([-size / 2 + separation * size / 100, - size / 2 + separation * size / 100, -inset / 2 - epsilon])
            linear_extrude(inset + 2 * epsilon)
                text(text = bottomLeft, font = font, size = fontSizeAbs, halign = "center", valign = "center");

        translate([size / 2 - separation * size / 100, - size / 2 + separation * size / 100, -inset / 2 - epsilon])
            linear_extrude(inset + 2 * epsilon)
                text(text = bottomRight, font = font, size = fontSizeAbs, halign = "center", valign = "center");
    }
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

