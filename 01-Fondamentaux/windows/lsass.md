# 🪟 Windows – LSASS

## 🔹 Qu’est-ce que LSASS ?

LSASS (Local Security Authority Subsystem Service) gère :
- authentification
- stockage des secrets en mémoire


## 🔹 Pourquoi c’est critique ?

- contient mots de passe / hashes
- cible d’outils comme Mimikatz

## 🔹 Attaques

- dump mémoire LSASS
- récupération credentials

## 🔹 Défenses

- Credential Guard
- protection du processus
- limiter droits admin
