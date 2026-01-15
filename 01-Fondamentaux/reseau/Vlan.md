# 🌐 Réseau – VLAN (Virtual LAN)

## 🔹 Qu’est-ce qu’un VLAN ?

Un **VLAN** (Virtual Local Area Network) est un réseau local **logique** qui permet de **segmenter un réseau physique** en plusieurs réseaux indépendants.

Il permet de :
- isoler des machines
- organiser le réseau par usage ou service
- améliorer la sécurité et les performances

## 🔹 Pourquoi utiliser des VLAN ?

Sans VLAN :
- toutes les machines sont dans le même domaine de broadcast
- plus de bruit réseau
- risque de sécurité accru

Avec VLAN :
- séparation logique des flux
- réduction du broadcast
- meilleure maîtrise des accès

## 🔹 Principe de fonctionnement

Chaque trame Ethernet peut être :
- **non taguée** (untagged)
- **taguée VLAN** (802.1Q)

Le **tag VLAN** contient :
- VLAN ID (VID)
- informations de priorité

## 🔹 VLAN ID

- plage : **1 à 4094**
- VLAN 1 : par défaut (à éviter)
- chaque VLAN = un domaine de broadcast distinct

## 🔹 Types de ports

### 🔸 Port Access
- appartient à **un seul VLAN**
- trames **non taguées**
- utilisé pour les postes clients

### 🔸 Port Trunk
- transporte **plusieurs VLAN**
- trames **taguées 802.1Q**
- utilisé entre switches ou vers un routeur

## 🔹 Inter-VLAN Routing

Les VLAN sont isolés par défaut.

Pour communiquer entre VLAN :
- routeur (router-on-a-stick)
- switch couche 3

👉 nécessaire pour l’accès Internet ou aux services partagés


## 🔹 Exemples de VLAN

| VLAN ID | Nom | Usage |
|------|------|------|
| 10 | USERS | Postes utilisateurs |
| 20 | SERVERS | Serveurs |
| 30 | ADMIN | Administration |
| 99 | MGMT | Management |

## 🔹 VLAN et Sécurité

- isolation des services critiques
- limitation de la propagation d’attaques
- contrôle du trafic inter-VLAN via ACL / firewall
- séparation utilisateurs / serveurs / admin

## 🔹 Bonnes pratiques

- ne pas utiliser VLAN 1
- documenter les VLAN
- limiter les VLAN sur les trunks
- sécuriser les ports (port security)
- filtrer l’inter-VLAN

## 🔹 VLAN et NAT / Firewall

- les VLAN structurent le réseau interne
- le firewall contrôle les flux entre VLAN
- le NAT est appliqué à la sortie vers Internet

## 🔹 Sécurité (AIS)

- segmentation = réduction de la surface d’attaque
- VLAN ≠ sécurité absolue
- attaques possibles : VLAN hopping
- toujours combiner VLAN + firewall
- surveiller les trunks et ports d’accès 
