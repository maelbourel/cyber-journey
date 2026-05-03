## Pré Requis 

Ouvrir les ports suivants sur le firewall de la machine hôte :

| Port | Protocole | Direction | Usage |
|------|-----------|-----------|-------|
| 10050 | TCP | Entrant | Le serveur Zabbix se connecte à l'agent (checks passifs) |
| 10051 | TCP | Sortant | L'agent contacte le serveur Zabbix (checks actifs) |

> 💡 Si seuls les checks passifs sont utilisés (configuration `Server=` uniquement), le port 10051 sortant n'est pas nécessaire.

Entrant source Zabbix destination Autre
Sortant source Autre destination Zabbix

## Installation sur l'hôte

Etape 1 :  
 Allez sur le site officiel pour adapter a sa version   
 [Zabbix_Packages](https://www.zabbix.com/download?zabbix=7.4&os_distribution=debian&os_version=13&components=agent_2&db=&ws=)  

Pour une solution sur Debian 13 :  

Installer le repository  

```bash
wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian13_all.deb
dpkg -i zabbix-release_latest_7.4+debian13_all.deb
apt update
```

Installer l'agent Zabbix 2

```bash
apt install zabbix-agent2
```

Optionnel installer les plugins de l'agent de Zabbix

```bash
apt install zabbix-agent2-plugin-mongodb zabbix-agent2-plugin-mssql zabbix-agent2-plugin-postgresql
```

Modifier le fichier de configuration de l'agent 

```bash
sudo nano /etc/zabbix/zabbix_agent2.conf
```

Avec les paramètres suivant 

```bash
Server=<IP_SERVEUR_ZABBIX>
ServerActive=<IP_SERVEUR_ZABBIX>
Hostname=nom_hote
```

Rédémarrer l'agent 

```bash
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
```

## Ajouter l'hôte sur Zabbix

Allez sur l'interface web de Zabbix

Collecte de données > Hôtes > Créer un hôte

Configurer l'hôte 

Nom de l'hôte = nom_hote renseigner dans `/etc/zabbix/zabbix_agent2.conf`

> ⚠️ Doit correspondre exactement (majuscules/minuscules incluses) au nom de l’hôte déclaré dans Zabbix.

Modèles choisir une template `Linux by Zabbix agent`  

Groupes d'hôtes choisir la categories ici `Linux servers`  

Interfaces > Ajouter : 

- Agent 
- IP = IP_de_hôte
- Port = 10050

Ajouter  

Test et validation

l'icone ZBX dois passer verte  

⏳ La première remontée de données peut prendre 1 à 2 minutes.

Sinon, vérifiez :

- Configuration de l’agent
- Firewall
- Réseau
