
settings.outformat="png";
settings.render=16;

include "helper.asy";

// size(2.5cm, 0);
size(3.5cm, 0); // maybe better if insert large figure
unitsize(0.8cm);

import graph3;
import three;

triple cameradirection(
  triple pt,
  projection P=currentprojection
) {
  if (P.infinity) {
    return unit(P.camera);
  } else {
    return unit(P.camera - pt);
  }
}
currentprojection = orthographic(
  // 1, 0.5, 0.5
  // 1, -0.5, 0.5
  // 0.8, -0.6, 0.5
  // 0.65, 0.65, 0.4
  // cos(pi/4), sin(pi/4), 0
  // 1, 0, 0
  // 0, 1, 0
  0, 0, 1
);
// triple persp = cameradirection(O, currentprojection);

triple towardcamera(
  triple pt,
  real distance=1,
  projection P=currentprojection
) {
  return pt + distance * cameradirection(pt, P);
}

void drawdot3d(triple coords, pen p = black) {
  dot(towardcamera(coords, 2), p + opacity(1) + linewidth(1pt));
}

void drawcircle(triple coords, real r = 1, pen p = black) {
  draw(circle(coords, 1, cameradirection(coords)), p);
}

real r2d(real radians) {
  return radians * 180 / pi;
}

real d2r(real degrees) {
  return degrees * pi / 180;
}

void name(
  string text,
  triple position,
  pen p = red
) {
  p = p + linewidth(0.3pt) + fontsize(1.2pt);
  triple cd = cameradirection(position);
  triple flat = position + (10 - dot(position, cd)) * cd;
  label(text, position = position, p = p);
}

void vector(
  triple origin,
  triple direction,
  pen p = red,
  real lw = 0.3pt,
  bool a3 = false,
  real s = 2.5pt,
  bool na = false,
  bool one = false
) {
  p = p + linewidth(lw) + fontsize(1.2pt);
  if (one) {
    direction = direction / length(direction);
  }
  if (!na) {
    draw(
      origin -- origin + direction, p,
      arrow=Arrow3(
        a3 || cross(currentprojection.camera, direction) == O
          ? DefaultHead3
          : DefaultHead2,
        emissive(p),
        size=s
      )
    );
  } else {
    draw(
      origin -- origin + direction, p
    );
  }
}

void base(
  triple origin,
  triple i = O, triple j = O, triple k = O,
  string subscript = "",
  pen p = red + linewidth(0.4pt) + fontsize(1.2pt),
  bool skipK = false
) {
  drawdot3d(origin, p);
  if (i == O) {
    i = cross(j, k);
  } else if (j == O) {
    j = -cross(i, k);
  } else if (k == O) {
    k = cross(i, j);
  }
  real s = 0.5pt;
  triple o = towardcamera(origin, 1);
  vector(o, i / length(i), p);
  vector(o, j / length(j), p);
  if (!skipK) {
    vector(o, k / length(k), p);
  }
}


// === PARAMS =======================================

real n_rollers = 4;

// angle between wheel plane and roller axis, as per our Modelica papers
real psi = 
  // 0
  // pi/4
  pi/6
  ;

// half the angle size of the roller, as per our Modelica papers.
// this is most likely defined for a regular omni-wheel as opposed to mecanum
// but for mecanum we need a parameter like this anyway, so let's reuse
real alpha = 2*pi / n_rollers / 2;

// angle between wheel axis and roller axis, as per Gferrer
real delta = pi/2 - psi;

// wheel radius, as per Gferrer (R in our papers)
real r = 4;
real R = r;

// distance between wheel axis and roller axis, as per Gferrer (R1 in ours)
real d = r * cos(alpha);
real R1 = d;

// angle of wheel rotation
real chi = 
  // 0
  pi/6
  // pi/9
  // pi/2
  ;

// === END OF PARAMS =================================

// === COORDS ========================================

// wheel plane is OYZ in the inertial frame
triple roller_axis = X * 0.5 + Y * 1.5;
roller_axis = roller_axis / length(roller_axis);

triple cart_center = 4X + 3Y;

triple mass_center_rel = X - Y;
triple mass_center = cart_center + mass_center_rel;

triple wheel_center_rel = (X * 0.7 + Y * 0.85)  * 1.3;
triple wheel_center = cart_center + wheel_center_rel;

// === END OF COORDS =================================

// === POINTS AND AXES ===============================

name("$x$", position = 7.5X - 0.5Y, black);
vector(O, 8X, black);
name("$y$", position = 5.5Y - 0.5X, black);
vector(O, 6Y, black);

draw(
  circle(cart_center, 2.5, Z + 0.5X + 0.5Y),
  darkgray + opacity(0.2) + linewidth(0.3pt)
);

name("$O$", position = cart_center - 0.5X, black);
drawdot3d(cart_center, black);
name("$S$", position = mass_center - 0.5X, black);
drawdot3d(mass_center, black);
vector(cart_center, mass_center_rel, black);

name("$\mathbf{r}_q$", position = wheel_center - 0.65X - 0.25Y, black);
vector(cart_center, wheel_center_rel, black);

name("$\mathbf{i}_q$", position = wheel_center + roller_axis + 0.35X, black);
vector(wheel_center, roller_axis, black);

name("$\mathbf{e}_2$", position = cart_center - 0.5X + Y - 0.2X - 0.5Y, black);
vector(cart_center, -0.5X + Y, black, one = true);
name("$\mathbf{e}_1$", position = cart_center + X + 0.5Y - 0.4Y, black);
vector(cart_center, X + 0.5Y, black, one = true);

triple diag = 0.5X + 0.1Y;

void draw_wheel(
  triple center,
  real angle
) {
  path3[] wheel = rotate(r2d(angle), center, center + Z) * box(center - diag, center + diag);
  draw(
    wheel,
    black + linewidth(0.3pt)
  );
  draw(
    rotate(r2d(angle), center, center + Z) * shift(center - diag) * scale(1, 0.2, 1) * unitplane,
    surfacepen = lightgray
  );
}

draw_wheel(wheel_center, -pi/3);

draw_wheel(cart_center - X + Y, pi/3);
draw_wheel(cart_center - X - Y, -pi/6);
draw_wheel(cart_center + X - 1.5Y, pi/6);

