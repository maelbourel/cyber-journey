# Path Cyber Security 101

sommaire  



## Start 

### Search Skills

📚 Notion : 

- [Shodan](https://www.shodan.io/)
- [Censys Search](https://search.censys.io/)
- [Virus Total](https://www.virustotal.com/gui/home/upload)
- [Have i been Pwned](https://haveibeenpwned.com/)
- CVE
- GitHub
- [OffSec's Exploit Database Archive](https://www.exploit-db.com/)
- [NVD](https://nvd.nist.gov/)
- man ( manuel linux)
- [microsoft](https://learn.microsoft.com/fr-fr/) ( manuel pour windows )

---

### Active Directory basics

📚 Notion : 

- windows domain
- Domain Controller
- OU / users
- trees forest and trusts

---

## Command Line

### Windows Command Line

📚 Notion :  

- set / ver / systeminfo
- ipconfig
- ping / tracert / nslookup / netstat
- cd / dir / tree / type / copy / move / del or erase
- tasklist / taskkill /PID
- /? help
  
---
  
### Windows PowerShell

📚 Notion : 

- GET-Content : Retrieves (gets) the content of a file and displays it in the console. (cat)
- `Set-Location`: Changes (sets) the current working directory.

- `Verb-Noun`
- Get-Command
- Get-Help

---

### Linux Shells

📚 Notion :

- Bash
- `chsh -s /usr/bin/zsh`.  pour changer de maniere permanente le shells
- script .sh
- Commencer avec un Shebang **#!/bin/bash**
- **chmod +x**

---

## NETWORKING

### Networking concepts

📚 Notion :

- OSI Model
- TCP/IP

---

### Networking Essentials

📚 Notion :

- DHCP ( Dynamyc Host C Protocol)
- ARP ( Address Resolution Protocol )
- ICMP ( ping / traceroute )

---

### Networking Core Protocols

📚 Notion :

- DNS ( Domain Name System )
- nslookup
- whois
- Telnet
- FTP port 21
- SMTP ( email )
- POP3
- IMAP

| **Protocol** | **Transport Protocol** | **Default Port Number** |
| --- | --- | --- |
| TELNET | TCP | 23 |
| DNS | UDP or TCP | 53 |
| HTTP | TCP | 80 |
| HTTPS | TCP | 443 |
| FTP | TCP | 21 |
| SMTP | TCP | 25 |
| POP3 | TCP | 110 |
| IMAP | TCP | 143 |

---

### Networking Secure Protocols 

📚 Notion :

- TLS ( certificate )
- HTTPS

The insecure versions use the default TCP port numbers shown in the table below:

| **Protocol** | **Default Port Number** |
| --- | --- |
| HTTP | 80 |
| SMTP | 25 |
| POP3 | 110 |
| IMAP | 143 |

The secure versions, i.e., over TLS, use the following TCP port numbers by default:

| **Protocol** | **Default Port Number** |
| --- | --- |
| HTTPS | 443 |
| SMTPS | 465 and 587 |
| POP3S | 995 |
| IMAPS | 993 |

-SSH  `ssh username@hostname`
-SFTP and FTPS
-VPN

---

### Wireshark the Basic 

📚 Notion :

- fonctionnement de Wireshark 

---

### Tcpdump the Basics 


📚 Notion :

- tcpdump
- -i INTERFACE
- -w FILE. The file extension is most commonly set to .pcap for archive
- -r FILE for read
- -c COUNT for limit the number of captured packets 
- -n Don’t Resolve IP Addresses -nn  Port Numbers
- -v for more details ( verbose )
  
Command	| Explanation
---|---
tcpdump -i INTERFACE	| Captures packets on a specific network interface
tcpdump -w | FILE	Writes captured packets to a file
tcpdump -r | FILE	Reads captured packets from a file
tcpdump -c | COUNT	Captures a specific number of packets
tcpdump -n	| Don’t resolve IP addresses
tcpdump -nn	| Don’t resolve IP addresses and don’t resolve protocol numbers
tcpdump -v	| Verbose display; verbosity can be increased with -vv and -vvv   


Command	| Explanation
---|---
tcpdump host IP or tcpdump host HOSTNAME	| Filters packets by IP address or hostname
tcpdump src host IP or	| Filters packets by a specific source host
tcpdump dst host IP	| Filters packets by a specific destination host
tcpdump port PORT_NUMBER	| Filters packets by port number
tcpdump src port PORT_NUMBER	| Filters packets by the specified source port number
tcpdump dst port PORT_NUMBER	| Filters packets by the specified destination port number
tcpdump PROTOCOL	| Filters packets by protocol; examples include ip, ip6, and icmp   

- greater LENGTH: Filters packets that have a length greater than or equal to the specified length
- less LENGTH: Filters packets that have a length less than or equal to the specified length

Command	| Explanation
---|---
tcpdump -q	| Quick and quite: brief packet information
tcpdump -e	| Include MAC addresses
tcpdump -A	| Print packets as ASCII encoding
tcpdump -xx	| Display packets in hexadecimal format
tcpdump -X	| Show packets in both hexadecimal and ASCII formats  

---

### Nmap: The Basics

📚 Notion :


