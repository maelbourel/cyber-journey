# 🌐 Réseau – NAT (Network Address Translation)

## 🔹 Qu’est-ce que le NAT ?

Le **NAT** (Network Address Translation) est un mécanisme réseau permettant de **traduire des adresses IP privées en adresses IP publiques** (et inversement).

Il est principalement utilisé pour :
- économiser les adresses IPv4
- permettre l’accès à Internet depuis un réseau privé
- masquer la structure interne du réseau

## 🔹 Pourquoi le NAT ?

Les adresses IP privées ne sont **pas routables sur Internet**.

Plages privées (RFC 1918) :
- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

👉 Le NAT permet à ces machines d’accéder à Internet via **une ou plusieurs adresses IP publiques**.

## 🔹 Fonctionnement

1. Une machine privée envoie un paquet vers Internet  
2. Le routeur NAT :
   - remplace l’adresse IP source privée par une IP publique
   - mémorise la correspondance (table NAT)
3. La réponse revient vers le routeur
4. Le routeur retransmet le paquet vers la machine interne concernée

## 🔹 Types de NAT

### 🔸 SNAT (Source NAT)
- Modifie l’adresse **source**
- Utilisé pour le trafic sortant vers Internet

### 🔸 DNAT (Destination NAT)
- Modifie l’adresse **destination**
- Utilisé pour exposer un service interne (redirection de port)

### 🔸 PAT (Port Address Translation)
- Plusieurs machines partagent **une seule IP publique**
- Différenciation via les ports
- Le type de NAT le plus courant (box Internet)

## 🔹 Exemples

Réseau interne : `192.168.1.0/24`  
Adresse IP publique : `203.0.113.10`

Exemple de traduction :
- `192.168.1.20:54321` → `203.0.113.10:40001`

## 🔹 NAT et Firewall

Le NAT est souvent associé à un **pare-feu** :
- le trafic entrant est bloqué par défaut
- les accès externes nécessitent une règle DNAT
- meilleure isolation du réseau interne

⚠️ Le NAT **n’est pas un mécanisme de sécurité à lui seul**


## 🔹 Limites du NAT

- ne respecte pas le principe end-to-end
- complique certains protocoles (VoIP, FTP actif)
- nécessite des redirections de ports
- peu adapté à IPv6

## 🔹 NAT et IPv6

Avec IPv6 :
- chaque machine peut disposer d’une adresse IP publique
- le NAT devient inutile
- la sécurité repose sur le pare-feu, pas sur la traduction d’adresses

## 🔹 Sécurité (AIS)

- services exposés via DNAT = surface d’attaque
- journaliser et auditer les règles NAT
- limiter strictement les ports ouverts
- NAT ≠ firewall
- mauvaise configuration = accès interne non désiré
