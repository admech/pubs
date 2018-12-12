include "./content/pic/asy/helper.asy";

unitsize(1.3cm);

real theta = 0;

// CART

path PLATFORM = unitcircle;
draw(PLATFORM, black + 1);

path WHEEL = shift(0, -1.2) * box((0.3,0.05), (-0.3,-0.05));
real label_start_angle = theta + pi/7;
real label_radius = 1.3;

path WHEEL_1 = rotate(90) * WHEEL;
fill(WHEEL_1, mediumgray);
draw(WHEEL_1, black + 1);

path WHEEL_2 = rotate(90 + 120) * WHEEL;
fill(WHEEL_2, mediumgray);
draw(WHEEL_2, black + 1);

path WHEEL_3 = rotate(90 + 240) * WHEEL;
fill(WHEEL_3, mediumgray);
draw(WHEEL_3, black + 1);

// LOCAL COORDINATES

label("$\mathbf{v}_0$", 1.7*(cos(theta + 0.2),sin(theta + 0.2)) - (0.1, 0.25));
draw((0,0) -- 1.5*(cos(theta),sin(theta)), arrow = Arrow(SimpleHead));

