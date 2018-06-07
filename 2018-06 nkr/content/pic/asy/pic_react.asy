include "./content/pic/asy/helper.asy";

unitsize(1.3cm);

// INERTIAL COORDINATES

real delta = 0.7;

label("$X$", (1.7,-1.75));
draw((-1.5 - delta,-1.4) -- (1.8,-1.4), arrow = Arrow(TeXHead));

label("$Y$", (-1.6 - delta, 1.6));
draw((-1.4 - delta,-1.5) -- (-1.4 - delta,1.7), arrow = Arrow(TeXHead));

label("$Z$", (-1.6 - delta, -1.2));
draw(shift(-1.4 - delta, -1.4) * scale(0.1) * unitcircle);

// CART

path PLATFORM = unitcircle;
draw(PLATFORM, black + 1);

path WHEEL = shift(0, -1.2) * box((0.3,0.05), (-0.3,-0.05));
real label_start_angle = pi/6 + pi/7;
real label_radius = 1.3;

label("$\textit{1}$", dr(label_start_angle) * label_radius);
path WHEEL_1 = WHEEL;
fill(WHEEL_1, mediumgray);
draw(WHEEL_1, black + 1);

label("$\textit{2}$", dr(2*pi/3 + label_start_angle) * label_radius);
path WHEEL_2 = rotate(120) * WHEEL;
fill(WHEEL_2, mediumgray);
draw(WHEEL_2, black + 1);

label("$N$", dr(4*pi/3 + label_start_angle - pi/4 - pi/25) * label_radius);
path WHEEL_3 = rotate(240) * WHEEL;
fill(WHEEL_3, mediumgray);
draw(WHEEL_3, black + 1);

// REACTIONS

// wheel 1

pair wheel1center = 1.2*dr(pi/6);
pair f1x_end = wheel1center + (1, 0) * 0.7;
pair f1y_end = wheel1center + (0, 1) * 0.7;

label("$\mathbf{F}^1_x$", 
    (f1x_end + (0.25, 0))
);
draw(
    wheel1center -- f1x_end
    , arrow=Arrow(SimpleHead)
    , black
);

label("$\mathbf{F}^1_y$", 
    (f1y_end + (0.3, 0))
);
draw(
    wheel1center -- f1y_end
    , arrow=Arrow(SimpleHead)
    , black
);

// wheel 2

pair wheel2center = 1.2*dr(pi-pi/6);
pair f2x_end = wheel2center + (1, 0) * 0.7;
pair f2y_end = wheel2center + (0, 1) * 0.7;

label("$\mathbf{F}^2_x$", 
    (f2x_end + (0.25, 0))
);
draw(
    wheel2center -- f2x_end
    , arrow=Arrow(SimpleHead)
    , black
);

label("$\mathbf{F}^2_y$", 
    (f2y_end + (0.3, 0))
);
draw(
    wheel2center -- f2y_end
    , arrow=Arrow(SimpleHead)
    , black
);

// wheel 3

pair wheel3center = 1.2*dr(-pi/2);
pair f3x_end = wheel3center + (1, 0) * 0.7;
pair f3y_end = wheel3center + (0, 1) * 0.7;

label("$\mathbf{F}^N_x$", 
    (f3x_end + (0.25, 0.05))
);
draw(
    wheel3center -- f3x_end
    , arrow=Arrow(SimpleHead)
    , black
);

label("$\mathbf{F}^N_y$", 
    (f3y_end + (0.3, -0.15))
);
draw(
    wheel3center -- f3y_end
    , arrow=Arrow(SimpleHead)
    , black
);

////////////////////////////////////////////////
// DOTS -- Should be done on top for PMM
////////////////////////////////////////////////

filldraw(DOT, white);
label("$S(x, y)$", (-0.1, -0.2));

label("$O$", (-1.2 - delta, -1.2) - (0.4, 0.4));
filldraw(shift(-1.4 - delta, -1.4) * DOT, white);


