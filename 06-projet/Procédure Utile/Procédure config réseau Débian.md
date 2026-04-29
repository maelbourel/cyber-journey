## Procédure config réseau IP Statique Débian 

Tout se passe dans le fichier `/etc/network/interfaces`

IP statique  
```bash
allow-hotplug eth0
iface eth0 inet static
    address X.X.X.X/Y
    gateway X.X.X.X
    dns-nameservers X.X.X.X
    dns-domain xxx.lan
```

DHCP  
```bash
allow-hotplug eth0
iface eth0 inet dhcp
```