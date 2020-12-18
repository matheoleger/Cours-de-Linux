# Les commandes principales du Shell

###### Ayant déjà vu dans le cours les **commandes**, j'y mettrais les nouvelles commandes que nous n'avons pas vue précedemment.

##### Liens vers le fichier des commandes vues dans le cours : https://github.com/kevinniel/resources/blob/master/Cours/linux/commandes_generiques.md

-----

### La commande ``echo``

`echo` est une commande qui va permettre d'afficher ce que l'on veut.

Elle s'écrit comme ceci `echo "ce que l'on veut écrire"`

On peut avoir une certaine documentation de `echo` en tapant la commande `echo man` dans la console.

On trouve certains paramètres :
 - ``echo -e ""`` : Permet d'interpréter certaines séquences de caractères précédées d'un backslash '\\')
 - ``echo -n ""`` : Permet de ne pas effectuer le saut de ligne final.

#### Exemple :

```bash
$ echo "Je m'appelle Mathéo"
Je m'appelle Mathéo
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
Après avoir tapé le mot de passe (le mot de passe reste invisible) il y a une ligne différente qui apparaît (la ligne finissant par ``#``).

----

## La commande `read`

Cette commande va permettre la demande de saisie de quelque chose, à l'utilisateur.

On doit donc placer la valeur lue dans une variable (qu'on pourra manipuler plus tard).

Elle s'écrit comme ceci `read nomdelavar`. Une fois cette commande entrée, on aura l'occasion de rentrée ce que l'on a besoin dans la variable directement à partir de la console.

Il y a différentes options disponible :
- ``read -p`` : Permet de mettre un message avant la saisie de l'utilisateur.
- ``read -n`` : Permet de limiter le nombre de caractères que peut saisir l'utilisateur.
- ``read -t`` : Permet de limiter le temps que peut mettre l'utilisateur à faire la saisie.
- ``read -s`` : Permet de cacher la saisie de l'utilisateur.

#### Exemples

Dans un fichier script nommé ``prenom.sh`` :

```bash
#!/bin/bash

read ecole

echo "Vous travaillez à $ecole"
```

En sortie :

```bash
$ ./ecole.sh
Ynov #ici c'est la ligne où j'ai entrée le nom de l'école
Vous travaillez à Ynov.
$
```
Voici les GIFs résument le fonctionnement des options de `read` :
![GIF](./Ressources/GIF/readp.gif)

![GIF](./Ressources/GIF/readn.gif)

![GIF](./Ressources/GIF/readt.gif)

![GIF](./Ressources/GIF/reads.gif)


## La commande `let`

Cette commande permet de faire des **opérations mathématiques** avec des variables.

En effet, les variables n'ont pas de type et sont **toutes** en réalité des **chaînes de caractères**.

Elle **ne** permet **pas** de faire des opérations avec **des nombres décimaux**.

Voici les opérations possibles :

- les additions "+"

- les soustractions "-" 

- les multiplications "*" 

- les divisions "/" 

- les puissances "**" 

- les modulos "%"

Elle se note comme ça : 
```bash
let "var_trois = nbr opération nbr"
```

On peut aussi faire comme ceci si on veut plusieurs variables :

```bash
let "var_un = nbr"

let "var_deux = nbr"

let "var_trois = var_un opération var_deux"
```
Ou alors

```bash
var_un = nbr

var_deux = nbr

let "var_trois = $var_un opération $var_deux"
```

#### Exemples

**1er exemple**

Dans le script

```bash
let "premier = 5"

let "deuxieme = 5"

let "multiplication = premier * deuxieme"     #pas besoin de $ (sauf si on utilise pas `let` pour les 2 premières variables)

