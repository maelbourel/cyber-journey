# 🪟 Active Directory – OU, Utilisateurs & Groupes

## 🔹 Unités Organisationnelles (OU)

### Définition

Une OU est un conteneur logique dans Active Directory permettant de :
- organiser les objets
- déléguer l’administration
- appliquer des GPO ciblées

### Pourquoi utiliser des OU ?

- structure claire
- meilleure sécurité
- délégation des droits

### Exemple d’OU

Entreprise  
├── Utilisateurs  
│ ├── RH  
│ └── IT  
├── Ordinateurs  
│ ├── Postes  
│ └── Serveurs  

## 🔹 Utilisateurs AD

### Types

- utilisateurs standards
- comptes administrateurs
- comptes de service

### Bonnes pratiques

- 1 utilisateur = 1 compte
- pas de compte admin permanent
- comptes de service limités

## 🔹 Groupes AD

### Types de groupes

| Type | Usage |
|----|-----|
| Sécurité | droits d’accès |
| Distribution | email |

### Portée des groupes

| Portée | Rôle |
|-----|-----|
| Domaine local | ressources locales |
| Global | utilisateurs |
| Universel | multi-domaines |

## 🔹 Sécurité (AIS)

- droits via groupes, pas utilisateurs
- limiter groupes à privilèges
- surveiller Admins du domaine

 