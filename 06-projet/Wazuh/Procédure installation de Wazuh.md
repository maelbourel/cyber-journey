# Procédure d'installation de Wazuh

## Configuration Minimal 

A se renseigner

## Pré Requis 

Avoir un adresse IP fixe 

[Procédure sur Débian](/06-projet/Procédure%20Utile/Procédure%20config%20réseau%20Débian.md)  

Ouvrir les port suivant :  

Port | Protocole | Usage 
---|---|---
1514 | TCP | Communication des agents (réception des logs)
1515 | TCP | Enregistrement des agents (enrollment) 
443 | TCP | Dashboard Wazuh (HTTPS)  
55000 | TCP | API REST Wazuh Manager


Avoir `curl` :

```bash
apt install curl
```


## Installation  

Wazuh fournit un script d'installation tout en un qyu déploie les trois composants sur la même VM : 

```bash 
su -
curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh
sudo bash ./wazuh-install.sh -a
```

> L'installation prend entre __5 et 15 minutes__ 

A la fin de l'installation le script affiche les identifiant par défaut : 

```bash 
INFO: --- Summary ---
INFO: You can access the web interface https://<wazuh-dashboard-ip>:443
    User: admin
    Password: <mot_de_passe_généré>
```
> ⚠️ NOTEZ CE MOT DE PASSE.
>
> Mais si vous le perdez vous pouvez le récuperer avec cette command :   
> ```tar -xvf /home/wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt```
> ```cat wazuh-install-files/wazuh-passwords.txt```

Vérifier les status des 3 services : 

```bash
systemctl status wazuh-manager
systemctl status wazuh-indexer
systemctl status wazuh-dashboard
```

## Configuration

Ouvrir l'interface Web de Wazuh :  

```bash
https://<IP_SERVEUR>
```

- Utilisateur : `admin`
- Mot de passe : `mot_de_passe_généré` notez a la fin de l'installation   

## Installez des agents

[Procédure lier un agent Wazuh pour Suricata](/06-projet/Wazuh/Procédure%20lier%20un%20agent%20Wazuh%20pour%20Suricata.md)  
[Procédure installation d'agent Wazuh sur Linux](/06-projet/Wazuh/Procédure%20installation%20d'agent%20Wazuh%20sur%20Linux.md)  
[Procédure installation d'agent Wazuh sur Windows](/06-projet/Wazuh/Procédure%20installation%20d'agent%20Wazuh%20sur%20Windows.md)  
[Procédure installation d'agent depuis Wazuh Manager](/06-projet/Wazuh/Procédure%20installation%20d'agent%20depuis%20Wazuh%20Manager.md)  



