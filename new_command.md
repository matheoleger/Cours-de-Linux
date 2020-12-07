# Les commandes principales du Shell

###### Ayant déjà vu dans le cours les **commandes**, j'y mettrais les nouvelles commandes que nous n'avons pas vue précedemment.

##### Liens vers le fichier des commandes vues dans le cours : https://github.com/kevinniel/resources/blob/master/Cours/linux/commandes_generiques.md

-----

### La commande ``echo``

`echo` est une commande qui va permettre d'afficher ce que l'on veut.

Elle s'écrit comme ceci `echo "ce que l'on veut écrire"`

##### Exemple :

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
Après avoir taper le mot de passe (Le mot de passe reste invisible) il y a une ligne différente qui apparait (la ligne finissant par ``#``).

----