# 🐧 Linux – Logs

## 🔹 Rôle des logs
Les logs permettent de :
- détecter incidents
- diagnostiquer problèmes
- enquêter après attaque


## 🔹 journalctl (systemd)

Centralise les logs.


## 🔹 Commandes utiles

- journalctl
- journalctl -xe
- journalctl -u ssh
- journalctl --since "1 hour ago"


## 🔹 /var/log (fichiers classiques)

| Fichier | Contenu |
|------|--------|
| auth.log | authentification |
| syslog | système |
| kern.log | noyau |
| dmesg | matériel |


## 🔹 Sécurité (AIS)

- détection brute force SSH
- connexions suspectes
- élévation de privilèges
 

