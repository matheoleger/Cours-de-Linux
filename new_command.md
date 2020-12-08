# Les commandes principales du Shell

###### Ayant déjà vu dans le cours les **commandes**, j'y mettrais les nouvelles commandes que nous n'avons pas vue précedemment.

##### Liens vers le fichier des commandes vues dans le cours : https://github.com/kevinniel/resources/blob/master/Cours/linux/commandes_generiques.md

-----

### La commande ``echo``

`echo` est une commande qui va permettre d'afficher ce que l'on veut.

Elle s'écrit comme ceci `echo "ce que l'on veut écrire"`

On peut avoir une certaine documentation de `echo` en tapant la commande `echo man` dans la console.

On trouve certains paramètres :
 - ``echo -e ""`` : permet d'interpréter certaines séquences de caractères  précédées d'un backslash '\\')
 - ``echo -n ""`` : Permet de ne pas effectuer le saut de ligne final.

#### Exemple :

```bash
$ echo "Bonjour tout le monde"
Bonjour tout le monde
$
```
-----

### La commande ``su root``

Même si la commande `su` a déjà été vu dans le cours, il est important de savoir que grâce à cette commande, on peut passer en **mode root** (c'est-à-dire un utilisateur ayant tous les droits).

`su root` permet de passer dans le mode "administrateur".

voici ce qu'il se passe : 

```bash
$ su root
Password:
root@nameuser:/#
```
Après avoir taper le mot de passe (le mot de passe reste invisible) il y a une ligne différente qui apparait (la ligne finissant par ``#``).

----

## La commande `read`

Cette commande va permettre la demande de saisie de quelque chose, à l'utilisateur.

On doit donc placer la valeur lu dans une variable (qu'on pourra manipuler plus tard).

Elle s'écrit comme ceci `read nomdelavar`. Une fois cette commande entrée, on aura l'occasion de rentrée ce que l'on a besoin dans la variable directement à partir de la console.

Il y a différentes options disponible :
- ``read -p`` : Permet de mettre un message avant la saisie de l'utilisateur.
- ``read -n`` : Permet de limiter le nombre de caractère que peut saisir l'utilisateur.
- ``read -t`` : Permet de limiter le temps que peut mettre l'utilisateur à faire la saisie.
- ``read -s`` : Permet de cacher la saisie de l'utilisateur.

#### Exemple

Dans un fichier script nommé ``prenom.sh`` :

```bash
#!/bin/bash

read prenom

echo "Vous vous nommez $prenom"
```

En sortie :

```bash
$ ./prenom.sh
Mathéo #ici c'est la ligne où j'ai entrée mon prénom
Vous vous nommez Mathéo
$
```
Voici les GIFs résument le fonctionnement des options de `read` :
![GIF](./Ressources/GIF/readp.gif)

![GIF](./Ressources/GIF/readn.gif)

##### À noter qu'ici, mon GIF montre une version "erronée", car il y a un retour à la ligne lors du `echo` alors que je n'ai pas ajouté le ``\n``. En effet, de base le `read -n` va directement arrêter de lire si la saisie atteint le nombre de caractère demandé par conséquent, il se met directement après comme ceci : `PIN code : 1234Your PIN code is 1234`. 