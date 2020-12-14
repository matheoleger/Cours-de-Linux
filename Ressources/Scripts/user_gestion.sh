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


