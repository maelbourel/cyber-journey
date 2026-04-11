
# Procédure d'installation des outils RSAT

## Pour un Windows 10 

Allez dans Paramètre > Application > Fonctionnalités facultative > Ajouter une fonctionnalités 

Et dans la barre de recherche taper RSAT et installer ```RSAT : outils Active Directory Domain Service``` et ```RSAT : outils de gestion de stratégie de groupe```  

Ouvrir une console ```mmc```  
Cliquer sur Fichier > Ajouter des composants logiciels enfichables (Ctrl+M)  
Ajouter les composant suivant : 

- Utilisateur et ordinateur Active Directory 
- Gestion des stratégies de groupe   

On a maintenant accès au outils RSAT pour contrôlez le Domains


## Pour un Windows 11

Via Powershell en Administrateur

```powershell
# Gestionnaire de Serveur (pas nécessaire ?)
Add-WindowsCapability -Online -Name "Rsat.ServerManager.Tools~~~~0.0.1.0"

# RSAT : outils Active Directory Domain Services Directory et services LDS
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"

# RSAT : outils de gestion de stratégie de groupe
Add-WindowsCapability -Online -Name "Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0"
```
