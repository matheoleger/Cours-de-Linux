# Les boucles

#### Il est préférable d'avoir vu  le [premier script](./premier_script.md) avant de commencer, car il permet de poser les bases sur l'exécution et l'écriture d'un script.

----

Il existe de types de boucle en bash (comme dailleur dans certains langages de programmation) :
- Les boucles `while`
- Les boucles `for`

## Les boucles `while`

"While" signifie "tant que" (en tout cas dans le domaine de l'informatique).

Par conséquent, c'est une boucle qui va attendre que la condition soit vraie (ou fausse selon ce que l'on veut).

Sous forme algorithmique :

```bash
TANT QUE test
FAIRE   
    chose_à_faire
FIN TANT QUE
```
Sous forme de `bash` :

```bash
while [ test ]
do
    chose_à_faire
done
```

**Exemple :**

Voici un programme qui sort "Hello World!" tant que vous n'avez pas saisie "stop" :

```bash

while [ -z $choice ] || [ $choice != "stop" ] 
do
    echo "Hello World!"
    read -p "Si vous voulez arrêter le programme dites 'stop' : " choice
done
```
:warning: Il faut avoir la condition `[ -z $choice ] ||`, car elle permet de lancer la boucle avec une valeur vide de `choice`. Sinon le programme mettra une erreur lors de son lancement.

En sortie :

```html
$ ./boucle.sh
Hello World!
Si vous voulez arrêter le programme dites 'stop' : non
Hello World!
Si vous voulez arrêter le programme dites 'stop' : ...
Hello World!
Si vous voulez arrêter le programme dites 'stop' : stop
$
```

## La boucle `for`

En `bash`, la boucle `for` fonctionne différemment des boucles `for` des autres langages.

Ici, la boucle `for` permet de parcourir une liste de valeurs. C'est-à-dire qu'elle continue tant qu'elle n'aura pas fait le tour de toutes les valeurs d'une variable.

Sous forme algorithmique :

```bash
POUR variable PRENANT val1 val2 val3
FAIRE   
    chose_à_faire
FIN POUR
```
Sous forme de `bash` :

```bash
for variable in 'val1' 'val2' 'val3'
do
    chose_à_faire
done
```

Exemple :

```bash
#!/bin/bash

for matos_de_video in 'micro' 'camera' 'stabilisateur' 'trépied'
do
    echo "Pour la vidéo il faut : $matos_de_video"
done
```
En sortie :

```bash
$ ./boucle.sh
Pour la vidéo il faut : micro
Pour la vidéo il faut : camera
Pour la vidéo il faut : stabilisateur
Pour la vidéo il faut : trépied
$
```
On peut aussi affecter directement une variable qui contient plusieurs valeur à la place d'une suite de valeur. Cette variable peut par exemple être une commande qui retourne plusieurs valeurs.


