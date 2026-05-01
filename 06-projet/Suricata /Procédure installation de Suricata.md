# Procédure d'installation de Suricata

## Configuration Minimal 

A se renseigner

## Pré Requis 

Avoir un adresse IP fixe 

[Procédure sur Débian](/06-projet/Procédure%20Utile/Procédure%20config%20réseau%20Débian.md)


## Installation  

Installer depuis les dépots : 

```bash
apt update
apt install suricata suricata-update jq -y
```
> `jq` est utile pour lire les `eve.json` proprement en CLI


## Configuration

Identifier l'interface du réseau : 

```bash
ip -br a
```

Éditer le fichier suricata.yaml :

```bash
nano /etc/suricata/suricata.yaml
```

Dans la section `af-packet` pour définir l'interface d'écoute : 

```bash
af-packet:
  - interface: ens18       # ← à adapter avec l'interface réseau
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes
```

Dans la section `vars` > `address-groups` pour définir le réseau a protéger : 

```bash
vars:
  address-groups:
    HOME_NET: "[10.42.0.0/16,192.168.42.0/24]" # LAN interne + réseau de transit pfSense/Proxmox OVH
    EXTERNAL_NET: "!$HOME_NET"
```

Dans la section `outputs` > `eve-log` verifier que eve-log est activé :

```bash
outputs:
  - eve-log:
      enabled: yes
      filetype: regular
      filename: eve.json
```

Dans la section `outputs` > `eve-log` > `types` > `alert` pour activer les détails dans les logs:

```bash 
- alert:
    payload: yes
    payload-printable: yes
    packet: yes
    tagged-packets: yes
```
> ⚠️ Attention a l'indentation

> 💡 __Pourquoi décommenter ces lignes ?__ Par défaut, Suricata ne log que le minimum (signature, IP, port). En activant payload et payload-printable, vous aurez le contenu du paquet qui a déclenché l'alerte 


Sauvegarde le fichier `suricata.yaml`

Pour vérifier la syntaxe du fichier yaml : 

```bash
suricata -T -c /etc/suricata/suricata.yaml
```

on devrait avoir une réponse comme : 

```bash
i: suricata: This is Suricata version 7.0.10 RELEASE running in SYSTEM mode
i: suricata: Configuration provided was successfully loaded. Exiting.
```

## Télécharger des règles

Un des jeux de règles le plus courant est __Emerging Threats Open__ 

```bash
suricata-update
```

Cette commande télécharge et installe les règles dans `/var/lib/suricata/rules/suricata.rules`

On peut vérifier le nombre de règles chargées :

```bash
grep -c "^alert" /var/lib/suricata/rules/suricata.rules
```

Il devrait en avoir plusieurs dizaine de milliers


## Démarrer Suricata 

```bash
systemctl enable suricata
systemctl start suricata
systemctl status suricata
```

Vérifier les logs de démarrage : 

```bash
tail -f /var/log/suricata/suricata.log
```

On devrait voir sur une ligne quelque chose comme :   

```bash
Info: detect: 49813 signatures processed. 1289 are IP-only rules, 4485 are inspecting packet payload, 43804 inspect application layer, 109 are decoder event only
```

Cette ligne confirme que les règles ont bien était chargés

> ⚠️ Au premier démarrage, Suricata peut mettre 30 secondes à 2 minutes pour charger toutes les règles.  
> Il faut possiblement des fois redémarrer une nouvelle fois Suricata

## Test des alertes avec un événement connu

On va tester avec une URL qui retourne volontairement la chaîne uid=0(root) dans sa réponse HTTP, ce qui déclenche la règle ET ATTACK_RESPONSE (SID 2100498). 

```bash
apt install curl -y
curl http://testmynids.org/uid/index.html
```

On vérifie que l'alerte c'est bien déclencher : 

```bash
cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'
```

On devrait retrouver quelque chose comme : 

```json
{
  "timestamp": "2025-XX-XXTXX:XX:XX.XXXXXX+0000",
  "event_type": "alert",
  "src_ip": "10.42.2.31",
  "dest_ip": "XXX.XXX.XXX.XXX",
  "alert": {
    "action": "allowed",
    "signature_id": 2100498,
    "signature": "GPL ATTACK_RESPONSE id check returned root",
    "category": "Potentially Bad Traffic",
    "severity": 2
  }
}
```

On peut vérifier par le log simplifié aussi : 

```bash
cat /var/log/suricata/fast.log
```

On devrait retrouver une ligne comme :

```bash
GPL ATTACK_RESPONSE id check returned root [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 52.85.47.4:80 -> 10.42.2.31:46544
```

## Bonus

[Procédure lier un agent Wazuh pour Suricata](/06-projet/Wazuh/Procédure%20lier%20un%20agent%20Wazuh%20pour%20Suricata.md)