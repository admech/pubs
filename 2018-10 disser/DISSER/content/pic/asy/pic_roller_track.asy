include "./content/pic/asy/helper.asy";

unitsize(1.3cm);

////////////////////////////////////////////////
// PLANE
////////////////////////////////////////////////

    draw((-1.5,-1.4) -- (1.7,-1.4), mydashdotted + grey);
    draw((-1.5,-1.8) -- (1.7,-1.8), black + 1);
    
    pair contact_point = (0, -1.4);

////////////////////////////////////////////////
// WHEEL HUB AND ROLLERS
////////////////////////////////////////////////

    path ROLLER_TEMPLATE = 
        (arc((0,0), 1.4, -135, -45)
        --
        arc((0,-2), 1.4, 45, 135)
        -- cycle)
    ;

    path ROLLER = 
        rotate(30) *
        ROLLER_TEMPLATE;
    fill(ROLLER, lightgray + opacity(0.5) + 1);

    real label_start_angle = pi/2 + pi/6 + pi/8;
    real label_radius = 1.6;

    draw(ROLLER, black + 1);

////////////////////////////////////////////////
// DIMENSIONS
////////////////////////////////////////////////

    // r - HUB RADIUS

        label("$r$", (1.67,0.33));
        path prdim = ((0,0) + 1.34*dr(pi/6)) -- (dr(-pi/2+ pi/6) + 1.34*dr(pi/6));
        draw(prdim, mydashdotted+grey);
        addarrow(prdim, grey);
        addarrow(reverse(prdim), grey);
    
    // l - WHEEL RADIUS TOGETHER WITH ROLLERS

        label("$l$", (-1.2,-0.7));
        path pldim = (-1.05,0) -- (-1.05,-1.4);
        draw(pldim, mydashdotted+grey);
        addarrow(pldim, grey);
        addarrow(reverse(pldim), grey);
    
    
    // rho - DISTANCE FROM ROLLER AXIS TO CONTACT POINT
    
        real chi_0 = pi/6;
        real fst_roller = -pi/2 + chi_0;
        pair roller_center = dr(fst_roller);
        pair half_roller_axis = dr(chi_0);
        
        // axis line end
        pair a = (roller_center - 1.5*half_roller_axis);
        
        // C_i line end
        pair b = (contact_point - 0.8*half_roller_axis);
        
        // direction of dimension line
        pair c = dr(pi/2 + pi/6)*0.3;
        
        // mid of dimension line
        pair d = (a+b)/2 + half_roller_axis * 0.2;
        
        // the dimension line itself
        path rho = (d + c) -- (d - c);
        
////////////////////////////////////////////////
// LOCAL COORDINATES
////////////////////////////////////////////////

    draw((0,0) -- 1.7*dr(pi/6), mydashdotted);
    draw((0,0) -- -1.5*(1,0), mydashdotted);
    
    draw(roller_center -- (0,0), arrow = Arrow(SimpleHead));
    draw((0,0) -- contact_point, arrow = Arrow(SimpleHead));

    label("$\bm{\gamma}$", (1.3,-1.4+0.25) + (0.17,0));
    draw((1.3,-1.4) -- (1.3,-1.4+0.5), arrow = Arrow(SimpleHead));

    label("$\mathbf{i}$", roller_center + 0.5*dr(pi/6) + (-0.17,-0.35));
    draw(roller_center -- (roller_center + 0.5*dr(pi/6)), arrow = Arrow(SimpleHead));

    label("$x$", 2.3*(cos(pi/6 - 0.2),sin(pi/6 - 0.2)) - (-0.1, 0.5));
    draw((roller_center - 1.2*(cos(pi/6),sin(pi/6))) -- (roller_center + 1.7*(cos(pi/6),sin(pi/6))), arrow = Arrow(SimpleHead));
    
    label("$\mathbf{d}$", roller_center + 0.27*dr(pi - pi/8));
    draw(shift(roller_center) * scale(0.09) * unitcircle);

////////////////////////////////////////////////
// DOTS -- Should be done on top for PMM
////////////////////////////////////////////////

    label("$P$", 0.4*dr(pi/2 - pi/12));
    drawdot((0,0));

    label("$C$", contact_point + 0.2*(1, 1));
    drawdot(contact_point);

    drawdot(contact_point + (0,-0.4));
    draw(contact_point -- (contact_point + (0,-0.4)), mydashdotted + gray);

    label("$K$", roller_center + (0.13,0.27));
    drawdot(roller_center);

    label("$B_+$", roller_center + 1.4*sin(pi/4)*dr(pi/6) + (0.23,-0.2));
    label("$B_-$", roller_center - 1.4*sin(pi/4)*dr(pi/6) + (-0.23,0.2));
    drawdot(roller_center + 1.38*sin(pi/4)*dr(pi/6));
    drawdot(roller_center - 1.38*sin(pi/4)*dr(pi/6));