echo $multiplication
```
En sortie

```bash
$./ope.sh
25
$
```
**2ème exemple**

Dans le script

```bash
let "var = 5 * 5"
```
En sortie

```bash
$./ope.sh
25
$
```

On peut aussi se servir d'une commande qui a l'aire moins répandue : ``expr``

Cette commande fonctionne presque pareil, mais la différence est qu'elle sert surtout pour faire les calculs directement.

Voir [cette page](https://www.quennec.fr/trucs-astuces/syst%C3%A8mes/gnulinux/programmation-shell-sous-gnulinux/les-bases-de-la-programmation-shell/larithm%C3%A9tique/la-commande-expr) pour plus d'information

## La commande `env`

Cette commande permet de voir qu'elles sont les [variables d'environnement](./form_shell.md#les-variables-denvironnement).

On doit tout simplement écrire `env` dans le terminal.

### Exemple

```bash
$ env
SHELL=/bin/bash
NAME=MSI
PWD=/mnt/c/Windows/system32
LOGNAME=smoowy
HOME=/home/smoowy
LANG=C.UTF-8
...
$
```

## La commande `pwd`

La commande `pwd` sert à savoir où l'on se trouve dans les répertoires.

On doit tout simplement écrire `pwd` dans le terminal.

### Exemple

```bash
$ pwd
/home/username/Documents
$
```

## La commande `export`

On se sert de cette commande pour créer nos propres [variables d'environnement](./form_shell.md#les-variables-denvironnement).

Il suffit juste de faire comme ceci :

```bash
$ VAR=value
$ export VAR
```
ou

```bash
$ export VAR=value
```

## La commande `cut`

La commande ``cut`` permet d'afficher des zones spécifiques d'un fichier en coupant les parties inintéressantes. 

Elle se forme comme ceci : `cut -<option> <chemin_du_fichier>`

Il y a plein de petite options mais les 3 principales sont :
- `-d` : permet de choisir un séparateur de champs
- `-c` : permet de choisir une colonne ou plusieurs colonnes
- `-f` : permet de choisir le nombre de champs qui seront récupéré, il est utilisé avec `-d` qui va déterminer la fin d'un champs.

Voici des exemples pour mieux comprendre :

On a un fichier `test.txt` qui contient :

```html
ligne 1 : c'est
ligne 2 : un
ligne 3 : test
ligne 4 : de
ligne 5 : la
ligne 6 : commande
ligne 7 : nommé
ligne 8 : cut
ligne 9 : vraiment
ligne 10 : pratique
```
Si l'on veut récupérer que la première colonne (c'est-à-dire le premier caractère de chaque ligne) on fait :

```bash
cut -c1 test.txt
```
Ce qui va donner :

```bash
l
l
l
l
l
l
l
l
l
l
l
```
On peut aussi récupérer plusieurs colonnes :

```bash
cut -c8- test.txt
```
Ce qui va donner :

```html
c'est
un
test
de
la
commande
nommé
cut
vraiment
 pratique
```
On peut aussi faire des champs par exemple `-c1-5` (qui aurait afficher que les 5 premiers caractères de chaque ligne) ou alors `-c1-5,8-10`(qui aurait afficher que les 5 premiers caractère de chaque ligne ainsi que les caractères de 8 à 10 de chaque ligne)

Maintenant on va tester l'utilisation du `-d` et du `-f` :

Toujours avec le même fichier ``test.txt`` on fait :

```bash
cut -d: -f2 test.txt
```
Ce qui va donner :

```html
 c'est
 un
 test
 de
 la
 commande
 nommé
 cut
 vraiment
 pratique
