## Procédure config réseau IP Statique Débian 

Tout se passe dans le fichier `/etc/network/interfaces`

IP statique  
```bash
allow-hotplug ens18
iface ens18 inet static
    address X.X.X.X/Y
    gateway X.X.X.X
    dns-nameservers X.X.X.X
    dns-domain xxx.lan
```

DHCP  
```bash
allow-hotplug eth0
iface ens18 inet dhcp
```