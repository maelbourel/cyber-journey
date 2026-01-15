# 🐧 Linux – SSH (Sécurité)

## 🔹 Qu’est-ce que SSH ?

SSH (Secure Shell) permet l’accès distant sécurisé à un système Linux.

Port par défaut : 22


## 🔹 Fonctionnement

- connexion chiffrée
- authentification par mot de passe ou clé
- client ↔ serveur

## 🔹 Fichiers clés

| Fichier | Rôle |
|------|----|
| /etc/ssh/sshd_config | configuration serveur |
| ~/.ssh/authorized_keys | clés autorisées |

## 🔹 Authentification par clé (recommandée)

- plus sécurisé
- protège contre brute force
- clé privée à protéger

## 🔹 Commandes utiles

- ssh user@ip
- ssh-keygen
- systemctl status ssh

## 🔹 Sécurisation SSH (INDISPENSABLE AIS)
- désactiver root login
- changer le port (optionnel)
- désactiver auth par mot de passe
- utiliser fail2ban
- limiter par IP

## 🔹 Attaques courantes

- brute force
- credential stuffing
- exploitation mauvaise config

## 🔹 Logs SSH

- journalctl -u ssh
- /var/log/auth.log
 