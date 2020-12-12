# Exemple n°1 : Scripts de gestion des comptes utilisateurs

>Faire un script de gestion des utilisateurs, qui doit permettre :
>  - de créer des utilisateurs
>  - de modifier des utilisateurs
>  - de supprimer des utilisateurs
>  - de voir tous les utilisateurs
>  - de faire une recherche sur l'existence d'un utilisateur en particulier

#### On va utiliser beaucoup de commande de gestion d'utilisateur, donc voici le lien vers le fichier du cours : https://github.com/kevinniel/resources/blob/master/Cours/linux/utilisateurs_et_groupes.md

#### Il n'y a pas d'exemple mais on comprend rapidement le fonctionnement des commandes.
------

#### Le script est plutôt chargé, par conséquent je vais le mettre en entier afin de montrer une vue d'ensemble puis expliquer partie par partie selon l'utilité des parties.


#### Je vais expliquer dans l'ordre du programme et non dans l'ordre des choses demandées

#### À noter que quand il y a le signe :floppy_disk:, cela veut simplement dire que c'est un résumé de ce que fais la condition /la commande / la ligne. Donc si les explications détaillées sont trop longue, on peut juste lire les parties résumées.

-----

```bash
#!/bin/bash

if [ $# = 0 ]
then
	echo "---GESTION UTILISATEUR---"
	echo './user_gestion.sh add <username>  / Pour ajouter un utilisateur'
	echo './user_gestion.sh modify <username> / Pour modifier un utilisateur'
	echo './user_gestion.sh delete <username> / Pour supprimer un utilisateur'
	echo './user_gestion.sh show / Pour voir tous les utilisateurs'
	echo "./user_gestion.sh <username> / Pour voir l'existence d'un utilisateur"
elif [ $# = 1 ]
then
	if [ $1 = "show" ]
	then
		cut -f1 -d: /etc/passwd
	else
		getent passwd $1 > /dev/null && echo "L'utilisateur existe" || { echo "Cette utilisateur n'existe pas"; }
	fi

elif [ $# = 2 ]
then
	if [ $1 = "add" ]
	then
		sudo useradd $2
	elif [ $1 = "delete" ]
	then
		sudo userdel $2
	elif [ $1 = "modify" ]
	then
		echo "Que voulez vous modifier ?"
		echo "Pour modifier le groupe, tapez : 1"
		echo "Pour modifier le mot de passe, tapez : 2"
		echo "Pour modifier le nom d'utilisateur, tapez : 3"
		read -p "Saisissez le chiffre : " nbrmodify

		if [ $nbrmodify = 1 ]
		then
            echo "---MODIFICATION RELATIVE AU GROUPE---"
			echo "Entrez 'show' pour voir la liste des groupes"
			echo "Entrez 'addto <nom_du_groupe>' pour ajouter l'utilisateur au groupe choisi"
			echo "Entrez 'rmfrom <nom_du_groupe>' pour supprimer l'utilisateur du groupe"
			read -p "Entrez la commande choisi : " commandgrp grpname

			if [ $commandgrp = "show" ]
			then
				cut -f1 -d: /etc/group
			elif [ $commandgrp = "addto" ]
			then
				sudo gpasswd -a $2 $grpname
			elif [ $commandgrp = "rmfrom" ]
			then
				sudo gpasswd -d $2 $grpname
			else
				echo "La commande n'est pas valide..."
			fi
		elif [ $nbrmodify = 2 ]
		then
			sudo passwd $2
		elif [ $nbrmodify = 3 ]
		then
			read -p "Entrez comme ceci 'nouvel_identifiant identifiant_à_changer' : " newid oldid
			sudo usermod --login $newid --home /home/$newid --move-home $oldid
		else
			echo "Le numéro n'est pas valide"
		fi
	else
		echo "La commande n'est pas valide, veuillez réessayer..."
	fi
fi
```

