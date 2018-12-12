// gotta serve:
// 1) omni
// 2) mecanum implicit
// 3) mecanum explicit

settings.outformat="png";
settings.render=16;

include "./content/pic/asy/helper.asy";

size(4cm, 0);
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
triple roller_axis = rotate(r2d(chi), X) * rotate(r2d(-(pi/2 - psi)), Z) * X;
triple contact_point = roller_center
  + R1 * tan(chi) / cos(psi) * roller_axis
  - (R - R1 / cos(chi)) * Z;

// === END OF COORDS =================================

triple f(real t) {
  return (t*cos(t)*1, t*sin(t), t);
}

pair mecanum_flat(real u) {
  return (
    // along the axis
    d * cos(delta)^2 * tan(u) + r * sin(delta) * sin(u),
    // across the axis
    -sqrt(cos(delta)^2 * tan(u)^2 + 1) * (r * cos(u) - d)
  );
}

typedef pair param2d(real);
typedef triple param3d(real);

param3d make_3d(param2d f_2d, triple origin, triple axis, triple radius) {
  return new triple(real param) {
    pair two = f_2d(param);
    return origin + two.x * axis - two.y * radius;
  };
}

param3d mecanum3d = make_3d(
  mecanum_flat,
  roller_center,
  roller_axis,
  radius_vector
);

path3 generatrix = graph(
  mecanum3d,
  -alpha * 1.0, alpha * 1.0,
  // 0, pi/2 - pi/8,
  operator ..,
  n = 6
);
draw(generatrix);

surface roller = surface(
  generatrix,
  c=roller_center,
  axis=roller_axis,
  n = 6
);
draw(
  roller,
  yellow + opacity(0.2),
  meshpen=gray + linewidth(0.1pt)
);

// === POINTS AND AXES ===============================

// inertial frame
drawdot3d(O);
draw(
  O -- 3X, gray, arrow=Arrow3(
  cross(currentprojection.camera, X) == O ? DefaultHead3 : DefaultHead2,
  size=2.5pt, emissive(gray))
);
draw(
  O -- 3.3Y, gray, arrow=Arrow3(
  cross(currentprojection.camera, Y) == O ? DefaultHead3 : DefaultHead2,
  size=2.5pt, emissive(gray))
);
draw(
  O -- 7.5Z, gray, arrow=Arrow3(
  cross(currentprojection.camera, Z) == O ? DefaultHead3 : DefaultHead2,
  size=2.5pt, emissive(gray))
);

draw(circle(wheel_center, R, X), darkgray + opacity(0.2));
draw(circle(wheel_center, R1, X), darkgray + opacity(0.2));

drawdot3d(wheel_center);
drawdot3d(roller_center);
// drawdot3d(mecanum3d(0), royalblue);
// drawdot3d(mecanum3d(alpha), green);
drawdot3d(contact_point, red);

draw(roller_center -- roller_center + roller_axis * 3);
draw(roller_center -- roller_center - roller_axis * 3);

// === END OF POINTS AND AXES ========================

