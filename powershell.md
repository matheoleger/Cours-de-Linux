# Installation sur Debian 10

#### Lien : https://docs.microsoft.com/fr-fr/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1

ce lien nous donne les commandes et les choses à télécharger pour réussir l'installation du Powershell sur Linux

### Résoudre le problème avec l'installation

J'ai eu un problème avec l'installation, il ne reconnaissait pas ce qu'on me demandait d'installer.

Pour ce faire, il fallait configurer les sources de APT.

#### Configurer les sources APT:

- Aller dans `\ > etc > apt`
- Editer le fichier `sources.list` avec la commande `sudo nano sources.list`
- (Si jamais une des erreurs est *"please insert the disc labeled"*) il faut enlever la ligne (ou la mettre en commentaire avec le `#`) `deb cdrom:[Debian GNU/Linux etc...`
- Ajouter la ligne suivante `deb http://ftp.fr.debian.org/debian/ sid main`

- Faire la commande `sudo apt update`

### Installation

Maintenant il faut suivre les instruction du [lien ci-joint]( https://docs.microsoft.com/fr-fr/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1)
. Il faut se rendre au niveau de l'installation pour **Debian 10**.

--------------

# Qu'est ce que PowerShell + "Fonctionnement"

> "PowerShell est un langage de script fondé sur la programmation orientée objet. Le logiciel PowerShell (fichier exécutable  powershell.exe  ) est l’interpréteur de l’interface en ligne de commande de l’environnement de développement Windows PowerShell." sur [OpenClassrooms]( https://openclassrooms.com/fr/courses/6344196-planifiez-vos-taches-avec-des-scripts-powershell-sur-windows-server/6527315-utilisez-les-commandes-de-base-de-powershell) 

> "Les commandes PowerShell sont constituées d’un verbe ou préfixe et d’un nom, séparés par un tiret. Elles peuvent être suivies de paramètres, on les appelle des commandlets ou cmdlets (command applets en anglais ou phrases en français)." sur [OpenClassrooms]( https://openclassrooms.com/fr/courses/6344196-planifiez-vos-taches-avec-des-scripts-powershell-sur-windows-server/6527315-utilisez-les-commandes-de-base-de-powershell) 

### :bulb: Provenant de [OpenClassrooms]( https://openclassrooms.com/fr/courses/6344196-planifiez-vos-taches-avec-des-scripts-powershell-sur-windows-server/6527315-utilisez-les-commandes-de-base-de-powershell)

Le préfixe de **cmdlet** est appelé verbe car il détermine l’action à effectuer sur les entités désignées dans la phrase. Quelques-uns des plus utiles :

- `Add`  permet d’ajouter des données ou informations sur le nom qui le suit

- `Get`  permet d’obtenir des données ou informations sur le nom qui le suit

- `Read`  permet de lire des données ou informations sur le nom qui le suit

- `Clear`  permet de réinitialiser l’affichage de l’interface 

- `Import` et `Export`  permettent d’importer/exporter des fichiers de commande ou des Alias

- `New`  permet de créer de nouveaux objets ou variables

- `Set`  permet de définir des données ou informations sur le nom qui le suit

- `Write`  permet d’écrire des données ou informations sur le nom qui le suit et peut agir comme le compte rendu d’une commande.

-------------

# Premières commandes PowerShell

- `Get-Help nomdelacommande` permet d’avoir des informations sur une commande

  Exemple: 
  
  `Get-Help Read-Host` ouvrira un "menu" dans lequel on aura beaucoup d'information sur la commande `Read-Host`
  
- `Read-Host` permet de récupérer des informations (que l'utilisateur pourra rentrer directement dans la console).
*Fonction qui permet de saisir une chaîne de caractères et de l’enregistrer dans une variable*

  Exemple:
  
  ![Read-Host test](./test_de_Read-Host.jpg)
  
  `$val` est une variable.
  
  On lui assigne une valeur qui est une chaine de caractère que l'utilisateur va rentrer.
  
  Pour ce faire, on utilise la commande `Read-Host` (avec lequel on peut rajouter une *"phrase d'introduction"*)

  A la suite de ça, on peut entrer la valeur de la chaine de caractère que l'on veut mettre dans `$val`.

  Les dernières lignes permettent de vérifier que `$val` à bien la valeur entrer précédemment.



