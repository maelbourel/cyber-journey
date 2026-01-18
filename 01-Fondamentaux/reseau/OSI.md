# 🌐 Réseau – Modèle OSI

## 🔹 Qu’est-ce que le modèle OSI ?

Le **modèle OSI** (Open Systems Interconnection) est un modèle théorique qui décrit **comment les communications réseau fonctionnent**, en les divisant en **7 couches**.

Il permet de :
- comprendre le fonctionnement des réseaux
- faciliter le dépannage
- standardiser les protocoles

---

## 🔹 Les 7 couches OSI

| N° | Couche | Rôle principal |
|----|--------|---------------|
| 7 | Application | Interface avec l’utilisateur |
| 6 | Présentation | Format, chiffrement |
| 5 | Session | Gestion des sessions |
| 4 | Transport | Fiabilité et ports |
| 3 | Réseau | Routage et IP |
| 2 | Liaison de données | MAC et trames |
| 1 | Physique | Transmission des bits |

---

## 🔹 Détail des couches

### 🔸 Couche 7 – Application
- services réseau aux applications
- ex : HTTP, HTTPS, FTP, SMTP, DNS

---

### 🔸 Couche 6 – Présentation
- encodage / décodage
- chiffrement / déchiffrement
- compression

---

### 🔸 Couche 5 – Session
- ouverture / fermeture des sessions
- synchronisation
- reprise de communication

---

### 🔸 Couche 4 – Transport
- communication de bout en bout
- gestion des ports
- fiabilité et contrôle de flux

Protocoles :
- TCP (fiable)
- UDP (non fiable)

---

### 🔸 Couche 3 – Réseau
- adressage logique
- routage des paquets
- choix du chemin

Protocoles :
- IP
- ICMP
- IPsec

---

### 🔸 Couche 2 – Liaison de données
- adressage MAC
- encapsulation en trames
- détection d’erreurs

Technologies :
- Ethernet
- VLAN (802.1Q)
- ARP

---

### 🔸 Couche 1 – Physique
- transmission des bits
- signaux électriques / optiques
- câbles, connecteurs, ondes

---

## 🔹 Modèle OSI vs TCP/IP

| OSI | TCP/IP |
|----|-------|
| 7 couches | 4 couches |
| Théorique | Pratique |
| Détail fin | Implémentation réelle |

---

## 🔹 Équipements par couche

| Couche | Équipements |
|------|-------------|
| 7–5 | Proxy, Firewall applicatif |
| 4 | Firewall stateful |
| 3 | Routeur |
| 2 | Switch |
| 1 | Hub, câble |

---

## 🔹 Dépannage avec OSI

Méthode ascendante :
1. Physique (câble, lien)
2. Liaison (MAC, VLAN)
3. Réseau (IP, routage)
4. Transport (ports)
5–7. Application

---

## 🔹 Sécurité (AIS)

- attaques possibles à chaque couche
- segmentation et filtrage par couche
- firewall multi-couches recommandé
- compréhension OSI = meilleure défense
- essentiel en réseau et cybersécurité
