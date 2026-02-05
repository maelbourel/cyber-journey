#!/bin/bash
#===============================================================================
# Script      : ex05_monitoring.sh
# Description : Analyse les logs Apache pour afficher les 10 IPs les plus fréquentes
#               Bonus: Analyse également les tentatives de connexion échouées (lastb)
# Usage       : ./ex05_monitoring.sh [fichier_log]
#               ./ex05_monitoring.sh --lastb
#===============================================================================

#-------------------------------------------------------------------------------
# Configuration par défaut
#-------------------------------------------------------------------------------
# Chemins possibles pour les fichiers de log Apache
CHEMINS_LOG_APACHE=(
    "/var/log/apache2/access.log"       # Debian/Ubuntu
    "/var/log/httpd/access_log"         # CentOS/RHEL
    "/var/log/apache/access.log"        # Autre variante
    "/var/log/apache2/other_vhosts_access.log"  # Vhosts Ubuntu
)

# Nombre d'adresses IP à afficher
TOP_N=10

#-------------------------------------------------------------------------------
# Couleurs pour l'affichage
#-------------------------------------------------------------------------------
ROUGE='\033[0;31m'
VERT='\033[0;32m'
JAUNE='\033[1;33m'
BLEU='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # Reset

#-------------------------------------------------------------------------------
# Fonction d'affichage de l'aide
#-------------------------------------------------------------------------------
afficher_aide() {
    echo "Usage: $0 [OPTIONS] [fichier_log]"
    echo ""
    echo "Description:"
    echo "  Analyse les fichiers de log pour afficher les adresses IP les plus fréquentes."
    echo ""
    echo "Options:"
    echo "  -n, --top <N>      Affiche les N adresses les plus fréquentes (défaut: 10)"
    echo "  -l, --lastb        Analyse les tentatives de connexion échouées (lastb)"
    echo "  -a, --all          Affiche toutes les IPs (pas de limite)"
    echo "  -h, --help         Affiche cette aide"
    echo ""
    echo "Arguments:"
    echo "  fichier_log        Chemin vers le fichier de log Apache à analyser"
    echo "                     (Si non spécifié, recherche automatique)"
    echo ""
    echo "Exemples:"
    echo "  $0                              # Recherche automatique du log Apache"
    echo "  $0 /var/log/apache2/access.log  # Fichier spécifique"
    echo "  $0 -n 20 access.log             # Top 20 des IPs"
    echo "  $0 --lastb                      # Analyse des connexions échouées"
    echo ""
    echo "Note: L'option --lastb nécessite les droits root (sudo)."
    exit 0
}

#-------------------------------------------------------------------------------
# Fonction pour rechercher automatiquement le fichier de log Apache
#-------------------------------------------------------------------------------
trouver_log_apache() {
    for chemin in "${CHEMINS_LOG_APACHE[@]}"; do
        if [[ -f "$chemin" ]] && [[ -r "$chemin" ]]; then
            echo "$chemin"
            return 0
        fi
    done
    return 1
}

#-------------------------------------------------------------------------------
# Fonction pour extraire les IPs d'un fichier de log Apache
# Format standard Apache: IP - - [date] "requête" code taille
#-------------------------------------------------------------------------------
extraire_ips_apache() {
    local fichier="$1"
    
    # Extraction de la première colonne (adresse IP)
    # Le format standard Apache commence par l'IP
    awk '{print $1}' "$fichier" | \
        # Filtre pour ne garder que les adresses IP valides (IPv4 et IPv6)
        grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$|^[0-9a-fA-F:]+$'
}

#-------------------------------------------------------------------------------
# Fonction pour compter et trier les IPs
#-------------------------------------------------------------------------------
compter_ips() {
    # Compte les occurrences, trie par nombre décroissant
    sort | uniq -c | sort -rn
}

