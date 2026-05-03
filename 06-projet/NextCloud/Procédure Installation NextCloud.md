# Procédure d'installation de NextCloud

## Configuration Minimal 

2-4 CPU , 4GB RAM minimal recommander 8GB RAM

## Pré Requis 

Avoir un adresse IP fixe  

[Procédure sur Débian](/06-projet/Procédure%20Utile/Procédure%20config%20réseau%20Débian.md)

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker](/06-projet/Procédure%20Utile/Procédure%20Installation%20Docker.md) 

Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter NextCloud dans Nginx Proxy Manager](/06-projet/Reverse%20Proxy/Procédure%20ajouter%20Nextcloud%20dans%20Nginx%20Proxy%20Manager.md) )

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
Si il y a un reverse proxy il faut aussi décommenter 

```bash
environment: 
      APACHE_PORT: 11000 
      APACHE_IP_BINDING: 0.0.0.0
```


> ⚠️ Si vous voulez rentrer votre propre sous domaine bien penser au régle de pare-feu Autoriser le port 11000 de la DMZ vers le LAN SERVEUR et du LAN SERVEUR autoriser les port 8080 , 8443 , 11000

Une fois tout les réglages bien mis en place on lance le conteneur

```bash
docker compose up -d
```  

Apres suivre l'installation a partir de l'interface web depuis `https:\\<IP_SERVEUR>:8080`