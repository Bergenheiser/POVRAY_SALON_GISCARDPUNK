#version 3.7;
#include "colors.inc"
#include "shapes.inc"
#include "woods.inc"

/* 
Plan du sol avec vecteur normal Y P(x,z)
Axe de roation pour les transofromation Y
*/
/*plane { y, 0
    pigment{
        checker Red Black
        }
}*/

#declare F_Mur = box {
    <-7.5,0,0>,<7.5,400,100> //Centrage de la partie de mur par rapport a x = 0 et suit l'axe Z
    // Centre de gravité <0,200,50>
}

#declare F_Creus = object{
    Round_Box( 
    <-9,132,10>,
    <9,350,90>,
    0.3,
    false,
)
}


#declare F_Fenetre = Round_Box( 
    <-1.5,132,10>,
    <1.5,350,90>, // Centrer comme les couches int/ext
    0.3,
    false,
)   