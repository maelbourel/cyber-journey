
# Procédure d'installation de Proxmox Backup Server

## Configuration Minimal 

2 CPU minimal , 2GB RAM minimal 4GB RAM recommandé , 2 Disque Dur un pour l'OS et pour le DATASTORE

## Pré Requis 

Autoriser le port `TCP 8007` du proxmox host vers PBS

## Installation  

Suivre l'installation et configurer une adresse IP fixe 

Passer l'addresse mail de `invalide` a `valid`


## Création d'un datastore sur PBS 

On accède a l'interface web de PBS `https://IPPBS:8007`  

Connexion `root` avec mot de passe définie lors de l'installation   

On crée un Datastrore `Add Datastore` : 

Name : Nom du Datastore  

Backing Path : choisir un chemin disque (ex: `/mnt/backups`)  


## Ajouter PBS dans Proxmox  

On accède a l'interface web de Proxmox  

Datacenter > Storage > Add > Proxmox Backup Server  

Champ | Valeur  
---|---
ID | `pbs`
Server | `AdresseIPdePBS`  
Username | `root@pam (ou user dédié)` 
Password | `mdp PBS` 
Datastore | `nom du datastore créé`
Fingerprint | `a récupéré depuis l'interface web PBS Dashboard > Show Fingerprint`  

> ⚠️ Attention il se peut que la route statique ne soit pas pris en compte on peut la rajouter avec `ip route add 10.42.0.0/16 via 192.168.42.2`


> Rendre la route persistante  
> Dans /etc/network/interfaces sur le host Proxmox, sur l'interface vmbr1 :  
> post-up ip route add 10.42.0.0/16 via 192.168.42.2  
> pre-down ip route del 10.42.0.0/16 via 192.168.42.2  


## Automatisation des Backup 

On accède a l'interface web de Proxmox 

Datacenter > Backup > Add   

Configuration du Backup Job  


## BONUS 

Si tu as un disque dédié, monte-le d'abord :

```bash
# Sur PBS
mkfs.ext4 /dev/sdb
mkdir -p /mnt/backups
mount /dev/sdb /mnt/backups
echo '/dev/sdb /mnt/backups ext4 defaults 0 2' >> /etc/fstab  
```