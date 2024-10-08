#version 3.7;
#include "colors.inc"
#include "shapes.inc"
#include "woods.inc"
#include "glass.inc"
#include "textures.inc"
#include "golds.inc"
#include "metals.inc"
#include "stones.inc"
#include "skies.inc"
#include "rad_def.inc"

//Import local
#include "./chaise.inc"

//VARIABLES
#declare EpaisseurCadre = 0.3;
#declare ProfondeurCadre = 0.1;
#declare TailleCadre = 5;

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
    translate<0,7,2.5>    
}

#declare line2 = text{
    ttf"./assets/GapSans" "...You find yourself wishing you'd paid attention in math class" 1,0
    translate<0,5.5,2.5> 
}

#declare line3 = text{
    ttf "./assets/GapSans" "to all those formulae you thought" 1,0
    translate<0,4,2.5>
}

#declare line4 = text{
    ttf "./assets/GapSans" "you'd never have any use for in real life." 1,0
    translate<0,2.5,2.5>
}

#declare line5 = text{
    ttf "./assets/GapSans" "-- Jeff Lee" 1,0
    translate<0,1,2.5>
}

#declare Ext_pan = box{
    <-0.5,0,0>, <0.5,10,60>    
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
                reflection 0.04
                specular 0.03
                roughness 0.03
                }        
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
            roughness 0.05
        }
    }
}

#declare M_Plafond = material {
	texture{
		pigment{White}
	finish{
		reflection 0
		ambient 0.1
		diffuse 0.1
		specular 0.0001
	}
	}
}

#declare M_Brass = material {
    texture{
        pigment{P_Brass2}
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


//PHOTO
#declare TextureBois = material{
    texture {
    pigment { wood color_map {
        [0.5 color rgb <0.6, 0.3, 0.1>]
        [0.7 color rgb <0.8, 0.5, 0.3>]
    }}
    finish { ambient 0.2 diffuse 0.6 }
    normal { bumps 0.5 scale 0.02 }
}
}

#declare TextureImage = material{ 
    texture{ 
    pigment
    { 
        image_map
        { 
            png "./assets/easter_egg.png"
        }
        scale 10
        translate<5,5,0>
        
    }
    finish{ specular 0.04 roughness 0.3} 
    }
    interior{ior 0}
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
object{O_GT_Top scale<1,0.2,1> scale x*2 translate<0,24.5,0>}
object{O_GT_Leg translate<-10,0,-10>}
object{O_GT_Leg translate<-10,0,10>}
object{O_GT_Leg translate <14,0,-14>}
object{O_GT_Leg translate <14,0,10>}
split_union off
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
  cone { <0,0,4>, 2, <0,0,10>, 1 texture {
   pigment{color transmit 0.9 }//rgbf<0.05,.34,1,.9>
   finish{ambient 0 diffuse .05
   specular .1 roughness 1e-3
   reflection {.1 fresnel on}
   conserve_energy}}}
  sphere { <0,0,6>, 1 texture {T_Copper_2B}} 
  cone { <0,0,4>, 1, <0,0,4.5>, 0.5 texture {T_Copper_2B}}                       
  cone { <0,0,6>, 1, <0,0,5.25>, 0.5 texture {T_Copper_2B}}
  cone { <0,0,4>, 0.75, <0,0,5>, 0.5 texture {T_Copper_2B}}
  cone { <0,0,5.5>, 0.75, <0,0,4.75>, 0.5 texture {T_Copper_2B}}
  material {texture{finish {ambient .8 diffuse .6}}}
  split_union off  //permets de raytrace la structure entiere au lieu de ses sous-parties individuelles
}

#declare Lava_Lamp = union {
  object{O_Base}
  object{O_LavaTube}
}

#declare Lava_Light = object{ 
    Lava_Lamp
    scale 4 
    rotate x*-90
}


//Panneau
#declare Texte_a_graver = union{
    object{line1}
    object{line2}
    object{line3}
    object{line4}
    object{line5}
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
split_union off //permets de raytrace la structure entiere au lieu de ses sous-parties individuelles
}


