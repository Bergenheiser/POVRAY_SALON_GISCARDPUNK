# Le salon GiscardPunk

Rappel de l'architecture logicielle du projet :

1. Modélisation des formes élémentaires (sous-ensemble d'objets complexes)
2. Matériaux et Textures
3. Habillage (Assemblage Formes + Matériaux)
4. Assemblage des objets complexes.
5. Paramètres d'environnement (lumière, caméra, etc.)

commande linux : povray main.pov main.ini

main.pov = fichier scene
<<<<<<< Updated upstream
main.ini = config image for 3840x2160
=======
main.ini = config image for 1920x108


CONCEPT:
Reprendre la pièce visible dans l'image salon circulaire
Ajouter le meuble kitch à droite
La TV, et les fenètres seront source de lumière
Les fenêtres 


Les murs du salon : un octogone centré sur l'origine, de largeur 800
>>>>>>> Stashed changes

Cahier des charges :
- Environnement fermé
- 2 types d'objets différents (formes, couleur)
- Type de modélisation géométrique :
    - Forme géométrique de base (sphere,box,cylinder,cone..)
    - Forme à chemin (prism, lathe, sphere sweep)
    - Un autre type de modèle (blob,isosurface,height_field, text)
- 1 objet doit etre un assemblage (composants avec métériaux différents) 
- 1 objet doit être transparent (min 50% de sa surface)
- 1 objet doit être réfléchissant (avec reflet identifiable)
- 1 objet doit être habillé avec une image externe identifiable 
- 2 sources lumineuses minimum
- La caméra doit utiliser un léger flou focal.

L'importation d'objets de sources externes est autorisée dans la limite de 10% du nombre total d'objets uniques.
