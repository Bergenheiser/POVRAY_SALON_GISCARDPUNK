#version 3.7;
#include "shapes.inc"
#include "colors.inc"

#declare B_out = Round_Box (
    <0,0,0>, <5,10,5>
    0.4, 
    false,
)

#declare B_in = Round_Box(
    <0.5,0.7,-1>,
    <4.5,9.8,6>,
    0.3,
    false
)

#declare Box = difference
{
    object 
    {
        B_out 
        texture
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
    object {B_in texture{pigment {Orange}}}
}

#declare SquareBox = object{
    Box scale <1.0, 0.5, 1.0> // <x, y, z>
}

#declare WideBox = object {
    Box scale <1.7,0.5,1>
}

object{WideBox}

object{SquareBox translate<0,5.5,0>}

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
    location <5,15,10>
    look_at <0,0,0>
    angle 75
}
light_source{ 
    <-6,6,-6>
    rgb 1 
}
global_settings{
    ambient_light rgb <1,1,1>
    assumed_gamma 2.0
}
