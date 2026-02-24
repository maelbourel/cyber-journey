# Nmap – Network Mapper

## 🎯 Objectif
Scanner un réseau pour découvrir :
- Machines actives
- Ports ouverts
- Services
- Versions
- OS

## 🔧 Commandes de base
nmap 192.168.1.10
nmap -sS 192.168.1.10              # SYN scan
nmap -sV 192.168.1.10              # Détection versions
nmap -O 192.168.1.10               # Détection OS
nmap -A 192.168.1.10               # Scan agressif
nmap -p- 192.168.1.10              # Tous les ports

## 🧠 Options utiles
-Pn     # Ignore ping
-T4     # Scan rapide
--script vuln   # Scripts vulnérabilités

## 📌 Usage typique
Reconnaissance initiale d’un réseau.



---


Option	| Explanation
---|---
-sL	| List scan – list targets without scanning
Host Discovery |	
-sn	| Ping scan – host discovery only
Port Scanning |	
-sT	| TCP connect scan – complete three-way handshake
-sS	| TCP SYN – only first step of the three-way handshake
-sU	| UDP Scan
-F	| Fast mode – scans the 100 most common ports
-p[range]	| Specifies a range of port numbers – -p- scans all the ports
-Pn	| Treat all hosts as online – scan hosts that appear to be down
Service Detection | 	
-O	| OS detection
-sV	| Service version detection
-A	| OS detection, version detection, and other additions
Timing | 	
-T<0-5>	| Timing template – paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5)
--min-parallelism <numprobes> and --max-parallelism <numprobes>	| Minimum and maximum number of parallel probes
--min-rate <number> and --max-rate <number>	| Minimum and maximum rate (packets/second)
--host-timeout	| Maximum amount of time to wait for a target host
Real-time output | 	
-v	| Verbosity level – for example, -vv and -v4
-d	| Debugging level – for example -d and -d9
Report | 	
-oN <filename>	| Normal output
-oX <filename>	| XML output
-oG <filename>	| grep-able output
-oA <basename>	| Output in all major formats  
