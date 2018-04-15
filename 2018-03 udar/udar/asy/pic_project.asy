include "./asy/helper.asy";

unitsize(1.3cm);

// draw((0,0) -- (1,0));
// draw((0,0) -- (0,1));

// SURFACE

path surface =
    (0,0)
    {dr(pi/8)} :: {dr(-pi/3)}
    (3, -0.9)
    {dr(pi/2-pi/8)} :: {right}
    (3.9, 0)
    {dr(pi/2+pi/6)} :: {dr(pi+pi/3)}
    cycle;

draw(surface, grey+1);

// PLANE

path plane =
    (0.75, 0.6)
    --
    (1.95, 0.15)
    --
    (3.75, 0.9)
    --
    (1.8, 1.5)
    --
    cycle;

draw(plane, black+1);

// VECTORS

pair q0 = (1.5, 0.6);
pair q1 = (2.7, 2.25);
pair q2 = (2.7, 0.6);

// Q DO

draw(
    q0 -- q1
    , arrow=Arrow(SimpleHead)
    , blue
);

// DELTA

draw(
    q1 -- q2
    , arrow=Arrow(SimpleHead)
    , red
);

// Q POSLE

draw(
    q0 -- q2
    , arrow=Arrow(SimpleHead)
    , heavygreen
);
