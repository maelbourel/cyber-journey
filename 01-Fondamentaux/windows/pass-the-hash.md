# 🪟 Windows – Pass-the-Hash

## 🔹 Principe

Attaque permettant d’utiliser un hash de mot de passe sans connaître le mot de passe en clair.

## 🔹 Contexte

- machines jointes au domaine
- NTLM utilisé

## 🔹 Étapes générales

1. récupération du hash
2. réutilisation pour s’authentifier
3. mouvement latéral

## 🔹 Impact

- compromission rapide du domaine
- escalade de privilèges

## 🔹 Défenses

- désactiver NTLM
- credential guard
- segmentation réseau
- surveillance des logs
