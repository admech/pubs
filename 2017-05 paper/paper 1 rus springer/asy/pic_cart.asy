include "./asy/helper.asy";

unitsize(1.3cm);

// INERTIAL COORDINATES

label("$X$", (1.85,-1.4));
draw((-1.5,-1.4) -- (1.7,-1.4), arrow = Arrow(TeXHead));

label("$Y$", (-1.2, 1.6));
draw((-1.4,-1.5) -- (-1.4,1.7), arrow = Arrow(TeXHead));

label("$Z$", (-1.6, -1.2));
draw(shift(-1.4, -1.4) * scale(0.1) * unitcircle);

label("$O$", (-1.2, -1.2));
filldraw(shift(-1.4, -1.4) * DOT, black);

// CART

path PLATFORM = unitcircle;
draw(PLATFORM, black);
filldraw(DOT, black);
label("$S(x, y)$", (-0.1, -0.2));

path WHEEL = shift(0, -1.2) * box((0.3,0.05), (-0.3,-0.05));

fill(WHEEL, mediumgray);
draw(WHEEL, black);

path WHEEL_2 = rotate(120) * WHEEL;
fill(WHEEL_2, mediumgray);
draw(WHEEL_2, black);

path WHEEL_3 = rotate(240) * WHEEL;
fill(WHEEL_3, mediumgray);
draw(WHEEL_3, black);

// LOCAL COORDINATES

label("$\xi$", 2.2*(cos(pi/6),sin(pi/6)));
draw((0,0) -- 2*(cos(pi/6),sin(pi/6)), arrow = Arrow(SimpleHead));

label("$\eta$", 1.7*(cos(pi/2+pi/6),sin(pi/2+pi/6)));
draw((0,0) -- 1.5*(cos(pi/2+pi/6),sin(pi/2+pi/6)), arrow = Arrow(SimpleHead));

// ANGLES

label("$\alpha_i$", 0.65*(cos(pi/4+pi/6),sin(pi/4+pi/6)), blue);
pair R_dim_line_end = 1.2*dr(pi-pi/6);
path R_dim_line = (0,0) -- R_dim_line_end;
draw(R_dim_line, dashed+gray);
draw(arc(
    (0,0),
    0.5*(cos(pi/6),sin(pi/6)),
    0.5*(cos(pi-pi/6),sin(pi-pi/6))
), arrow=Arrow(TeXHead), blue);

// also R dimension here
label("$R$", (-0.75, 0.2));
addarrow(R_dim_line, black);
addarrow(reverse(R_dim_line), black);

// also n_i vector here
label("$\vec{n}_i$", 
    ((R_dim_line_end*1.5) + (-0.1, 0.3))
);
draw(
    R_dim_line_end
    --
    (R_dim_line_end*1.5)
    , arrow=Arrow(TeXHead)
    , black
);


label("$\theta$", 0.75*(cos(-pi/12+pi/6),sin(-pi/12+pi/6)), heavygreen);
draw((0,0) -- (1.2,0), dashed+gray);
draw(arc(
    (0,0),
    0.6*(1,0),
    0.6*(cos(pi/6),sin(pi/6))
), arrow=Arrow(TeXHead), heavygreen);

real chi_angle = 2*pi/3 + pi/6;
real chi_dist = 1.2;
label("$\chi_i$", (chi_dist + 0.3)*dr(chi_angle) + (0.3, 0.35), red);
draw(arc(
    chi_dist*dr(chi_angle),
    chi_dist*dr(chi_angle) + 0.3*dr(chi_angle + pi/4),
    chi_dist*dr(chi_angle) + 0.3*dr(chi_angle - pi/4),
    CW
), arrow=Arrow(TeXHead), red);

