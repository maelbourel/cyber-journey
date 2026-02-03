#!/bin/bash

while true; do 

    echo "============================="
    echo "     PANNEAU DE CONTROLE     "
    echo "============================="
    echo "1) Cloner un Dossier"
    echo "2) Faire une Sauvegarde"
    echo "3) Créer un utilisateur"
    echo "4) Supprimer un utilisateur"
    echo "5) EXIT"
    echo "============================="
    echo "Choisissez une option : "
    read choix

    case $choix in
        1)
            echo "Veuillez renseigner le chemin du dossier a cloner : "
            read variable1
            echo "Veuillez renseigner le chemin ou le cloner : "
            read variable2
            ./clone_dossier.sh $variable1 $variable2
            sleep 2
            ;;

        2)
            echo "Veuillez renseigner le dossier a sauvegarder : "
            read variable1
            ./sauvegarde.sh $variable1
             sleep 2
            ;;

        3)
            echo "Veuillez rentrer le nom de l'utilisateur que vous voulez crée : "
            read variable1
            sudo ./creation_utilisateur.sh $variable1
             sleep 2
            ;;

        4)
            echo "Veuillez rentrer le nom de l'utilisateur que vous voulez supprimer : "
            read variable1
            sudo ./suppression_utilisateur.sh $variable1
             sleep 2
            ;;

        5)
            echo "En revoir"
            break
            ;;

        *)
            echo "Option invalide, veuillez réessayer"
            ;;

    esac
done