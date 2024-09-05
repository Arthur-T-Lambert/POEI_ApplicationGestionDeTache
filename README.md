# POEI_ApplicationGestionDeTache

Implémentation d'une application de gestion de tâche (ToDoList).

## Description

Ceci est une petite application, à la limite un "widget", permettant la gestion des tâches du quotidien par l'utilisateur. L'utilisateur peut à tout moment consulter la liste des tâches qu'il s'est assigné. Chaque tâche comporte un nom ou un titre, une description optionelle, une date et une heure de complétion, ainsi qu'une case à cocher pour indiquer si la tâche est effectuée ou non. La liste des tâche est persistante d'une exécution à l'autre.

## Installation

- **Windows x86_64** :
  Lancer l'exécutable `BTInstaller_win_x86_64.exe`, placé à la racine du dépôt, et suivre les instructions.
- **Autres plateformes** :
  En cours de développement. 

## Fonctionalités

### Fenêtre principale

Au lancement de l'application, la fenêtre principale est directement visible.

La majeure partie de la fenêtre de l'application montre la liste des tâches. Cette liste est divisée en trois sous-listes :
- `Aujourd'hui` : Les tâches à faire au plus tard aujourd'hui
- `Cette semaine` : Les tâches à faire dans la semaine qui suit
- `Plus tard` : Les tâches à faire plus tard

Les titres des trois sous-listes sont suffixés par deux nombres : le nombre de tâches **non effectuées** présentes dans la sous-liste et le nombre de tâches total dans la sous-liste.

Chacune des trois sous-listes peut être "repliée" ou "dépliée" à volonté par l'utilisateur en cliquant sur une bouton à gauche du titre. Dans l'état "replié", on ne voit que le titre et les deux nombres. Dans l'état "déplié", on voit l'ensemble des tâches de la sous-liste. 

Chaque tâche occupe une ligne. De gauche à droite, on voit :
- une case à cocher
- le titre de la tâche
- la date de complétion
- l'heure de complétion (si elle existe)

Les tâches "effectuées" restent présentes dans chacune des trois listes, mais apparaissent visuellement différentes, en plus de la coche visible.

Les tâches non effectuées dont la date de réalisation est dépassée restent dans la sous-liste "Aujourd'hui", mais sont "mises en avant" par un choix de couleurs plus vives, afin d'alerter l'utilisateur.

La description, si elle est présente, n'est pas visible directement dans la liste des tâche.

Si la liste des tâches est plus grande que la place disponible dans la fenêtre de l'application, un ascenseur apparaît pour faire glisser la liste des tâches et la rendre entièrement accessible.

### Changer le statut d'une tâche

Une case à cocher est présente devant chaque tâche. Si elle est cochée, cela signifie que la tâche est effectuée (terminée). Elle apparait dans une couleur plus "terne" (grisée). Pour changer son statut, il suffit de cliquer sur la case à cocher. 

### Ajouter une tâche

Un bouton "+" est toujours visible dans la fenêtre principale. Il permet d'ajouter une tâche. Lorsque l'utilisateur clique dessus, la page "Edition de tâche" apparaît en lieu et place de la page principale. Cette page permet de modifier tous les champs disponibles de la tâche.

On peut donc y voir :
- un champ de texte éditable pour le titre (nom) de la tâche
- un champ éditable pour la date. Un bouton permet à l'utilisateur de choisir une date dans une fenêtre popup "calendrier"
- un champ éditable pour l'heure. Un bouton permet à l'utilisateur de choisir une heure dans une fenêtre popup "heure"
- un champ de texte éditable multi-ligne pour la description (notes)
- un bouton `Annuler`
- un bouton `Ajouter`

- Si l'utilisateur clique sur le bouton `Annuler`, la fenêtre se ferme et laisse la place à la fenêtre principale sans rien changer à la liste des tâches. 
- Si l'utilisateur clique sur le bouton `Ajouter` et que toutes les infos sont correctes (titre d'au moins un caractère, date valide), la fenêtre se ferme et laisse la place à la fenêtre principale, avec la liste des tâches à jour avec la toute nouvelle tâche créée.

### Éditer une tâche

Si l'utilisateur clique sur le titre d'une tâche, on passe directement au mode "Édition de tâche". La page `Édition de tâche` apparaît en lieu et place de la page principale. Elle est identique à la page `Édition de tâche` lors de la création de tâche à ceci près que le bouton `Ajouter` est remplacé par deux boutons : `Supprimer` et `Valider`.

- Si l'utilisateur clique sur le bouton `Annuler`, la fenêtre se ferme et laisse la place à la fenêtre principale sans rien changer à la liste des tâches. 
- Si l'utilisateur clique sur le bouton`Supprimer`, une fenêtre popup apparaît demandant à l'utilisateur de confirmer son action. Si c'est le cas, la fenêtre se ferme et laisse la place à la fenêtre principale, avec la liste des tâches mise à jour avec la tâche qui vient d'être supprimée n'apparaissant plus. 
- Si l'utilisateur clique sur le bouton `Valider` et que toutes les infos sont correctes (titre d'au moins un caractère, date valide), la fenêtre se ferme et laisse la place à la fenêtre principale, avec la liste des tâches à jour avec la tâche éditée à jour et dans la bonne sous-liste.

## Reste à faire

Un lien vers un document décrivant les évolutions possibles :
[TODO.md](TODO.md)

## Documentation technique

[Documentation technique](GestionTache/doc/html/index.html)