// === BASES =========================================

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
  real s = 2.5pt
) {
  p = p + linewidth(lw) + fontsize(1.2pt);
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

// Oijk -- fixed in wheel, k along wheel axis
triple k1 = X;
base(
  origin = wheel_center,
  i = -radius_vector,
  k = k1,
  p = orange + linewidth(0.4pt) + fontsize(1.2pt),
  skipK = true
);
name("$\mathbf{i}$", position = wheel_center - radius_vector * 1.3, orange);
name("$\mathbf{j}$", position = wheel_center + cross(radius_vector, k1) * 1.3, orange);
name("$\mathbf{k} = \mathbf{k}_1$", position = wheel_center + k1 * 1.3 + Y * 1 + 0.4 * (-1, -1, 0), red);
name("$\mathbf{s}$", position = wheel_center + k1 * 1.3 - 0.5Z + 0.2Y, blue);

// roller coords axes

// Oi1j1k1
base(
  origin = wheel_center,
  j = Z,
  k = k1,
  subscript = "1"
);
name("$\mathbf{i}_1$", position = wheel_center + cross(Z, k1) * 1.5);
name("$\mathbf{j}_1$", position = wheel_center + Z * 1.5);

// Oi2j2k2
triple tmp_c = cross(roller_axis, (0, 0, 1));
triple k2 = tmp_c / length(tmp_c);
base(
  origin = roller_center,
  i = roller_axis,
  k = k2,
  subscript = "2"
);
name("$\mathbf{i}_2$", position = roller_center + roller_axis * 1.2 + X * 0.3 + Y * 0.3);
name("$\mathbf{j}_2$", position = roller_center - cross(roller_axis, k2) * 1.5 + X * 0.25 + Y * 0.3);
name("$\mathbf{k}_2$", position = roller_center + k2 * 1.5 + Y * 0.8 - X * 0.05);

// === END OF BASES ==================================

// === OTHER VECTORS =================================

vector(towardcamera(3.3Y, 0.5), Z, black);
name("$\bm{\gamma}$", position = 3.3Y + Z * 1.0 + 0.5Y, black);

// name("$x$", position = 3X + Y * 1.0, heavygray);
// name("$y$", position = 3.3Y + Z * 1.0, heavygray);
// name("$z$", position = 7.5Z + Y * 1.0, heavygray);

// implicit
triple rho = (wheel_center - roller_center) / length(wheel_center - roller_center);
vector(towardcamera(roller_center, 0.5), rho, blue, lw = 1pt);

real mu = dot(R * Z - R1 * rho, k2) / dot(k1, k2);
vector(roller_center, R1 * rho * 0.91, heavygreen, lw = 1pt);
vector(roller_center + R1 * rho, -R * Z * 0.95, heavygreen, lw = 1pt);
vector(roller_center + R1 * rho - R * Z, mu * X * 0.9, heavygreen, lw = 1pt);

name("$\lambda$", position = roller_center + R1 * rho - R * Z + mu * X * 0.5 + 0.05X - 0.5Y, heavygreen);
name("$l$", position = wheel_center - R * Z * 0.5 - 0.5Y, heavygreen);

triple tmp_dir = (0, cos(pi/6), sin(pi/6));
draw(wheel_center -- (wheel_center + R1 * tmp_dir), gray);
name("$r$", position = wheel_center + R1 * tmp_dir * 0.5 + 0.5Z - 0.15X, gray);
triple tmp_chi_dir = (0, cos(chi), sin(chi));
draw(roller_center -- (roller_center + R1 * tmp_chi_dir * 0.8), gray);

draw(arc(roller_center, roller_center + tmp_chi_dir * R1 * 0.75, roller_center - roller_axis, -radius_vector), blue);
name("$\psi$", position = roller_center + R1 * tmp_chi_dir * 0.9 - 0.5X, blue);

draw(arc(wheel_center, wheel_center - Z, wheel_center + radius_vector, X), blue);
name("$\chi$", position = wheel_center - 0.6Z - 0.3Y, blue);

// explicit
triple CD = roller_axis * R1 * tan(chi) / cos(psi);
triple DG = -(R - R1 / cos(chi)) * Z;
vector(roller_center, CD * 0.95, royalblue, lw = 1pt);
vector(roller_center + CD, DG * 0.8, royalblue, lw = 1pt);

drawdot3d(roller_center + CD, black);
name("$D$", position = roller_center + CD - 0.35X + 0.25Z, royalblue);
name("$C$", position = roller_center + CD + DG - 0.5Z + 0.2X, red);

name("$a$", position = roller_center + CD * 0.5 - 0.4X - 0.05Y, royalblue);
name("$h$", position = roller_center + CD + DG * 0.5 + 0.35Y, royalblue);

// === END OF OTHER VECTORS ==========================


// === OTHER LABELS ==================================


name("$P$", position = wheel_center - Y * 0.5 - X * 0.5, black);
name("$K$", position = roller_center + Y * 0.5 + X * 0.15, black);


// === END OF OTHER LABELS ===========================
