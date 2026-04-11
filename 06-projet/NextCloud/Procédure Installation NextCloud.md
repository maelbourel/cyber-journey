# Procédure d'installation de NextCloud

## Configuration Minimal 

2-4 CPU , 4GB RAM minimal recommander 8GB RAM

## Pré Requis 

Avoir un adresse IP fixe

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker]()

Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter NextCloud dans Nginx Proxy Manager]())

## Installation  

Créer un dossier NextCloud et télécharger le github de Nextcloud avec le fichier compose.yaml

```bash
mkdir NextCloud
cd NextCloud
git clone https://github.com/nextcloud/all-in-one.git
```

Allez dans le dossier `all-in-one` et modifier le fichier `compose.yaml`

```bash 
services:
  nextcloud-aio-mastercontainer:
    dns:
      - 10.42.2.10          # Samba AD DC (DNS interne du domaine)
    extra_hosts:
      - "cloud.delphin-lab.fr:10.42.0.5"   # Pointe vers NPM (DMZ)
```

> ⚠️ Si vous voulez rentrer votre propre sous domaine bien penser au régle de pare-feu Autoriser le port 11000 de la DMZ vers le LAN SERVEUR et du LAN SERVEUR autoriser les port 8080 , 8443 , 11000

Une fois tout les réglages bien mis en place on lance le conteneur

```bash
docker compose up -d
```  

Apres suivre l'installation a partir de l'interface web depuis `https:\\Ipnextcloud:8080`