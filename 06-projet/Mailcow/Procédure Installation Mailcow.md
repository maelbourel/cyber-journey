## Configuration Minimal 

2 CPU , 6GB RAM minimal

> ⚠️ LXC non supporté, l'installer obligatoirement sur une VM

## Pré Requis 

Avoir un adresse IP fixe

Avoir Docker Compose d'installer 

[Procédure d'installation de Docker]()

Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter Mailcow dans Nginx Proxy Manager](https://bookstack.delphin-lab.fr/books/documentation-reverse-proxy/page/procedure-ajouter-mailcow-dans-nginx-proxy-manager))

Ouvrir les port suivant :  

Service | Protocol | Port
---|---|---
Postfix SMTP | TCP | 25
Postfix SMTPS | TCP | 465
Postfix Submission | TCP | 587
Dovecot IMAP | TCP | 143
Dovecot IMAPS | TCP | 993
Dovecot POP3 | TCP | 110
Dovecot POP3S | TCP | 995
Dovecot ManageSieve | TCP | 4190
HTTP(S) | TCP | 80/443  

Sur Pfsense faire un Aliases  

> ⚠️ Pour le NAT ouvrir que le port 25

## Installation  

On récupère le github et place au bon endroit avec les bonnes permissions 

```bash
su
umask 0022 # umask 0022 définit les permissions par défaut pour que vos nouveaux fichiers soient modifiables par vous-même, mais uniquement lisibles par les autres utilisateurs.
cd /opt
git clone https://github.com/mailcow/mailcow-dockerized
cd mailcow-dockerized
```

On lance le script   

```bash
./generate_config.sh
```
Pendant le script il faudra renseigner le sous domaine `mail.delphin-lab.fr` , on laisse le reste par défault ou recommandé  

> ⚠️  Attention avant de lancer le `docker compose` penser a autoriser dans le firewall le protocole ICMP et de rajouter dans le DNS Resolver le sous domaine dans le Host Overrides  

Une fois tout les réglages prêt lancer le conteneur

```bash
docker compose up -d 
```

On accède ensuite a l'interface web 

`https://mail.delphin-lab.fr/admin`  

Le compte par défault est `admin` avec le mot de passe `moohoo`

Pour finir la configuration aller dans : 

Courriel > Configuration > Ajouter un Domaine  

On remplis les informations et on note de coter la clé `dkim._domainkey` crée.

Ensuite il faut configurer tout les enregistrement DNS suivants : 

Nom | Type | Valeur
---|---|---
mail |  A | `IP publique`
autodiscover | CNAME | `mail.delphin-lab.fr`
autoconfig | CNAME | `mail.delphin-lab.fr`
@ | MX 10 | `mail.delphin-lab.fr`
@ | TXT | `"v=spf1 mx a -all"`
dkim._domainkey | TXT | `Avec la valeur noter plus tot pendant la configuration`
_dmarc | TXT | `"v=DMARC1; p=reject; rua=mailto:contact@delphin-lab.fr"` 


## Vérification 

Pour vérifier que tout fonctionne :

- [https://www.mail-tester.com/](https://www.mail-tester.com/)
- [https://mxtoolbox.com/SuperTool.aspx](https://mxtoolbox.com/SuperTool.aspx)