# Procédure d'installation d'agent depuis Wazuh Manager

## Installation

Depuis l'interface graphique de Wazuh Manager  

Dashboard > Agents > Deploy new agent   

Choisir l'OS  

Renseigner l'adresse du manager <IP_SERVEUR_WAZUH> 

Renseigner un nom d'agent  

Copier la commande d'installation générée

L'executer sur la machine cible ( PowerShell sous Win , Bash sous Linux )


## Vérification coté Wazuh Manager

Sur Wazuh Manager : 

```bash 
/var/ossec/bin/manage_agents -l
```
On doit voir l'agent avec le statut Active

On doit aussi le voir sur l'interface Web coté `Dashboard` > `Agent Management`  
