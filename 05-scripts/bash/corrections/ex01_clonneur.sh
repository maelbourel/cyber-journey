#!/bin/bash
#===============================================================================
# Script      : ex01_clonneur.sh
# Description : Clone le contenu d'un répertoire source vers un répertoire cible
# Usage       : ./ex01_clonneur.sh <répertoire_source> <répertoire_cible>
#===============================================================================

#-------------------------------------------------------------------------------
# Fonction d'affichage de l'aide
#-------------------------------------------------------------------------------
afficher_aide() {
    echo "Usage: $0 <répertoire_source> <répertoire_cible>"
    echo ""
    echo "Description:"
    echo "  Copie tous les fichiers du répertoire source vers le répertoire cible."
    echo "  Si le répertoire cible n'existe pas, il sera créé automatiquement."
    echo ""
    echo "Arguments:"
    echo "  répertoire_source  : Chemin du répertoire contenant les fichiers à copier"
    echo "  répertoire_cible   : Chemin du répertoire de destination"
    exit 1
}

#-------------------------------------------------------------------------------
# Vérification du nombre d'arguments
#-------------------------------------------------------------------------------
if [[ $# -ne 2 ]]; then
    echo "Erreur: Nombre d'arguments incorrect."
    afficher_aide
fi

# Récupération des arguments
repertoire_source="$1"
repertoire_cible="$2"

#-------------------------------------------------------------------------------
# Vérification que le répertoire source existe
#-------------------------------------------------------------------------------
if [[ ! -d "$repertoire_source" ]]; then
    echo "Erreur: Le répertoire source '$repertoire_source' n'existe pas."
    exit 2
fi

#-------------------------------------------------------------------------------
# Vérification que le répertoire source n'est pas vide
#-------------------------------------------------------------------------------
if [[ -z "$(ls -A "$repertoire_source" 2>/dev/null)" ]]; then
    echo "Attention: Le répertoire source '$repertoire_source' est vide."
fi

#-------------------------------------------------------------------------------
# Création du répertoire cible s'il n'existe pas
#-------------------------------------------------------------------------------
if [[ ! -d "$repertoire_cible" ]]; then
    echo "Le répertoire cible '$repertoire_cible' n'existe pas."
    echo "Création du répertoire..."
    
    # Création du répertoire avec les répertoires parents si nécessaire (-p)
    if mkdir -p "$repertoire_cible"; then
        echo "Répertoire '$repertoire_cible' créé avec succès."
    else
        echo "Erreur: Impossible de créer le répertoire '$repertoire_cible'."
        exit 3
    fi
fi

#-------------------------------------------------------------------------------
# Copie des fichiers du répertoire source vers le répertoire cible
#-------------------------------------------------------------------------------
echo ""
echo "Début de la copie de '$repertoire_source' vers '$repertoire_cible'..."
echo "----------------------------------------"

# Compteur de fichiers copiés
fichiers_copies=0
erreurs=0

# Parcours de tous les éléments du répertoire source
for element in "$repertoire_source"/*; do
    # Vérification que l'élément existe (gestion du cas où le répertoire est vide)
    if [[ -e "$element" ]]; then
        # Récupération du nom de l'élément
        nom_element=$(basename "$element")
        
        # Copie de l'élément (fichier ou dossier avec -r pour récursif)
        if cp -r "$element" "$repertoire_cible/"; then
            echo "  [OK] Copié: $nom_element"
            ((fichiers_copies++))
        else
            echo "  [ERREUR] Échec de la copie: $nom_element"
            ((erreurs++))
        fi
    fi
done

#-------------------------------------------------------------------------------
# Affichage du résumé
#-------------------------------------------------------------------------------
echo "----------------------------------------"
echo "Copie terminée!"
echo "  - Éléments copiés avec succès: $fichiers_copies"
echo "  - Erreurs: $erreurs"

# Code de sortie basé sur le nombre d'erreurs
if [[ $erreurs -gt 0 ]]; then
    exit 4
fi

exit 0
