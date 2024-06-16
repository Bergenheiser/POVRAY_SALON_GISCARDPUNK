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

Liste des objets à modéliser:
Table (Dim) DONE
Meuble Kitch (Dim) DONE
Cadre photo (Dim) DONE
Fenetre (Max) DONE
Chaise (Dim) DONE
Tapis au sol (Dim) WIP
Murs (Max) DONE
Texte à placer (Max) WIP vérifier si la rotation c'est bien passé car on ne voyait pas le texte sous la fenere (new scale)
Skysphere (Max) WIP vérifier la texture en rendu final
Lava Lamp by Graham Barth (importée) https://www.ms.uky.edu/~lee/visual05/gallery/gallery.html

Faire scatter ! RETROUVE LE CODE CONNARD
Enlever reflection plafond
Lumùière sur lava lamp,
Poser meuble
Réparer la plaque texte
Importer cadre
Importer chaise

> > > > > > > Stashed changes

Cahier des charges :

- Environnement fermé
- 2 types d'objets différents (formes, couleur)
- Type de modélisation géométrique :
  - Forme géométrique de base (sphere,box,cylinder,cone..) -> La majorité des objets
  - Forme à chemin (prism, lathe, sphere sweep) -> Les pieds de la de la table
  - Un autre type de modèle (blob, isosurface, height_field, text)
- 1 objet doit etre un assemblage (composants avec matériaux différents)
- 1 objet doit être transparent (min 50% de sa surface) -> Table (Dimitri)
- 1 objet doit être réfléchissant (avec reflet identifiable) -> Table (Dimitri)
- 1 objet doit être habillé avec une image externe identifiable -> Cadre photo (Dimitri)
- 2 sources lumineuses minimum
- La caméra doit utiliser un léger flou focal.

L'importation d'objets de sources externes est autorisée dans la limite de 10% du nombre total d'objets uniques.

" You know you have been raytracing too long when ...
... You find yourself wishing you'd paid attention in math class to all those formulae you thought you'd never have any use for in real life.
-- Jeff Lee "

3.4.3.4 Sky Sphere
Texture from : https://wiki.povray.org/content/Reference:Skies.inc
try to rotate it in order to have some clear zone

Font
https://github.com/Interstices-/GapSans