#-------------------------------------------------------------------------------
# Fonction pour afficher les résultats de manière formatée
#-------------------------------------------------------------------------------
afficher_resultats() {
    local titre="$1"
    local limite="$2"
    
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║  $titre"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║  Rang │    Requêtes │ Adresse IP                            ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    
    local rang=0
    local total_affiche=0
    
    while read -r count ip; do
        ((rang++))
        
        # Vérification de la limite (si -1, pas de limite)
        if [[ "$limite" -ne -1 ]] && [[ "$rang" -gt "$limite" ]]; then
            break
        fi
        
        # Formatage de l'affichage avec alignement
        printf "║  %4d │ %11d │ %-37s ║\n" "$rang" "$count" "$ip"
        ((total_affiche++))
        
    done
    
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "  Total d'adresses affichées: $total_affiche"
}

#-------------------------------------------------------------------------------
# Fonction principale pour analyser les logs Apache
#-------------------------------------------------------------------------------
analyser_apache() {
    local fichier_log="$1"
    local limite="${2:-$TOP_N}"
    
    #---------------------------------------------------------------------------
    # Si aucun fichier n'est spécifié, recherche automatique
    #---------------------------------------------------------------------------
    if [[ -z "$fichier_log" ]]; then
        echo -e "${CYAN}Recherche du fichier de log Apache...${NC}"
        fichier_log=$(trouver_log_apache)
        
        if [[ -z "$fichier_log" ]]; then
            echo -e "${ROUGE}Erreur: Aucun fichier de log Apache trouvé.${NC}"
            echo "Chemins recherchés:"
            for chemin in "${CHEMINS_LOG_APACHE[@]}"; do
                echo "  - $chemin"
            done
            echo ""
            echo "Veuillez spécifier le chemin du fichier de log en argument."
            exit 2
        fi
    fi
    
    #---------------------------------------------------------------------------
    # Vérification du fichier
    #---------------------------------------------------------------------------
    if [[ ! -f "$fichier_log" ]]; then
        echo -e "${ROUGE}Erreur: Le fichier '$fichier_log' n'existe pas.${NC}"
        exit 3
    fi
    
    if [[ ! -r "$fichier_log" ]]; then
        echo -e "${ROUGE}Erreur: Impossible de lire '$fichier_log'.${NC}"
        echo "Essayez avec sudo."
        exit 4
    fi
    
    #---------------------------------------------------------------------------
    # Informations sur le fichier
    #---------------------------------------------------------------------------
    echo ""
    echo -e "${BLEU}══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLEU}       ANALYSE DES LOGS APACHE - TOP $limite IPs             ${NC}"
    echo -e "${BLEU}══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "Fichier analysé: $fichier_log"
    echo "Taille du fichier: $(du -h "$fichier_log" | cut -f1)"
    echo "Nombre total de lignes: $(wc -l < "$fichier_log")"
    
    #---------------------------------------------------------------------------
    # Extraction et comptage des IPs
    #---------------------------------------------------------------------------
    echo ""
    echo -e "${CYAN}Analyse en cours...${NC}"
    
    # Extraction des IPs, comptage et tri
    local resultats=$(extraire_ips_apache "$fichier_log" | compter_ips)
    
    # Nombre total d'IPs uniques
    local total_ips_uniques=$(echo "$resultats" | wc -l)
    echo "Nombre d'adresses IP uniques: $total_ips_uniques"
    
    #---------------------------------------------------------------------------
    # Affichage des résultats
    #---------------------------------------------------------------------------
    echo "$resultats" | afficher_resultats "TOP $limite ADRESSES IP - LOGS APACHE" "$limite"
}

