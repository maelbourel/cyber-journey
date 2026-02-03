#!/bin/bash

if [[ -d $1 ]]
then
    echo "Compression de $1 "
    date=$(date +"%Y-%m-%d_%H-%M")
    tar -czf ${date}.tar.gz $1

else
    echo "Le dossier $1 n'existe pas "
    echo "Impossible a compresser"

fi




