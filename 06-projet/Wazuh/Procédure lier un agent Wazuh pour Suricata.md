# Procédure lier un agent Wazuh pour Suricata

## Pré Requis 

Avoir Suricata

[Procédure installation de Suricata](/06-projet/Suricata%20/Procédure%20installation%20de%20Suricata.md)

Avoir Wazuh

[Procédure installation de Wazuh](/06-projet/Wazuh/Procédure%20installation%20de%20Wazuh.md)  

Ouvrir les port suivant :  

Port | Protocole | Usage 
---|---|---
1514 | TCP | Envoi des événements au Manager
1515 | TCP | Enrollment automatique auprès du Manager


## Installation  

On récupère la clé et le repo Wazuh :

```bash
apt install gpg -y

curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg

echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list

apt update
```

On installe l'agent Wazuh : 

```bash
WAZUH_MANAGER="<IP_SERVEUR_WAZUH>" apt install -y wazuh-agent
```

On active et démarre l'agent : 

```bash
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent
systemctl status wazuh-agent
```

## Vérification coté Wazuh Manager

Sur Wazuh Manager : 

```bash 
/var/ossec/bin/manage_agents -l
```
On doit voir l'agent Suricata avec le statut Active

On doit aussi le voir sur l'interface Web coté `Dashboard` > `Agent Management`  


## Configurer la collecte des logs Suricata

Éditer la configuration de l'agent : 

```bash 
nano /var/ossec/etc/ossec.conf
```

Dans la section `<ossec_config>` rajouter le bloc suivant : 

```bash 
<localfile>
  <log_format>json</log_format>
  <location>/var/log/suricata/eve.json</location>
</localfile>
```

> ⚠️ Attention :  
> - Le log_format doit être json (pas syslog). Wazuh sait parser nativement le format EVE JSON de Suricata.  
> - Le chemin doit correspondre exactement au fichier configuré dans suricata.yaml.  
> - L'utilisateur wazuh (ou ossec) doit avoir les droits de lecture sur le fichier : chmod 644 /var/log/suricata/eve.json


Ensuite Redémarrez l'agent : 

```bash
systemctl restart wazuh-agent
```

