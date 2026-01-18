# 🌐 Réseau – ARP (Address Resolution Protocol)

## 🔹 Qu’est-ce que l’ARP ?

**ARP** (Address Resolution Protocol) est un protocole réseau permettant de **faire la correspondance entre une adresse IP et une adresse MAC** sur un réseau local.

👉 Il est indispensable au fonctionnement d’IPv4 sur un LAN.

---

## 🔹 Pourquoi l’ARP est nécessaire ?

- Les applications communiquent avec des **adresses IP**
- Les cartes réseau communiquent avec des **adresses MAC**
- ARP fait le lien entre les deux

Sans ARP, un hôte ne peut pas envoyer de trame Ethernet à une destination IP locale.

---

## 🔹 Fonctionnement de l’ARP

1. La machine A veut joindre une IP locale
2. Elle vérifie sa **table ARP**
3. Si l’entrée n’existe pas :
   - elle envoie une **ARP Request** (broadcast)
4. La machine cible répond avec une **ARP Reply** (unicast)
5. L’association IP ↔ MAC est stockée en cache

---

## 🔹 Types de messages ARP

- **ARP Request** : “Qui a cette IP ?”
- **ARP Reply** : “Cette IP correspond à cette MAC”

---

## 🔹 Table ARP

Chaque machine maintient une **table ARP locale**.

Contenu :
- adresse IP
- adresse MAC
- interface
- durée de vie (cache)

Commande :
- `arp -a`
- `ip neigh`

---

## 🔹 ARP et Broadcast

- ARP Request est envoyé en **broadcast**
- ARP Reply est envoyé en **unicast**
- limité au réseau local (couche 2)

---

## 🔹 ARP et Routage

- ARP fonctionne **uniquement dans un même réseau**
- pour une destination distante :
  - ARP résout la MAC du **routeur (gateway)**

---

## 🔹 ARP et IPv6

- ARP n’existe pas en IPv6
- remplacé par **NDP (Neighbor Discovery Protocol)**

---

## 🔹 Problèmes courants liés à ARP

- cache ARP obsolète
- conflits d’adresses IP
- attaques ARP spoofing

---

## 🔹 Sécurité (AIS)

- ARP n’est **pas authentifié**
- vulnérable au **ARP poisoning / spoofing**
- permet des attaques de type MITM
- protections possibles :
  - ARP statique
  - Dynamic ARP Inspection (DAI)
  - segmentation VLAN
  - surveillance réseau
