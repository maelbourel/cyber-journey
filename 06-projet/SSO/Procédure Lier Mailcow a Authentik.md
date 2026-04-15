# Intégration de Mailcow avec Authentik (SSO via OIDC)

## Prérequis

- Authentik installé et fonctionnel
- Mailcow installé et fonctionnel
- Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter Authentik dans Nginx Proxy Manager]())
- DNS interne résolvant les sous-domaines `*.delphin-lab.fr` vers le reverse proxy



## 1 Créer l'application et le provider

- Se connecter à l'interface admin Authentik
- Naviguer vers **Applications → Applications**
- Cliquer sur **Create with Provider** 

**Étape 1 — Application :**

| Champ | Valeur |
|---|---|
| **Nom** | `Mailcow` |
| **Slug** | `Mailcow` |

  

**Étape 2 — Choisir un fournisseur :**

- Sélectionner **OAuth2/OpenID Connect Provider**

**Étape 3 — Configurer le fournisseur :**

| Champ | Valeur |
|---|---|
| **Flux d'autorisation** | `default-provider-authorization-implicit-consent` |
| **URI/Origines de redirection** | `Strict` — `https://mail.delphin-lab.fr` |

| **Clé de signature** | `authentik Self-signed Certificate` |


**Étape 4 — Soumettre**


## 3. Configurer Mailcow

- Se connecter en tant que admin 
- Naviger vers `Systeme > Configuration > Accès > Identity Provider`

| Champ | Valeur |
|---|---|
Fournisseur d'identité | Generic-OIDC
Endpoint d'autorisation: | https://auth.delphin-lab.fr/application/o/authorize/ 
Endpoint Token: | https://auth.delphin-lab.fr/application/o/token/
Endpoint User info: | https://auth.delphin-lab.fr/application/o/userinfo/
ID Client: | ID Client fournit sur Authentik
Secret Client: | Secret Client fournit sur Authentik
Url de redirection: | https://mail.delphin-lab.fr
Scopes Client: | openid profile email  

- Cocher Ignorer les erreur SSL   
- Cocher Créer automatiquement l'utilisateur à la connexion

- Naviguer vers `courriel > Configuration > Boites de réception > Modèles 
- Selectionner le modèle par `Default` et tout en bas bien cocher la case `Redirection directe vers SOGo`

> ⚠️ si soucis de connexion échoué a cause de problèmes de certificat modifier le `docker-compose.override.yml`

## 4. Modifier le fichier `docker-compose.override.yml`

Depuis la VM mailcow

```bash
sudo nano /opt/mailcow-dockerized/docker-compose.override.yml
```

Rajouter ce block :

```bash
services:
  php-fpm-mailcow:
    extra_hosts:
      - "auth.delphin-lab.fr:10.42.0.5"
  sogo-mailcow:
    extra_hosts:
      - "auth.delphin-lab.fr:10.42.0.5"
    volumes:
      - ./data/assets/ssl/authentik-ca.crt:/usr/local/share/ca-certificates/authentik.crt:ro
  nginx-mailcow:
    extra_hosts:
      - "auth.delphin-lab.fr:10.42.0.5"
```

Puis stopper et relancer le service 

```bash
sudo docker compose down
sudo docker compose up -d
```

Une fois le service relancer exécuter : 

```bash
sudo docker compose exec sogo-mailcow update-ca-certificates
```

## 5. Test et validation

1. Accéder à `https://mail.delphin-lab.fr/`
2. Un bouton **Single Signe-On** doit apparaître sous le formulaire classique
3. Cliquer sur le bouton → redirection vers Authentik
4. Se connecter avec un compte du domaine (synchronisé depuis Samba AD)
5. Après authentification, retour automatique vers mailcow, session ouverte
