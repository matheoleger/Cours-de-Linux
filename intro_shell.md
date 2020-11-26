[quetcequeleshelltest](./intro_shell.md#quest-ce-que-le-shell-) 

# Introduction au Shell

## Qu'est-ce que le Shell ?

Le **Shell** est nommé l'**interface système** ou **coque logicielle**(= shell en anglais).

Il fournit l'**interface utilisateur**  et correspond à la couche logicielle la plus externe d'un **système d'exploitation**. C'est-à-dire qu'il est **la couche logicielle** permettant à l'homme de communiquer plus facilement avec la machine et donc d'accéder aux services que l'OS propose.

L'interface système permet donc de **contrôler** et de **communiquer** avec la machine.

Le shell de l'OS peut prendre 2 formes :

- **L'interface en ligne de commande** (*CLI = "command line interface"*)
- **L'interface sous forme graphique** (*GUI = "graphical user interface"*) c'est-à-dire un **environnement graphique** permettant une utilisation plus simplifiée de la machine.

On va s'intéresser à la première forme : **l'interface en ligne de commande**.

Comme son nom l'indique, cela va permettre à l'utilisateur de **communiquer** via du texte avec la machine (et inversement). Mais pour que les commandes soient reconnues, on a besoin d'un **interpréteur de commande** (*CLI = command-line interpreter*).

Ils existent différents interpréteurs de commandes selon l'OS utilisé:
    - Sous Windows, le logiciel d'interprétation des commandes est le `cmd.exe` mais depuis quelques années, il existe un 2ème interpréteur de commande qui est le `powershell.exe`
    - Sous Linux, les interpréteur de commandes sont les `shells Unix` (ils en existent beaucoup, exemples : sh / bash / etc....)
    - Sous Mac, c'est simplement le `terminal`

On va s'intéresser aux shells Unix.
Tout d'abord ***qu'est ce qu'un shell Unix ?***

> Il se présente sous la forme d'une interface en ligne de commande accessible depuis la console ou un terminal. L'utilisateur lance des commandes sous forme d'une entrée texte exécutée ensuite par le shell. [Wikipédia](https://fr.wikipedia.org/wiki/Shell_Unix)

Pour résumé, un shell Unix va permettre d'**interpréter** les **commandes données** sous forme de texte dans un terminal **Unix**. C'est un peu le "langage" qui permet à l'utilisateur et à la machine de se comprendre.

Il existe différents shells Unix, voici les plus connus:
- ***sh*** : signifie *Bourne Shell*. Le premier interpréteur de commande qui est à l'origine des autres.
- ***bash*** : signifie *Bourne Again Shell*. Fondé sur le *Bourne Shell* mais plus complet (notamment en reprennant des éléments du ksh et du csh). Disponible par défaut sur les systèmes Linux et Mac OS.
- ***ksh*** : signifie *Korn Shell*. Compatible avec *bash* et il possède un grand nombre de fonctionnalité.
- ***csh*** : signifie *C Shell*. Elle a une synthaxe similaire au langage C.
- ***tcsh*** : signifie *Tenex C Shell*. Une amélioration du *csh*.
- ***zsh*** : signifie *Z Shell*. Il reprend la plupart des fonctions de bash, ksh et tcsh.

Le **sh** est installé sur tous les OS basés sur UNIX. Mais il montre des limites.

Par conséquent, aujourd'hui le shell le plus utilisé est le **bash** (sûrement car c'est le shell créé par GNU). Il est installé par défaut sur beaucoup de distribution Linux.

Mais pas sur toutes et donc certaines reste soit en **sh** par défaut ou soit avec d'autres shells comme **ksh**.




