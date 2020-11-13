---
title: "Devoirs pour le Vendredi 13/11/2020"
tags: ""
---

## TreeView Directory Hierarchy LINUX

```
\
├── bin
|   ├── cd
|   ├── nano
|   ├── mv
|   └── ...      //contient les commandes de LINUX
|
├── home
|   ├── lost+found     // ne peut pas être ouvert
|   └── osboxes        // nom de l'utilisateur
|       ├── Desktop
|       ├── Documents
|       └── ...        // contient fichiers perso du user
|
├── root  // répertoire admin système
|
├── sys   // fonctionnalité système
|   ├── block
|   ├── bus
|   ├── class
|   ├── dev
|   ├── device
|   ├── firmware
|   ├── fs
|   ├── hypervisor
|   ├── kernel
|   ├── module
|   └── power
|
├── boot   // système pour le lancement
|   ├── grub
|   └── ... -amd64
|
├── mnt
|
├── run    // fichiers pour l'execution
|   ├── alsa
|   ├── cup
|   └── ...
|
├── tmp
|   └── ...  // Fichiers temporaires
|
├── dev      //périphériques
|   ├── stdin
|   ├── stdout
|   ├── cdrom
|   └── ...
|
├── usr
|   ├── bin
|   ├── games
|   ├── include
|   ├── lib
|   ├── lib32
|   ├── lib64
|   ├── libexec
|   ├── libx32
|   ├── local
|   ├── sbin
|   ├── share
|   └── src
|
├── etc   //configuration système
|   ├── sudoers
|   ├── sudoers.d
|   └── ...
|
├── proc
|   └── ... // tous les fichiers temp de processus
|
└── var // données variables

```

## Histoire de LINUX

-   ### les années 1970

    #### Création du système UNIX par AT&T:

    En 1969, Ken Thompson qui travaillait alors pour les laboratoires Bell développa la première version d'un système d'exploitation mono-utilisateur sous le nom de New Ken's System. (Ensuite sera nommé UNIX et breveté par AT&T)

    Dès la fin de l'année 1977, des chercheurs de l'université de Californie apportèrent de nombreuses améliorations au système Unix et le distribuèrent sous le nom de Berkeley Software Distribution (BSD). Finalement, les distributions BSD furent purgées du code AT&T, et librement disponibles en 1991.

-   ### 1983

      En 1983, Richard Stallman annonce son projet de développer un système d'exploitation libre compatible UNIX appelé GNU
      

-   ### 1991
      En 1991, l’étudiant finlandais Linus Torvalds, indisposé par la faible disponibilité du serveur informatique UNIX, entreprend le développement d’un noyau de système d'exploitation, qui prendra le nom de « noyau Linux ».
      Le 25 août 1991, il annonce sur le forum Usenet, le développement du noyau Linux.
    #### Linus Torvalds choisit rapidement de publier son noyau sous licence GNU GPL. Cette décision rend compatibles juridiquement les systèmes GNU et Linux. Dès lors, pour combler le vide causé par le développement inachevé de Hurd, GNU et le noyau Linux sont associés pour former un nouveau système d'exploitation (parfois considéré comme variante de GNU) : GNU/Linux ou Linux.

## Sources

<https://fr.wikipedia.org/wiki/Unix>

<https://www.debian.org/releases/stable/s390x/apcs02.fr.html>
