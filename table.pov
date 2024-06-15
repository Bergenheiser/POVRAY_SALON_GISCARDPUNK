#version 3.7;
#include "colors.inc"
#include "glass.inc"


#declare F_Foot = lathe {
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

#declare F_T_LegPole = cylinder {
    <0, 0, 0>, <0, 40, 1>, 1 
}

#declare F_T_Top = cylinder {
  <0,0,0>,
  <0,1,0>,
  15
}


////Matériaux
#declare M_Glass = material {
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

////Habillage
#declare GT_Top = object{
  T_Top
  material{M_Glass}
}
#declare GT_LegPole = object {
  T_LegPole
  material{M_Glass}
}
#declare GT_Foot = object {
  T_Foot
  material{M_Glass}
}

///Assemblage
#declare GT_Leg = union {
  object {GT_Foot}
  object {GT_LegPole translate <0, 9, 0> }
} 

#declare GlassTable = union{
  object{GT_Top scale<0,0.2,0> translate<0,49,0>}
  object{GT_Leg translate<-7.5,0,-7.5>}
  object{GT_Leg translate<-7.5,0,7.5>}
  object{GT_Leg translate <7.5,0,-7.5>}
  object{GT_Leg translate <7.5,0,7.5>}
}

object{GlassTable}


background{
    <0.2,0.2,1>
}

plane {
    <0,-5,0>, 0
    pigment {
        checker Red Yellow
    }
}

camera{ right x * image_width/image_height
    up y * 1
    location <5,45,-20>
    look_at <0,50,0>
    angle 75
}
light_source{ 
    <-6,3,-6>
    rgb 0.7 
}
light_source{
  <5,30,10>
  rgb 0.7
}

global_settings{
  radiosity{}
}