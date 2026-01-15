# 🌐 Réseau – VPN (Virtual Private Network)

## 🔹 Qu’est-ce qu’un VPN ?

Un **VPN** (Virtual Private Network) est un mécanisme permettant de **créer un tunnel chiffré** à travers un réseau non sécurisé (ex : Internet).

Il permet de :
- sécuriser les communications
- relier des réseaux distants
- accéder à un réseau privé à distance

## 🔹 Principe de fonctionnement

1. Création d’un **tunnel chiffré**
2. Authentification des pairs
3. Encapsulation des paquets
4. Transmission sécurisée via Internet
5. Décapsulation à l’arrivée

👉 Les données sont protégées contre l’écoute et la modification.

## 🔹 Types de VPN

### 🔸 VPN Site-à-Site

Relie **deux réseaux complets** entre eux.

- utilisé entre sites d’entreprise
- transparent pour les utilisateurs
- communication permanente

Exemple :
- Site A (192.168.1.0/24) ↔ Site B (10.0.0.0/24)

📌 Technologies courantes :
- IPsec

### 🔸 VPN Client-to-Site (Accès distant)

Relie **un utilisateur** à un réseau privé.

- accès distant (télétravail)
- nécessite un client VPN
- accès contrôlé par utilisateur

Exemples :
- OpenVPN
- IPsec (IKEv2)
- WireGuard

### 🔸 VPN SSL

Basé sur TLS/HTTPS.

- accessible via navigateur ou client léger
- souvent utilisé pour accès applicatifs
- déploiement simple

## 🔹 Différences principales

| Critère | Site-à-Site | Client-to-Site |
|------|------|------|
| Connexion | Réseau ↔ Réseau | Client ↔ Réseau |
| Utilisateurs | Transparent | Authentifiés individuellement |
| Usage | Interconnexion de sites | Télétravail |
| Tunnel | Permanent | À la demande |

## 🔹 Protocoles VPN

- **IPsec** : standard, robuste, complexe
- **OpenVPN** : flexible, basé TLS
- **WireGuard** : léger, rapide, moderne
- **L2TP/IPsec** : ancien, combiné

## 🔹 VPN et Réseau

- fonctionne souvent avec NAT (NAT-T)
- nécessite des routes adaptées
- interagit avec firewall et ACL
- attention aux conflits d’adressage

## 🔹 Limites du VPN

- surcharge due au chiffrement
- mauvaise config = fuite de trafic
- accès trop large possible
- dépendance à Internet

## 🔹 Bonnes pratiques

- authentification forte (certificats, MFA)
- segmentation des accès VPN
- journalisation des connexions
- mises à jour régulières
- limiter les droits des utilisateurs VPN

## 🔹 VPN et Sécurité (AIS)

- tunnel chiffré ≠ accès sécurisé
- VPN mal configuré = point d’entrée critique
- appliquer le principe du moindre privilège
- surveiller les accès distants
- désactiver les tunnels inutilisés 
