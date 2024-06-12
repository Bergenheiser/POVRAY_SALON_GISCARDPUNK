#version 3.7;
#include "colors.inc"

global_settings {
    assumed_gamma 2.0
    ambient_light <1, 1, 1> // <red, green, blue}
}

#declare FrameThickness = 0.3;
#declare FrameDepth = 0.1;
#declare FrameSize = 5;


background {
    <0.2,0.2,1>
}

plane {
    <0,1,0>, 0
    pigment {
        checker Red Yellow
    }
}
camera {
    right x * image_width/image_height
    up y * 1
    location <-20, 5, -20>
    look_at <0, 0, 0>
}
light_source{<20,6,20> rgb 1}


light_source {
    <0, 10, -10>
    color rgb <1, 1, 1>
}

// Wood texture for the frame
#declare WoodTexture = texture {
    pigment { wood color_map {
        [0.5 color rgb <0.6, 0.3, 0.1>]
        [0.7 color rgb <0.8, 0.5, 0.3>]
    }}
    finish { ambient 0.2 diffuse 0.6 }
    normal { bumps 0.5 scale 0.02 }
}

// Image texture
#declare ImageTexture = material{ 
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
    finish{ambient 0.1 diffuse 0.9 specular 0.5 roughness 0.03} 
    }
}
// Outer frame with rounded edges
#declare FrameOuter = difference {

    // Main box of the frame
    box {
            <-FrameSize, -FrameSize, -FrameDepth>, <FrameSize, FrameSize, FrameDepth>
            texture { WoodTexture }
        }
    // Cut out the inner part of the frame
    box {
        <-FrameSize + FrameThickness, -FrameSize + FrameThickness, -FrameDepth - 0.1>,
        <FrameSize - FrameThickness, FrameSize - FrameThickness, FrameDepth + 0.1>
    }
}
#declare ImageFrame = object{
    box{
    <0,0,0>, <1,1,1>
    } 
    material{ImageTexture}
    translate<-FrameSize + FrameThickness + 0.01, -FrameSize + FrameThickness + 0.01, -FrameDepth + 0.01>
}
// Image plane
#declare ImagePlane = box {
    <-FrameSize + FrameThickness + 0.01, -FrameSize + FrameThickness + 0.01, -FrameDepth + 0.01>,
    <FrameSize - FrameThickness - 0.01, FrameSize - FrameThickness - 0.01, -FrameDepth + 0.02>
    material{ImageTexture}
}
#declare CadrePhoto = union {
    object {FrameOuter}
    object {ImagePlane}
    
}
object{CadrePhoto translate<0,FrameSize,0>}
