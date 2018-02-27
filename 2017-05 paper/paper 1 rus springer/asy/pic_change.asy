include "./asy/helper.asy";

unitsize(0.8cm);

import three;

currentprojection = perspective(2, 1, 1.25);
triple persp = (2, 1, 1.25);

void drawdot3d(triple coords) {
    dot(coords, white);
    draw(circle(coords, 0.063, persp), black);
}

draw(-X--2X ^^ -2Y--2Y ^^ -Z--1.9Z, heavygray);

label("$\chi_{-}$", 1.8(X+Z)-Y);
draw(plane(3X,3Z,Y-1.5(X+Z)), blue);

label("$\chi_{+}$", 1.8(-X+Z)+Y);
draw(plane(3X,3Z,-Y-1.5(X+Z)), blue);

label("$\chi_i$", 1.9Y - 0.8X + 0.1Z);
label("$q$", 1.75X - 0.3Y + 0.2Z);
label("$\nu$", 2Z + 0.35Y);

drawdot3d(O);

draw(-Y+X+Z .. -0.2Y+0.8X+Z .. 0.2Y-0.8X+Z .. Y-X+Z, deepgreen + 1);
drawdot3d(-Y+X+Z);
drawdot3d(Y-X+Z);

draw(Y-X+Z -- -Y-X+Z, red + dashed + 1);
drawdot3d(-Y-X+Z);

draw(-Y+X+Z -- Y+X+Z, red + dashed + 1);
drawdot3d(Y+X+Z);


