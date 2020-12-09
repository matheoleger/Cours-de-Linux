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