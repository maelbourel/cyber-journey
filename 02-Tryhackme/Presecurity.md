# PATH PRE-SECURITY
Sommaire  
[Introduction to cyber security](#introduction-to-cyber-security)  
[Network Fundamentals](#network-fundamentals)  
[How The Web Works](#how-the-web-works)  
[Linux Fundamentals](#linux-fondamental)  
[Windows Fundamentals](#windows-fundamentals)  


## Introduction to Cyber Security

### Offensive Security Intro 

🎯 Goal : Trouver des URLs secret

🧰 Outils utilisés :

- dirb ( brute force approach )

>dirb is a tool for find hidden website pages  

```bash
dirb http://example.com
```

[Plus sur l'outils dirb](https://www.kalilinux.fr/commandes/dirb-sur-kali-linux/)

---
### Defensive Security Intro


🎯 GOAL : Dans la peau d'un SOC ( security operation center )  trier des alertes via SIEM  

🧰 Outils utilisés : 

- SIEM 

>Un SIEM (Security Information and Event Management) est une solution de cybersécurité qui permet de collecter, centraliser, analyser et corréler les événements de sécurité provenant de différents systèmes informatiques afin de détecter les menaces et incidents de sécurité.  
---

## Network Fundamentals

### What is Networking ?


📚 Notion : 
- Addresse IP
- Adresse MAC
- ICMP ( Internet Control Message Protocol ) ping

  ping `addresseip`  


[📹 Video](https://youtu.be/42u_2e6eNF4)

---

### Intro to LAN 

📚 Notion : 
- Star topology
- bus topology
- Ring topology
- Switch 
- Routeur
- Sous réseau
- ARP 
- DHCP
  
[📹 Video](https://youtu.be/csYtPidvvFQ)

---

### OSI Model 

📚 Notion : 

- OSI
- TCP
- UDP

---

### Packet & Frames

📚 Notion : 

- TCP/IP
- Port

[Liste de Ports](https://www.vmaxx.net/techinfo/ports.htm)

[📹 Video](https://youtu.be/vzcLrE0SfiQ)

---

### Extending Tour Network

📚 Notion : 
  
  - Redirection de Port
  - Firewalls
  - VPN
  - VLAN

---

## How The Web Works

### DNS in Detail

📚 Notion : 

- DNS
- Domain Hierarchy
- 

[📹 Video](https://youtu.be/jpTY1S5vs9k)

---

### HTTP in Detail

📚 Notion : 

- HTTP
- HTTPS
- HTTP methods
- HTTP Status 😼 [Status avec des chat](https://http.cat/)
- Cookie


[📹 Video](https://youtu.be/XZyapIKV3Rw)  

---

### How Websites Work

📚 Notion :

- HTML Injection

[📹 Video](https://youtu.be/iWoiwFRLV4I) 

---

### Putting it all together

📚 Notion :

- Web server

[📹 Video](https://youtu.be/Aa_FAA3v22g) 

---

## Linux Fondamental

### Linus Fondamental Part 1

📚 Notion :

| Command | Description |
---|---
echo |	Output any text that we provide
whoami |	Find out what user we're currently logged in as!
ls |	listing
cd |	change directory
cat |	concatenate
pwd |	print working directory 


- Commande Find
- Commande Grep

Commande Shell 

Symbol / Operator |	Description
---|---
& |	This operator allows you to run commands in the background of your terminal.
&& |	This operator allows you to combine multiple commands together in one line of your terminal.
\> |	This operator is a redirector - meaning that we can take the output from a command (such as using cat to output a file) and direct it elsewhere.
\>> | This operator does the same function of the > operator but appends the output rather than replacing (meaning nothing is overwritten).  


[📹 Video](https://youtu.be/kPylihJRG70) 

---

### Linux Fondamental Part 2

📚 Notion :

- SSH
  

  Command | Full Name |	Purpose 
  ---|---|---
touch |	touch |	Create file  
mkdir |	make directory |	Create a folder  
cp |	copy |	Copy a file or folder  
mv |	move |	Move a file or folder  
rm |	remove |	Remove a file or folder  
file |	file |	Determine the type of a file    

- permision
- User & Groups
  
[📹 Video](https://youtu.be/7Zt2Mp2IeBI)

---

### Linux Fondamental Part 3


📚 Notion :

- Nano / Vim
- wget
- SCP ( secure copy )
- python3 -m http.server
- ps aux
- top / htop
- PID
- kill
- systemctl
- cron / crontabs
- community repositories


[📹 Video](https://youtu.be/bwgaZCb2ft8)

---

## Windows Fundamentals 

### Windows Fundamentals 1

📚 Notion :

- NTFS
- Privilege / user et groupe
  
---

### Windows Fundamentals 2

📚 Notion :

- msconfig
- UAC ( User Account Control Setting )
- Event viewer
- compmgmt
- resmon
- registry ( regedit )

---

### Windows Fundamentals 3 

📚 Notion :

- windows security
- firewall
- bitlocker