# POEI_ApplicationGestionDeTache

Implémentation d'une application de gestion de tâche (ToDoList).

## Fonctionalités manquantes

### Gestion du style

On souhaite pouvoir faire évoluer le style de l'application au travers des "Settings". Changer la police, la taille des caractères, etc.

### Supprimer tout texte dans l'application

L'application a vocation a être de petite taille, voire à être utilisée sur téléphone. Pour s'éviter le problème de la traduction et avoir des boutons de taille minimale, la bonne idée serait de remplacer tous les textes des boutons par des icônes. Le principe de la notice IKEA... Le seul texte visible serait celui entré par l'utilisateur, dans la langue qu'il souhaite. 

### Gestion du temps

Pour l'instant il n'y a pas de gestion du temps dans l'application. La liste des tâches et leur répartition par catégorie n'évolue que lorsque l'utilisateur la modifie. Il serait intéressant d'afficher l'heure, d'une part, et que l'affichage des tâches reste cohérent avec l'heure courante. Pour l'implémentation, un timer avec un cycle d'une minute suffirait, et ne serait pas trop lourd.
 