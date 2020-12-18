# Cours sur Shell 
------------

## Introduction

Voici un cours sur le **Shell UNIX**.
Ici, on verra dans un premier temps qu'est ce que le Shell, à quoi ça sert en général. On essayera aussi de faire un **premier script**. 

Puis nous verrons les commandes principales du Shell ainsi que le **fonctionnement du Shell** (c'est-à-dire formation de **variables**, les **conditions**, les **boucles** etc...).

Puis, pour finir, on va regarder des exercices qui permettront de montrer l'utilité d'un script.

:bulb: À savoir que le fichier "powershell.md" est encore ici (ancien fichier demandé avant le TP) mais ne fait pas forcément parti du travail final.

----------

## Sommaire

1. [Introduction au Shell](./intro_shell.md)
    - [Qu'est-ce que le Shell ?](./intro_shell.md#quest-ce-que-le-shell-) 
    - [Histoire du Shell](./intro_shell.md#histoire-du-shell)

2. [Commandes principales du bash](./new_command.md)

3. [Editer un fichier](./nano_et_vi.md) 
    - [Editer avec `nano`](./nano_et_vi.md#editer-un-fichier-avec-nano) 
    - [Editer avec `vi`](./nano_et_vi.md#editer-un-fichier-avec-vi)
4. [Premier Script](./premier_script.md)
    - [Création d'un script](./premier_script.md#création-et-édition-du-script)
    - [Exécution basique d'un script](./premier_script.md#execution-du-script--définition-des-droits)
    - [Exécution de n'importe où](./permier_script.md#execution-du-script-de-nimporte-où) (sous forme de commande)
5. [Formation du shell](./form_shell.md) (résumé de ce qui se trouve ci-dessous)
    - [Les Variables](./variable.md)
    - [Les conditions](./condition.md)
    - [Les boucles](./boucle.md)
    - [Les fonctions](./fonction.md)
6. [Exemple n°1](./example_one.md) (Script de gestion des comptes utilisateurs)
7. [Exemple n°4](./example_four.md) (Script de gestion de contacts)


-----
## Avis sur le projet

Personnellement, j'ai bien **aimé** ce projet qui a été très intéressant.

En effet, j'ai appris beaucoup de chose sur **Linux** et les **shells**. Et ce projet m'a montré une facette de l'informatique vraiment **intéressante** et qui m'a beaucoup plu.

La partie **Exercices** était vraiment super bien ! Malheureusement j'aurais bien aimé avoir une petite partie cours sur **Apache** car je n'ai pas tout compris.

Le déroulement du projet était bien aussi car elle permettait de ne pas avoir une charge de travail énorme en dehors des cours.

C'était un très bon complément au cours qu'on a eu au début du module.

-----

## Sources

#### Introduction au Shell
Utilisation de Wikipédia en général . J'ai mis le lien principal qui permet de trouver tous les liens qui m'ont servis à détailler.
https://fr.wikipedia.org/wiki/Shell

https://www.youtube.com/watch?v=Fiz3lMZhWKM

https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/42867-introduction-aux-scripts-shell

### Commandes principales du bash

Toute la documentation officiel de linux (+ utilisation de `man`).

pour `sed` : https://buzut.net/apprendre-commande-sed-linux/

pour ``let`` : https://fr.wikibooks.org/wiki/Programmation_Bash/Calculs

### Premiers scripts

https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/42867-introduction-aux-scripts-shell

### Formation du shell

https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/42867-introduction-aux-scripts-shell

### Exemple n°1

https://doc.ubuntu-fr.org/tutoriel/gestion_utilisateurs_et_groupes_en_ligne_de_commande
https://forum.ubuntu-fr.org/viewtopic.php?id=289647
http://www.linux-france.org/article/memo/node8.html
https://forum.ubuntu-fr.org/viewtopic.php?id=2000272
https://linux.goffinet.org/administration/securite-locale/operations-sur-les-utilisateurs-et-les-groupes/#1-cr%C3%A9er-un-utilisateur
https://doc.ubuntu-fr.org/tutoriel/changer_un_identifiant_de_compte

### Exemple n°4

https://linuxfr.org/forums/linux-debutant/posts/%C3%A9crire-dans-un-fichier-texte-en-mode-commande
https://buzut.net/apprendre-commande-sed-linux/