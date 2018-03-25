include "./asy/helper.asy";

unitsize(1.3cm);

////////////////////////////////////////////////
// PLANE
////////////////////////////////////////////////

    draw((-1.5,-1.4) -- (1.7,-1.4), black + 1);
    
    pair contact_point = (0, -1.4);

////////////////////////////////////////////////
// WHEEL HUB AND ROLLERS
////////////////////////////////////////////////

    path HUB = unitcircle;
    draw(HUB, black + 1);
    
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

    label("$\textit{1}$", -dr(label_start_angle - pi/32) * label_radius);
    draw(ROLLER, black + 1);
    
    label("$\textit{2}$", -dr(pi/2 + label_start_angle) * label_radius);
    path ROLLER_2 = rotate(90) * ROLLER;
    draw(ROLLER_2, fatdashed+gray + 1);
    
    path ROLLER_3 = rotate(180) * ROLLER;
    draw(ROLLER_3, fatdashed+gray + 1);
    
    label("$n$", -dr(3*pi/2 + label_start_angle - pi/8) * label_radius);
    path ROLLER_4 = rotate(270) * ROLLER;
    draw(ROLLER_4, fatdashed+gray + 1);


////////////////////////////////////////////////
// LOCAL COORDINATES
////////////////////////////////////////////////

    label("$\mathbf{n}^\perp_i$", 2*(cos(pi/6 + 0.2),sin(pi/6 + 0.2)) + (0.28, 0.05));
    draw((0,0) -- 2.3*(cos(pi/6),sin(pi/6)), arrow = Arrow(SimpleHead));
    
    label("$\mathbf{n}^z_i$", 2.3*(cos(pi/2+pi/6 - 0.2),sin(pi/2+pi/6 - 0.2)) - (-0.1, 0.5));
    draw((0,0) -- 1.8*(cos(pi/2+pi/6),sin(pi/2+pi/6)), arrow = Arrow(SimpleHead));


////////////////////////////////////////////////
// ANGLES
////////////////////////////////////////////////

    label("$\kappa_j$", 0.82*(cos(-2*pi/8-0.05),sin(-2*pi/8-0.05)), blue);
    draw((0,0) -- -1.4*(cos(pi/2+pi/6),sin(pi/2+pi/6)), mydashdotted+gray);
    draw((0,0) -- 1.4*(cos(-pi/2),sin(-pi/2)), mydashdotted+gray);
    draw(arc(
        (0,0),
        -1.15*(cos(pi/2+pi/6),sin(pi/2+pi/6)),
        1.15*(cos(pi/6),sin(pi/6))
    ), arrow=Arrow(TeXHead), blue);

    // direction of positive roller rotation
    label(
        "$\phi_{ij}$",
        dr(pi/6) + 0.8*dr(pi/2 + pi/6) + 0.4*dr(pi/2 + pi/6 - pi/4) + 0.2*dr(pi/4),
        purple
    );
    draw(dr(pi/6) -- dr(pi/6) + 1.5*dr(pi/2 + pi/6), mydashdotted+gray);
    draw(arc(
        dr(pi/6) + dr(pi/2 + pi/6),
        dr(pi/6) + dr(pi/2 + pi/6) + 0.3*dr(pi/2 + pi/6 + pi/4),
        dr(pi/6) + dr(pi/2 + pi/6) + 0.3*dr(pi/2 + pi/6 - pi/4),
        CW
    ), arrow=Arrow(TeXHead), purple);

    label("$\chi_i$", 1.6*(cos(-pi/12+pi/6),sin(-pi/12+pi/6)), red);
    draw((0,0) -- (1.6,0), mydashdotted+gray);
    
    draw(arc(
        (0,0),
        1.3*(1,0),
        1.3*(cos(pi/6),sin(pi/6))
    ), arrow=Arrow(TeXHead), red);

////////////////////////////////////////////////
// DIMENSIONS
////////////////////////////////////////////////

    // r - HUB RADIUS

        label("$r$", (-0.4,-0.1));
        draw((0,0) -- dr(pi + pi/6), mydashdotted+grey);
    
    // l - WHEEL RADIUS TOGETHER WITH ROLLERS

        label("$l$", (1.7,-0.7));
        path pldim = (1.5,0) -- (1.5,-1.4);
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
        
        // teh label!
        label("$\rho_i$", ((a+b)/2 - half_roller_axis*0.2), heavygreen);
        
        // axis line
        draw(
            a
            --
            (roller_center + half_roller_axis)
        , mydashdotted+heavygreen);
        
        // C_i line
        draw(
            contact_point
            --
            b
        , mydashdotted+heavygreen);
        
        // dimension line with two outside arrows
        draw(rho, mydashdotted+heavygreen);
        addarrow(rho, heavygreen, Relative(0.3));
        addarrow(reverse(rho), heavygreen, Relative(0.3));

////////////////////////////////////////////////
// DOTS -- Should be done on top for PMM
////////////////////////////////////////////////

    label("$P_i$", 0.4*dr(pi/2 - pi/12));
    drawdot((0,0));

    label("$C_i$", contact_point + 0.2*(1, 1));
    drawdot(contact_point);asy