```

Le séparateur est ici ":" défini avec ``-d`` et on prend le 2ème champ (donc ce qui sera après les ":" ) avec `-f2`.


## La commande `getent`

> La  commande  ``getent``  affiche  les  entrées  des bases de données prises en charge par les bibliothèques du Name Service Switch (NSS). [Manpages Ubuntu](http://manpages.ubuntu.com/manpages/trusty/fr/man1/getent.1.html)

Le but de cette commande est de récupérer une ou plusieurs informations sur quelque chose en particulier. On ne va pas détailler beaucoup cette commande, car elle est très complète, elle fonctionne sous forme de base de donnée, c'est-à-dire que la commande fera des choses différentes selon ce que vous cherchez.

Elle se note : `getent <base_de_donnée> <clé>`

Le seul exemple que je peux donner, c'est celui-ci :

```bash
getent passwd username
```
En sortie :

```html
username:x:1000:1000::/home/username/:bin/sh
```
Elle ressort la ligne du fichier ``passwd`` qui est relative à la "clé" donnée qui est le nom d'utilisateur ``username``.

## La commande `usermod`

Cette commande est vraiment pratique pour la gestion d'utilisateur.

En effet, elle permet de faire beaucoup de choses donc je vous conseille de taper la commande ``man usermod`` dans votre terminal pour en savoir plus sur le fonctionnement.

Ce qu'on peut retenir principalement :
- modification du **nom d'utilisateur**
- modification du **dossier utilisateur**
- modification du **shell utilisé**
- modification du **mot de passe**
- modification du **groupe**
- ...

Il y a beaucoup de chose possible...

Voici un exemple qui permet de changer le **nom d'utilisateur** ainsi que le **dossier utilisateur** :

```bash
sudo usermod --login new_user_name --home /home/new_user_name --move-home old_user_name
```

le nom d'utilisateur `old_user_name` est modifié ainsi que le dossier utilisateur pour être remplacé par `new_user_name`.

## La commande `sort`

Cette commande permet de trier un fichier.

En effet, on peut se servir de `sort` pour faire plusieurs tris.

Voici un tableau qui récapitule les tris possibles (pour plus d'information, utiliser la commande `man sort`) :

La commande s'écrit : `sort -option`

|Options| Significations |
|-------|----------------|
| b 	|Saute les colonnes constituées de blancs.
| d 	|Trie de type dictionnaire.
| n 	|Trie par ordre numérique.
| f 	|Aucune différentiation n'est faite entre minuscules et majuscules.
| b 	|Ignore les espaces placés en début de champ.
| r 	|Trie inverse.
| M 	|Trie chronologiquement les mois.
|t: 	|Trie suivants les champs séparés par les caractères deux points (`` :'').

## La commande `sed`

Cette commande est très complète et permet un tas de choses pour l'édition de ligne sur un fichier.

Ici, on verra que les choses que j'ai jugées utile.

Premièrement, cette commande s'écrit globalement comme ceci : `sed -param "referent_au_doc" nom_doc`

`-param` sera le paramètre qui changera l'action que l'on veut faire.

`referent_au_doc` va être modifié selon ce que l'on veut faire du texte, mais globalement, il sert à faire référence à la ligne qu'on veut modifier/filtrer/etc... Il peut y avoir des "commandes" dans cette ligne qui permettront aussi de choisir ce que l'on fait de cette valeur (l'écrire ? le numéro de la ligne ? etc...)

`nom_doc` est tout simplement le chemin du doc (ou juste son nom si les 2 fichiers sont dans le même dossier).

:bulb: À savoir que si l'on veut pouvoir **impacter directement le fichier** (c'est-à-dire que les **modifications** que l'on fait soit **appliquer** au document) on doit se servir du paramètre `-i`

On peut faire un tas de choses avec cette commande et j'ai donc choisi de juste montrer la base, c'est-à-dire :
- **Filtrer des lignes**
- **Supprimer des lignes**
- **Modifier des lignes**
- **Faire plusieurs commandes**

Voir [cette page](https://buzut.net/apprendre-commande-sed-linux/) pour plus d'exemple et d'explication sur ce qui est possible de faire avec `sed`.

### Filtrer des lignes

On peut, avec `sed`, **filtrer** pour **avoir une ligne** ou qu'un **groupe de ligne** particulière.

Pour ce faire, on utilise la commande `sed -n`. Le paramètre `-n` permet de filtrer les lignes. On peut donc choisir de les écrire avec la commande `/p` ou récupérer le numéro de la ligne avec `/=` (nous verrons un peu plus tard à quoi cela correspond)

#### Choisir une ligne avec le numéro de la ligne

Si on veut **écrire une ligne**, on peut choisir le **numéro de la ou des ligne(s)** avec la commande : `sed -n nump` (le `p` est la commande permettant l'écriture)

Le `p` (après `num`) est très important, car il va permettre l'écriture de la ligne, en effet si on ne met pas de `p` alors il y aura une erreur. (on aurait pu écrire `-n num=`, mais le ``=`` aurait retourné le numéro de la ligne donc, dans ce cas, inutile)

On peut aussi choisir des intervalles de lignes : (exemple : toutes les lignes de 1 à 4) ``sed -n 1,4p nom_doc``  

Ou même plusieurs lignes choisies : (exemple : la ligne 1 et la ligne 4) ``sed -n "1p;4p" nom_doc``  

**Exemple :**

On a un document texte :

```html
la ligne 1
la ligne 2
la ligne 3
la ligne 4
la ligne 5
```
Si on fait la commande permettant d'écrire la ligne 2 :

```bash
$ sed -n 2p text.txt
la ligne 2
$
```
Et maintenant si l'on veut écrire de la ligne 2 à la ligne 5 :

```bash
$ sed -n 2,5p text.txt
la ligne 2
la ligne 3
la ligne 4
la ligne 5
$
```
#### Choisir une ligne avec un groupe de caractère

On peut aussi **choisir une ligne** en fonction d'**un groupe de caractère ou de spécificité** qu'elles ont :

On fait la commande : `sed -n "/caractere/<p ou =>" nom_doc`

Comme précédemment, il faut spécifier, après le `/` soit `p` pour écrire, soit `=` pour avoir la valeur de la ligne.

On peut aussi faire un ensemble de caractère en utilisant ";"
(exemple : ``sed -n "/caractere1/p;/caractere2/p" nom_doc``)

**Exemple :**

On a un document texte :

```html
la ligne : 1
la ligne : 2
la ligne : 3
la ligne : 4
la ligne : 5
```

Si on fait la commande permettant d'écrire les lignes ayant le signe `:` :

```bash
$ sed -n "/:/p" text.txt
la ligne : 1
la ligne : 2
la ligne : 3
la ligne : 4
la ligne : 5
$
```

Maintenant on veut seulement une ligne ayant le caractère 4 :

```bash
$ sed -n "/4/p" text.txt
la ligne : 4
$
```
### Supprimer une ligne

Cette fois-ci, on ne va plus filtrer pour récupérer des lignes en particulière, mais **supprimer une ligne** (ou un groupe de ligne) pour **récupérer l'ensemble du document sans cette ligne** (ou sans le groupe de ligne).

La commande ce fait comme la précédente, c'est-à-dire qu'il y a le choix, soit de **supprimer** une ou plusieurs ligne(s) grâce à leur **numéro de ligne**, soit une ou plusieurs ligne(s) ayant un **caractère particulier**.

#### Supprimer grâce au numéro de ligne

La commande est la suivante : `sed "numd" nom_doc`

Le `d` (après `num`) est important, car c'est lui qui spécifie le fait qu'on veut supprimer une ligne.

On peut aussi faire un intervalle de ligne : (exemple : supprimer la ligne 1 à la ligne 4) `sed "1d,4d" nom_doc`

Ou encore supprimer plusieurs lignes spécifiques en fonction de leur numéro : (exemple : supprimer la ligne 1 et la ligne 4) `sed "1d;4d" nom_doc`

**Exemple :**

On a un fichier texte :

```html
la ligne : 1
la ligne : 2
la ligne : 3
la ligne : 4
la ligne : 5
```

Si on fait la commande pour supprimer la ligne 2 :

```bash
$ sed "1d" text.txt
la ligne : 1
la ligne : 3
la ligne : 4
la ligne : 5
$
```
### Supprimer grâce à un caractère spécifique

Afin de supprimer grâce à un caractère spécifique, on utilise la commande : ``sed "/caractere/d" nom_doc``

Comme précédemment le `d` est important.

On peut aussi faire un ensemble de caractère en utilisant ";"
(exemple : ``sed "/caractere1/d;/caractere2/d" nom_doc``)

**Exemple :**

On a un fichier texte :

```html
la ligne : 1 /
la ligne : 2 *
la ligne : 3 +
la ligne : 4 -
la ligne : 5 %
```
On veut supprimer les lignes avec un "/" (on devra utiliser le backslash "\\" pour spécifier que c'est un caractère normal) et un "%" :

```bash
$ sed "/\//d;/%/d" text.txt
la ligne : 2 *
la ligne : 3 +
la ligne : 4 -
$
```

### Modifier une ligne

#### Substitution

Ici, on cherche à changer le texte d'une ligne.

C'est très simple, il suffit de se servir de la commande ``s/`` comme ceci : ``sed  "s/ancien_texte/nouveau_texte/" nom_doc``

**Exemple :** 

Le texte :

```html
Bonjour
c'est
moi
```
Modification de "moi" en "nous" :

```bash
$ sed "s/moi/nous/" text.txt
Bonjour
c'est
nous
$
```

### Faire plusieurs commandes

En effet, on peut faire plusieurs commandes en même temps.

Tout dépendra de ce que l'on veut faire, vous pouvez trouver des exemples dans le [quatrième exemple](./example_four.md).

Il faut se servir des accolades ``{}`` comme ceci : `sed "première_commande {les_autres_commandes}" nom_doc`.