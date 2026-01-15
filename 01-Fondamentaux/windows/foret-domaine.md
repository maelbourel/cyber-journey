# 🪟 Active Directory – Forêt & Domaine

## 🔹 Pourquoi ces notions existent ?

Active Directory doit pouvoir :
- gérer une grande organisation
- séparer les responsabilités
- sécuriser les accès
tout en restant centralisé.

## 🔹 Domaine (Domain)

### Définition

Un domaine est une unité administrative et de sécurité dans Active Directory.

Il permet de :
- gérer les utilisateurs
- gérer les ordinateurs
- appliquer des GPO
- authentifier les accès

Exemple :
entreprise.local

### Caractéristiques d’un domaine

- possède au moins un Domain Controller
- base d’utilisateurs propre
- politiques de sécurité spécifiques
- frontières de sécurité (partielles)

## 🔹 Forêt (Forest)

### Définition

Une forêt est le **plus haut niveau logique** d’Active Directory.

Elle regroupe :
- un ou plusieurs domaines
- partageant une même configuration AD

### Rôle de la forêt

- limite de sécurité principale
- partage du schéma AD
- catalogue global
- relations de confiance internes

## 🔹 Relation Forêt ↔ Domaine

- Une forêt contient **au moins un domaine**
- Tous les domaines d’une forêt se font confiance par défaut
- La forêt définit les règles globales

## 🔹 Exemple concret

Entreprise internationale :

Forêt : `corp.local`

- Domaine racine : `corp.local`
- Domaine enfant : `eu.corp.local`
- Domaine enfant : `us.corp.local`

## 🔹 Forêt = frontière de sécurité

⚠️ Point clé AIS :
> Si la forêt est compromise, **tous les domaines le sont**.

## 🔹 Sécurité (AIS)

- protéger les Domain Controllers
- limiter les droits forestiers
- surveiller les comptes Enterprise Admin
- journaliser les actions critiques


## 🔹 Rôles critiques liés à la forêt

- Schema Master
- Enterprise Admin
- Global Catalog
 