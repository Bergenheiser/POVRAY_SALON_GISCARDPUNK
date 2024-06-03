#version 3.7;
#include "shapes.inc"
#include "colors.inc"
#include "woods.inc"

#declare B_out = Round_Box (
    <0,0,0>, <5,10,5>
    0.4, 
    false,
)

#declare B_in = Round_Box(
    <0.5,0.7,-1>,
    <4.5,9.5,6>,
    0.3,
    false
)


#declare Box = difference
{
    object {B_out texture{pigment{rgb 1}}}
    object {B_in texture{pigment {Orange}}}
}


#declare Boite = object{
    Box
}

object{Boite interior{}}

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
    location <5,15,-5>
    look_at <0,0,0>
    angle 75
}
light_source{ 
    <-6,6,-6>
    rgb 1 
}
global_settings{ambient_light rgb <1,1,1>}
