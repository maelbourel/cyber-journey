# Procédure d'installation de Authentik

## Configuration Minimal 

2 CPU , 2GB RAM minimal recommander 4GB RAM

## Pré Requis 

Avoir un adresse IP fixe

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker]()

## Installation 

Crée un dossier Authentik et télécharger le compose.yml du site officiel

```bash
mkdir Authentik
cd Authentik
wget https://docs.goauthentik.io/compose.yml
```

Pour la base de donnée PostgreSGL il faut rajouter des variables cachées pour les mots de passe dans le fichier .env  

```bash
echo "PG_PASS=$(openssl rand -base64 36 | tr -d '\n')" >> .env
echo "AUTHENTIK_SECRET_KEY=$(openssl rand -base64 60 | tr -d '\n')" >> .env
```

> OpenSSL rand permet de générer aléatoirement des caractères  

Pour avoir les rapport d'erreur on peut rajouter cette variable dans le fichier .env   

```bash
echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env
```  

De base les port de Authentik sont le 9000 -> HTTP et le 9443 -> HTTPS
On peut les changer dans le fichier .env  

```bash
COMPOSE_PORT_HTTP=80
COMPOSE_PORT_HTTPS=443
```

Le fichier compose.yml et le .env sont maintenant configurer on peut deployer le docker  

```bash
docker compose up -d
```

Une fois le service lancer pour la premiere installation il faut allez sur le site ```http://IPaddress:9000/if/flow/initial-setup/.`  

Le compte administrateur de base est ```akadmin```

