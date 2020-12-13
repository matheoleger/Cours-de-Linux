# Les conditions

#### Il est préférable d'avoir vu  le [premier script](./premier_script.md) avant de commencer, car il permet de poser les bases sur l'exécution et l'écriture d'un script.

----

#### Dans cette partie, nous allons voir pas mal de chose :
- [Les conditions basiques `if`, ``else``, ``elif``](./condition.md#les-conditions-basiques)
    -  [la condition `if`](./condition.md#la-condition-if)
    -  [la condition `else`](./condition.md#la-condition-else)
    -  [la condition `elif`](./condition.md#la-condition-elif)
- [Les tests](./condition.md#les-tests)
    - [tests sur des chaines de caractères](./condition.md#tests-sur-des-chaines-de-caratères)
    - [tests sur des nombres](./condition.md#tests-sur-des-nombres)
    - [tests sur des fichiers](./condition.md#tests-sur-des-fichiers)
    - [Opérateurs logiques](./condition.md#opérateurs-logiques)

---
## Les conditions basiques

Dans un premier temps, on va voir comment se forme les conditions en `bash`.

### La condition ``if``

On utilise globalement le `if` qui est la base des conditions.

Sous forme algorithmique :

```html
SI le_test
ALORS
    la_chose_que_l'on_veut_faire
FIN
```
Sous forme `bash` :

```bash
if [ le_test ]
then
    la_chose_a_faire
fi
```

ou encore :

```bash
if [ le_test ]; then
    la_chose_a_faire
fi
```
En effet, on peut aussi écrire le `then` sur la même ligne en rajoutant un ";".

:bulb: À noter que les espaces entre le **test** et les **crochets** sont importants. Il faut écrire ``[ le_test ]`` et pas ``[le_test]``.

Exemple pour mieux comprendre :

```bash
#!/bin/bash

nbr=12                          # On déclare que le nombre = 12

if [ $nbr = 12 ]                # SI le nombre est égale à 12
then                            # ALORS
    echo "Le nombre est 12"     # on écrit "Le nombre est 12"
fi                              # FIN de la condition
```

Les commentaires expliquent le fonctionnement de la condition.

### La condition `else`

La condition ``if`` à elle toute seule ne suffit pas forcément. En effet, on peut être ammené dans certains cas à vouloir faire quelque chose si ***le test*** n'a pas marché.

Et pour cela on se sert de la condition `else` (qui signifie SINON)

Sous forme algorithmique :

```html
SI le_test
ALORS
    faire_quelque_chose
SINON
    faire_quelque_chose
FIN
```
Sous forme `bash` :

```bash
if [ le_test ]
then
    faire_quelque_chose
else
    faire_quelque_chose
fi
```

**Exemple :**

```bash
#!/bin/bash

nbr=12                              # On déclare que le nombre = 12

if [ $1 = 12 ]                      # SI le nombre est égale à 12
then                                # ALORS
    echo "Le nombre est 12"         # on écrit "Le nombre est 12"
else                                # SINON
    echo "Ce n'est pas un douze"    # on écrit "Ce n'est pas un douze"
fi                                  # FIN de la condition
```
Testons le script :

Si je mets en paramètre "12" :
```bash
$./test.sh 12
Le nombre est 12
$
```
En revanche, si je mets autre chose qu'un 12 :

```bash
$./test.sh 13
Ce n'est pas un douze
$
```

### La condition `elif`

On peut aussi ajouter des ``SINON SI`` qui vont eux permettrent d'avoir une condition que si la condition précédente n'est pas bonne.

`elif` correspond donc à ``else if`` soit ``SINON SI``

Sous forme algorithmique :

```html
SI le_premier_test
ALORS
    faire_quelque_chose
SINON SI le_deuxieme_test
THEN
    faire_quelque_chose
SINON
    faire_quelque_chose
FIN
```
Sous forme `bash` :

```bash
if [ le_premier_test ]
then
    faire_quelque_chose
elif [ le_deuxieme_test ]
then
    faire_quelque_chose
else
    faire_quelque_chose
fi
```

**Exemple :**

```bash
#!/bin/bash

nbr=12                              # On déclare que le nombre = 12

if [ $1 = 12 ]                      # SI le nombre est égale à 12
then                                # ALORS
    echo "Le nombre est 12"         # on écrit "Le nombre est 12"
elif [ $1 = 6 ]                     #SINON SI le nombre est égale à 6
then                                #ALORS
    echo "Le nombre est 6"          # on écrit "Le nombre est 6"
else                                # SINON
    echo "Ce n'est ni un 6 ni un douze"    # on écrit "Ce n'est pas un douze"
fi                                  # FIN de la condition
```

On test le programme :

Si je mets 12 en paramètre :

```bash
$./test.sh 12
Le nombre est 12
$
```

Si je mets 6 en paramètre :

```bash
$./test.sh 6
Le nombre est 6
$
```
En revanche, si je mets autre chose :

```bash
$./test.sh 18
Ce n'est ni 6 ni douze
$
```
## Les tests

:warning: Toutes cette partie est fortement inspiré d'[Openclassrooms](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/43394-les-conditions#/id/r-43360). En effet, les tableaux qu'ils ont fait sont très pratique, par conséquent je me suis permis de faire la même chose.

D'après eux, il y a trois types de tests différents en bash :
- tests sur des chaines de caractères
- tests sur des nombres
- tests sur des fichiers

À noter que toutes les variables sont par défaut considéré comme des chaines de caractères. 


### Tests sur des chaines de caractères

| Conditions            |Significations                |
|--------            |-------------                 |
|``$valeur1 = $valeur2``| Vérification si les 2 chaines sont **identiques**|
|``$valeur1 != $valeur2``| Vérification si les 2 chaines sont **différentes**|
|``-z $valeur``| Vérification de si la chaine est **vide**|
|``-n $valeur``| Vérification de si la chaine n'est **pas vide**|

:bulb: On parle bien ici de **chaine de caractère** donc il ne prendra pas en compte des calculs mathématiques. Exemple : `1+1 = 2` sera un **test faux** car la chaine de caractère ``1+1`` est **différente** de la chaine de caractère `2`. Nous verrons plus tard quelque chose qui fera un test de nombre.

**Exemples :**

```bash
#!/bin/bash

valeur1 = "Jane"
valeur2 = "John"

if [ valeur1 != valeur2 ]
then
    echo "Nous sommes différents"
else
    echo "Nous sommes la même personne"
fi
```

En sortie : 

```bash
$./test.sh
Nous sommes différents
$
```

## Tests sur des nombres

Le tableau ci-dessous montre les différentes conditions possibles avec des nombres.

La construction se fait comme ceci : ``$var1 -condition $var2``

| Conditions            |Significations                |
|--------            |-------------                 |
|``-eq``| vérification de l'égalité de 2 nombres (= **e**qual)|
|`-ne`| vérification de la différence de 2 nombres (= **n**ot **e**qual)|
|`-gt`| correspond au signe ">" (= **g**reater **t**han)|
|`-ge`| correspond au signe ">=" (= **g**reater or **e**qual)|
|`-lt`| correspond au signe "<" (= **l**ower **t**han)|
|`-le`| correspond au signe "<=" (= **l**ower or **e**qual)|

:bulb: Il y a une deuxième manière de faire les tests. En effet, on peut se servir des **doubles parenthèses** qui est dédié aux comparaisons arithmétiques : `==`, `!=`, `<`, `<=` etc...

Elles vont permettre de ne pas utiliser "les mots cléfs", mais justement se servir directement des signes appropriés.

**Exemples :**

On va faire avec les 2 méthodes pour montrer les possibilités :

```bash
#!/bin/bash

if [ $1 -lt 18 ]                #Si le paramètre n°1 est strictement inférieur à 18
then                            #Alors
    echo "Plus petit que 18"
else                            #Sinon
    echo "Plus grand ou égale à 18"
fi
```
**OU ALORS**

```bash
#!/bin/bash

if (($1 < 18))                  #Si le paramètre n°1 est strictement inférieur à 18
then                            #Alors
    echo "Plus petit que 18"
else                            #Sinon
    echo "Plus grand ou égale à 18"
fi
```

La sortie sera la même :

```bash
$./test.sh 18
Plus grand ou égale à 18
$
```

```bash
$./test.sh 16
Plus petit que 18
$
```

### Tests sur des fichiers

On peut facilement faire des tests de fichier en ``bash`` :

Cela se construit par : `-condition $fichier`

| Conditions            |Significations                |
|--------            |-------------                 |
|`-e`| Vérification de l'existence du fichier (**e**xistence)|
|`-d`| Vérifie si le fichier est un répertoire (**d**irectory)|
|`-f`| Vérifie si le ficheir est un fichier (**f**ile)|
|`-L`| Vérifie si le fichier est un lien symbolique (**l**ink)|
|`-r`| Vérifie si le fichier est lisible (**r**ead)|
|`-w`| Vérifie si le fichier est modifiable (**w**rite)|
|`-x`| Vérifie si le fichier est exécutable (e**x**ecute)|
|`$fichier1 -nt $fichier2`| Vérifie si le `fichier1` est plus récent que le `fichier2` (**n**ewer **t**han)|
|`$fichier1 -ot $fichier2`| Vérifie si le `fichier1` est plus ancien que le `fichier2`(**o**lder **t**han)|

**Exemple :**
Voici un script qui vérifie l'existence d'un fichier :

```bash
#!/bin/bash

if [ -e $1 ]
then
    echo "Le fichier existe bien !"
else
    echo "Le fichier n'existe pas !"
fi
```
En sortie :

```bash
$ ./test.sh user_gestion.sh
Le fichier existe bien !
$
```
```bash
$ ./test.sh quoi
Le fichier n'existe pas !
$
```
### Opérateurs logiques

Pour faire plusieurs tests, on peut se servir des opérateurs logiques ``&&`` et ``||``

| Opérateur            |Significations                |
|--------            |-------------                 |
|`&&`| Correspond à "ET"|
|`||`| Correspond à "OU"|
|`!`| Correspond à "FALSE" (il permet d'inverser un test)|

### Le ``&&`` et le ``||``

Le ``ET`` et le ``OU`` permettent de faire plusieurs tests pour une même conditions.

**Exemple :**

Faisons un programme qui demande l'âge et la taille d'une personne pour savoir s'il peut rentrer dans le manège :

```bash
#!/bin/bash

read -p "Quelle est votre âge et votre taille svp ? " age taille

if [ age -ge 10 ] && [ taille -ge 160 ]
then
    echo "Vous pouvez rentrer !"
else
    echo "Désolé mais vous ne pouvez pas rentrer ?"
fi
```
Ici, on vérifie si l'*âge* est **supérieur ou égale** à *10* **ET** si la *taille* est **supérieur ou égale** à *160*

En sortie :

Si l'**âge** est de *10* et la **taille** de *160* :

```bash
$ ./test.sh
Quelle est votre âge et votre taille svp ? 10 160
Vous pouvez rentrer !
$
```
Ici l'âge et la taille sont bon.

Si l'**âge** est de *9* et la **taille** de *160* :

```bash
$ ./test.sh
Quelle est votre âge et votre taille svp ? 9 160
Vous pouvez rentrer !
$
```
Ici l'âge n'est pas bon mais la taille était bonne. Malheureusement comme il y a **un des 2 éléments** vérifiés qui **n'est pas bon**, alors la personne **ne peut pas aller** dans le manège.

On aurait aussi pu remplacer le ``&&`` par ``||`` pour faire en sorte que **SI** l'**une des deux** conditions est **bonne**, alors la personne **aurait pu aller** dans le manège.

### Le `!`

On peut aussi inverser un test avec le `!`.

Exemple :

```bash
#!/bin/bash

if [ ! -d $1 ]
then
    echo "Ceci n'est pas un répertoire"
else
    echo "Ceci est un répertoire"
fi
```

En sortie :

```bash
$ ./test.sh test.sh
Ceci n'est pas un répertoire
$
```
