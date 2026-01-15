# 🐧 Linux – Permissions

## 🔹 Principe

Les permissions contrôlent qui peut :
- lire (r)
- écrire (w)
- exécuter (x)
un fichier ou un dossier.


## 🔹 Les 3 types d’utilisateurs

- propriétaire (user)
- groupe (group)
- autres (others)


## 🔹 Représentation

Exemple :
-rwxr-x---

| Partie | Signification |
|-----|--------------|
| - | fichier |
| rwx | propriétaire |
| r-x | groupe |
| --- | autres |


## 🔹 Valeurs numériques

| Permission | Valeur |
|-----------|-------|
| r | 4 |
| w | 2 |
| x | 1 |

Exemple :
chmod 750 fichier

## 🔹 Commandes clés

- ls -l
- chmod
- chown
- chgrp


## 🔹 Permissions spéciales

- SUID
- SGID
- Sticky bit

⚠️ Risque de privilèges excessifs.


## 🔹 Sécurité (AIS)

- principe du moindre privilège
- permissions trop larges = risque
- malware via SUID


 