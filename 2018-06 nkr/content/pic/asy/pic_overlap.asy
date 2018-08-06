include "./content/pic/asy/helper.asy";

unitsize(1.3cm);

// PLANE

draw((-1.5,-1.4) -- (1.7,-1.4), black + 1);

// WHEEL

path HUB = unitcircle;
draw(HUB, black + 1);

path ROLLER_TEMPLATE = 
    (arc((0,0), 1.4, -90 - 180/6, -90 + 180/6)
    --
    arc((0,-2), 1.4, 90 - 180/6, 90 + 180/6)
    --
    cycle)
;

path FIRST_ROLLER = rotate(30) * ROLLER_TEMPLATE;
draw(FIRST_ROLLER, black + 1);
fill(FIRST_ROLLER, lightgray + opacity(0.5));

path LAST_ROLLER = rotate(30+60*5) * ROLLER_TEMPLATE;
draw(LAST_ROLLER, black + 1);
fill(LAST_ROLLER, lightgray + opacity(0.5));

for (int i = 1; i < 5; ++i) {
    draw(rotate(30 + 60*i) * ROLLER_TEMPLATE, fatdashed+gray + 1);
}


// LOCAL COORDINATES

    label("$\mathbf{n}^\perp_i$", 2*(cos(pi/6 + 0.2),sin(pi/6 + 0.2)) + (0.2, 0.1));
    draw((0,0) -- 2.3*(cos(pi/6),sin(pi/6)), arrow = Arrow(SimpleHead));
    
    label("$\mathbf{n}^z_i$", 2.3*(cos(pi/2+pi/6 - 0.2),sin(pi/2+pi/6 - 0.2)) - (-0.1, 0.5));
    draw((0,0) -- 1.8*(cos(pi/2+pi/6),sin(pi/2+pi/6)), arrow = Arrow(SimpleHead));


// ANGLES

// draw((0,0) -- 1.4*(cos(-pi/3),sin(-pi/3)), mydashdotted+gray);
// draw((0,0) -- 1.4*(cos(-pi/2),sin(-pi/2)), mydashdotted+gray);

// draw((0,0) -- (1.6,0), mydashdotted+gray);

////////////////////////////////////////////////
// DOTS -- Should be done on top for PMM
////////////////////////////////////////////////

filldraw(DOT, white);