//Photo
#declare O_Cadre = difference {

    box {
            <-TailleCadre, -TailleCadre, -ProfondeurCadre>, <TailleCadre, TailleCadre, ProfondeurCadre>
            material { TextureBois }
        }
    box {
        <-TailleCadre + EpaisseurCadre, -TailleCadre + EpaisseurCadre, -ProfondeurCadre - 0.1>,
        <TailleCadre - EpaisseurCadre, TailleCadre - EpaisseurCadre, ProfondeurCadre + 0.1>
    }
}

#declare O_Plane_Image = box {
    <-TailleCadre + EpaisseurCadre + 0.01, -TailleCadre + EpaisseurCadre + 0.01, -ProfondeurCadre + 0.01>,
    <TailleCadre - EpaisseurCadre - 0.01, TailleCadre - EpaisseurCadre - 0.01, -ProfondeurCadre + 0.02>
    material{TextureImage}
}
#declare CadrePhoto = union {
    object {O_Cadre}
    object {O_Plane_Image}
    
}

/////POSITIONNEMENT/////////////
//////////////////////////////////
object{
    Texte_a_graver
    scale<-12.5,12.5,0.7>
    rotate<0,109,0>
    translate<-592.5,0,0>
    no_shadow
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

object{TableVerre scale 5 translate<0,-5,0>}

object{O_Tapis scale <600,600,1> rotate x*90 translate <-300,1,-300>
 photons{
                target
                reflection on
                refraction off
            }}

object{Meuble scale 1.2 rotate y*70 translate <470,0,100>
 photons{
                target
                reflection on
                refraction off
            }
 }

object{Chaise rotate y*60 scale 110 translate<130,0,75>
 photons{
                target
                reflection on
                refraction off
            }
}

object{CadrePhoto scale 8 rotate y*40 translate<210,250+TailleCadre,505> no_shadow}


/////////////PARAMETRES D'ENVIRONNEMENT////////////////
//////////////////////////////////////////////////////
#declare dawn =rgb<0.49,0.32,0.19>; 
//49% red, 32% green and 19% 

sky_sphere {
    pigment {
      gradient y                                                                                                           
      color_map {
        [0.000 0.002 color rgb <1.0, 0.2, 0.0>
                     color rgb <1.0, 0.2, 0.0>]
        [0.002 0.200 color rgb <0.8, 0.1, 0.0>
                     color rgb <0.2, 0.2, 0.3>]
      }
      scale 10
      translate -1
    }
    pigment {
      bozo
      turbulence 0.65
      octaves 6
      omega 0.7
      lambda 2
      color_map {
          [0.0 0.1 color rgb <0.85, 0.85, 0.85>
                   color rgb <0.75, 0.75, 0.75>]
          [0.1 0.5 color rgb <0.75, 0.75, 0.75>
                   color rgbt <1, 1, 1, 1>]
          [0.5 1.0 color rgbt <1, 1, 1, 1>
                   color rgbt <1, 1, 1, 1>]
      }
      scale <0.2, 0.5, 0.2>
    }
    scale 0.09
    rotate -70*x
    emission rgb <0.5,0.8,0.95> 
}

light_source{
    <0,120,0>
    color White
    looks_like { Lava_Light } 
    fade_distance 250
    fade_power 1
    shadowless

}

light_source {
    <-140,350,600>
    color dawn
    spotlight
    radius 75
    adaptive 1
    jitter
    point_at <0, -80, 100>
     photons{
                reflection on
                refraction on
            }
}

light_source {
    <-650,300,200>
    color dawn
    spotlight
    radius 60
    adaptive 1
    jitter
    point_at <-100, 0, 0>
    photons{
                reflection on
                refraction on
            }
}

camera { 
        perspective 
        right x*image_width/image_height
        up y
        location <350,260,-550>
        angle 80
        aperture 5.0
        blur_samples 2
        focal_point<0,150,0>
        look_at <0,250,290>
}

global_settings{
assumed_gamma 2.0 
radiosity{Rad_Settings(Radiosity_OutdoorLight,off,off)}
photons {
    count 10000
    media 100
    }
}  
