# PATH PRE-SECURITY
Sommaire  
[Introduction to cyber security](#introduction-to-cyber-security)  
[Network Fundamentals](#network-fundamentals)  
[How The Web Works](#how-the-web-works)  
[Linux Fundamentals](#linux-fondamental)  



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


[📹 Video](https://youtu.be/kPylihJRG70) 