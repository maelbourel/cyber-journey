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
  
 Allez sur le site officiel pour télécharger l'agent en .msi  

[Lien Agent Window](https://www.zabbix.com/download_agents)  

Pendant l'installation bien noter le hostname ici `DESKTOP-2U9UI6Q`  

Remplir l'ip du serveur Zabbix

Le Port 10050  

Server or Proxy for active check remettre l'ip du serveur Zabbix  

Ne pas cocher "enable psk"  

Cocher ajout de l'agent au chemin d'accès  

Finalisez l'installation

> Vérifier que l'agent Zabbix tourne bien dans le gestionnaire de tache
 


## Ajouter l'hôte sur Zabbix

Allez sur l'interface web de Zabbix

Collecte de données > Hôtes > Créer un hôte

Configurer l'hôte 

Nom de l'hôte = hostname ici `DESKTOP-2U9UI6Q`

> ⚠️ Doit correspondre exactement (majuscules/minuscules incluses) au nom de l’hôte.

Modèles choisir une template `Windows by Zabbix agent`  

Groupes d'hôtes choisir la categories ici `Discovered hosts`  

Interfaces > Ajouter : 

- Agent 
- Ip = Ip_de_hôte
- Port = 10050

Ajouter  

Test et validation

l'icone ZBX dois passer verte  

⏳ La première remontée de données peut prendre 1 à 2 minutes.

