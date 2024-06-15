#version 3.7;
#include "colors.inc"
#include "woods.inc"
#include "shapes.inc"
/**
* \file main.pov
* \brief Programme pour le projet d'Infographie 2 (Semestre 6)
* \author GAILLARD Maxime && COPLEY Dimitri
* \date 15/06/2024
*/

/* 
Définition de l'espace 3D utilisé pour la modélisation
Plan du sol avec vecteur normal Y P(x,z)
Axe de roation pour les transofromation Y
*/

/*Modélisation géométrique (Création des formes élémentaires de nos structures complexes)*/

/*
Définition du sol et du plafond avec des polygones qui ferment la salle déssinée dans le plan
*/
#declare F_Sol = polygon{
    10, // E A I H C G F B D E
    <-600,0,-800>,<-600,0,0>,<-500,0,300>,<-300,0,500>,<0,0,600>,<300,0,500>,<500,0,300>,<600,0,0>,<600,0,-800>,<-600,0,-800>
}

#declare F_Plafond = polygon{
    10, // E A I H C G F B D E
    <-600,400,-800>,<-600,400,0>,<-500,400,300>,<-300,400,500>,<0,400,600>,<300,400,500>,<500,400,300>,<600,400,0>,<600,400,-800>,<-600,400,-800>
}

/* 
Definition du Mur Entier 
Epaisseur = 15 cm
Longueur = 1m = 100 cm
Hauteur = 4 m = 400 cm
On texturera a la fin de l'assemblage des morceau en doublant cette couche et en ajoutant une couche de 1 cm de Verre au milieu 
pour les fenetres.
*/
#declare F_Mur = box {
    <-7.5,0,0>,<7.5,400,100> //Centrage de la partie de mur par rapport a x = 0 et suit l'axe Z
    // Centre de gravité <0,200,50>
}

/* 
Definition taille du trou fenetre // Out
*/
#declare F_Creus = object{
    Round_Box( 
    <-9,132,15>,
    <9,350,95>,
    40,
    false,
)
}

/*                                                                                                  
Definition de la couche de verre pour les fenetres 
Epaisseur = 3 cm
Longueur = 80cm
Hauteur = 80cm
On utilisera cette couche pour faire des fenetres dans notre mur [A REPRENDRE]
*/
#declare F_Fenetre = object{Round_Box( 
    <-1.5,132,5>,
    <1.5,350,95>, // Centrer comme les couches int/ext
    2,
    false,
)
}





/*Matériaux (Textures)*/
/*
Définition du matériau pour le mur
*/
#declare M_Mur = material{
    texture
    {
     pigment{
        rgb<0.5,0.5,0.5>
    }
    finish {
        ambient 1
        emission  0
        specular 1 roughness 1
        reflection 1
        }
    }
}
/*
Définition du matériau pour le verre des vitres
*/   
#declare M_Verre =
material{    
    texture{
        pigment{ rgbf<0.98,0.98,0.98,0.8>}
            finish { diffuse 0.1
                reflection 0.01
                specular 0.8
                roughness 0.0003
                phong 1
                phong_size 400}
           }
} 
/*
Définition du matériau pour le sol
*/    
#declare M_Sol = material{
    texture{T_Wood1}
}
/*
Définition du matériau pour le plafond
*/
#declare M_Plafond = material{
    texture{T_Wood1}
}


/*
Habillage (Formes + matéiraux) = Object
O_ POUR OBJET HABILLE
*/
#declare O_Mur = object{
    F_Mur
    material{M_Mur}
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




/* 
Assemblage des objets pour la scène 
*/
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





/*
Mise en scène des objets dans la scène
Paramètres globaux d'environnements

Rappel du plan :
Plan du sol avec vecteur normal Y P(x,z)
Axe de roation pour les transofromation Y
*/

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



//Position réelle
/*camera{
    right x * image_width/image_height
    up y * 1
    location <-3000,200,-4800>
    look_at <0,0,0>
    angle 66
}*/


//Position test
camera{ 
    right x * image_width/image_height
    up y * 1
    location <-300,200,-500>
    look_at <0,200,0>
    angle 75
    
}

light_source {
    <-400, 300, -600> // <x, y, z>
    color <1.0, 1.0,  1.0> // <red, green, blue>
    area_light <5, 0, 0>, <0, 0, 5>, 5, 5 // <x, y, z>, <x, y, z>, size 1, size 2    
}






global_settings{
    ambient_light rgb <1,1,1>
    assumed_gamma 2.0
}
