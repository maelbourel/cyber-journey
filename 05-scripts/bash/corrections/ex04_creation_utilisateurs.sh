#!/bin/bash
#===============================================================================
# Script      : ex04_creation_utilisateurs.sh
# Description : Crée des utilisateurs système avec mot de passe aléatoire
# Usage       : ./ex04_creation_utilisateurs.sh <nom_utilisateur>
#               ./ex04_creation_utilisateurs.sh -f <fichier.csv>
# Note        : Ce script nécessite les droits root (sudo)
#===============================================================================

#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------
LONGUEUR_MDP=12          # Longueur du mot de passe généré
SHELL_DEFAUT="/bin/bash" # Shell par défaut pour les nouveaux utilisateurs

#-------------------------------------------------------------------------------
# Couleurs pour l'affichage (optionnel)
#-------------------------------------------------------------------------------
ROUGE='\033[0;31m'
VERT='\033[0;32m'
JAUNE='\033[1;33m'
NC='\033[0m' # No Color (reset)

#-------------------------------------------------------------------------------
# Fonction d'affichage de l'aide
#-------------------------------------------------------------------------------
afficher_aide() {
    echo "Usage: $0 <nom_utilisateur>"
    echo "       $0 -f <fichier.csv>"
    echo ""
    echo "Description:"
    echo "  Crée un nouvel utilisateur système avec un mot de passe aléatoire."
    echo ""
    echo "Options:"
    echo "  -f, --file <fichier.csv>  Crée plusieurs utilisateurs depuis un fichier CSV"
    echo "  -h, --help                Affiche cette aide"
    echo ""
    echo "Format du fichier CSV:"
    echo "  nom_utilisateur,nom_complet,groupe"
    echo "  (la première ligne d'en-tête est ignorée si elle commence par 'nom' ou '#')"
    echo ""
    echo "Exemples:"
    echo "  $0 jean"
    echo "  $0 -f utilisateurs.csv"
    echo ""
    echo "Note: Ce script nécessite les droits administrateur (sudo)."
    exit 1
}

#-------------------------------------------------------------------------------
# Fonction pour vérifier les droits root
#-------------------------------------------------------------------------------
verifier_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${ROUGE}Erreur: Ce script doit être exécuté en tant que root (sudo).${NC}"
        echo "Essayez: sudo $0 $*"
        exit 1
    fi
}

#-------------------------------------------------------------------------------
# Fonction pour générer un mot de passe aléatoire
#-------------------------------------------------------------------------------
generer_mot_de_passe() {
    local longueur="${1:-$LONGUEUR_MDP}"
    
    # Génération d'un mot de passe avec des caractères alphanumériques et spéciaux
    # On utilise /dev/urandom pour une meilleure entropie
    local mdp=$(tr -dc 'A-Za-z0-9!@#$%&*' < /dev/urandom | head -c "$longueur")
    
    # Fallback si /dev/urandom n'est pas disponible
    if [[ -z "$mdp" ]]; then
        mdp=$(openssl rand -base64 "$longueur" | head -c "$longueur" 2>/dev/null)
    fi
    
    # Dernier recours avec $RANDOM
    if [[ -z "$mdp" ]]; then
        mdp=""
        local chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%'
        for ((i = 0; i < longueur; i++)); do
            mdp+="${chars:RANDOM % ${#chars}:1}"
        done
    fi
    
    echo "$mdp"
}

#-------------------------------------------------------------------------------
# Fonction pour vérifier si un utilisateur existe déjà
#-------------------------------------------------------------------------------
utilisateur_existe() {
    local nom="$1"
    id "$nom" &>/dev/null
}