#-------------------------------------------------------------------------------
# Fonction BONUS: Analyser les connexions échouées avec lastb
#-------------------------------------------------------------------------------
analyser_lastb() {
    local limite="${1:-$TOP_N}"
    
    echo ""
    echo -e "${BLEU}══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLEU}    ANALYSE DES TENTATIVES DE CONNEXION ÉCHOUÉES (lastb)     ${NC}"
    echo -e "${BLEU}══════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    #---------------------------------------------------------------------------
    # Vérification des droits root
    #---------------------------------------------------------------------------
    if [[ $EUID -ne 0 ]]; then
        echo -e "${JAUNE}Note: Cette commande nécessite les droits root pour accéder à /var/log/btmp${NC}"
        echo "Essayez: sudo $0 --lastb"
        echo ""
    fi
    
    #---------------------------------------------------------------------------
    # Vérification que lastb est disponible
    #---------------------------------------------------------------------------
    if ! command -v lastb &>/dev/null; then
        echo -e "${ROUGE}Erreur: La commande 'lastb' n'est pas disponible.${NC}"
        exit 5
    fi
    
    #---------------------------------------------------------------------------
    # Vérification du fichier btmp
    #---------------------------------------------------------------------------
    if [[ ! -f /var/log/btmp ]]; then
        echo -e "${ROUGE}Erreur: Le fichier /var/log/btmp n'existe pas.${NC}"
        echo "Ce fichier enregistre les tentatives de connexion échouées."
        exit 6
    fi
    
    #---------------------------------------------------------------------------
    # Exécution de lastb et extraction des IPs
    #---------------------------------------------------------------------------
    echo -e "${CYAN}Analyse des tentatives de connexion échouées...${NC}"
    echo ""
    
    # lastb affiche les tentatives de connexion échouées
    # Format: utilisateur terminal IP date
    # On extrait les IPs (3ème colonne pour les connexions SSH)
    
    local resultats=$(lastb 2>/dev/null | \
        # Filtrer les lignes vides et les lignes de résumé
        grep -v "^$" | grep -v "^btmp" | \
        # Extraire les adresses IP (généralement en 3ème colonne)
        awk '{print $3}' | \
        # Ne garder que les IPs valides
        grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | \
        # Compter et trier
        compter_ips)
    
    # Vérification des résultats
    if [[ -z "$resultats" ]]; then
        echo -e "${VERT}Aucune tentative de connexion échouée enregistrée.${NC}"
        echo "Ou les entrées ne contiennent pas d'adresses IP."
        return
    fi
    
    # Statistiques
    local total_tentatives=$(lastb 2>/dev/null | grep -v "^$" | grep -v "^btmp" | wc -l)
    local total_ips_uniques=$(echo "$resultats" | wc -l)
    
    echo "Nombre total de tentatives échouées: $total_tentatives"
    echo "Nombre d'adresses IP uniques: $total_ips_uniques"
    
    #---------------------------------------------------------------------------
    # Affichage des résultats
    #---------------------------------------------------------------------------
    echo "$resultats" | afficher_resultats "TOP $limite IPs - CONNEXIONS ÉCHOUÉES (lastb)" "$limite"
    
    #---------------------------------------------------------------------------
    # Informations supplémentaires sur les utilisateurs ciblés
    #---------------------------------------------------------------------------
    echo ""
    echo -e "${CYAN}Noms d'utilisateurs les plus ciblés:${NC}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    
    lastb 2>/dev/null | \
        grep -v "^$" | grep -v "^btmp" | \
        awk '{print $1}' | \
        sort | uniq -c | sort -rn | \
        head -n 5 | \
        while read -r count user; do
            printf "║  %8d tentatives │ %-37s ║\n" "$count" "$user"
        done
    
    echo "╚══════════════════════════════════════════════════════════════╝"
}

#-------------------------------------------------------------------------------
# Programme principal
#-------------------------------------------------------------------------------

# Variables pour les options
fichier_log=""
mode_lastb=false
limite=$TOP_N

# Traitement des arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            afficher_aide
            ;;
        -l|--lastb)
            mode_lastb=true
            shift
            ;;
        -n|--top)
            if [[ -n "$2" ]] && [[ "$2" =~ ^[0-9]+$ ]]; then
                limite="$2"
                shift 2
            else
                echo -e "${ROUGE}Erreur: -n nécessite un nombre.${NC}"
                exit 1
            fi
            ;;
        -a|--all)
            limite=-1
            shift
            ;;
        -*)
            echo -e "${ROUGE}Erreur: Option inconnue: $1${NC}"
            afficher_aide
            ;;
        *)
            fichier_log="$1"
            shift
            ;;
    esac
done

#-------------------------------------------------------------------------------
# Exécution selon le mode choisi
#-------------------------------------------------------------------------------
if [[ "$mode_lastb" == true ]]; then
    # Mode BONUS: analyse lastb
    analyser_lastb "$limite"
else
    # Mode normal: analyse logs Apache
    analyser_apache "$fichier_log" "$limite"
fi

exit 0
