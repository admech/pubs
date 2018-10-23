settings.outformat="png";
settings.render=16;

include "./content/pic/asy/helper.asy";

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
  0.8, -0.6, 0.5
  // 0.65, 0.65, 0.4
  // cos(pi/4), sin(pi/4), 0
  // 1, 0, 0
  // 0, 1, 0
  // 0, 0, 1
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
  dot(towardcamera(coords, 2), p + opacity(1) + linewidth(2pt));
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
  bool na = false
) {
  p = p + linewidth(lw) + fontsize(1.2pt);
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
triple wheel_center = Z * R;
triple radius_vector = (-cos(chi) * Z + sin(chi) * Y);
triple roller_center = wheel_center + R1 * radius_vector;
triple roller_axis = rotate(r2d(-(pi/2 - psi)), Z) * X;
triple contact_point = wheel_center - R * Z;

// === END OF COORDS =================================

// === POINTS AND AXES ===============================

vector(-3Y + 3X, -6X, gray, na = true);
vector(-3Y - 3X, 8Y, gray, na = true);
vector(5Y - 3X, 6X, gray, na = true);
vector(5Y + 3X, -8Y, gray, na = true);

draw(circle(wheel_center, R, X), darkgray + opacity(0.2));
vector(O, 4.6Y, gray, na = true);

name("$\mathbf{i}$", position = contact_point + roller_axis * 3 + 0.6Y, black);
vector(O, 3 * roller_axis, black);

triple vp = cross(Z, roller_axis);
name("$\mathbf{v}_P$", position = contact_point + vp * 1.5 + 0.6Y, black);
vector(O, 1.5 * vp, black);

name("$O$", position = wheel_center + 0.6Y, black);
drawdot3d(wheel_center);
name("$P$", position = contact_point - 0.6X, black);
drawdot3d(contact_point);

// draw(roller_center -- roller_center - roller_axis * 3);

// === END OF POINTS AND AXES ========================

// === BASES =========================================

triple k1 = X;

// === END OF BASES ==================================

// === OTHER VECTORS =================================

// name("$x$", position = 3X + Y * 1.0, heavygray);
// name("$y$", position = 3.3Y + Z * 1.0, heavygray);
// name("$z$", position = 7.5Z + Y * 1.0, heavygray);

// implicit
triple rho = (wheel_center - roller_center) / length(wheel_center - roller_center);

vector(wheel_center, -R * rho, black, na = true);
vector(wheel_center, -R * Z, black, na = true);

name("$R$", position = wheel_center - R * Z * 0.4 - 0.5Y, black);

triple tmp_psi_dir = (-sin(psi), cos(psi), 0) * 2;
vector(contact_point, R1 * tmp_psi_dir * 0.8, gray, na = true);
draw(arc(contact_point, contact_point + tmp_psi_dir * R1 * 0.75, contact_point + Y, -Z), blue);
triple tmp_half_psi_dir = (-sin(psi/2), cos(psi/2), 0) * 2;
name("$\psi$", position = contact_point + R1 * tmp_half_psi_dir * 0.9 - 0.4Y - 0.25X, blue);

draw(arc(wheel_center, wheel_center - Z, wheel_center + radius_vector, X), blue);
name("$\chi$", position = wheel_center - 0.6Z - 0.3Y, blue);


// === END OF OTHER VECTORS ==========================


