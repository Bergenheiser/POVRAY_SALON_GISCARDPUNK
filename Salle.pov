#version 3.7;
#include "colors.inc"
#include "shapes.inc"
#include "woods.inc"
#include "glass.inc"
#include "textures.inc"
#include "golds.inc"
#include "metals.inc"
#include "stones.inc"




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
    <-9,132,10>,
    <9,350,90>,
    40,
    false,
)
}

#declare F_Fenetre = object{Round_Box( 
    <-1.5,130,2>,
    <1.5,352,98>, // Centrer comme les couches int/ext
    2,
    false,
)
}

#declare F_Tapis = box{
    <0,0,0>,<1,1,1>
}

#declare F_Scatter_Box = box{
    <-1.5,132,5>,
    <3,350,95>
    pigment { rgbt 1 } hollow
    interior
    { media
     { scattering { 1, 0.07 extinction 0.01 }
       samples 30,100
     }
    }
    
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

// Panneau

#declare line1 = text{
    ttf "./assets/GapSans" "You know you have been raytracing too long when..." 1, 0
    translate<0,5.5,2.5>
    
     
}

#declare line2 = text{
    ttf"./assets/GapSans" "...You find yourself wishing you'd paid attention in math class to all those formulae you thought you'd never have any use for in real life." 1,0
    translate<0,4,2.5> 
}

#declare line3 = text{
    ttf "./assets/GapSans" "-- Jeff Lee" 1,0
    translate<0,2.5,2.5>
   
}

#declare Ext_pan = box{
    <-0.5,0,0>, <0.5,8,60>    
}




//Meuble
#declare F_Ext_Meuble = Round_Box (
    <0,0,0>, <5,10,5>
    0.4, 
    false,
)
#declare F_Int_Meuble = Round_Box(
    <0.5,0.7,-1>,
    <4.5,9.8,6>,
    0.3,
    false
)











/////////////////MATERIAUX////////////////////////
/////////////////////////////////////////////////

    
#declare M_Verre =
material{    
    texture{
        pigment{ color transmit 0.9}
            finish { 
                reflection 0.01
                specular 0.04
                roughness 0.03
                phong 0.75
                phong_size 150}        
   }
   interior{ior 1.4}
} 
    
#declare M_Sol = material{
    texture{T_Wood1}
    scale 10
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
            diffuse 0.4
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


//Meuble
#declare M_Ext_Meuble = material
{texture
        {
            pigment{rgb 0.9}
            finish {
                    ambient 0.2
                    diffuse 0.7
                    specular 0.6
                    reflection 0.2
                }
        }
}

#declare M_Int_Meuble = material{texture{pigment {Orange}}}


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
    material{M_Papier_Peint}
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



///LAVA LAMP
#declare O_Base = union {
  cone { <0,0,0>, 2, <0,0,2>, 1 finish {F_MetalE}}  
difference{
  cone { <0,0,2>, 1, <0,0,4>, 2 finish {F_MetalE}}
  sphere { <0,0,4>, 0.75 texture {T_Ruby_Glass}}
}
cone { <0,0,10>, 1, <0,0,11.5>, 0.75 finish {F_MetalE}}
}

#declare O_LavaTube = union{   
  cone { <0,0,4>, 2, <0,0,10>, 1 texture {T_Ruby_Glass}}
  sphere { <0,0,6>, 1 texture {T_Copper_2B}} 
  cone { <0,0,4>, 1, <0,0,4.5>, 0.5 texture {T_Copper_2B}}                       
  cone { <0,0,6>, 1, <0,0,5.25>, 0.5 texture {T_Copper_2B}}
  cone { <0,0,4>, 0.75, <0,0,5>, 0.5 texture {T_Copper_2B}}
  cone { <0,0,5.5>, 0.75, <0,0,4.75>, 0.5 texture {T_Copper_2B}}
}

#declare Lava_Lamp = union {
  object{O_Base}
  object{O_LavaTube}
}
//Panneau
#declare Texte_a_graver = union{
    object{line1}
    object{line2}
    object{line3}
}

#declare Text_Final = difference{
    object{Ext_pan}
    object{Texte_a_graver}
}

//Meuble
#declare Boite = difference
{
    object {F_Ext_Meuble material{M_Ext_Meuble}}
    object {F_Int_Meuble material{M_Int_Meuble}}
}

#declare BoiteCarree = object{
    Boite scale <1.0, 0.5, 1.0>
}
#declare BoiteLarge = object {
    Boite scale <1.7,0.5,1>
}

#declare Meuble = union {
object{BoiteLarge scale 10}
object{BoiteCarree translate<0,5.5,0> scale 10}
object{Boite translate<-5,0,0> scale y*1.1 scale 10}
object{BoiteLarge translate<-5,11,0> scale 10}
object{Boite translate<8.5,0,0> scale 11}
object{BoiteLarge translate<3.5,11,0> scale 10}
}


/////POSITIONNEMENT

object{
    Text_Final
    pigment{P_Chrome4}
    rotate <0, 19, 0>
    translate <-581.5,30,0>
}

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



//object{TableVerre scale 5}

object{O_Tapis scale <600,600,1> rotate x*90 translate <-300,1,-300>}

object{F_Scatter_Box translate <-300,250,500>}

//object{Lava_Lamp scale 4 rotate x*-90 translate<0,120,0>}

object{Meuble scale 1.2 rotate y*70 translate <470,1,100>} //rotate y*-30 translate <250,1,300>}




/////////////PARAMETRES D'ENVIRONNEMENT////////////////

sky_sphere {
  pigment {
    rgb<0.5,0.8,0.92>
    scale 130
    translate<0,0,-100>
    }
    emission rgb <0.5,0.8,0.95> 
}

camera { 
        perspective 
        right x*image_width/image_height
        up y
        location <350,260,-550>
        /*aperture 0.4 
        blur_samples 1
        angle 80
        focal_point<0,100,0>*/
        look_at <0,250,290>
}


/*camera {
    location <-100,700,900>
    look_at <-150,400,600>
}*/

light_source {
    <-140,350,600>
    color White
    spotlight
    radius 75
    adaptive 1
    jitter
    point_at <0, -80, 100>
} //POSITION VALIDEE



// CALCULER COORDS AUTRES LUMIERE
light_source {
    <-650,300,200>
    color White
    spotlight
    radius 60
    adaptive 1
    jitter
    point_at <-100, 0, 0>
}



global_settings{
    ambient_light rgb<1, 1, 1>
 //Pour le positionnement à retirer en prod.
assumed_gamma 2.0 
//radiosity{}
}  