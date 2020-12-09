# Formation du Shell

#### Le shell ressemble à un langage de programmation. C'est-à-dire qu'il se forme de la même manière avec l'utilisation de variables, de boucles, de conditions etc...

#### Il est préférable d'avoir vu avant le [premier script](./premier_script.md) qui permet de poser les bases sur l'exécution et l'écriture d'un script.
------

## Les variables

### Déclaration et utilisation d'une variable

Pour **déclarer** une variable, il faut faire :

```bash
nomdelavar=lavaleur
```

Mais pour utiliser la **valeur** d'une variable, on écrit:

```bash
$nomdelavar
```

En bash, une variable **n'est pas typée**. Donc on peut avoir beaucoup de variables différentes :

```bash
caractere=a
mot=texte
message="texte avec espace"
messagedeux='texte avec espace 2'
nombre=2108
```
Nous verrons un peu plus tard quelle est la différence entre les **simple quotes ' '** et les **double quotes " "**.

**Exemple**

On écrit un script qui va print ``Hello World!`` mais cette fois-ci en utilisant les variables.

```bash
#!/bin/bash

var="Hello World!"

echo $var
```
(voir [ici](./new_command.md#la-commande-echo) pour l'explication du fonctionnement de echo)

Une fois le script exécuté, voici le résultat :

```bash
$ ./hello_world.sh
Hello World!
$
```
### La différence entre les ***"quotes"***

#### Single quotes (apostrophes ' ')

Dans le script 
```bash
#!/bin/bash

var="Hello World!"

echo 'la variable est : $var'
```
En sortie :

```html
$ ./hello_world.sh
la variable est : $var
$
```

En effet, ici cela écrit littéralement ce qu'il y a entre les apostrophes. (il n'y a pas d'analyse)

#### Double quotes (guillemets " ")

Dans le script 
```bash
#!/bin/bash

var="Hello World!"

echo "la variable est : $var"
```
En sortie :

```html
$ ./hello_world.sh
la variable est : Hello World!
$
```
En effet, ici cela écrit ce qu'il y a entre les apostrophes en prenant en compte les symboles spéciaux. (il y a une analyse)

#### Back quotes (les accents graves \` `)

Dans le script 
```bash
#!/bin/bash

var=`pwd`

echo "la variable est : $var"
```
En sortie :

```html
$ ./hello_world.sh
la variable est : username/Documents
$
```
Les accents graves permettent de mettre une commande dans une variable (et par conséquent de l'exécuter avec ``echo``).

### Demande de saisie

On peut utiliser la commande `read` (explication de la commande [ici](./new_command.md#la-commande-read)) afin d'assigner une valeur par la demande de saisie.

Grâce à `read` on peut faire des programmes avec des demandes de saisie du type :

Dans le script:

```bash
echo "Combien avez vous d'argent ?"

read monnaie

echo "Vous avez $monnaie€ d'argent !"
```
En sortie :

```html
$ ./monnaie.sh
Combien avez vous d'argent ?
50
Vous avez 50€ d'argent !
```
Cet exemple montre l'utilisation de `read` pour lire l'information que le script avait besoin, et retourne avec `echo` la variable.

Vous pouvez retrouver les options de la commande `read` [ici](./new_command.md#la-commande-read) avec des exemples.

### Concaténation de variable (= addition de texte)

On peut faire une concaténation de variables contenant des chaines de caractère.

Pour ce faire il faut faire :

```bash
premierevar=chaine1
deuxiemevar=chaine2
total=$premierevar$deuxiemevar
```
Et donc si on fait un `echo $total` le résultat sera :

```bash
chaine1chaine2
```

Mais on peut aussi ajouter du texte en plus qui n'est pas dans une variables, comme ceci

```bash
premierevar=chaine1
deuxiemevar=chaine2
total="$premierevar est avant $deuxiemevar"
```
Donc si on fait un `echo $total` le résultat sera :
```bash
chaine1 est avant chaine2
```
> :bulb: À savoir qu'on peut aussi faire la concaténation dans un ``echo``.

### Opérations mathématiques

Comme on l'a vu précédemment, il n'y a pas de type pour les variables, et par conséquent il n'y a que des chaines de caractère par défaut. Donc les opérations mathématiques **avec des variables** ne peuvent pas être fait sans commande spécifique.

Il est aussi possible de faire des opérations mathématiques en utilisant la commande `let` (voir la [commande](./new_command.md#la-commande-let)).



Voici un exemple :

```bash
let "addition = 5 + 5"

echo $addition
```

deuxième exemple plus complet :

```bash

let "premier = 5"

let "deuxieme = 5"

let "multiplication = premier * deuxieme"     #pas besoin de $ (sauf si on utilise pas `let` pour les 2 premières variables)

echo $multiplication
```

## Les variables des paramètres

On peut ajouter des paramètres après la commande pour lancer le programme, comme ceci :

```bash
$ ./test.sh param1 param2 param3
```
Les valeurs de ses paramètres peuvent être récupérées grâce à des variables qui ont été automatiquement créées :

- $# correspond aux nombres de paramètres (ici *4*)
- $0 correspond au nom du script (ici *./test.sh*)
- $1 correspond au premier paramètre (ici *param1*)
- ...
- $9

Pour avoir plus de 9 paramètres, il faut utiliser la commande `shift`


## Les variables d'environnement

Les **variables d'environnement** sont des variables qui sont déclarer à l'**échelle globale** de la machine. C'est-à-dire que ce genre de variable est **utilisable partout** (contrairement au variable classique qui sont déclarer et utilisable que dans un fichier).

On peut les connaitre avec la commande `env` (voir [ici](./new_command.md#la-commande-env)).

Voici les plus utiles (d'après [OpenClassrooms](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/43126-afficher-et-manipuler-des-variables)):

- ``SHELL`` : indique quel type de shell est en cours d'utilisation (sh, bash, ksh…) ;

- ``PATH`` : une liste des répertoires qui contiennent des exécutables que vous souhaitez pouvoir lancer sans indiquer leur répertoire. (déjà vu [ici](./premier_script.md#execution-du-script-de-nimporte-où) lors de notre premier script)

- ``HOME`` : la position de votre dossier ``home``.

- ``PWD`` : le dossier dans lequel vous vous trouvez. (on peut aussi utiliser [la commande ``pwd``](./new_command.md#la-commande-pwd))

- ``OLDPWD`` : le dossier dans lequel vous vous trouviez auparavant.

On peut aussi créer notre propre variable d'environnement avec la commande `export` (voir [ici](./new_command.md#la-commande-export)).







