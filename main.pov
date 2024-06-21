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



//Chaise (le code ci-joint n'est pas organiquement sourcé, il est le produit de l'admiration des travaux de la communauté POVRAY) 
//Cependant, l'esthetique est entierement produit de notre direction artistique

#declare LegChair1=lathe{
	cubic_spline
	26,
	<0.051,-0.005>,	<0.039,0.000>,	<0.041,0.012>,	<0.049,0.017>,	<0.051,0.026>,
	<0.055,0.042>,	<0.042,0.074>,	<0.057,0.099>,	<0.052,0.109>,	<0.062,0.114>,
	<0.067,0.123>,	<0.063,0.135>,	<0.071,0.141>,	<0.079,0.191>,	<0.072,0.226>,
	<0.063,0.264>,	<0.056,0.292>,	<0.045,0.320>,	<0.044,0.354>,	<0.043,0.376>,
	<0.046,0.390>,	<0.050,0.403>,	<0.060,0.419>,	<0.056,0.438>,	<0.055,0.454>,
	<0.055,0.458>
	scale 0.1/0.454
	scale <2,1,2>
}                                                      
#declare rLegChair=0.079*0.1/0.454;
#declare rLegChair=0.079*1.5*0.1/0.454;
#declare LegChair2=superellipsoid{<0.2,0.2> scale <1,0.5,1> translate y*0.5 scale <rLegChair,0.1,rLegChair>}
#declare LegChair3 = lathe{
	cubic_spline
	10,
	<0.031,-0.003>,	<0.032,0.000>,	<0.035,0.012>,	<0.038,0.020>,	<0.045,0.029>,
	<0.054,0.044>,	<0.049,0.064>,	<0.029,0.081>,	<0.026,0.085>,	<0.013,0.092>
	scale 0.05/0.085
	scale <0.8,1,0.8>
}
#declare yLegChair=0.45;
#declare LegChair=union{
        object{LegChair3}
        object{LegChair2 translate y*0.05}
        object{LegChair1 rotate x*180 translate y*0.25}
        object{LegChair2 translate y*0.25}
        object{LegChair1 translate y*0.35}
        scale yLegChair/0.45
}                        
#declare xChair=yLegChair*1.1;
#declare zChair=xChair;
#declare RodChair1=cylinder{0,xChair*x,rLegChair}
#declare RodChair2=cylinder{0,xChair*x,rLegChair}


#declare RodChair1 = union{
        cylinder{0,x*xChair,rLegChair*0.3 translate y*0.03 translate z*0.01}
        prism{
        	cubic_spline
        	0,
        	1,
        	26,
        	<0.050,0.>,	<0.,0.010>,	<0.,0.060>,	<0.050,0.080>,	<0.100,0.100>,
        	<0.070,0.050>,	<0.110,0.050>,	<0.150,0.070>,	<0.170,0.080>,	<0.190,0.090>,
        	<0.170,0.040>,	<0.230,0.080>,	<0.290,0.040>,	<0.270,0.090>,	<0.290,0.080>,
        	<0.310,0.070>,	<0.350,0.050>,	<0.390,0.050>,	<0.360,0.100>,	<0.410,0.080>,
        	<0.460,0.060>,	<0.460,0.010>,	<0.410,0.>,	<0.050,0.>,	<0.,0.010>,<0.,0.060>
        	translate <-0.23,-0.5,-0.05>
        	scale <1,1,-1>
        	scale <xChair*0.5/0.23,rLegChair*0.7,xChair*0.3/0.23>
        	rotate x*-90                               
        	translate <xChair*0.5,0,rLegChair*0.5>
	}
	
}
#declare RodChair2= prism{
	cubic_spline
	0,
	xChair,
	12,
	<0.005,0.006>,	<0.010,0.026>,	<0.020,0.033>,	<0.019,0.073>,	<0.007,0.082>,	<0.005,0.106>,
	<0.042,0.103>,	<0.031,0.046>,	<0.038,0.007>,	<0.005,0.006>,	<0.010,0.026>,	<0.020,0.033>
	translate <-0.021,0,-0.053>
	scale <1,1,-1>
	scale <0.7*rLegChair/0.021,1,0.3*rLegChair/0.021>
	rotate z*-90
	rotate -x*90
}
#declare yEl=0.02;
#declare elBack=superellipsoid{<0.4,0.4> scale <1,0.5,1> translate y*0.5 scale <rLegChair,0.1,rLegChair>
        clipped_by{box{<-rLegChair*1.2,0.029,-rLegChair*1.2>,<rLegChair*1.2,0.071,rLegChair*1.2>}}
        scale <1,0.1/0.04,1>
        translate -y*0.03        
        }                       
