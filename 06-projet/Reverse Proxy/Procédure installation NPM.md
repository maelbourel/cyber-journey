# Procédure d'installation de NginxProxyManager

## Pré Requis 

Avoir un adresse IP fixe 

[Procédure sur Débian](/06-projet/Procédure%20Utile/Procédure%20config%20réseau%20Débian.md)

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker](/06-projet/Procédure%20Utile/Procédure%20Installation%20Docker.md)


## Installation  

Créer un dossier NginxProxyManager

```bash
mkdir NginxProxyManager
cd NginxProxyManager
```

Créer un fichier `docker-compose.yaml` et copiez : 

```bash 
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    environment:
      TZ: "Europe/Paris"
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```

Après on lance le conteneur

```bash
docker compose up -d
```  

Fin de l'installation sur l'interface Web

`http://<IP_SERVEUR>:81`