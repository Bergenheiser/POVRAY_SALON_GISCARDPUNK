#version 3.7;
#include "colors.inc"
#include "shapes.inc"
#include "woods.inc"
#include "glass.inc"
#include "textures.inc"


////////FORMES ELEMENTAIRES/////////////////
////////////////////////////////////////////

/* 
Definition du Mur Entier 
Epaisseur = 15 cm
Longueur = 1m = 100 cm
Hauteur = 4 m = 400 cm
*/

#declare F_Sol = polygon{
    10, // E A I H C G F B D E
    <-600,0,-800>,<-600,0,0>,<-500,0,300>,<-300,0,500>,<0,0,600>,<300,0,500>,<500,0,300>,<600,0,0>,<600,0,-800>,<-600,0,-800>
}

#declare F_Plafond = polygon{
    10, // E A I H C G F B D E
    <-600,400,-800>,<-600,400,0>,<-500,400,300>,<-300,400,500>,<0,400,600>,<300,400,500>,<500,400,300>,<600,400,0>,<600,400,-800>,<-600,400,-800>
}

#declare F_Mur = box {
    <-7.5,0,0>,<7.5,400,100> //Centrage de la partie de mur par rapport a x = 0 et suit l'axe Z
    // Centre de gravité <0,200,50>
}

/* 
Definition taille du trou fenetre // Out
*/
#declare F_Creus = object{
    Round_Box( 
    <-9,132,5>,
    <9,350,95>,
    40,
    false,
)
}

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


//TABLE

#declare F_Pied_Table = lathe {
  cubic_spline
  9, 
  <1, 0>,   
  <1, 3>,   
  <1.5, 4>,   
  <1, 5>, 
  <2, 6>,   
  <1, 7>,
  <2.5,8>,
  <1,9>,
  <1,11>
  texture {
    pigment { color rgb <1, 1, 1> }
  }
  finish {
    ambient 0.1
    diffuse 0.9
  }
}

#declare F_Poteau_Pied_Table = cylinder {
    <0, 0, 0>, <0, 20, 1>, 1 
}

#declare F_Table = cylinder {
  <0,0,0>,
  <0,1,0>,
  15
}













/////////////////MATERIAUX////////////////////////
/////////////////////////////////////////////////

    
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
#declare M_Verre_Table = material {
  texture{
    pigment {White*.99+Green*.01 filter 0.999}
    normal {bumps .1 scale .5}
    finish {
      diffuse 0
      ambient 0
      specular 0.01
      roughness 0.005
      reflection {0.04, .9 fresnel}
      conserve_energy
    }
  }
  interior {ior 2.4 fade_distance 0.3 fade_power 1000 fade_color rgb<0,0.1,0.05>}
}


/////////////HABILLAGE///////////////////
///////////////////////////////////////////

#declare O_Mur = object{
    F_Mur
    material{M_Papier_Peint}
}


#declare O_Verre = object{ 
    F_Fenetre
    material{M_Verre}
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

//TABLE
#declare O_GT_Top = object{
  F_Table
  material{M_Verre_Table}
}
#declare O_GT_LegPole = object {
  F_Poteau_Pied_Table
  material{M_Verre_Table}
}
#declare O_GT_Foot = object {
  F_Pied_Table
  material{M_Verre_Table}
}


////CSG ET TRANSFORMATIONS
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

#declare Mur_Fenetre = union{
    object{O_Mur_Creus}
    object{O_Verre}
}

//TABLE
#declare O_GT_Leg = union {
  object {O_GT_Foot scale 0.5}
  object {O_GT_LegPole translate <0, 4.5, 0> }
} 

#declare TableVerre = union{
  object{O_GT_Top scale<0,0.2,0> scale x*2 translate<0,24.5,0>}
object{O_GT_Leg translate<-14,0,-14>}
object{O_GT_Leg translate<-14,0,14>}
object{O_GT_Leg translate <14,0,-14>}
object{O_GT_Leg translate <14,0,14>}
}


/////POSITIONNEMENT

object{TableVerre scale 5}

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




















/////////////PARAMETRES D'ENVIRONNEMENT////////////////

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