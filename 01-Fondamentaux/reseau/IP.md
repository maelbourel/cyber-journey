# __Adresses IP__

## __Qu'est-ce qu'une adresse IP ?__

Une adresse IP (Internet Protocol) identifie de manière unique une machine sur un réseau afin de permettre la communication.  

## __IP privée vs IP publique__

### __IP privées ( non routables sur Internet )__

Utilisées en réseau local  

- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16
  
### __IP publiques__

Visible sur Internet , attribuées par les FAI ( Fournisseur Accès à Internet )


## __Masque de sous-réseau / CIDR__

Permet de définir sur l'addresse IP la partie réseau et la partie machine  
Définit le nombre possible de machine sur un réseau 
Exemple : 
- 255.255.255.0 /24
- 255.255.0.0 / 16
  
## __Passerelle ( Gateway )__

Routeur permettant l'accès à d'autre réseaux , notamment Internet.


## __IPv4 vs IPv6__

__IPv4__ | __IPv6__ 
---------|---------
32 bits  | 128 bits
4 octets | 8 groupes hexadécimaux 
4,3 milliards d'adresses | quasi illimité
ex : 192.168.1.1 | ex : 2001:db8::1
