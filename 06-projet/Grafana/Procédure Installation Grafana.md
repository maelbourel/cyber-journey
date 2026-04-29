# Procédure d'installation de Grafana

## Configuration Minimal 

A se renseigner

## Pré Requis 

Avoir un adresse IP fixe 

[Procédure sur Débian](/06-projet/Procédure%20Utile/Procédure%20config%20réseau%20Débian.md)

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker](/06-projet/Procédure%20Utile/Procédure%20Installation%20Docker.md)


## Installation  

Créer un dossier Grafana

```bash
mkdir Grafana
cd Grafana
```

Créer un fichier `docker-compose.yaml` et copiez : 

```bash 
services:
  grafana:
    image: grafana/grafana-enterprise
    container_name: grafana
    restart: unless-stopped
    ports:
      - '3000:3000'
    volumes:
      - grafana-storage:/var/lib/grafana
volumes:
  grafana-storage: {} 
```

Après on lance le conteneur

```bash
docker compose up -d
```  

Fin de l'installation sur l'interface Web

`http://Ipmachine:3000`