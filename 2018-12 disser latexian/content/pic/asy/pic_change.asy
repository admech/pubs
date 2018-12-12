include "./content/pic/asy/helper.asy";

unitsize(0.8cm);

import three;

currentprojection = perspective(2, 1, 1.25);
triple persp = (2, 1, 1.25);

void drawdot3d(triple coords) {
    dot(coords, white);
    draw(circle(coords, 0.063, persp), black);
}

// check the direction away from screen
// draw( (1.7X + 0.8Z) -- (-Y), (3bp)+green, Arrow3(size=10bp));
// triple dir = (1.7X + 0.8Z) + (-Y);

draw(-X--2X ^^ -2Y--2Y ^^ -Z--1.9Z, heavygray);

label("$\chi_{-}$", 1.8(X+Z)-Y, p=fontsize(9pt));
draw(plane(3X,3Z,Y-1.5(X+Z)), blue);

label("$\chi_{+}$", 1.8(-X+Z)+Y, p=fontsize(13pt));
draw(plane(3X,3Z,-Y-1.5(X+Z)), blue);

label("$\chi_i$", 1.9Y - 0.8X + 0.0Z, p=fontsize(11pt));
label("$\mathbf{q}$", 1.85X - 0.2Y + 0.15Z, p=fontsize(8.75pt));
label("\textbf{\textupsilon}", 2Z + 0.23Y, p=fontsize(10pt));

drawdot3d(O);

draw(-Y+X+Z .. -0.2Y+0.8X+Z .. 0.2Y-0.8X+Z .. Y-X+Z, deepgreen + 1);
drawdot3d(-Y+X+Z);
drawdot3d(Y-X+Z);

draw(Y-X+Z -- -Y-X+Z, gray + mydashdotted);
drawdot3d(-Y-X+Z);

draw(-Y+X+Z -- Y+X+Z, gray + mydashdotted);
drawdot3d(Y+X+Z);


