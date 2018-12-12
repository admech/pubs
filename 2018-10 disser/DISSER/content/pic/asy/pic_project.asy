include "./content/pic/asy/helper.asy";

unitsize(1.3cm);

// draw((0,0) -- (1,0));
// draw((0,0) -- (0,1));

string dotq = "\dot{\mathbf{q}}";
string dqdo = dotq + "^-";
string dqposle = dotq + "^+";
string nuvec = "\boldsymbol{\mathbf{\nu}}";
string nuposle = nuvec + "^+";
string subspace = "\widetilde{V}";
string deltadq = "\Delta" + dotq;

string m(string s) {
    return "$" + s + "$";
}

// SURFACE

pair s1 = (0,0);
pair s2 = (3, -0.9);
pair s3 = (3.9, 0);

label(m("\mathcal{M}"), s2 + (-0.05, 0.6), p=fontsize(11pt));

path surface =
    s1
    {dr(pi/8)} :: {dr(-pi/3)}
    s2
    {dr(pi/2-pi/8)} :: {right}
    s3
    {dr(pi/2+pi/6)} :: {dr(pi+pi/3)}
    cycle;

draw(surface, grey+1);

// PLANE

pair p1 = (0.75, 0.6);
pair p2 = (1.95, 0.15);
pair p3 = (3.75, 0.9);
pair p4 = (1.8, 1.5);

label(m(subspace), p3 + (0.3, 0.2), p=fontsize(11pt));

path plane = p1 -- p2 -- p3 -- p4 -- cycle;

draw(plane, black+1);

// VECTORS

pair q0 = (1.5, 0.6);
pair q1 = (2.7, 2.25);
pair q2 = (2.7, 0.6);

// Q DO

label(m(dqdo), q1 + (-0.5, -0.3), p=fontsize(11pt));
draw(
    q0 -- q1
    , arrow=Arrow(arrowhead = SimpleHead, size = 8)
    , blue+linewidth(1)
);

// DELTA

label(m(deltadq), (q1 + q2) / 2 + (0.3, 0.2), p=fontsize(11pt));
draw(
    q1 -- q2
    , arrow=Arrow(arrowhead = SimpleHead, size = 8)
    , red+linewidth(1)
);

// Q POSLE

label(m(dqposle), (q0 + q2) / 2 + (0.2, 0.25), p=fontsize(11pt));
draw(
    q0 -- q2
    , arrow=Arrow(arrowhead = SimpleHead, size = 8)
    , heavygreen+linewidth(1)
);
