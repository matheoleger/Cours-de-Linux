#!/bin/bash

if [ $# = 0 ]
then
	echo "----ANNUAIRE TELEPHONIQUE----"
	echo "phone_book.sh add : Ajouter un contact"
	echo "phone_book.sh modify <'contact_name'> : Modifier un contact (mettre le nom entre guillement)"
	echo "phone_book.sh del <'contact_name'> : Supprimer un contact (mettre entre guillemet)"
	echo "phone_book.sh show : Voir la liste de tous les contacts"
	echo "phone_book.sh info <'contact_name'> : Voir les informations d'un contact (mettre entre guillemet)"
	echo "phone_book.sh find <e-mail> : Retrouver le nom d'un contact"
	echo "phone_book.sh find <phone_number> : Retrouver le nom d'un contact"

elif [ $# = 1 ]
then
	if [ $1 = "add" ]
	then
		echo "----CREATION D'UN NOUVEAU CONTACT----"
		read -p " Voulez-vous commencer la création ?(oui/non)" continue
		if [ $continue = "oui" ]
		then
			read -p "Entrez le nom et prénom du contact :" name
			read -p "Entrez l'adresse mail du contact :" email
			read -p "Entrez le numéro de téléphone :" phonenbr
			echo "$name:$email:$phonenbr" >> annuaire.txt
		else
			echo "Annulation de la création..."
		fi
	elif [ $1 = "show" ]
	then
		cut -d: -f1 annuaire.txt | sort -d 
	else
		echo "Mauvaise commande..."
	fi
elif [ $# = 2 ]
then
	if [ $1 = modify ]
	then
	echo "Modifier le nom / l'e-mail / le numéro ?"
	read -p " Entrez 'nom', 'email' ou 'num' : " vartomodif

		if [ $vartomodif = nom ]
		then
			read -p "Nouveau nom : " changename
			sed -i -e "/$2/ {s/$2/$changename/}" annuaire.txt
		elif [ $vartomodif = email ]
		then
			read -p "Nouvelle email : " changemail
			oldmail=$(sed -n "/$2/p" annuaire.txt | cut -d: -f2)
			sed -i -e "/$2/ {s/$oldmail/$changemail/}" annuaire.txt
		elif [ $vartomodif = num ]
		then
			read -p "Nouveau numéro : " changenum
			oldnum=$(sed -n "/$2/p" annuaire.txt | cut -d: -f3)
			sed -i -e "/$2/ {s/$oldnum/$changenum/}" annuaire.txt 
		fi
	elif [ $1 = del ]
	then
		sed -i "/$2/d" annuaire.txt
	elif [ $1 = info ]
	then
		name=$(sed -n "/$2/p" annuaire.txt | cut -d: -f1)
		mail=$(sed -n "/$2/p" annuaire.txt | cut -d: -f2)
		num=$(sed -n "/$2/p" annuaire.txt | cut -d: -f3)
		echo -e "NOM : $name \nE-MAIL : $mail \nTEL : $num"
	elif [ $1 = find ]
	then
		sed -n "/$2/p" annuaire.txt | cut -d: -f1
	else
		echo "Mauvaise commande..."
	fi
else
	echo "Mauvaise commande..."
fi
