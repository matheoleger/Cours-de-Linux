# La formation du shell

#### Le shell ressemble à un langage de programmation. C'est-à-dire qu'il se forme de la même manière avec l'utilisation de variables, de boucles, de conditions etc...

#### Il est préférable d'avoir vu le [premier script](./premier_script.md) avant de commencer, car il permet de poser les bases sur l'exécution et l'écriture d'un script.

#### :warning: Ici, je fais un bref résumé de chaque élément permettant l'écriture d'un vrai script (variables, boucles, conditions...), pour que ce soit plus rapide pour moi si j'ai envie de me rappeler rapidement.

-------

## Sommaire
#### 1. [Les variables](./form_shell.md#les-variables) (la page complète [ici](./variable.md))
#### 2. [Les conditions](./form_shell.md#les-conditions) (la page complète [ici](./condition.md))
#### 3. [Les boucles](./form_shell.md#les-boucles) (la page complète [ici](./boucle.md))
#### 4. [Les fonctions](./form_shell.md#les-fonctions) (la page complète [ici](./fonction.md))

------
# Les fiches rapides

## Les variables 

### Déclaration + utilisation

On déclare une variable comme ça :

```bash
variable=valeur
```

Et pour se servir de la valeur :

```bash
$variable
```

### Saisir une valeur (depuis le terminal)

Pour faire une demande de saisie (pour mettre une valeur dans une variable on fait) :

```bash
read nom_de_la_variable
```

### Les "quotes"

`""` : Peut lire les caractères particuliers donc reconnaitra une variable (grâce à ``$variable``)

``''``: Mettra exactement ce qu'il y aura écrit donc ne peut pas reconnaitre les variables.

` `` ` : Reconnaitra les commandes `bash` et pourra donc être placé dans des variables.

### Variables de paramètres

Les valeurs de ses paramètres peuvent être récupérées grâce à des variables qui ont été automatiquement créées :

- $# correspond aux nombres de paramètres (ici *4*)
- $0 correspond au nom du script (ici *./test.sh*)
- $1 correspond au premier paramètre (ici *param1*)
- ...
- $9

Pour avoir plus de 9 paramètres, il faut utiliser la commande `shift`

### Variables d'environnement

On peut les connaitre avec la commande `env` (voir [ici](./new_command.md#la-commande-env)).

Les principales :

- ``SHELL`` : indique quel type de shell est en cours d'utilisation (sh, bash, ksh…) ;

- ``PATH`` : une liste des répertoires qui contiennent des exécutables que vous souhaitez pouvoir lancer sans indiquer leur répertoire. (déjà vu [ici](./premier_script.md#execution-du-script-de-nimporte-où) lors de notre premier script)

- ``HOME`` : la position de votre dossier ``home``.

- ``PWD`` : le dossier dans lequel vous vous trouvez. (on peut aussi utiliser [la commande ``pwd``](./new_command.md#la-commande-pwd))

- ``OLDPWD`` : le dossier dans lequel vous vous trouviez auparavant.

## Les conditions

### le `if`

La condition `if` se forme comme ceci :

```bash
if [ le test ]
then
    action_a_faire
fi
```

### le `else`

La condition `else` se forme comme ceci :

```bash
if [ le test ]
then
    action_1
else            #le else
    action_2
fi
```

### le `elif`

La condition `elif` se forme comme ceci :

```bash
if [ le test ]
then
    action_1
elif [ le test 2 ]      #le elif
then
    action_2
else
    action_3
fi
```

### Les différents tests

- #### Test sur des chaines de caractères

| Conditions            |Significations                |
|--------            |-------------                 |
|``$valeur1 = $valeur2``| Vérification si les 2 chaines sont **identiques**|
|``$valeur1 != $valeur2``| Vérification si les 2 chaines sont **différentes**|
|``-z $valeur``| Vérification de si la chaine est **vide**|
|``-n $valeur``| Vérification de si la chaine n'est **pas vide**|

- #### Test sur des nombres

La construction se fait comme ceci : ``$var1 -condition $var2``

| Conditions            |Significations                |
|--------            |-------------                 |
|``-eq``| vérification de l'égalité de 2 nombres (= **e**qual)|
|`-ne`| vérification de la différence de 2 nombres (= **n**ot **e**qual)|
|`-gt`| correspond au signe ">" (= **g**reater **t**han)|
|`-ge`| correspond au signe ">=" (= **g**reater or **e**qual)|
|`-lt`| correspond au signe "<" (= **l**ower **t**han)|
|`-le`| correspond au signe "<=" (= **l**ower or **e**qual)|

- #### Test sur des fichiers

Cela se construit par : `-condition $fichier`

| Conditions            |Significations                |
|--------            |-------------                 |
|`-e`| Vérification de l'existence du fichier (**e**xistence)|
|`-d`| Vérifie si le fichier est un répertoire (**d**irectory)|
|`-f`| Vérifie si le fichier est un fichier (**f**ile)|
|`-L`| Vérifie si le fichier est un lien symbolique (**l**ink)|
|`-r`| Vérifie si le fichier est lisible (**r**ead)|
|`-w`| Vérifie si le fichier est modifiable (**w**rite)|
|`-x`| Vérifie si le fichier est exécutable (e**x**ecute)|
|`$fichier1 -nt $fichier2`| Vérifie si le `fichier1` est plus récent que le `fichier2` (**n**ewer **t**han)|
|`$fichier1 -ot $fichier2`| Vérifie si le `fichier1` est plus ancien que le `fichier2`(**o**lder **t**han)|

### Opérateurs logiques

| Opérateur            |Significations                |
|--------            |-------------                 |
|`&&`| Correspond à "ET"|
|`||`| Correspond à "OU"|
|`!`| Correspond à "FALSE" (il permet d'inverser un test)|

## Les boucles

### La boucle `while`

"While" signifie "tant que" (en tout cas dans le domaine de l'informatique).

C'est une boucle qui va attendre que la condition soit vraie (ou fausse selon ce que l'on veut).

```bash
while [ test ]
do
    chose_à_faire
done
```

### La boucle `for`

En `bash`, la boucle `for` fonctionne différemment des boucles `for` des autres langages.

Ici, la boucle `for` permet de parcourir une liste de valeurs. C'est-à-dire qu'elle continue tant qu'elle n'aura pas fait le tour de toutes les valeurs d'une variable.

```bash
for variable in 'val1' 'val2' 'val3'
do
    chose_à_faire
done
```

## Les fonctions

### Déclaration + utilisation

Il y a 2 façons de déclarer une fonction en bash :

```bash
function nom_fonction{

}
```
OU

```bash
nom_fonction(){

}
```
On peut aussi mettre les accolades comme ça :

```bash
nom_fonction()
{

}
```

Pour appeler une fonction :

```bash
#Declarer la fonction
nom_fonction()
{

}

#Appeler la fonction
nom_fonction
```

### Les variables dans les fonctions 

La déclaration de variable est particulière pour les fonctions :
- On peut se servir des variables déclarées ailleurs dans le script.
- Créer des nouvelles variables pour le script.
- Créer des variables locales, c'est-à-dire, propre à la fonction.

**Pour les variables locales** : `local nom_var=valeur` 