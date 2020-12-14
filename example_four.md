# Exemple n°4 : Créer un annuaire téléphonique (lien du [script](./Ressources/Scripts/phonebook/phone_book.sh))

>Le script devra permettre la gestion d'un annuaire téléphonique. Il devra inclure les fonctionnalités suivantes :
> - ajouter un contact (nom + tel + mail)
> - modifier un contact
> - voir la liste de tous les contacts (triés par ordrealphabétiques grâce à leurs noms et n'afficher que leurs noms)
> - voir le détail d'un contact grâce à son nom
> - retrouver le nom d'un contact grâce à son adresse mail
> - retrouver le nom d'un contact grâce à son téléphone
> - supprimer un contact
>
>L'ensemble des informations devront être enregistrées dans un fichier texte

#### Par manque de temps, cette exercice sera expliqué très brièvement (le script sera commenté et séparé en fonction de ce qu'il fait).
#### À noter aussi que le script aurait pu être plus propre au  niveau de la structure (utilisation de fonctions auraient pu être intéressant)

----

## Le script en entier

Dans un premier temps, voici le script en entier :

```bash
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

```

## Première partie : Explication du fonctionnement pour l'utilisateur.

```bash
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
[...]
```
Ici on retrouve l'explication du fonctionnement de chaque commande afin que l'utilisateur choisisse ce qu'il veut faire.

## Deuxième partie : S'il y a 1 paramètre.

```bash
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
[...]
```
Il y a 2 commandes ne demandant qu'un seul paramètre.

### La commande `phone_book.sh add`

```bash
    if [ $1 = "add" ]
	then
		echo "----CREATION D'UN NOUVEAU CONTACT----"
		read -p " Voulez-vous commencer la création ?(oui/non)" continue
		if [ $continue = "oui" ]
		then
			read -p "Entrez le nom et prénom du contact :" name # Mettre le nom dans la var "name"
			read -p "Entrez l'adresse mail du contact :" email # Mettre le mail dans la var "email"
			read -p "Entrez le numéro de téléphone :" phonenbr # Mettre le numéro de téléphone dans la var "phonenbr"
			echo "$name:$email:$phonenbr" >> annuaire.txt
		else
			echo "Annulation de la création..."
		fi
    [...]
```
Ici, on va demander, dans un premier temps, **si la personne veut vraiment créer un contact** avec la commande `read -p " Voulez-vous commencer la création ?(oui/non)" continue` (ce sera pour éviter les mauvaises manipulations). On aurait d'ailleur pu le mettre à la fin afin de savoir s'il voulait vraiment confirmer les saisies précédentes.

Il y aura donc une vérification de **si la variable `continue` est égale à "oui"**.

Si c'est le cas, alors on va lire, avec la commande `read` (voir [ici](./new_command.md#la-commande-read)) les différentes informations (qui seront placé dans les variables `name` `email` `phonenbr`).

Puis grâce à la commande `echo "$name:$email:$phonenbr" >> annuaire.txt` on écrit la ligne correspondant au nouveau contact dans le document `annuaire.txt` sous la forme `nom:email:numéro`.

### La commande `phone_book.sh show`

```bash
    elif [ $1 = "show" ]
	then
		cut -d: -f1 annuaire.txt | sort -d 
	else
		echo "Mauvaise commande..."
	fi
[...]
```
Ici, on va simplement faire la même chose que lors de l'[exemple n°1](./example_one.md), c'est-à-dire la commande `cut -d: -f1 annuaire.txt` (voir [ici](./new_command.md#la-commande-cut)) qui va garder que le premier champs avant le séparateur ":".

La commande `sort -d` (voir [ici](./new_command.md#la-commande-sort)) va servir à remettre dans l'ordre alphabétique (= ordre du dictionnaire d'où le ``-d``).

**:floppy_disk: La ligne va dans un premier temps récuperer tous les premiers champs se trouvant avant le séparateur ":", *puis* va les remettres dans l'ordre alphabétique.**

## Troisième partie : S'il y a 2 paramètres.

```bash
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
[...]
```

Il y a 3 commandes qui se servent de 2 paramètres.

### La commande `phone_book.sh modify <contact_name>`

```bash
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
[...]
```