#-------------------------------------------------------------------------------
# Fonction pour créer un seul utilisateur
#-------------------------------------------------------------------------------
creer_utilisateur() {
    local nom_utilisateur="$1"
    local nom_complet="${2:-$nom_utilisateur}"  # Nom complet (optionnel)
    local groupe="${3:-}"                        # Groupe (optionnel)
    
    echo "----------------------------------------"
    echo "Création de l'utilisateur: $nom_utilisateur"
    
    #---------------------------------------------------------------------------
    # Vérification que le nom d'utilisateur est valide
    #---------------------------------------------------------------------------
    if [[ ! "$nom_utilisateur" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        echo -e "${ROUGE}  [ERREUR] Nom d'utilisateur invalide: $nom_utilisateur${NC}"
        echo "  Le nom doit commencer par une lettre minuscule et contenir"
        echo "  uniquement des lettres minuscules, chiffres, tirets ou underscores."
        return 1
    fi
    
    #---------------------------------------------------------------------------
    # Vérification si l'utilisateur existe déjà
    #---------------------------------------------------------------------------
    if utilisateur_existe "$nom_utilisateur"; then
        echo -e "${JAUNE}  [ATTENTION] L'utilisateur '$nom_utilisateur' existe déjà.${NC}"
        return 2
    fi
    
    #---------------------------------------------------------------------------
    # Génération du mot de passe aléatoire
    #---------------------------------------------------------------------------
    local mot_de_passe=$(generer_mot_de_passe)
    
    #---------------------------------------------------------------------------
    # Création de l'utilisateur avec useradd
    #---------------------------------------------------------------------------
    # Options useradd:
    #   -m : crée le répertoire personnel
    #   -s : définit le shell par défaut
    #   -c : commentaire (nom complet)
    #   -G : groupe(s) supplémentaire(s)
    
    local options_useradd="-m -s $SHELL_DEFAUT -c \"$nom_complet\""
    
    # Ajout du groupe si spécifié et s'il existe
    if [[ -n "$groupe" ]]; then
        if getent group "$groupe" &>/dev/null; then
            options_useradd+=" -G $groupe"
        else
            echo -e "${JAUNE}  [ATTENTION] Le groupe '$groupe' n'existe pas. Ignoré.${NC}"
        fi
    fi
    
    # Exécution de useradd
    if eval useradd $options_useradd "$nom_utilisateur" 2>/dev/null; then
        echo -e "${VERT}  [OK] Utilisateur créé avec succès.${NC}"
    else
        echo -e "${ROUGE}  [ERREUR] Échec de la création de l'utilisateur.${NC}"
        return 3
    fi
    
    #---------------------------------------------------------------------------
    # Attribution du mot de passe
    #---------------------------------------------------------------------------
    # Utilisation de chpasswd pour définir le mot de passe
    echo "$nom_utilisateur:$mot_de_passe" | chpasswd
    
    if [[ $? -eq 0 ]]; then
        echo -e "${VERT}  [OK] Mot de passe défini avec succès.${NC}"
    else
        echo -e "${ROUGE}  [ERREUR] Échec de la définition du mot de passe.${NC}"
        return 4
    fi
    
    #---------------------------------------------------------------------------
    # Forcer le changement de mot de passe à la première connexion (optionnel)
    #---------------------------------------------------------------------------
    chage -d 0 "$nom_utilisateur" 2>/dev/null
    
    #---------------------------------------------------------------------------
    # Affichage des informations
    #---------------------------------------------------------------------------
    echo ""
    echo "  ┌─────────────────────────────────────────────┐"
    echo "  │ INFORMATIONS DU NOUVEL UTILISATEUR          │"
    echo "  ├─────────────────────────────────────────────┤"
    echo "  │ Nom d'utilisateur : $nom_utilisateur"
    echo "  │ Mot de passe      : $mot_de_passe"
    echo "  │ Répertoire home   : /home/$nom_utilisateur"
    echo "  │ Shell             : $SHELL_DEFAUT"
    [[ -n "$nom_complet" ]] && echo "  │ Nom complet       : $nom_complet"
    [[ -n "$groupe" ]] && echo "  │ Groupe            : $groupe"
    echo "  └─────────────────────────────────────────────┘"
    echo ""
    echo -e "  ${JAUNE}⚠ IMPORTANT: Notez ce mot de passe, il ne sera plus affiché !${NC}"
    echo -e "  ${JAUNE}  L'utilisateur devra changer son mot de passe à la première connexion.${NC}"
    
    return 0
}

#-------------------------------------------------------------------------------
# Fonction pour créer des utilisateurs depuis un fichier CSV (BONUS)
#-------------------------------------------------------------------------------
creer_depuis_csv() {
    local fichier_csv="$1"
    
    # Vérification que le fichier existe
    if [[ ! -f "$fichier_csv" ]]; then
        echo -e "${ROUGE}Erreur: Le fichier '$fichier_csv' n'existe pas.${NC}"
        exit 2
    fi
    
    # Vérification que le fichier n'est pas vide
    if [[ ! -s "$fichier_csv" ]]; then
        echo -e "${ROUGE}Erreur: Le fichier '$fichier_csv' est vide.${NC}"
        exit 3
    fi
    
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║     CRÉATION D'UTILISATEURS DEPUIS UN FICHIER CSV           ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Fichier source: $fichier_csv"
    
    # Compteurs
    local total=0
    local succes=0
    local echecs=0
    local ignores=0
    
    # Lecture du fichier CSV ligne par ligne
    while IFS=',' read -r nom_utilisateur nom_complet groupe || [[ -n "$nom_utilisateur" ]]; do
        # Suppression des espaces en début/fin et des retours chariot
        nom_utilisateur=$(echo "$nom_utilisateur" | tr -d '\r' | xargs)
        nom_complet=$(echo "$nom_complet" | tr -d '\r' | xargs)
        groupe=$(echo "$groupe" | tr -d '\r' | xargs)
        
        # Ignorer les lignes vides
        [[ -z "$nom_utilisateur" ]] && continue
        
        # Ignorer les lignes de commentaires et d'en-tête
        [[ "$nom_utilisateur" =~ ^[#] ]] && continue
        [[ "$nom_utilisateur" =~ ^[nN]om ]] && continue
        
        ((total++))
        
        # Création de l'utilisateur
        if creer_utilisateur "$nom_utilisateur" "$nom_complet" "$groupe"; then
            ((succes++))
        else
            code_retour=$?
            if [[ $code_retour -eq 2 ]]; then
                ((ignores++))
            else
                ((echecs++))
            fi
        fi
        
    done < "$fichier_csv"
    
    #---------------------------------------------------------------------------
    # Affichage du résumé
    #---------------------------------------------------------------------------
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                      RÉSUMÉ                                  ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║  Total d'entrées traitées : $total"
    echo "║  Utilisateurs créés       : $succes"
    echo "║  Utilisateurs ignorés     : $ignores (existaient déjà)"
    echo "║  Erreurs                  : $echecs"
    echo "╚══════════════════════════════════════════════════════════════╝"
}

#-------------------------------------------------------------------------------
# Programme principal
#-------------------------------------------------------------------------------

# Vérification qu'au moins un argument est fourni
if [[ $# -lt 1 ]]; then
    afficher_aide
fi

# Vérification des droits root
verifier_root "$@"

# Traitement des arguments
case "$1" in
    -h|--help)
        afficher_aide
        ;;
    -f|--file)
        # Mode fichier CSV (BONUS)
        if [[ -z "$2" ]]; then
            echo -e "${ROUGE}Erreur: Veuillez spécifier un fichier CSV.${NC}"
            afficher_aide
        fi
        creer_depuis_csv "$2"
        ;;
    -*)
        echo -e "${ROUGE}Erreur: Option inconnue: $1${NC}"
        afficher_aide
        ;;
    *)
        # Mode création d'un seul utilisateur
        echo "╔══════════════════════════════════════════════════════════════╗"
        echo "║          CRÉATION D'UN NOUVEL UTILISATEUR                   ║"
        echo "╚══════════════════════════════════════════════════════════════╝"
        creer_utilisateur "$1"
        ;;
esac

exit 0
