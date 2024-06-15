#version 3.7;
#include "shapes.inc"
#include "colors.inc"


//////////////////////////////////////////
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

//////////MATERIAUX

#declare M_Ext_Meuble = material
{texture
        {
            pigment{rgb 1}
            finish {
                    ambient 0.2
                    diffuse 0.9
                    specular 0.6
                    reflection 0.2
                }
        }
}

#declare M_Int_Meuble = material{texture{pigment {Orange}}}

///////////HABILLLAGE


#declare O_Int_Meuble = object{
    F_Int_Meuble
    material{M_Int_Meuble}
}

#declare O_Ext_Meuble = object{
    F_Ext_Meuble
    material{M_Ext_Meuble}
}


////////////////ASSEMBLAGE

#declare Boite = difference
{
    object 
    {
        B_ext 
        
    }
    object {B_int}
}




////////////TRANSFORMATIONS
#declare BoiteCarree = object{
    Boite scale <1.0, 0.5, 1.0> // <x, y, z>
}
#declare BoiteLarge = object {
    Boite scale <1.7,0.5,1>
}


//////////POSITIONNNEMENT
#declare Meuble = union {
object{BoiteLarge scale 10}
object{BoiteCarree translate<0,5.5,0> scale 10}
object{Boite translate<-5,0,0> scale y*1.1 scale 10}
object{BoiteLarge translate<-5,11,0> scale 10}
object{Boite translate<8.5,0,0> scale 10}
object{BoiteLarge translate<3.5,11,0> scale 10}
}

object{Meuble}


///////////////////////////////////////

///LAISSER ICI//////////////



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
//Bien translate de 1/2 cm sur les surfaces confondus
background{
    <0.2,0.2,1>
}
plane {
    <0,1,0>, 0
    pigment {
        checker Red Yellow
    }
}
camera{ right x * image_width/image_height
    up y * 1
    location <50,300,100>
    look_at <0,0,0>
    angle 75
}
light_source{ 
    <-60,60,-60>
    rgb 1 
}
global_settings{
    ambient_light rgb <1,1,1>
    assumed_gamma 2.0
}
