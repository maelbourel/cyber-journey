# 🌐 Réseau – Switch & Routeur

## 🔹 Switch

### 🔸 Qu’est-ce qu’un switch ?

Un **switch** (commutateur) est un équipement réseau permettant de **connecter plusieurs machines au sein d’un même réseau local (LAN)**.

Il fonctionne principalement en **couche 2 (OSI)**.

---

### 🔸 Fonctionnement

- utilise les **adresses MAC**
- apprend les MAC via la table CAM
- envoie les trames uniquement vers le port concerné
- réduit le trafic inutile (broadcast exclu)

---

### 🔸 Types de switch

- **Switch non manageable** : simple, aucune configuration
- **Switch manageable** : VLAN, sécurité, supervision
- **Switch couche 3** : routage inter-VLAN

---

### 🔸 Fonctions principales

- VLAN (802.1Q)
- Port Access / Trunk
- Spanning Tree (STP)
- Port Security
- QoS

---

### 🔸 Sécurité (Switch)

- segmentation via VLAN
- port security (limite MAC)
- désactiver ports inutilisés
- protection contre boucles réseau

---

## 🔹 Routeur

### 🔸 Qu’est-ce qu’un routeur ?

Un **routeur** est un équipement réseau permettant de **relier plusieurs réseaux différents**.

Il fonctionne en **couche 3 (OSI)**.

---

### 🔸 Fonctionnement

- utilise les **adresses IP**
- consulte la table de routage
- choisit la meilleure route
- transfère les paquets entre réseaux

---

### 🔸 Fonctions principales

- routage statique
- routage dynamique (OSPF, RIP, BGP)
- NAT
- inter-VLAN routing
- filtrage (ACL)

---

### 🔸 Sécurité (Routeur)

- contrôle des flux réseau
- filtrage par IP / ports
- journalisation
- séparation LAN / WAN

---

## 🔹 Switch vs Routeur

| Critère | Switch | Routeur |
|------|------|------|
| Couche OSI | 2 (ou 3) | 3 |
| Adresse utilisée | MAC | IP |
| Rôle | Communication locale | Communication inter-réseaux |
| VLAN | Oui | Indirect |
| NAT | Non | Oui |

---

## 🔹 Switch L3 vs Routeur

- switch L3 : rapide, réseau interne
- routeur : WAN, NAT, VPN, Internet
- souvent complémentaires

---

## 🔹 Exemple d’architecture

- switch : segmentation VLAN
- routeur / firewall : routage + NAT + sécurité
- accès Internet centralisé

---

## 🔹 Sécurité (AIS)

- switch compromis = écoute réseau possible
- routeur compromis = contrôle du trafic
- durcir les accès d’administration
- séparer management et production
- journaliser et surveiller les équipements
