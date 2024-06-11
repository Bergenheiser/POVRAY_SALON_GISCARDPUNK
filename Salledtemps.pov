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
    
#declare Window_Glass =
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
Definition de la couche exterieur et int�rieur du mur 
Epaisseur = 15 cm
Longueur = 1m = 100 cm
Hauteur = 4 m = 400 cm
On texturera a la fin de l'assemblage des morceau en doublant cette couche et en ajoutant une couche de 1 cm de Verre au milieu 
pour les fenetres.
*/
#declare Mur_entier = box {
    <-7.5,0,0>,<7.5,400,100> //Centrage de la partie de mur par rapport a x = 0 et suit l'axe Z
    pigment{
        Pink
    }
    finish {
        ambient 1
        emission  0
        specular 1 roughness 1
        reflection 1
        }
}

#declare Mur_avec_fenetre = box {
    <-7.5,-200,-50>,<7.5,200,50> // Version du Mur centr�e sur (0,0,0) pour faire la fenetre
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
/* 
Definition taille du trou fenetre // Out
*/
#declare Couche_Fenetre = Round_Box( 
    <-8,-40,-40,><8,40,40>,
    0.6,
    false,
)
    
    
    

/*                                                                                                  
Definition de la couche du milieu du mur 
Epaisseur = 3 cm
Longueur = 80cm
Hauteur = 80cm
On utilisera cette couche pour faire des fenetres dans notre pi�ce
*/
#declare Couche_verre = Round_Box( 
    <-1.5,0,0>,<1.5,79.5,79.5>, // Centrer comme les couches int/ext
    0.6,
    false,
)    

#declare Box = difference
{
    object
    {
        Mur_avec_fenetre
    }
    object
    {
        Couche_Fenetre
        texture {pigment {Grey}
    }
}

#declare Glass_window = object {Couche_verre}
    material{Window_Glass}
}

object{
    Box
    translate<-7.5,200,20> 
}

object{Glass_window translate<-6,119.5,-19.5>}


/*
Ajouter du verre (table.pov)
Faire les fenetres (Round_Box voir meuble.pov)
Box qui ferme en haut + en bas
Skysphere + �clairement
*/

camera { location <-100,200,0>
        right x*image_width/image_height
        look_at <0,200,100>
        
}

light_source{ 
    <0,1000,0>
    rgb 1 
}

global_settings{ambient_light rgb <1,1,1>}  