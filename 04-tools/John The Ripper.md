# John The Ripper – Crack de hash

## 🎯 Objectif
Casser des mots de passe hashés.

## 🔧 Commande simple
john hash.txt

## 🔧 Avec wordlist
john --wordlist=rockyou.txt hash.txt

## 🔍 Voir résultats
john --show hash.txt

## 📌 Algorithmes supportés
MD5, SHA1, bcrypt, NTLM...