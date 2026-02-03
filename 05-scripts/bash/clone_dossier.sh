#!/bin/bash

if [[ -d $1 ]]
then
    echo "Le chemin du répertoire source : $1 "
else
    echo "Le chemin du répertoire source est incorrect "

fi

if [[ -d $2 ]]
then
    echo "Le chemin du répertoires destination : $2 "
else
    mkdir $2
    echo "Creation du répertoire $2 "
fi

cp -R $1 $2

echo "Le Dossier $1 a bien était cloner au $2 "