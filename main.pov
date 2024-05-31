#version 3.7;
#include "colors.inc"
#include "woods.inc"


//Modélisation géométrique (Création des formes élémentaires de nos structures complexes)

/*#declare F_Room = box { <0,0,0> <7100,3000,14200>}
#declare F_Bic_Capuchon = cylinder {
    <0, 0, 0>, 
    <0, 58, 0>, 
    7
    
}*/


//Matériaux (Textures)

//#declare M_TableTop = material{texture{T_Wood4}}

/*#declare Glass = material
{ 
    texture {
    pigment { rgbt <0.9, 0.9, 0.9> filter 0.95}
    finish {
        ambient 0.2
        diffuse 0.1
        specular 0.9
        reflection { 0.1, 1.0 fresnel on }
        }
    }
    interior{ ior 1.5 }
}*/

//Habillage (Formes+Matériaux)
/*#declare CorpsBlanc= object {
    F_Bic_Corps
    material{M_PlastiqueBlanc}
}*/


///////////////////////
//////Assemblage///////
///////////////////////
//union=groupe vs. merge=union ensembliste
/*#declare BicRouge = union
{
object {PastilleRouge}
object {CorpsBlanc translate <0, 2, 0> }
object {CapuchonRouge translate <0,2+82,0>}
}*/


/////////////////////////////////////////////////////////:
//Mise en scène et paramètres globaux d'environnements (disposition du catalogue d'objets composites, caméra, lumières)
///////////////////////////
///Generalement on fait toute les transformations d'orientation avant les translate. 
//object{Room translate <-3400,-750,-14100> }


//Position réelle
/*camera{
    right x * image_width/image_height
    up y * 1
    location <-3000,200,-4800>
    look_at <0,0,0>
    angle 66
}*/

light_source{
    <-2800,100,-500>
    color White
}
//Position test
camera{ right x * image_width/image_height
    up y * 1
    location <-100,100,-1000>
    look_at <0,0,0>
    angle 75
}

background{
    <0.2,0.2,1>
}

global_settings{ambient_light rgb <1,1,1>}
