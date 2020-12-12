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

#### Exemples

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

![GIF](./Ressources/GIF/readt.gif)

![GIF](./Ressources/GIF/reads.gif)


## La commande `let`

Cette commande permet de faire des **opérations mathématiques** avec des variables.

En effet, les variables n'ont pas de type et sont **toutes** en réalité des **chaines de caractères**.

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
- `-c` : permet de choisir une colonne ou une plage de colonne
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
Si l'on veut récupérer que la première colonne (c'est-à-dire le permier caractère de chaque ligne) on fait :

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
On peut aussi faire des champs par exemple `-c1-5` (qui aurait afficher que les 5 premiers caractère de chaque ligne) ou alors `-c1-5,8-10`(qui aurait afficher que les 5 premiers caractère de chaque ligne ainsi que les caractère de 8 à 10 de chaque ligne)

Maintenant on va tester l'utilisation du `-d` et du `-f` :

Toujours avec le même fichier ``test.txt`` On fait :

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

Le séparateur est ici ":" définit avec ``-d`` et on prend le 2ème champs (donc ce qui sera après les ":" ) avec `-f2`.


## La commande `getent`

> La  commande  ``getent``  affiche  les  entrées  des bases de données prises en charge par les bibliothèques du Name Service Switch (NSS). [Manpages Ubuntu](http://manpages.ubuntu.com/manpages/trusty/fr/man1/getent.1.html)

Le but de cette commande est de récupéré une ou plusieurs informations sur quelque chose en particulier. On ne va pas détailler beaucoup cette commande car elle est très complète, elle fonctionne sous forme de base de donnée c'est-à-dire que la commande fera des choses différentes selon ce que vous cherchez.

Elle se note : `getent <base_de_donnée> <clé>`

Le seul exemple que je peux donnée c'est celui-ci :

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

En effet, elle permet de faire beaucoup de chose donc je vous conseille de taper la commande ``man usermod`` dans votre terminal pour en savoir plus sur le fonctionnement.

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
