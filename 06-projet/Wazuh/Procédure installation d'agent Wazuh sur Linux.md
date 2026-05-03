# Procédure d'installation d'agent Wazuh sur Linux


## Pré Requis 

Avoir Wazuh

[Procédure installation de Wazuh](/06-projet/Wazuh/Procédure%20installation%20de%20Wazuh.md)

Ouvrir les port suivant :  

Port | Protocole | Usage 
---|---|---
1514 | TCP | Communication des agents (réception des logs)
1515 | TCP | Enregistrement des agents (enrollment) 


Avoir `curl` :

```bash
apt install curl
```


## Installation  

Installer des paquets et rajouter un dépôt :

```bash
apt-get install gnupg apt-transport-https
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
apt-get update
```

## Déploiement  

Installer l'agent : 

```bash
WAZUH_MANAGER="<IP_SERVEUR_WAZUH>" apt-get install wazuh-agent
```

On active et démarre l'agent : 

```bash
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent
```  

## Vérification coté Wazuh Manager

Sur Wazuh Manager : 

```bash 
/var/ossec/bin/manage_agents -l
```
On doit voir l'agent avec le statut Active

On doit aussi le voir sur l'interface Web coté `Dashboard` > `Agent Management`  


## Bonus pour configurer la collecte des logs

Éditer la configuration de l'agent ici : 

```bash 
nano /var/ossec/etc/ossec.conf
```

Ensuite redémarrez l'agent : 

```bash
systemctl restart wazuh-agent
```
