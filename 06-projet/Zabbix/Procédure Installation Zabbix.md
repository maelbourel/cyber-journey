
# Procédure d'installation de Zabbix

## Configuration Minimal 

2-4 CPU , 4GB RAM minimal 20 GO de disque

## Pré Requis 

Avoir un adresse IP fixe


## Installation  

Etape 1 :  
 Allez sur le site officiel pour adapter a sa version   
 [Zabbix_Packages](https://www.zabbix.com/download?zabbix=7.4&os_distribution=debian&os_version=13&components=server_frontend_agent&db=pgsql&ws=nginx)  

Pour une solution sur Debian 13 avec une base de donnée en PostgreSQL :  

Installer le repository 

```bash
wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian13_all.deb
dpkg -i zabbix-release_latest_7.4+debian13_all.deb
apt update
```
Installer Zabbix server, frontend , agent

```bash
apt install zabbix-server-pgsql zabbix-frontend-php php8.4-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
```

Installer la base de donnée ici PostgreSQL 

```bash
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

```bash
apt update
apt install postgresql postgresql-contrib
systemctl status postgresql
systemctl start postgresql
systemctl enable postgresql
```

On initialise la database avec un `motdepasse`

```bash
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
```

On importe le schéma initial de données :

```bash
zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

On configure la database 

```bash
nano /etc/zabbix/zabbix_server.conf
```
On y ajoute le `motdepasse` précédemment configuré 

```bash
DBPassword=motdepasse
```

On configure le fichier php 

```bash
nano /etc/zabbix/nginx.conf
```

En décommenttant le port et le server_name si on a un sous-domaine

```bash
listen 8080;
server_name example.com;
```

On lance le service Zabbix 

```bash
systemctl restart zabbix-server zabbix-agent nginx php8.4-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.4-fpm
```

On finit l'install sur l'interface Web 

`http://Ipdelamachine:8080`  


> Il se peut qu'il y ai un soucis avec les packs de langues dans ce cas il faut :  
>
> ```bash dpkg-reconfigure locales ```  
> Sélectionner les langues `en_US.UTF-8 UTF-8` et `fr_FR.UTF-8 UTF-8`  
> Rédemarrer Zabbix :  
>   ```systemctl restart zabbix-server zabbix-agent nginx php8.4-fpm```
>   ```systemctl enable zabbix-server zabbix-agent nginx php8.4-fpm```


Par default après l'installation terminer :

- Utilisateur : `Admin`
- Mot de passe : `zabbix`

> ⚠️ Penser a changez le mot de passe générique





























