# Procédure d'installation d'agent Wazuh sur Windows


## Pré Requis 

Avoir Wazuh

[Procédure installation de Wazuh](/06-projet/Wazuh/Procédure%20installation%20de%20Wazuh.md)

Ouvrir les port suivant :  

Port | Protocole | Usage 
---|---|---
1514 | TCP | Communication des agents (réception des logs)
1515 | TCP | Enregistrement des agents (enrollment) 



## Installation  

Télécharger l'agent sur le site officiel en .msi [ici](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-windows.html)  

Option 1 : Lancer l'installation en interface graphique :

Laissez tout par défault et remplissez `Manager IP` par <IP_SERVEUR_WAZUH>  

Option 2 : Lancer l'installation en CLI : 

Dans le dossier du paquet .msi en PowerShell :

```pwsh
.\wazuh-agent-4.14.5-1.msi /q WAZUH_MANAGER="<IP_SERVEUR_WAZUH>"
```

Lancer l'agent :

```pwsh
Start-Service wazuhsvc
```

> Verifier que l'agent tourne bien dans le gestionnaire de tache

## Vérification coté Wazuh Manager

Sur Wazuh Manager : 

```bash 
/var/ossec/bin/manage_agents -l
```
On doit voir l'agent avec le statut Active

On doit aussi le voir sur l'interface Web coté `Dashboard` > `Agent Management`  

