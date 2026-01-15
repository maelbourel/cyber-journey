# 🐧 Linux – Utilisateurs & Groupes

## 🔹 Principe

Linux est un système multi-utilisateur.
Chaque action est exécutée par un utilisateur appartenant à un ou plusieurs groupes.

## 🔹 Types d’utilisateurs

- root : super-administrateur
- utilisateurs standards
- utilisateurs système (services)

## 🔹 Fichiers importants

| Fichier | Rôle |
|------|----|
| /etc/passwd | liste des utilisateurs |
| /etc/shadow | mots de passe chiffrés |
| /etc/group | groupes |

## 🔹 Commandes essentielles

- useradd
- userdel
- usermod
- groupadd
- groups
- id

---

## 🔹 sudo
Permet à un utilisateur d’exécuter des commandes avec des privilèges élevés.

⚠️ À limiter strictement.


## 🔹 Sécurité (AIS)

- principe du moindre privilège
- audit des comptes
- comptes inutiles = risque
- éviter connexions directes root
 