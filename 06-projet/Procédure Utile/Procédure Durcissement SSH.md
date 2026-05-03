# Procédure Durcissement SSH

> ⚠️ Attention ⚠️ Ne pas se couper l'accès   
> Toujours  tester la nouvelle configuration dans une session séparée avant de fermer la session active. 

## Créer un utilisateur dédié 

```bash
# Installer sudo 
apt install -y sudo

# Crée l'utilisateur d'administration dédié 
useradd -m -s /bin/bash adminlab
passwd adminlab

# Vérifier les droits sudo 
groups adminlab
``` 

### Optionnel - sudo sans mot de passe pour cet utilisateur 

```bash
visudo -f /etc/sudoers.d/adminlab
```
Ajouter : 

```bash 
adminlab ALL=(ALL) NOPASSWD : ALL
```  

## Générer et déployer les clés SSH 

### Pour un poste Linux 

Générer la clé

```bash
ssh-keygen -t ed25519 -C "adminlab@delphin-lab.fr" -f ~/.ssh/delphin_ed25519

# Proteger la clé privée avec une passphrase forte
```  

Déployer la clé

```bash
ssh-copy-id -i ~/.ssh/delphin_ed25519.pub adminlab@<IP_SERVEUR>
```  

### Pour un poste Windows 

Générer la clé

```powershell
ssh-keygen -t ed25519 -C "adminlab@delphin-lab.fr" -f "$env:USERPROFILE\.ssh\delphin_ed25519"

# Proteger la clé privée avec une passphrase forte
```  

Déployer la clé

```powershell
$pubkey = Get-Content "$env:USERPROFILE.ssh\delphin_ed25519.pub"  

ssh adminlab@<IP_SERVEUR> "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$pubkey' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```  

## Vérifier les permissions et la connexion par clé

Verification des permission :

```bash
# Sur le serveur cible
chmod 700 /home/adminlab/.ssh
chmod 600 /home/adminlab/.ssh/authorized_keys
chown -R adminlab:adminlab /home/adminlab/.ssh

# Vérifier 
ls -la /home/adminlab/.ssh
```

Vérification de la connexion :

```bash
ssh -i ~/.ssh/delphin_ed25519 adminlab@<IP_SERVEUR>
```

## Configuration du sshd_config

> ⚠️ A modifier seulement après avoir vérifier que la connexion par clé marche bien 

Éditer le fichier sshd_config :

```bash
nano /etc/ssh/sshd_config
```


```bash
Port 5000 
# Pour changer le port attention pour la connexion il faudra preciser ce port avec l'argument -p 5000

PermitRootLogin no 
# Pour désactiver la connexion root

PasswordAuthentication no 
PermitEmpyPassword no
# Pour désactiver les connexion par mdp

PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
# Pour autoriser les clés SSH
```

Relancer le service : 
```bash
systemctl reload sshd
# Priviliger reload pour ne pas couper session existant sinon restart
```






