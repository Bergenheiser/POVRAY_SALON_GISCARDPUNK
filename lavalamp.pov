#include "colors.inc"
#include "glass.inc"
#include "golds.inc"
#include "metals.inc"
#include "stones.inc"
#include "woods.inc"

camera { 
  sky <0,0,1>
  direction <-1,0,0>
  right <-4/3,0,0>
  location <15,15,13>
  look_at <0,0,6>
  angle 45
}

global_settings { ambient_light White }

light_source { <6,0,5> color White}
light_source { <-6,0,5> color White}
light_source { <0,6,5> color White} 
light_source { <0,-6,5> color White}                                        
light_source { <6,0,10> color White}
light_source { <-6,0,10> color White}
light_source { <0,6,10> color White}
light_source { <0,-6,10> color White}  
light_source { <-15,-15,0> color White} 

background {color White}

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

object{Lava_Lamp}