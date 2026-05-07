# DOSSIER PROJET

Titre Professionnel : Administrateur d’Infrastructures Sécurisées


MAEL BOUREL


Période de stage / tuteur entreprise

# Sommaire 

1. Page de garde

2. [Présentation de l’entreprise et du contexte](#2-présentation-de-lentreprise-et-du-contexte)    
	2.1 [Présentation de la structure d’accueil](#21-présentation-de-la-structure-daccueil)  
	2.2 [Contexte du projet](#22-contexte-du-projet)  
	2.3 [Objectif de la mission](#23-objectif-de-la-mission)   
	2.4 [Choix de l’approche open-source](#24-choix-de-lapproche-open-source)   
	2.5 [Solution retenues et justification des choix](#25-solution-retenues-et-justification-des-choix)

3. [Analyse et conception de la solution](#3-analyse-et-conception-de-la-solution)    
	3.1 [Architecture globale](#31-architecture-globale)  
	3.2 [Plan d’adressage réseau]  

4. Gestion de projet


# 2. Présentation de l'entreprise et du contexte

## 2.1 Présentation de la structure d'accueil 

Delphin Informatique est une entreprise de services numériques dans l'administration système et réseau, le conseil en systèmes d'information et le développement web. Elle est dirigée par Baptiste Delphin et intervient principalement auprès de TPE et PME souhaitant moderniser ou sécuriser leur infrastructure informatique.

Son positionnement est résolument orienté vers les solutions libres et open-source. 

## 2.2 Contexte du projet

La mission confiée s'inscrit dans la continuité de l'activité de Delphin Informatique : concevoir une infrastructure informatique complète open-source qui peut répondre aux besoins des TPE et PME.

Ce type de structure présente généralement les problématiques suivantes :

- Sécurisation réseau insuffisante, avec peu ou pas de filtrage des accès et de protection contre les intrusions.
  
- Gestion des comptes utilisateurs dispersée et manuelle sur chaque service.

- Absence de SSO : Entraînant de multiple identifiants et mot de passe différents selon les applications.

- Pas de solution de partage de fichiers collaborative et sécurisée.

- Pas de serveur de messagerie professionnel.

- Aucune supervision de l'infrastructure : les pannes et anomalies ne sont détectées qu'a posteriori.

- Absence de politique de sauvegarde, augmentant les risques de perte de données.
  
- Exposition aux menaces extérieur.

## 2.3 Objectif de la mission

L'objectif est de concevoir et déployer un proof of concept (PoC) d'infrastructure complète, entièrement basé sur des logiciels libres et open-source, démontrant qu'une TPE ou PME peut disposer d'un système d'information structuré, sécurisé et maintenable sans coût de licence logicielle.

Pour répondre au problématique les plus courante cette infrastructure sera composé : 

- d'un pare-feu
  
- d'un contrôleur de domaine
  
- d'un SSO
  
- D'une solution de partage de fichiers collaborative et sécurisée.
  
- d'un serveur mail

- D'un outils de Supervision 

- D'observer la disponibilité des services
  
- d'une solution de sauvegarde
  
- d'un IPS/IDS
  
- d'un SIEM
  
- Et des mesures de cybersécurité seront mis en place


L'ensemble de la démarche donne également lieu à une documentation technique complète, réutilisable par Delphin Informatique dans ses interventions clients.

## 2.4 Choix de l’approche open-source  

Le choix d’une stack exclusivement open source répond à plusieurs enjeux rencontrés par les TPE/PME, notamment les contraintes budgétaires liées aux licences logicielles (Microsoft 365, Windows Server, etc.), d’éviter le verrouillage propriétaire (« lock-in »), la volonté de réduire la dépendance aux GAFAM, ainsi que le besoin de reprendre le contrôle sur les données et l’infrastructure informatique.  

Car cette démarche s’inscrit également dans une logique d’hébergement maîtrisé, soit en infrastructure on-premise, soit sur des serveurs hébergés en France ou en Europe, par exemple chez OVHcloud, afin de garantir une meilleure maîtrise des données, de leur localisation et des services associés.


Voici un tableau pour montrer économiquement la différence entre une solution propriétaire basée sur les produits Microsoft, ou une stack open-source auto-hébergée.

| Besoin | Solution propriétaire | Coût estimé / an | Solution retenue (open-source) | Coût |
|---|---|---|---|---|
| Pare-feu / routeur | Cisco ASA / Fortinet | 500 – 2 000 € | pfSense | Gratuit |
| Annuaire / AD | Windows Server + CAL | 600 – 1 200 € | Samba AD DC | Gratuit |
| SSO / IAM | Azure AD P1 | 720 € | Authentik | Gratuit |
| Reverse proxy | F5 Nginx Plus | 500 – 1 500 € | Nginx Proxy Manager | Gratuit |
| Partage de fichiers | SharePoint / OneDrive | Inclus M365 | Nextcloud / TrueNas | Gratuit |
| Messagerie | Microsoft 365 Business Basic | 720 – 1 440 € | Mailcow | Gratuit |
| Supervision | PRTG / Datadog | 500 – 2 000 € | Zabbix + Grafana | Gratuit |
| Disponibilité services | Site24x7 / Pingdom | 200 – 600 € | Uptime Kuma | Gratuit |
| Sauvegarde | Veeam Backup / Acronis | 300 – 800 € | Proxmox Backup Server | Gratuit |
| IDS/IPS | Darktrace / Snort commercial | 2 000 – 5 000 € | Suricata | Gratuit |
| SIEM | Microsoft Sentinel / Splunk | 1 500 – 5 000 € | Wazuh | Gratuit |
| **Total estimé** | | **8 000 – 20 000 €/an** | | **0 €/an** |


> Estimations indicatives pour 10 à 20 utilisateurs, hors coûts d'intégration et de maintenance. Les coûts propriétaires incluent les licences uniquement.

Le choix de la stack open-source permet une économie non négligeable pour des TPE/PME sur les licences, tout en offrant des fonctionnalités équivalentes.  

Au-delà de l’aspect économique, cette approche favorise la souveraineté numérique, une meilleure compatibilité avec les standards ouverts, ainsi que la transparence des solutions utilisées. Enfin, elle contribue à renforcer l’indépendance numérique de l’entreprise, un enjeu devenu important à prendre en compte.  


## 2.5 Solution retenues et justification des choix

Pour chaque composant, plusieurs alternatives open-source ont été étudiées avant de retenir la solution finale.

| Besoin | Solution retenue | Alternatives étudiées | Raison du choix |
|---|---|---|---|
| Pare-feu / routeur | **pfSense** | OPNsense, VyOS | Interface mature, large communauté, nombreux plugins (IDS intégré, VPN), documentation abondante. OPNsense est une alternative sérieuse mais la communauté pfSense est plus large. |
| Annuaire LDAP / AD | **Samba AD DC** | OpenLDAP, FreeIPA | Seule solution open-source implémentant nativement Active Directory complet (Kerberos, GPO, SYSVOL). Compatible RSAT sans configuration supplémentaire. OpenLDAP est plus léger mais ne gère pas les GPO. |
| SSO / IdP | **Authentik** | Keycloak, Authelia | Interface moderne et intuitive, synchronisation LDAP native, support OIDC et SAML. Plus léger que Keycloak (qui nécessite une JVM et plus de RAM). Authelia est plus limité en fonctionnalités. |
| Reverse proxy | **Nginx Proxy Manager** | Traefik, Caddy | Interface graphique simple, gestion automatique des certificats Let's Encrypt intégrée, adapté à une infrastructure sans CI/CD. Traefik est plus adapté aux environnements Docker orchestrés. |
| Partage de fichiers | **Nextcloud** | Seafile, Pydio Cells | Écosystème applicatif très riche, intégration LDAP/OIDC native, très répandu en entreprise, applications mobiles matures. Seafile est plus performant en transfert pur mais moins intégré. |
| Messagerie | **Mailcow** | Mailu, iRedMail | Stack complète clé en main (Postfix, Dovecot, Rspamd, SOGo, antispam). Interface d'administration moderne. Mailu est plus léger mais moins complet. iRedMail est moins maintenu. |
| Supervision métriques | **Zabbix + Grafana** | Nagios, Checkmk, Prometheus seul | Zabbix pour la collecte et les alertes (agents natifs Linux/Windows/SNMP), Grafana pour la visualisation avancée. Combinaison standard en production. Nagios est vieillissant. Checkmk est une bonne alternative mais moins personnalisable. |
| Disponibilité services | **Uptime Kuma** | Statping, Cachet | Très léger, interface moderne, multiples canaux de notification (email, Telegram, Slack, Discord). Statping est moins activement maintenu. |
| Sauvegarde | **Proxmox Backup Server** | Bacula, Amanda, Veeam | Intégration native et transparente avec Proxmox VE, déduplication des données, restauration granulaire fichier par fichier, entièrement gratuit. Veeam Community Edition est limité à 10 workloads. |
| IDS/IPS | **Suricata** | Snort, Zeek | Multithreading natif (plus performant que Snort sur les flux modernes), règles Emerging Threats Open gratuites et régulièrement mises à jour, format de log EVE JSON facilitant l'intégration avec un SIEM. |
| SIEM | **Wazuh** | Elastic SIEM, OpenSearch Security | Stack tout-en-un intégrée (Manager + Indexer + Dashboard), agents disponibles Linux et Windows, intégration native des logs Suricata, FIM (File Integrity Monitoring) inclus. Elastic SIEM nécessite plus de configuration manuelle. |

# 3. Analyse et conception de la solution  

## 3.1 Architecture globale

L"infrastructure est déployée sur un hyperviseur Proxmox, combinant des conteneurs LXC et des machines virtuelles ( VM ) selon les contraintes de chaque service.

