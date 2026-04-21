## Pré Requis 

Ouvrir les ports suivants sur le firewall 
 Port | Protocole
------|----------
 161 (SNMP) | UDP 


## Installation sur l'hôte

Dans l'interface web de TrueNAS

System > Service  

Activer SNMP en Running et Start Automatically

Ensuite edit `SNMP` et donner un nom a community `zabbix`  


## Ajouter l'hôte sur Zabbix

Allez sur l'interface web de Zabbix

Collecte de données > Hôtes > Créer un hôte

Configurer l'hôte 

Nom de l'hôte = nom de l'hote 

Modèles choisir la template `Generic by SNMP`  

Groupes d'hôtes choisir la categories ici `Linux servers`  

Interfaces > Ajouter : 

- SNMP
- Ip = Ip_de_hôte
- Port = 161
- Deplier le menu et remplir la communauté SNMP par le nom choisit ici `zabbix`

Ajouter  

Test et validation

l'icone SNMP dois passer verte  

⏳ La première remontée de données peut prendre 1 à 2 minutes.
