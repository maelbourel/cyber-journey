# Gobuster – Bruteforce rapide

## 🎯 Objectif
Enumération rapide :
- Répertoires
- Sous-domaines
- Vhosts

## 🔧 Répertoires
gobuster dir -u http://target.com -w wordlist.txt

## 🔧 DNS
gobuster dns -d target.com -w wordlist.txt

## 🔧 VHOST
gobuster vhost -u http://target.com -w wordlist.txt

## 📌 Avantage
Très rapide (multithread).