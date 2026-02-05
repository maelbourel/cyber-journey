#!/bin/bash
#===============================================================================
# Script      : ex02_sauvegarde.sh
# Description : Génère une archive tar.gz d'un répertoire avec la date actuelle
# Usage       : ./ex02_sauvegarde.sh <répertoire_à_sauvegarder> [répertoire_destination]
#===============================================================================

#-------------------------------------------------------------------------------
# Fonction d'affichage de l'aide
#-------------------------------------------------------------------------------
afficher_aide() {
    echo "Usage: $0 <répertoire_à_sauvegarder> [répertoire_destination]"
    echo ""
    echo "Description:"
    echo "  Crée une archive tar.gz du répertoire spécifié."
    echo "  Le nom de l'archive inclut la date et l'heure actuelles."
    echo ""
    echo "Arguments:"
    echo "  répertoire_à_sauvegarder : Chemin du répertoire à archiver"
    echo "  répertoire_destination   : (Optionnel) Où placer l'archive"
    echo "                             Par défaut: répertoire courant"
    echo ""
    echo "Exemple:"
    echo "  $0 /home/user/documents /backup"
    echo "  -> Crée: /backup/documents_2024-01-15_14h30m45s.tar.gz"
    exit 1
}

#-------------------------------------------------------------------------------
# Vérification du nombre d'arguments
#-------------------------------------------------------------------------------
if [[ $# -lt 1 ]] || [[ $# -gt 2 ]]; then
    echo "Erreur: Nombre d'arguments incorrect."
    afficher_aide
fi

# Récupération des arguments
repertoire_source="$1"
repertoire_destination="${2:-.}"  # Par défaut: répertoire courant

#-------------------------------------------------------------------------------
# Vérification que le répertoire source existe
#-------------------------------------------------------------------------------
if [[ ! -d "$repertoire_source" ]]; then
    echo "Erreur: Le répertoire '$repertoire_source' n'existe pas."
    exit 2
fi

#-------------------------------------------------------------------------------
# Vérification/création du répertoire de destination
#-------------------------------------------------------------------------------
if [[ ! -d "$repertoire_destination" ]]; then
    echo "Le répertoire de destination '$repertoire_destination' n'existe pas."
    echo "Création du répertoire..."
    
    if mkdir -p "$repertoire_destination"; then
        echo "Répertoire créé avec succès."
    else
        echo "Erreur: Impossible de créer le répertoire de destination."
        exit 3
    fi
fi

#-------------------------------------------------------------------------------
# Génération du nom de l'archive avec la date actuelle
#-------------------------------------------------------------------------------
# Récupération du nom du répertoire source (sans le chemin)
nom_repertoire=$(basename "$repertoire_source")

# Génération de la date au format: AAAA-MM-JJ_HHhMMmSSs
date_actuelle=$(date +"%Y-%m-%d_%Hh%Mm%Ss")

# Construction du nom complet de l'archive
nom_archive="${nom_repertoire}_${date_actuelle}.tar.gz"
chemin_archive="${repertoire_destination}/${nom_archive}"

#-------------------------------------------------------------------------------
# Vérification de l'espace disque disponible (approximatif)
#-------------------------------------------------------------------------------
# Calcul de la taille du répertoire source en Ko
taille_source=$(du -sk "$repertoire_source" 2>/dev/null | cut -f1)

# Espace disponible dans le répertoire de destination en Ko
espace_disponible=$(df -k "$repertoire_destination" 2>/dev/null | tail -1 | awk '{print $4}')

if [[ -n "$taille_source" ]] && [[ -n "$espace_disponible" ]]; then
    # Vérification (avec une marge car tar.gz compresse)
    if [[ "$espace_disponible" -lt "$taille_source" ]]; then
        echo "Attention: L'espace disque pourrait être insuffisant."
        echo "  Taille source: ~$((taille_source / 1024)) Mo"
        echo "  Espace disponible: ~$((espace_disponible / 1024)) Mo"
    fi
fi

#-------------------------------------------------------------------------------
# Création de l'archive tar.gz
#-------------------------------------------------------------------------------
echo ""
echo "Création de l'archive de sauvegarde..."
echo "  Source: $repertoire_source"
echo "  Destination: $chemin_archive"
echo "----------------------------------------"

# Options tar:
#   -c : créer une nouvelle archive
#   -z : compresser avec gzip
#   -v : mode verbeux (affiche les fichiers)
#   -f : spécifie le nom du fichier archive
#   -C : change de répertoire avant l'archivage (pour éviter les chemins absolus)

# Récupération du répertoire parent pour l'option -C
repertoire_parent=$(dirname "$repertoire_source")

if tar -czvf "$chemin_archive" -C "$repertoire_parent" "$nom_repertoire"; then
    echo "----------------------------------------"
    echo ""
    echo "Archive créée avec succès!"
    
    # Affichage des informations sur l'archive
    taille_archive=$(du -h "$chemin_archive" | cut -f1)
    echo ""
    echo "Informations sur l'archive:"
    echo "  Nom    : $nom_archive"
    echo "  Chemin : $chemin_archive"
    echo "  Taille : $taille_archive"
    echo "  Date   : $(date +"%d/%m/%Y à %H:%M:%S")"
else
    echo "----------------------------------------"
    echo "Erreur: La création de l'archive a échoué."
    
    # Suppression de l'archive partielle si elle existe
    [[ -f "$chemin_archive" ]] && rm -f "$chemin_archive"
    
    exit 4
fi

#-------------------------------------------------------------------------------
# Vérification de l'intégrité de l'archive
#-------------------------------------------------------------------------------
echo ""
echo "Vérification de l'intégrité de l'archive..."

if tar -tzf "$chemin_archive" > /dev/null 2>&1; then
    echo "  [OK] L'archive est valide et peut être extraite."
else
    echo "  [ERREUR] L'archive semble corrompue!"
    exit 5
fi

exit 0
