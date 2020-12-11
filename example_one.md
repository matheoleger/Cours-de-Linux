# Exemple n°1 : Scripts de gestion des comptes utilisateurs

>Faire un script de gestion des utilisateurs, qui doit permettre :
>  - de créer des utilisateurs
>  - de modifier des utilisateurs
>  - de supprimer des utilisateurs
>  - de voir tous les utilisateurs
>  - de faire une recherche sur l'existence d'un utilisateur en particulier

------

#### Le script est plutôt chargé, par conséquent je vais le mettre en entier afin de montrer une vue d'ensemble puis expliquer partie par partie selon l'utilité des parties.


#### Je vais expliquer dans l'ordre du programme et non dans l'ordre des choses demandées

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
```

On fait, à l'intérieur de cette condition, une autre vérification (avec d'autres conditions) qui sert à savoir si la commande `show` est bien appelée.

**Si c'est le cas** alors on affiche les noms d'utilisateurs qui sont stocké dans le fichier ``passwd``. 

Pour afficher **seulement le contenu** qui nous intéresse (car dans ``passwd`` il y a un tas d'information sur les utilisateurs, or nous on veut juste le **nom**), on utilise la commande `cut` (voir [ici](./new_command.md)) qui va couper toute la partie qui se trouve après le premier champ (défini par ``-f1``) dont le séparateur ":" à été défini par ``-d:``. 

#### :floppy_disk: Pour faire plus simple, `cut -d: -f1` permet de garder la partie avant le premier ":" rencontré (sur une ligne), donc le premier mot qui correspond au nom d'utilisateur.

**Dans le cas où ce n'est pas "show" qui est le premier paramètre**, alors on va chercher à savoir si ce premier argument est un nom d'utilisateur.

C'est ici qu'on va devoir dire si c'est un nom d'utilisateur ou pas. Pour ce faire il faut commencer par une **vérification** avec la commande ``getent`` (voir [ici](./new_command.md)) qui va chercher dans la **base de donnée** ``passwd`` le nom d'utilisateur qu'on cherche à vérifier `$1` (``$1`` est la variable qui a été créée automatiquement lors du lancement du programme et qui correspond au paramètre n°1).

#### :floppy_disk: Littéralement, la commande va chercher dans la base de donnée ``passwd`` si le nom placé dans la variable ``$1`` fait parti du fichier. La commande est de base censé retourner la ligne correspondant au nom d'utilisateur.

La partie `> /dev/null` permet justement de ne pas afficher le résultat de la commande.

La partie `&& echo "L'utilisateur existe" || { echo "Cette utilisateur n'existe pas"; }` va être la partie qui correspond à ce qui va sortir. En effet, si la commande à fonctionner alors la partie "`&& echo "L'utilisateur existe"`" va se lancer. À noter que `&&` veut dire ***ET***. 

#### :floppy_disk: Donc ici : **la commande marche** *ET* **écrit "L'utilisateur existe"**

Mais si la commande ne marche pas il y a la partie "``|| { echo "Cette utilisateur n'existe pas"; }``" qui sera retourner. À savoir que le `||` correspond au ***OU***.

#### :floppy_disk: Donc ici : **la commande ne marche pas** donc **écrit "L'utilisateur existe"**