#declare elBackEnd=superellipsoid{<0.4,0.4> scale <1,0.5,1> translate y*0.5 scale <rLegChair,0.1,rLegChair>
        clipped_by{box{<-rLegChair*1.2,0.029,-rLegChair*1.2>,<rLegChair*1.2,0.2,rLegChair*1.2>}}
        scale <1,0.1/0.04,1>
        translate -y*0.03        
        }                       
#declare NailChair=sphere{0,rLegChair*0.5 scale <1,1,0.5>}
#declare RodBack=superellipsoid{<0.3,0.3> scale <xChair*0.5,rLegChair,rLegChair*0.8>}
#declare elPillowBack=difference{
        superellipsoid{<0.5,0.5>}
        plane{z,0 inverse}
        scale <xChair*0.5,rLegChair,rLegChair*1>
}





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

//Chaise

#declare C_Nail=color Bronze;
#declare T_NailChair=texture{
        pigment{C_Nail}
        finish{metallic brilliance 5 reflection 0.1 ambient 0.01 diffuse 0.5 specular 0.4 roughness 0.01}
}           
#declare T_WoodChair=texture{
        pigment{
               Tan_Wood
        }   
        normal{brick 0.5 scale .1}
        finish{ambient 0.00 diffuse 0.4 specular 0.2 roughness 0.4}
}

#declare T_CanvasChair=texture{
       pigment{ 
        image_map
        { 
            png "./assets/texture_coussin.png" map_type 0 interpolate 2 
        }
        scale 0.5
        }
        normal{quilted 1 turbulence 0.01 scale 0.1*<1,1,1> rotate z*45}
        finish{diffuse 0.3 specular 0.04 roughness 0.1}
        scale 0.5
}

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
}

//Chaise
#declare nEl=25;
#declare yEl=0.03;
#declare BackChair=union{
        #declare i=0;          
        #declare posEl=<0,0,0>;
        #declare aEl=0;
        #while (i<nEl)                                           
                #if (mod(i,3)=0)
                        union{
                                object{NailChair rotate -y*90 translate -x*(xChair*0.5+rLegChair)}
                                object{NailChair rotate -y*90 translate x*(xChair*0.5+rLegChair)}
                                rotate x*aEl translate posEl 
                                texture{T_NailChair}
                        }
                #end
                #if (i<nEl-1)
                        union{
                                object{elBack scale <1,yEl/0.1,1> translate -x*xChair*0.5}
                                object{elBack scale <1,yEl/0.1,1> translate x*xChair*0.5}
                                rotate x*aEl translate posEl 
                        }
                #else
                        union{
                                object{elBackEnd scale <1,yEl/0.1,1> translate -x*xChair*0.5}
                                object{elBackEnd scale <1,yEl/0.1,1> translate x*xChair*0.5}
                                rotate x*aEl translate posEl 
                        }
                #end
                #if (i=11 | i=23)
                        object{RodBack rotate x*aEl translate posEl texture{T_WoodChair}}
                #end
                #declare posEl=posEl+<0,yEl*cos(radians(aEl)),yEl*sin(radians(aEl))>;
                #declare aEl=aEl+0.28;
                #declare i=i+1;
        #end

        #declare i=0;          
        #declare posEl=<0,0,0>;
        #declare aEl=0;
        union{
                #while (i<nEl)                                                       
                
                        #if (i>11 & i<23)
                                object{elPillowBack rotate x*aEl translate posEl}
                        #end
                        #declare posEl=posEl+<0,yEl*cos(radians(aEl)),yEl*sin(radians(aEl))>;
                        #declare aEl=aEl+0.25;
                        #declare i=i+1;
                #end
                texture{T_CanvasChair}        
        }

}                           
#declare xNailsPillow=union{
                #declare i=0;
                #while (i<7)
                        object{NailChair translate x*xChair*i/6 translate -z*rLegChair} //*0.1*sin(pi*i/6)}
                #declare i=i+1;
                #end
                translate -x*xChair*0.5
       }                          

#declare zNailsPillow=union{
                #declare i=0;
                #while (i<6)
                        object{NailChair translate x*zChair*i/6 translate -z*rLegChair} //*0.1*sin(pi*i/6)}
                #declare i=i+1;
                #end
                translate -x*zChair*0.5
                
       }                          