## Fonctionnement global

J'ai décidé que le programme fonctionnerait principalement grâce aux paramètres. C'est-à-dire que pour lancer une commande, il faut faire `user_gestion.sh <command>`.

Le fichier a dailleur été placé dans le dossier ``usr/local/bin`` qui est un dossier ``PATH`` donc permettant d'exécuter des fichier de n'importe où.

Il peut y avoir jusqu'à 3 paramètres :
- le nom du programme (pour lancer le programme)
- la commande
- un nom d'utilisateur


## Première condition : expliquer à l'utilisateur ce qu'il peut faire.

En effet, les toutes premières lignes du code servent à expliquer à l'utilisateur le fonctionnement du script.
```bash
if [ $# = 0 ]   # Si le nombre de paramètre est égale à 0 (donc s'il n'y a que le nom du programme)
then
	echo "---GESTION UTILISATEUR---"
	echo './user_gestion.sh add <username>  / Pour ajouter un utilisateur'
	echo './user_gestion.sh modify <username> / Pour modifier un utilisateur'
	echo './user_gestion.sh delete <username> / Pour supprimer un utilisateur'
	echo './user_gestion.sh show / Pour voir tous les utilisateurs'
	echo "./user_gestion.sh <username> / Pour voir l'existence d'un utilisateur"
[...]
```
La première condition va vérifier s'il y a qu'un seul paramètre. Si c'est le cas, alors on donne les informations sur le fonctionnement du script afin que l'utilisateur puisse savoir qu'elles sont les commandes possibles.

## Deuxième condition : Les commandes ne demandant qu'un seul paramètre

Il n'y a que 2 commandes qui fonctionne avec un seul paramètre :
- la commande `show` qui va permettre de voir tous les utilisateurs
- la commande qui va permettre de regarder l'existence d'un utilisateur (on place pour seul paramètre le nom de l'utilisateur)

```bash
elif [ $# = 1 ] # Si le nombre de paramètre est égale à 1 (donc s'il y a le nom du programme ainsi qu'un paramètre)
then
	if [ $1 = "show" ]           # si le paramètre 1 est "show" alors
	then                         # on affiche le contenu du fichier passwd qui contient tous les utilisateurs
		cut -f1 -d: /etc/passwd  # mais on cut tout ce qui nous intéresse pas
	else 
		getent passwd $1 > /dev/null && echo "L'utilisateur existe" || { echo "Cette utilisateur n'existe pas"; }
	fi
[...]
```

On fait, à l'intérieur de cette condition, une autre vérification (avec d'autres conditions) qui sert à savoir si la commande `show` est bien appelée.

**Si c'est le cas** alors on affiche les noms d'utilisateurs qui sont stocké dans le fichier ``passwd``. 

