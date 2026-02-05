#!/bin/bash
#===============================================================================
# Script      : ex03_plus_ou_moins.sh
# Description : Jeu de devinette - trouver un nombre aléatoire entre 1 et 100
# Usage       : ./ex03_plus_ou_moins.sh
#===============================================================================

#-------------------------------------------------------------------------------
# Configuration du jeu
#-------------------------------------------------------------------------------
NOMBRE_MIN=1
NOMBRE_MAX=100

#-------------------------------------------------------------------------------
# Fonction pour afficher le titre du jeu
#-------------------------------------------------------------------------------
afficher_titre() {
    clear
    echo "╔══════════════════════════════════════════╗"
    echo "║           JEU DU PLUS OU MOINS           ║"
    echo "╠══════════════════════════════════════════╣"
    echo "║  Devinez le nombre entre $NOMBRE_MIN et $NOMBRE_MAX !     ║"
    echo "║  Tapez 'q' pour quitter                  ║"
    echo "╚══════════════════════════════════════════╝"
    echo ""
}

#-------------------------------------------------------------------------------
# Fonction pour vérifier si l'entrée est un nombre valide
#-------------------------------------------------------------------------------
est_un_nombre() {
    local input="$1"
    # Vérifie si l'entrée est un nombre entier (positif ou négatif)
    [[ "$input" =~ ^-?[0-9]+$ ]]
}

#-------------------------------------------------------------------------------
# Fonction principale du jeu
#-------------------------------------------------------------------------------
jouer() {
    # Génération d'un nombre aléatoire entre NOMBRE_MIN et NOMBRE_MAX
    # $RANDOM génère un nombre entre 0 et 32767
    local nombre_secret=$(( (RANDOM % NOMBRE_MAX) + NOMBRE_MIN ))
    
    # Initialisation du compteur d'essais
    local essais=0
    
    # Variable pour stocker la proposition du joueur
    local proposition
    
    echo "J'ai choisi un nombre entre $NOMBRE_MIN et $NOMBRE_MAX."
    echo "À vous de le deviner !"
    echo ""
    
    #---------------------------------------------------------------------------
    # Boucle principale du jeu
    #---------------------------------------------------------------------------
    while true; do
        # Demande de saisie
        read -p "Votre proposition: " proposition
        
        # Vérification si le joueur veut quitter
        if [[ "$proposition" == "q" ]] || [[ "$proposition" == "Q" ]]; then
            echo ""
            echo "Dommage ! Le nombre était: $nombre_secret"
            echo "Vous aviez fait $essais essai(s)."
            return 1
        fi
        
        # Vérification que l'entrée est un nombre
        if ! est_un_nombre "$proposition"; then
            echo "  ⚠ Veuillez entrer un nombre valide (ou 'q' pour quitter)."
            continue
        fi
        
        # Vérification que le nombre est dans la plage valide
        if [[ "$proposition" -lt "$NOMBRE_MIN" ]] || [[ "$proposition" -gt "$NOMBRE_MAX" ]]; then
            echo "  ⚠ Le nombre doit être entre $NOMBRE_MIN et $NOMBRE_MAX."
            continue
        fi
        
        # Incrémentation du compteur d'essais
        ((essais++))
        
        #-----------------------------------------------------------------------
        # Comparaison avec le nombre secret
        #-----------------------------------------------------------------------
        if [[ "$proposition" -lt "$nombre_secret" ]]; then
            # Le nombre proposé est trop petit
            echo "  ↑ C'est PLUS ! (essai n°$essais)"
            
        elif [[ "$proposition" -gt "$nombre_secret" ]]; then
            # Le nombre proposé est trop grand
            echo "  ↓ C'est MOINS ! (essai n°$essais)"
            
        else
            # Le joueur a trouvé le nombre !
            echo ""
            echo "╔══════════════════════════════════════════╗"
            echo "║            🎉 BRAVO ! 🎉                 ║"
            echo "╚══════════════════════════════════════════╝"
            echo ""
            echo "Vous avez trouvé le nombre $nombre_secret !"
            echo "Nombre d'essais: $essais"
            
            # Message selon la performance
            if [[ $essais -le 5 ]]; then
                echo "Excellent ! Vous êtes un champion !"
            elif [[ $essais -le 7 ]]; then
                echo "Très bien joué !"
            elif [[ $essais -le 10 ]]; then
                echo "Bien joué !"
            else
                echo "Vous y êtes arrivé, c'est l'essentiel !"
            fi
            
            return 0
        fi
    done
}

#-------------------------------------------------------------------------------
# Fonction pour demander si le joueur veut rejouer
#-------------------------------------------------------------------------------
demander_rejouer() {
    local reponse
    echo ""
    read -p "Voulez-vous rejouer ? (o/n): " reponse
    
    case "$reponse" in
        [oOyY]|[oO][uU][iI]|[yY][eE][sS])
            return 0  # Oui, rejouer
            ;;
        *)
            return 1  # Non, quitter
            ;;
    esac
}

#-------------------------------------------------------------------------------
# Programme principal
#-------------------------------------------------------------------------------

# Affichage du titre
afficher_titre

# Boucle pour permettre de rejouer
while true; do
    # Lancement d'une partie
    jouer
    
    # Demande si le joueur veut rejouer
    if ! demander_rejouer; then
        echo ""
        echo "Merci d'avoir joué ! À bientôt !"
        echo ""
        break
    fi
    
    # Nouvelle partie
    echo ""
    echo "════════════════════════════════════════════"
    echo "          NOUVELLE PARTIE !"
    echo "════════════════════════════════════════════"
    echo ""
done

exit 0
