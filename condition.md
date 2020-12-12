# Les conditions

#### Il est préférable d'avoir vu  le [premier script](./premier_script.md) avant de commencer, car il permet de poser les bases sur l'exécution et l'écriture d'un script.

----

#### Dans cette partie, nous allons voir pas mal de chose :
#### - [Les conditions basiques `if`, ``else``, ``elif``](./condition#les-conditions-basiques)


---
## Les conditions basiques

Dans un premier temps, on va voir comment se forme les conditions en `bash`.

### la condition ``if``

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

### la condition `else`

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

Exemple :

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

Si je met en paramètre "12" :
```bash
$./test.sh 12
Le nombre est 12
$
```
En revanche si je met autre chose qu'un 12 :

```bash
$./test.sh 13
Ce n'est pas un douze
$
```