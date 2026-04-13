# Procédure d'installation de NextCloud

## Configuration Minimal 

4 CPU , 8GB RAM minimal

## Pré Requis 

Avoir un adresse IP fixe

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker]()

Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter Mailcow dans Nginx Proxy Manager]())



## Installation  

On récupère le github et place au bon endroit avec les bonnes permissions 

```bash
su
umask 0022
cd /opt
git clone https://github.com/mailcow/mailcow-dockerized
cd mailcow-dockerized
```

On lance le script   

```bash
./generate_config.sh
```
Pendant le script il faudra renseigner le sous domaine `mail.delphin-lab.fr` , on laisse le reste par défault ou recommandé  

> ⚠️  Attention avant de lancer le `docker compose` penser a autoriser dans le firewall le protocole ICMP et de rajouter dans le DNS Resolver le sous domaine dans le Host Overrides  

Une fois tout les réglages prêt lancer le conteneur

```bash
docker compose up -d 
```

On accède ensuite a l'interface web 

`https://mail.delphin-lab.fr/admin`  

Le compte par défault est `admin` avec le mot de passe `moohoo`