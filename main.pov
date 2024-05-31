#version 3.7;
#include "colors.inc"
#include "woods.inc"


//Modélisation géométrique (Création des formes élémentaires de nos structures complexes)


#declare F_Room = box { <0,0,0> <7100,3000,14200>}
#declare F_Bic_Capuchon = cylinder {
    <0, 0, 0>, 
    <0, 58, 0>, 
    7
    
}

#declare F_Bic_Corps = cylinder {
    <0,0,0>,
    <0,82,0>,
    6

}

#declare F_Bic_Pastille = cylinder{
    <0,0,0>,
    <0,2,0> 
    5.5
}

#declare F_Table = box {
    <0,0,0>, <1300, 745, 500> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
    
}

#declare F_Verre_Corps = cylinder{
     <0,0,0>, <0,80,0>, 40
}

#declare F_Verre_Bord = sphere {
    <0,80,0>, 5
}


//Matériaux (Textures)
#declare M_PlastiqueBlanc = material{texture{pigment{White}}}
#declare M_PlastiqueRouge = material{texture{pigment{Red}}}
#declare M_PlastiqueBleu = material{texture{pigment{Blue}}}
#declare M_PlastiqueNoir = material{texture{pigment{Black}}}
#declare M_Neutre = material{texture {pigment{White}}}
#declare M_TableTop = material{texture{T_Wood4}}

#declare Glass = material
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
}

//Habillage (Formes+Matériaux)
#declare CorpsBlanc= object {
    F_Bic_Corps
    material{M_PlastiqueBlanc}
}
#declare CapuchonBleu = object {
    F_Bic_Capuchon
    material{M_PlastiqueBleu}
}

#declare CapuchonRouge = object {
    F_Bic_Capuchon
    material{M_PlastiqueRouge}
}

#declare CapuchonNoir = object {
    F_Bic_Capuchon
    material{M_PlastiqueNoir}
}

#declare PastilleRouge = object {
    F_Bic_Pastille
    material{M_PlastiqueRouge}
}

#declare PastilleNoire = object { 
    F_Bic_Pastille
    material{M_PlastiqueNoir}
}
#declare PastilleBleu = object { 
    F_Bic_Pastille
    material{M_PlastiqueBleu}
}
#declare Table = object {
    F_Table
    material{M_TableTop}
}
#declare Room = object {
    F_Room
    material{M_Neutre}
}
#declare VerreCorps = object{
    F_Verre_Corps
    material{Glass}
}
#declare VerreBord = object{
    F_Verre_Bord
    material{Glass}
}






///////////////////////
//////Assemblage///////
///////////////////////
//union=groupe vs. merge=union ensembliste
#declare BicRouge = union
{
object {PastilleRouge}
object {CorpsBlanc translate <0, 2, 0> }
object {CapuchonRouge translate <0,2+82,0>}
}

#declare BicNoir = union 
{
object {PastilleNoire}
object {CorpsBlanc translate <0,2,0>}
object {CapuchonNoir translate <0,2+82,0>}
}

#declare BicBleu = union
{
    object{PastilleBleu}
    object {CorpsBlanc translate <0,2,0>}
    object {CapuchonBleu translate <0,2+82,0>}
}
//A réparer de façon à arrondir les bords du verre
#declare Verre = merge {
        object {VerreCorps}
        object {VerreBord}
}
/////////////////////////////////////////////////////////:
//Mise en scène et paramètres globaux d'environnements (disposition du catalogue d'objets composites, caméra, lumières)
///////////////////////////
///Generalement on fait toute les transformations d'orientation avant les translate. 
object{Room translate <-3400,-750,-14100> }
object{Table translate<-(1300/2),-750,-500/2>}
object{BicRouge}
object{BicNoir translate<0,-86,0> rotate<90,-60,0> translate<70,0,-20> }
object{BicBleu rotate <-90, 30, 0> translate<-15,0,-35> }
object{Verre translate<-300,0,-150>}



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
