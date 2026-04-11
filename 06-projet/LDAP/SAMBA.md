# Procédure d'installation de SAMBA

## Prérequis 

### Avoir une adresse IP fixe

modifier le fichier ```/ect/network/interfaces```

```bash
allow-hotplug ens18
iface ens18 inet static
        address 10.42.2.10/24
        gateway 10.42.2.1
        dns-nameservers 10.42.2.1
        dns-search STAGE.LAN
```

### Modifier le hosts et le hostname

dans le fichier ```/etc/hosts``` :  

```bash 
127.0.0.1       localhost
10.42.2.10      SAMBA.STAGE.LAN
```

et dans le fichier ```/etc/hostname``` :

```bash
SAMBA.STAGE.LAN
```

## Installation de SAMBA

```bash 
apt update && apt upgrade -y
```
```bash
apt install samba -y
```

Une fois SAMBA installé avant de faire le provisioning du domain controler il faut renommer le fichier smb.conf en smb.conf.initial ( penser au sudo si pas en root )

```bash
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.initial
```

On peut maintenant lancer le provisioning en interactive mode ( laisser tout les choix par défault )

```bash 
sudo samba-tool domain provision --use-rfc2307 --interactive
```

## Réglage de pare-feu si SAMBA AD et Client sur des Vlan différents

Crée un aliases dans pfsense  
Firewall > Aliases > Ports > Add  
  
Port|Protocole|Service
---|---|---
88 | TCP/UDP | Kerberos
135 | TCP| RPC Endpoint Mapper 
389 | TCP/UDP | LDAP 
445 | TCP | SMB 
464 | TCP/UDP | Kerberos password
636 | TCP | LDAPS
3268 | TCP | Global Catalog 
49152-65535 | TCP | RPC dynamique  

Ensuite rajouter une regle firewall dans le LANClient vers le LANService en TCP/UDP avec Aliases
Firewall > Rules > LANCLIENT  


## Rejoindre le Domain à partir d'un Windows Client

Étape 1 : 

Changer le DNS par l’adresse Ip du SAMBA  

Étape 2 :  

Allez dans paramètre système > A propos de > renommer ce PC ( avancé ) > Modifier > Membre d'un domaine   

Puis se connecter avec par défaut l'utilisateur ```administrator``` et le mot de passe mis lors de l'installation sur le domaine ```STAGE.LAN```  
Le PC devra ensuite redémarrer et se connecter avec ```STAGE\Administrator```   

L'ordi a bien rejoint le Domain

