# Les fonctions

#### Il est préférable d'avoir vu  le [premier script](./premier_script.md) avant de commencer, car il permet de poser les bases sur l'exécution et l'écriture d'un script.

----

En effet, les fonctions sont aussi présentes en ``bash``.

Les fonctions sont vraiment très **pratiques** et vont permettre une **meilleure lisibilité** et une **meilleure organisation** du script.

Avec elles, on peut **rassembler** des bouts de code ensemble afin d'**organiser** les choses que fait le script.

Une fonction sera pratique dans le cas où vous avez besoin de faire des **tâches répétées**.

## Déclaration

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

## Appeler la fonction

Appeler une fonction permettra de l'exécuter.

Attention : on ne peut pas appeler une fonction avant de l'avoir déclaré. La déclaration de la fonction se fait toujours avant de l'appeler.

Pour appeler, on fait : `nom_fonction`

C'est tout ce qu'il faut faire, mais voici comment ça doit être mis :

```bash
# Déclarer
nom_fonction() {
    
}

# Appeler
nom_fonction
```

En effet, comme en bash il n'y a pas de fonction "main" alors, on doit juste l'appeler en dehors.

Mais on peut aussi appeler des fonctions dans des fonctions.

### **Exemple :**

Voici le script :
```bash
#!/bin/bash

myFunc(){

    echo "Hello World!"
    mySecondFunc
}

mySecondFunc(){

    echo "Hello Second World!"
}

myFunc
```

En sortie :

```bash
$./function.sh
Hello World!
Hello Second World!
$
```

Comme vous pouvez le voir, en appelant simplement la fonction `myFunc`, on a fait les lignes de commande se trouvant dans cette fonction, et comme dans cette fonction on appelle la fonction `mySecondFunc`, cela lance les lignes de commandes de cette deuxième fonction.

## Les variables

La déclaration de variable est particulière pour les fonctions :
- On peut se servir des variables déclarées ailleurs dans le script.
- Créer des nouvelles variables pour le script.
- Créer des variables locales, c'est-à-dire, propre à la fonction.

En effet, on peut se servir de n'importe quelle variable déclarer et déclarer des variables que les autres fonctions pourront réutiliser. **À une condition :** la fonction contenant la variable devra être appelée AVANT d'utiliser la variable. (exemple en dessous pour que ce soit plus claire)

Mais il existe bel et bien des variables qu'on ne pourra pas réutiliser d'une fonction à une autre : la variable locale.

### Exemples :

On a un script avec 2 variables respectivement placées dans les fonctions :

```bash
#!/bin/bash

myFunc(){   
    first="first"   # Déclaration d'une variable "first"

    echo "$second"  # On écrit la valeur de second

    mySecondFunc    # appel de la fonction mySecondFunc()
}

mySecondFunc(){
    second="second" # Déclaration d'une variable "second"

    echo "$first"   # On écrit la valeur de first
}

myFunc              # appel de la fonction myFunc()
```

En sortie :

```bash
$./function.sh

first
$
```
Comme on peut le voir, il y a une ligne vide. En effet, `second` est dans la fonction `mySecondFunc()` et comme cette fonction est appelée **après** avoir fait le `echo "$second"` et bien la fonction ne connaît pas encore de variable `second`.

En revanche, si on aurait fait ça :

```bash
#!/bin/bash

myFunc(){   
    first="first"   # Déclaration d'une variable "first"

    mySecondFunc    # appel de la fonction mySecondFunc() 

    echo "$second"  # On écrit la valeur de second
}

mySecondFunc(){
    second="second" # Déclaration d'une variable "second"

    echo "$first"   # On écrit la valeur de first
}

myFunc              # appel de la fonction myFunc()
```

En sortie :

```bash
$./function.sh
first
second
$
```
Et cette fois-ci tout a été écrit. Mais alors pourquoi cet ordre des mots ? Et bien, c'est dû au fait qu'on appelle la fonction `mySecondFunc` avant de faire le `echo "$second"` et comme la variable `first` était déjà déclarée au moment où la fonction a été appelé, alors il a pu écrire la valeur de la variable `first`.

Maintenant voici ce qu'il se passe si on déclare la variable `first`, mais en local :

```bash
#!/bin/bash

myFunc(){   
    local first="first"   # Déclaration d'une variable "first"

    mySecondFunc    # appel de la fonction mySecondFunc() 

    echo "$second"  # On écrit la valeur de second
}

mySecondFunc(){
    second="second" # Déclaration d'une variable "second"

    echo "$first"   # On écrit la valeur de first
}

myFunc              # appel de la fonction myFunc()
```

En sortie :

```bash
$./function.sh
first
second
$
```

Il se passe exactement la même chose, car les variables locales sont connues par les fonctions appelées par la fonction où elles sont déclarées.

Mais alors à quoi ça sert de déclarer une variable locale ?

Et bien comme on l'a dit précédemment, les fonctions peuvent déclarer des variables globales (qui seront connues dans tout le script) et elles seront utilisables dans le script basique (sans fonction). En revanche, si la variable est déclarée comme local, je ne pourrai pas m'en servir en dehors de la fonction (je pourrais quand même m'en servir dans les fonctions appelées par ma fonction contenant la variable locale).

### Exemple :

Déclaration de la variable globale `first`

```bash
myFunc(){
    first="first"
    echo "Peux-tu print $first ?"
}

myFunc
echo "$first ! Est ce que ça a marché ?"
```
En sortie :

```bash
$./function.sh
Peux-tu print first ?
first ! Est ce que ça a marché ?
```

En revanche, si la variable `first` est locale :

```bash
myFunc(){
    local first="first"
    echo "Peux-tu print $first ?"
}

myFunc
echo "$first ! Est ce que ça a marché ?"
```
En sortie :

```bash
$./function.sh
Peux-tu print first ?
 ! Est ce que ça a marché ?
```
Ici, on n'a pas pu se servir de la variable en dehors de sa fonction.