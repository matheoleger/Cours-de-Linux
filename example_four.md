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
			sed -i "s/$2/$changename/" annuaire.txt
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
			sed -i "s/$2/$changename/" annuaire.txt
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
			sed -i "s/$2/$changename/" annuaire.txt
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
La partie `modify` est séparé en 3 parties :
- modification du nom
- modification de l'email
- modification du numéro

On demande en premier lieu ce que voudrait faire l'utilisateur :

```bash
if [ $1 = modify ]
	then
	echo "Modifier le nom / l'e-mail / le numéro ?"
	read -p " Entrez 'nom', 'email' ou 'num' : " vartomodif
[...]
```
Pour ce faire on va utiliser la commande `read`.

Une fois la réponse obtenue dans la variable `vartomodif`, on ajoute 3 conditions pour vérifier laquelle valeur est à modifier :

```bash
		if [ $vartomodif = nom ] # si ce qui doit être modifier c'est le nom
		then
			read -p "Nouveau nom : " changename
			sed -i "s/$2/$changename/" annuaire.txt
		elif [ $vartomodif = email ] # si ce qui doit être modifier c'est l'adresse mail
		then
			read -p "Nouvelle email : " changemail
			oldmail=$(sed -n "/$2/p" annuaire.txt | cut -d: -f2)
			sed -i -e "/$2/ {s/$oldmail/$changemail/}" annuaire.txt
		elif [ $vartomodif = num ] # si ce qui doit être modifier c'est le numéro de téléphone
		then
			read -p "Nouveau numéro : " changenum
			oldnum=$(sed -n "/$2/p" annuaire.txt | cut -d: -f3)
			sed -i -e "/$2/ {s/$oldnum/$changenum/}" annuaire.txt 
		fi
[...]
```
Les trois conditions se ressemblent, la première est légèrement différente.

#### Modification du nom

```bash
if [ $vartomodif = nom ]
then
	read -p "Nouveau nom : " changename
	sed -i "s/$2/$changename/" annuaire.txt
[...]
```
La première ligne est très simple : elle demande juste le nouveau nom afin de la placer dans une variable `changename`.

La deuxième est plus compliqué, en effet on utilise une nouvelle commande qui est `sed` (voir [ici](./new_command.md#la-commande-sed)). Cette commande va, dans notre cas, permettre de modifier les informations d'une ligne en particulière.

`sed -i -e "s/$2/$changename/" annuaire.txt` : le `-i` permet de faire en sorte que la modification se fasse sur le document. Puis `"s/$2/$changename/"` va faire une substitution, d'où le `s/` qui est le bout de la commande qui va "activer" cette fonctionnalité. La substitution permet de modifier le texte placé dans la variable ``$2`` en le remplacant par celui placé dans `$changename`. La partie `annuaire.txt` est le nom du document qu'il faut modifier.

#### Modification de l'adresse mail ou du numéro

Les 2 conditions sont quasiment identiques. Par conséquent je ne ferais le détails que d'une seule :

```bash
elif [ $vartomodif = email ] # si ce qui doit être modifier c'est l'adresse mail
then
	read -p "Nouvelle email : " changemail
	oldmail=$(sed -n "/$2/p" annuaire.txt | cut -d: -f2)
	sed -i -e "/$2/ {s/$oldmail/$changemail/}" annuaire.txt
[...]
```
Il y a toujours la commande `read` pour récuperer l'information qui change.

Cette fois-ci, on a besoin de récupérér une valeur qui est l'ancienne adresse mail. En effet, on aurait pu faire plus simple en demandant simplement à l'utilisateur de redonner l'ancienne adresse. Mais je voulais que ce soit plus automatisé.

Alors pour ce faire, il a fallut que l'on coupe la valeur que l'on cherche à modifier (dans le cas ici c'est l'adresse mail mais ça marche de la même façon pour le numéro de téléphone).

`oldmail=$(sed -n "/$2/p" annuaire.txt | cut -d: -f2)` cette ligne va nous permettre de récupérer cette ancienne adresse mail.

Tout d'abord : ``var=$(lacommande)`` va permettre de récupérer dans une variable, la valeur retourner par la commande.

Ensuite : `sed -n "/$2/p" annuaire.txt | cut -d: -f2` La commande se passe en 2 étapes, premièrement `sed -n "/$2/p" annuaire.txt` qui va récupérer la ligne précise de l'utilisateur que l'on veut modifier. En effet `-n` est un paramètre permettant de trouver la ligne correspondant au caractère se trouvant entre les guillemets : ``"/$2/p"``. Ici le ``$2`` est la variable contenant le lien du compte et ``/p`` va demandé de "print" la valeur (il ne print pas dans la console mais va juste récuperer la valeur se trouvant sur la ligne). Si on aurait mis `/=` au lieu de `/p` on aurait eu le numéro de la ligne.

Puis ``cut -d: -f2`` qui va couper juste la partie qui nous intéresse sur la ligne (la ligne récupérer avec la commande précédente).

**:floppy_disk: ``oldmail=$(sed -n "/$2/p" annuaire.txt | cut -d: -f2)`` va placer dans la variable `oldmail`, la valeur récupérer avec les commandes `sed` et `cut` qui respectivement vont trouver la bonne ligne (puis la récupérer) et ensuite couper la partie intéressante de cette ligne.**

Pour finir : On fait presque la même commande que pour le changement du nom, c'est-à-dire : `sed -i -e "/$2/ {s/$oldmail/$changemail/}" annuaire.txt`. Cette fois-ci le `-e` est présent car il sert à pouvoir mettre 2 commandes (les 2 qui sont dans les ""). `/$2/` sert à determiner la ligne et `{s/$oldmail/$changemail/}` sert à modifier l'ancienne adresse mail par celle qui a été entré précédemment par l'utilisateur.

### La commande `phone_book.sh del <contact_name>`

```bash
elif [ $1 = del ] # Si la commande choisi est "del"
then
	sed -i "/$2/d" annuaire.txt
[...]
```

On utilise encore la commande `sed`, mais cette fois-ci pour **supprimer** une ligne (donc un contact). Pour ce faire on fait : `/$2/d`, il faut spécifier une chose qui fera référence à la ligne, ici c'est bien entendu le nom placé dans ``$2`` et avec le `/d` on supprime la ligne correspondante (comme d'habitude : `annuaire.txt` pour spécifier le fichier).