Pour afficher **seulement le contenu** qui nous intéresse (car dans ``passwd`` il y a un tas d'information sur les utilisateurs, or nous on veut juste le **nom**), on utilise la commande `cut` (voir [ici](./new_command.md) cette nouvelle commande) qui va couper toute la partie qui se trouve après le premier champ (défini par ``-f1``) dont le séparateur ":" à été défini par ``-d:``. 

**:floppy_disk: Pour faire plus simple, `cut -d: -f1` permet de garder la partie avant le premier ":" rencontré (sur une ligne), donc le premier mot qui correspond au nom d'utilisateur.**

**Dans le cas où ce n'est pas "show" qui est le premier paramètre**, alors on va chercher à savoir si ce premier argument est un nom d'utilisateur.

C'est ici qu'on va devoir dire si c'est un nom d'utilisateur ou pas. Pour ce faire il faut commencer par une **vérification** avec la commande ``getent`` (voir [ici](./new_command.md) cette nouvelle commande) qui va chercher dans la **base de donnée** ``passwd`` le nom d'utilisateur qu'on cherche à vérifier `$1` (``$1`` est la variable qui a été créée automatiquement lors du lancement du programme et qui correspond au paramètre n°1).

 **:floppy_disk: Littéralement, la commande va chercher dans la base de donnée ``passwd`` si le nom placé dans la variable ``$1`` fait parti du fichier. La commande est de base censé retourner la ligne correspondant au nom d'utilisateur.**

La partie `> /dev/null` permet justement de ne pas afficher le résultat de la commande.

La partie `&& echo "L'utilisateur existe" || { echo "Cette utilisateur n'existe pas"; }` va être la partie qui correspond à ce qui va sortir. En effet, si la commande à fonctionner alors la partie "`&& echo "L'utilisateur existe"`" va se lancer. À noter que `&&` veut dire ***ET***. 

**:floppy_disk: Donc ici : la commande marche *ET* écrit "L'utilisateur existe"**

Mais si la commande ne marche pas il y a la partie "``|| { echo "Cette utilisateur n'existe pas"; }``" qui sera retourner. À savoir que le `||` correspond au ***OU***.

**:floppy_disk: Donc ici : la commande ne marche pas donc : écrit "Cette utilisateur n'existe pas"**

## Troisième condition : Les commandes demandant deux paramètres

Avant de commencer l'explication la troisième condition, je précise que je vais parler un peu plus rapidement de la grande partie sur "modify" car c'est vraiment une grande partie mais qui reste néanmoins relativement explicite.

### Les commandes ``add`` and ``delete``
```bash
elif [ $# = 2 ]     # S'il y a 2 argument alors :
then
	if [ $1 = "add" ] # Si c'est la commande "add" alors :
	then
		sudo useradd $2 
	elif [ $1 = "delete" ]  # Si c'est la commande "delete" alors :
	then
		sudo userdel $2
[...]
```

Cette fois-ci, c'est la cas où il y a 2 paramètres. À l'intérieur de cette condition on y retrouve d'autres conditions dont les deux ci-dessus.

La **première** va vérifier si la commande demandé est `add`. **Si c'est le cas**, alors en tant que **"super-utilisateur"** (sudo) le script exécutera la commande `useradd` (lien [ici](https://github.com/kevinniel/resources/blob/master/Cours/linux/utilisateurs_et_groupes.md#commandes)) qui sert à **créer un utilisateur** ayant le nom placé en **deuxième paramètre** (dans la variable ``$2``).

**:floppy_disk: La ligne `sudo useradd $2` va créer un utilisateur du nom placé dans la variable ``$2``**.

La **deuxième** va vérifier si la commande demandé est `delete`.**Si c'est le cas**, alors le programme fera la même chose que la condition vu précédemment à la grande différence que la commande `userdel` (lien [ici](https://github.com/kevinniel/resources/blob/master/Cours/linux/utilisateurs_et_groupes.md#commandes)) sert à **supprimer un utilisateur**.

**:floppy_disk: La ligne `sudo userdel $2` va supprimer l'utilisateur du nom placé dans la variable ``$2``**.

### La commande `modify`

Dans la condition vérifiant s'il y a 2 paramètres, il y a une troisième condition qui est celle-ci : 

```bash
elif [ $1 = "modify" ] # Si c'est la commande "modify" alors :
	then
		echo "Que voulez vous modifier ?"
		echo "Pour modifier le groupe, tapez : 1"
		echo "Pour modifier le mot de passe, tapez : 2"
		echo "Pour modifier le nom d'utilisateur, tapez : 3"
		read -p "Saisissez le chiffre : " nbrmodify

		if [ $nbrmodify = 1 ] # Si l'utilisateur à choisi "1"
		then
            echo "---MODIFICATION RELATIVE AU GROUPE---"
			echo "Entrez 'show' pour voir la liste des groupes"
			echo "Entrez 'addto <nom_du_groupe>' pour ajouter l'utilisateur au groupe choisi"
			echo "Entrez 'rmfrom <nom_du_groupe>' pour supprimer l'utilisateur du groupe"
			read -p "Entrez la commande choisi : " commandgrp grpname

			if [ $commandgrp = "show" ]
			then
				cut -f1 -d: /etc/group
			elif [ $commandgrp = "addto" ]
			then
				sudo gpasswd -a $2 $grpname
			elif [ $commandgrp = "rmfrom" ]
			then
				sudo gpasswd -d $2 $grpname
			else
				echo "La commande n'est pas valide..."
			fi
		elif [ $nbrmodify = 2 ] # Si l'utilisateur à choisi "2"
		then
			sudo passwd $2
		elif [ $nbrmodify = 3 ] # Si l'utilisateur à choisi "3"
		then
			read -p "Entrez comme ceci 'nouvel_identifiant identifiant_à_changer' : " newid oldid
			sudo usermod --login $newid --home /home/$newid --move-home $oldid
		else
			echo "Le numéro n'est pas valide"
		fi
[...]
```
Cette condition sera "déclenchée" lors de la demande de l'utilisateur qui aura choisi la commande `modify`.

Cette condition est séparé en 3 parties : 
- Modification relative au **groupe** (ajouter ou supprimer un utilisateur dans un groupe)
- Modification du **nom d'utilisateur**
- Modification du **mot de passe**

Il aurait pu y avoir plus de modification possible comme *le **shell** utilisé par l'utilisateur*, mais par manque de temps j'ai préféré m'arrêter à ces 3 modifications majeures.

 On remarque ces parties avec les 5 permières commandes de la conditions `echo` et `read` :

```bash
[...]
echo "Que voulez vous modifier ?"
echo "Pour modifier le groupe, tapez : 1"
echo "Pour modifier le mot de passe, tapez : 2"
echo "Pour modifier le nom d'utilisateur, tapez : 3"
read -p "Saisissez le chiffre : " nbrmodify
[...]
```
Le choix sera donc mit en avant par de simple numéro.

On récupère le numéro donné par l'utilisateur avec la commande `read`.

### Modification du groupe 

**Si le numéro est 1** voilà ce qui se passe :
```bash
if [ $nbrmodify = 1 ] # Si l'utilisateur à choisi "1"
		then
            echo "---MODIFICATION RELATIVE AU GROUPE---"
			echo "Entrez 'show' pour voir la liste des groupes"
			echo "Entrez 'addto <nom_du_groupe>' pour ajouter l'utilisateur au groupe choisi"
			echo "Entrez 'rmfrom <nom_du_groupe>' pour supprimer l'utilisateur du groupe"
			read -p "Entrez la commande choisi : " commandgrp grpname

			if [ $commandgrp = "show" ]
			then
				cut -f1 -d: /etc/group
			elif [ $commandgrp = "addto" ]
			then
				sudo gpasswd -a $2 $grpname
			elif [ $commandgrp = "rmfrom" ]
			then
				sudo gpasswd -d $2 $grpname
			else
				echo "La commande n'est pas valide..."
			fi
[...]
```
Le **chiffre 1** renvoit ici à la **modification relative aux groupes**

Dans un premier temps on redemande à l'utilisateur ce qu'il veut faire avec d'autres commandes qui lui sont montré :
- Voir les groupes
- ajout d'un utilisateur à un groupe
- enlever un utilisaeur d'un groupe

Et encore un ``read`` pour voir ce qu'il va saisir mais cette fois-ci avec **deux variables au lieu d'une** afin de récupéré le **premier mot** qui sera la *commande* et le **deuxième mot** qui sera le *nom du groupe*.

Une fois ceci fait, on cherche à vérifier quelle est la commande demandé :

```bash
if [ $commandgrp = "show" ] # Si l'utilisateur utilise "show"
then
	cut -f1 -d: /etc/group
elif [ $commandgrp = "addto" ] # Si l'utilisateur utilise "addto"
then
	sudo gpasswd -a $2 $grpname
elif [ $commandgrp = "rmfrom" ] # Si l'utilisateur utilise "rmfrom"
then
	sudo gpasswd -d $2 $grpname
else
	echo "La commande n'est pas valide..."
fi
[...]
```

**Si la commande voulu est `show`** alors on va juste faire un ``cut`` dans le fichier `group` avec les même options vu précédemment.

**Si la commande voulu est `addto`** alors on va utiliser la commande `gpasswd` (lien [ici](https://github.com/kevinniel/resources/blob/master/Cours/linux/utilisateurs_et_groupes.md#commandes)) avec l'options `-a` (correspond à `add`) qui va permettre d'ajouter un utilisateur à un certains groupe.

**:floppy_disk: La commande ``sudo gpasswd -a $2 $grpname`` va ajouter (grâce à l'option ``-a``) un utilisateur dont le nom est placé dans la variable ``$2`` (qui est le nom choisi au tout début) dans le groupe dont le nom est placé dans la variable `grpname`.**

**Si la commande voulu est `rmfrom`** alors on fait la même commande que précédemment en changeant juste l'option `-a` par l'option `-d` (correspond à `delete`) qui va permettre de supprimer un utilisateur d'un groupe (juste le supprimer du groupe).

**:floppy_disk: La commande ``sudo gpasswd -d $2 $grpname`` va supprimer (grâce à l'option ``-d``) un utilisateur dont le nom est placé dans la variable ``$2`` (qui est le nom choisi au tout début) dans le groupe dont le nom est placé dans la variable `grpname`.**

Le dernier ``else`` est juste là au cas où l'utilisateur n'a pas fait une bonne commande.


### Modification du nom d'utilisateur ou du mot de passe

```bash
elif [ $nbrmodify = 2 ]
then
	sudo passwd $2
elif [ $nbrmodify = 3 ]
then
	read -p "Entrez le nouvelle identifiant : " newid oldid
	sudo usermod --login $newid --home /home/$newid --move-home $2
else
	echo "Le numéro n'est pas valide"
fi
```

Le **chiffre 2** renvoit ici à la modification du mot de passe.

La commande ``passwd`` (lien [ici](https://github.com/kevinniel/resources/blob/master/Cours/linux/utilisateurs_et_groupes.md#commandes)) sert à changer le mot de passe d'un utilisateur.

**:floppy_disk: Avec la commande `sudo passwd $2`, on change le *mot de passe* de l'utilisateur dont le nom est placé dans la variable `$2`** 


Le **chiffre 3** renvoit ici à la modification du nom d'utilisateur.

On demande d'abord à l'utilisateur (grâce à `read`) le nouveau nom d'utilisateur (placé dans la variable `newid`).

Ensuite on utilise la commande ``usermod`` (voir [ici](./new_command.md) cette nouvelle commande ) qui va permettre, grâce aux options choisi, de **changer le nom** (avec ``--login``) ainsi que l'emplacement du **dossier utilisateur** (avec ``--home``). L'option `--move-home` sert à dire qu'elle était l'ancien nom d'utilisateur.

**:floppy_disk: Avec la commande `sudo usermod --login $newid --home /home/$newid --move-home $oldid`, on change le *nom d'utilisateur* ainsi que l'emplacement du *dossier utilisateur* (dont le nom est placé dans la variable `$2`) par un nouveaux noms (qui est placé dans la variable $newid)**

Le `else` sert dans le cas où l'utilisateur a saisie une mauvaise commande.

### Pour finir...

```bash
else
	echo "La commande n'est pas valide, veuillez réessayer..."
fi
```

Le dernier `else` sert dans le cas où l'utilisateur a saisie une mauvaise commande.

Le script pourrait être plus complet mais, comme dit précédemment, on a un temps limité. J'ai donc choisi de faire les commandes les plus importantes.