#declare Pillow=union{    
        union{
                object{xNailsPillow translate -z*zChair*0.5}
                object{xNailsPillow scale <1,1,-1> translate z*zChair*0.5}
                object{zNailsPillow rotate y*-90 scale <-1,1,1> translate -x*xChair*0.5}
                object{zNailsPillow rotate y*-90 translate x*xChair*0.5}
                translate y*rLegChair*0.25
                texture{T_NailChair}
        }                             
        
        difference{
                difference{superellipsoid{<0.4,0.4>} plane{y,0} scale <xChair*0.5,rLegChair*2.5,zChair*0.5>*1.02}
                plane{y,0}
                texture{T_CanvasChair rotate <0,45,-45>}
                translate -y*0.01
        }
        
        superellipsoid{<0.3,0.3> scale rLegChair*1.1 translate <-xChair,0,-zChair>*0.5}
        superellipsoid{<0.3,0.3> scale rLegChair*1.1 translate <-xChair,0,zChair>*0.5}
        superellipsoid{<0.3,0.3> scale rLegChair*1.1 translate <xChair,0,-zChair>*0.5}
        superellipsoid{<0.3,0.3> scale rLegChair*1.1 translate <xChair,0,zChair>*0.5}

        superellipsoid{<0.3,0.3> scale <xChair*0.5,rLegChair,rLegChair> translate -z*zChair*0.5}
        superellipsoid{<0.3,0.3> scale <xChair*0.5,rLegChair,rLegChair> translate z*zChair*0.5}

        superellipsoid{<0.3,0.3> scale <zChair*0.5,rLegChair,rLegChair> rotate -y*90 translate -x*xChair*0.5}
        superellipsoid{<0.3,0.3> scale <zChair*0.5,rLegChair,rLegChair> rotate -y*90 translate x*xChair*0.5}

}
#declare Chaise=union{                                                
        union{
                object{BackChair translate z*zChair*0.5}
                object{Pillow}
                translate y*(yLegChair+rLegChair*0.5)
                texture{T_WoodChair}
        }                            
        union{
                object{LegChair translate <xChair,0,zChair>*0.5}
                object{LegChair translate <xChair,0,-zChair>*0.5}
                object{LegChair translate <-xChair,0,zChair>*0.5}
                object{LegChair translate <-xChair,0,-zChair>*0.5}
                texture{T_WoodChair}
        }
        union{
                object{RodChair1 translate <-xChair*0.5,0.1,-zChair*0.5>}
                object{RodChair1 scale <1,1,-1> translate <-xChair*0.5,0.1,zChair*0.5>}
                object{RodChair2 translate <-xChair*0.5,0.3,-zChair*0.5>}
                object{RodChair2 scale <1,1,-1> translate <-xChair*0.5,0.3,zChair*0.5>}
                texture{T_WoodChair}
        }                
        union{
                
                object{RodChair1 scale <zChair/xChair,1,1> rotate y*-90 scale <-1,1,1> translate <-xChair*0.5,0.1,-zChair*0.5>}
                object{RodChair1 scale <zChair/xChair,1,1> rotate y*-90 translate <xChair*0.5,0.1,-xChair*0.5>}
                object{RodChair2 scale <zChair/xChair,1,1> rotate y*-90 scale <-1,1,1> translate <-xChair*0.5,0.3,-zChair*0.5>}
                object{RodChair2 scale <zChair/xChair,1,1> rotate y*-90 translate <xChair*0.5,0.3,-zChair*0.5>}
                texture{T_WoodChair}
                
        }
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
                     // Scale pour voir apparaitre le texte en diagonal sous la fenetre
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

object{O_Tapis scale <600,600,1> rotate x*90 translate <-300,1,-300>}

object{F_Scatter_Box translate <-300,250,500>}

object{Lava_Lamp scale 4 rotate x*-90 translate<0,120,0>}

object{Meuble scale 1.2 rotate y*70 translate <470,0,100>} //rotate y*-30 translate <250,1,300>}

object{Chaise rotate y*60 scale 110 translate<130,0,75>}

object{CadrePhoto scale 8 rotate y*40 translate<210,250+TailleCadre,505> no_shadow}


/////////////PARAMETRES D'ENVIRONNEMENT////////////////
//////////////////////////////////////////////////////

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


camera { 
        perspective 
        right x*image_width/image_height
        up y
        location <350,260,-550>
        aperture 0.4 
        blur_samples 1
        angle 80
        focal_point<0,100,0>
        look_at <0,250,290>
}


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
