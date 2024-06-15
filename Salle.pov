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


#declare F_Sol = polygon{
    10, // E A I H C G F B D E
    <-600,0,-800>,<-600,0,0>,<-500,0,300>,<-300,0,500>,<0,0,600>,<300,0,500>,<500,0,300>,<600,0,0>,<600,0,-800>,<-600,0,-800>
}

#declare F_Plafond = polygon{
    10, // E A I H C G F B D E
    <-600,400,-800>,<-600,400,0>,<-500,400,300>,<-300,400,500>,<0,400,600>,<300,400,500>,<500,400,300>,<600,400,0>,<600,400,-800>,<-600,400,-800>
}


/* 
Definition du Mur Entier 
Epaisseur = 15 cm
Longueur = 1m = 100 cm
Hauteur = 4 m = 400 cm
On texturera a la fin de l'assemblage des morceau en doublant cette couche et en ajoutant une couche de 1 cm de Verre au milieu 
pour les fenetres.
*/
#declare F_Mur = box {
    <-7.5,0,0>,<7.5,400,100> //Centrage de la partie de mur par rapport a x = 0 et suit l'axe Z
    // Centre de gravité <0,200,50>
}

/* 
Definition taille du trou fenetre // Out
*/
#declare F_Creus = object{
    Round_Box( 
    <-9,132,15>,
    <9,350,95>,
    40,
    false,
)
}

/*#declare x0Creu = -9;
#declare x1Creu = 9;
#declare y0Creu = 132;
#declare y1Creu = 300;
#declare z0Creu = 10;
#declare z1Creu = 90;*/

/*                                                                                                  
Definition de la couche de verre pour les fenetres 
Epaisseur = 3 cm
Longueur = 80cm
Hauteur = 80cm
On utilisera cette couche pour faire des fenetres dans notre mur [A REPRENDRE]
*/
#declare F_Fenetre = object{Round_Box( 
    <-1.5,132,5>,
    <1.5,350,95>, // Centrer comme les couches int/ext
    2,
    false,
)
}   
#declare F_Tapis = box{
    <0,0,0>,<1,1,1>
}
///MATERIAUX

    
#declare M_Verre =
material{    
    texture{
        pigment{ rgbf<0.98,0.98,0.98,0.8>}
            finish { diffuse 0.7
                reflection 0.2
                specular 0.04
                roughness 0.03
                phong 1
                phong_size 400}
           }
} 
    
#declare M_Sol = material{
    texture{T_Wood1}
}

#declare M_Plafond = material{
    texture{T_Wood1}
}
    
#declare M_Tapis = material{
    texture {
        pigment{
            image_map{
                png "./assets/persian_rug.png" map_type 0 interpolate 2
            }
        }
        normal{ bumps 0.5 }
    }
    
}

#declare M_Papier_Peint = material{
    texture{
        pigment{
           rgb<0.9,0.9,0.8>
        }
        normal{ brick 0.5}
        finish{
            specular 0.01
            diffuse 0.7
            reflection { 0.01, 0.04 }
            roughness 0.05 //TEST GRADIENT DE REFLECTION
        }
    }
}



///HABILLAGE//// 


//// O_ POUR OBJET HABILLE

#declare O_Mur = object{
    F_Mur
    material{M_Papier_Peint}
}


#declare O_Verre = object{ 
    F_Fenetre
    material{M_Verre}
}

#declare O_Mur_Creus = difference
{
    object
    {
        O_Mur
    }
    object
    {
        F_Creus
    }
}

#declare O_Sol = object{
    F_Sol
    material{M_Sol}
}

#declare O_Plafond = object{
    F_Plafond
    material{M_Plafond}
}

#declare O_Tapis = object{
    F_Tapis
    material{M_Tapis}
}


//// ASSEMBLAGE
#declare Mur_Fenetre = union{
    object{O_Mur_Creus}
    object{O_Verre}
}




/////POSITIONNEMENT

object{O_Tapis scale <600,600,1> rotate x*90 translate <-300,1,-300>}

object{
    Mur_Fenetre // Remplacer par mur avec fenetre une fois l'objet final crée
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 19, 0>
    translate <-600,0,0>
    // Segment AI P(x,z) 
}

object{
    O_Mur
    scale <1,1,sqrt(8)> //Scale de Z
    rotate <0, 45, 0>
    translate <-500,0,300>
    // Segment IH P(x,z)  
}

object{
    Mur_Fenetre // Remplacer par mur avec fenetre une fois l'objet final crée
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 71, 0>
    translate <-300,0,500>
    // Segment HC P(x,z) 
}

object{
    O_Mur
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 109, 0>
    translate <0,0,600>
    // Segment CG P(x,z)  
}

object{
    Mur_Fenetre // Remplacer par mur avec fenetre une fois l'objet final crée
    scale <1,1,sqrt(8)>
    rotate <0, 135, 0>
    translate <300,0,500>
    // Segment GF P(x,z) 
}

object{
    O_Mur
    scale <1,1,sqrt(10)> //Scale de Z
    rotate <0, 161, 0>
    translate <500,0,300>
    
    // Segment FB P(x,z) 
}
// Modifier les dimention de ces 3 murs si on veut ajouter des fenetre dedans 
object{
    O_Mur
    scale<1,1,8>
    translate<-600,0,-800>
    
    // Segment EA P(x,z)
}

object{
    O_Mur
    scale<1,1,8>
    translate<600,0,-800>
    
    // Segment DB P(x,z)
}

object{
    O_Mur
    scale<1,1,12>
    rotate<0,90,0>
    translate<-600,0,-800>
    
    // Segment ED P(x,z)
}

object{
    O_Sol
}

object{
    O_Plafond
}



/*
Ajouter du verre (table.pov)
Faire les fenetres (Round_Box voir meuble.pov)
Box qui ferme en haut + en bas
Skysphere + ï¿½clairement
*/

cylinder {  // Positive X-axis (red)
  <0, 0, 0>  // Start point
  <100, 0, 0>  // End point
  1
  pigment { rgb<1,0,0> }
}

cylinder {  // Positive Y-axis (green)
  <0, 0, 0>
  <0, 100, 0>
  1
  pigment {  rgb<0,1,0>  }
}

cylinder {  // Positive Z-axis (blue)
  <0, 0, 0>
  <0, 0, 100>
  1
  pigment {  rgb<0,0,1> }
}

sky_sphere {
  pigment {
    rgb<0.5,0.8,0.92>
    scale 130
    translate<0,0,-100>
    }
    emission rgb <0.5,0.8,0.92>
}

camera {location <0,300,-700>
        right x*image_width/image_height
        look_at <0,250,-600>    
}

light_source{ 
    <-100,300,-100>
    rgb 0.8
}

global_settings{
assumed_gamma 2.0 
}  