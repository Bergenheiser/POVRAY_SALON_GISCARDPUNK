#version 3.7;
#include "colors.inc"
#include "shapes.inc"

global_settings { assumed_gamma 2.0 }
/* 
Plan du sol avec vecteur normal Y P(x,z)
Axe de roation pour les transofromation Y
*/
plane { y, 0
    pigment{
        checker Red Black
        }
}

/* 
Definition de la couche exterieur et intï¿½rieur du mur 
Epaisseur = 15 cm
Longueur = 1m = 100 cm
Hauteur = 4 m = 400 cm
On texturera a la fin de l'assemblage des morceau en doublant cette couche et en ajoutant une couche de 1 cm de Verre au milieu 
pour les fenetres.
*/
#declare F_Mur_entier = box {
    <-7.5,0,0>,<7.5,400,100> //Centrage de la partie de mur par rapport a x = 0 et suit l'axe Z
}

#declare F_Mur_avec_fenetre = box {
    <-7.5,-200,-50>,<7.5,200,50> // Version du Mur centr�e sur (0,0,0) pour faire la fenetre
}
#declare F_Couche_Fenetre = Round_Box( 
    <-8,-40,-40,><8,40,40>,
    0.3,
    false,
)
#declare F_Couche_verre = Round_Box( 
    <-1.5,0,0>,<1.5,79.5,79.5>, // Centrer comme les couches int/ext
    0.3,
    false,
)   

///MATERIAUX

#declare M_Mur = material{
    texture
    {
     pigment{
        White
    }
    finish {
        ambient 1
        emission  0
        specular 1 roughness 1
        reflection 1
        }
    }
}
    
#declare M_Window_Glass =
material{    
    texture{
        pigment{ rgbf<0.98,0.98,0.98,0.8>}
            finish { diffuse 0.1
                reflection 0.2
                specular 0.8
                roughness 0.0003
                phong 1
                phong_size 400}
           }
} 

/* 
Definition taille du trou fenetre // Out
*/
    
    
    

/*                                                                                                  
Definition de la couche du milieu du mur 
Epaisseur = 3 cm
Longueur = 80cm
Hauteur = 80cm
On utilisera cette couche pour faire des fenetres dans notre piï¿½ce
*/

///HABILLAGE////
#declare Mur_Fenetre= object{
    F_Mur_avec_fenetre
    material{M_Mur}
}
#declare Mur = object{
    F_Mur_entier
    material{M_Mur}
}


#declare Glass_window = object{ 
    F_Couche_verre
    material{M_Window_Glass}
}

#declare Mur_Creuse = difference
{
    object
    {
        Mur_Fenetre
    }
    object
    {
        F_Couche_Fenetre
    }
}

object{
    Mur // Remplacer par mur avec fenetre une fois l'objet final crée
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 19, 0>
    translate <-600,0,0>
    // Segment AI P(x,z) 
}

object{
    Mur
    scale <1,1,sqrt(8)> //Scale de Z
    rotate <0, 45, 0>
    translate <-500,0,300>
    // Segment IH P(x,z)  
}

object{
    Mur // Remplacer par mur avec fenetre une fois l'objet final crée
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 71, 0>
    translate <-300,0,500>
    // Segment HC P(x,z) 
}

object{
    Mur
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 109, 0>
    translate <0,0,600>
    // Segment CG P(x,z)  
}

object{
    Mur // Remplacer par mur avec fenetre une fois l'objet final crée
    scale <1,1,sqrt(8)>
    rotate <0, 135, 0>
    translate <300,0,500>
    // Segment GF P(x,z) 
}

object{
    Mur
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 161, 0>
    translate <500,0,300>
    
    // Segment FB P(x,z) 
}
// Modifier les dimention de ces 3 murs si on veut ajouter des fenetre dedans 
object{
    Mur
    scale<1,1,8>
    translate<-600,0,-800>
    
    // Segment EA P(x,z)
}

object{
    Mur
    scale<1,1,8>
    translate<600,0,-800>
    
    // Segment DB P(x,z)
}

object{
    Mur
    scale<1,1,12>
    rotate<0,90,0>
    translate<-600,0,-800>
    
    // Segment ED P(x,z)
}


#declare Window_Object = union{
    object{Mur_Creuse translate<-7.5,200,20>}
    object{Glass_window translate<-6,159.5,-19.5>}
}

object{Window_Object}

/*
Ajouter du verre (table.pov)
Faire les fenetres (Round_Box voir meuble.pov)
Box qui ferme en haut + en bas
Skysphere + ï¿½clairement
*/

camera { location <-100,200,-100>
        right x*image_width/image_height
        look_at <0,200,100>
        
}

light_source{ 
    <-100,300,-100>
    rgb 1 
}

global_settings{ambient_light rgb <1,1,1>}  