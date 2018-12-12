
////////////////////////////////////////////////////////
// THIS FILE MUST BE INCLUDED BY PATH
// RELATIVE TO THE FILE THAT WILL USE THE *.ASY FILES 
// THAT WILL INCLUDE THIS FILE
//
// 0_0
//
// That is, if you have such a structure:
//     .
//     main.tex        <-- uses image.asy
//     asy/
//         helper.asy  
//         image.asy   <-- uses helper.asy
// 
//  then image.asy should have:
//      include "./asy/helper.asy";
//
//  but not just
//      include "./helper.asy";
//
//  So 80's.
//
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// Specially for PMM:
//
// settings.gray=true;
usepackage("textgreek", "euler");
//
////////////////////////////////////////////////////////
usepackage("bm"); // for bold greeks

pair dr(real angle) {
    return (cos(angle), sin(angle));
}

void addarrow(
    path g, 
    pen p=grey,
    position position=EndPoint
) {
    add(
        arrow(
            TeXHead,
            g,
            invisible,
            FillDraw(p),
            position
        )
    );
}

path DOT = scale(0.03) * unitcircle;

void drawdot(pair coords) {
    filldraw(
        shift(coords)
         * scale(0.03)
         * unitcircle
        , white
    );
}

pen fatdashed=linetype(new real[] {8,4});

pen mydashdotted=linetype(new real[] {8,4,2,4});
