# Intégration de Grafana avec Authentik (SSO via OIDC)

A RELIRE ET A TESTER CETTE DOC


## Prérequis

- Authentik installé et fonctionnel
- Grafana installé et fonctionnel

## 1 Créer l'application et le provider

- Se connecter à l'interface admin Authentik
- Naviguer vers **Applications → Applications**
- Cliquer sur **Create with Provider** 

**Étape 1 — Application :**

| Champ | Valeur |
|---|---|
| **Nom** | `Grafana` |
| **Slug** | `grafana` |

  
> ⚠️ Noter le **slug** de coter, il sera utilisé dans l'URL de l'OIDC Issuer.  

**Étape 2 — Choisir un fournisseur :**

- Sélectionner **OAuth2/OpenID Connect Provider**

**Étape 3 — Configurer le fournisseur :**

| Champ | Valeur |
|---|---|
| **Flux d'autorisation** | `default-provider-authorization-implicit-consent` |
| **URI/Origines de redirection** | `Strict` — `http://ipgrafana:3000/login/generic_oauth` |
| **URI de déconnexion** | `https://ipgrafana:3000/logout` |
| **Logout Method** | Cocher `Front-channel`
| **Clé de signature** | `authentik Self-signed Certificate` |

Dans `Advanced protocol settings` pour les scopes rajouter `authentik default Oauth Mapping : Application Entitlements` en plus de `email` `openid` et `profile`  



**Étape 4 — Configurer les liaisons :**

- Optionnel : permet de restreindre l'accès à certains groupes/utilisateurs
- Peut être laissé vide pour un accès ouvert à tous les utilisateurs synchronisés

**Étape 5 — Soumettre**


## 2. Configurer Grafana

- Aller dans le dossier docker du Grafana  
- Dans le fichier `docker-compose.yaml` rajouter les variables dans la section `environment` du service `bookstack` :

```yaml
environment:
        GF_AUTH_GENERIC_OAUTH_ENABLED: "true"
        GF_AUTH_GENERIC_OAUTH_NAME: "authentik"
        GF_AUTH_GENERIC_OAUTH_CLIENT_ID: "CLIENT ID a Récupérer sur provider"
        GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET: "CLIENT SECRET a Récupérer sur provider"
        GF_AUTH_GENERIC_OAUTH_SCOPES: "openid profile email entitlements"
        GF_AUTH_GENERIC_OAUTH_AUTH_URL: "https://<addresse-authentik>/application/o/authorize/"
        GF_AUTH_GENERIC_OAUTH_TOKEN_URL: "https://<addresse-authentik>/application/o/token/"
        GF_AUTH_GENERIC_OAUTH_API_URL: "https://<addresse-authentik>/application/o/userinfo/"
        GF_AUTH_SIGNOUT_REDIRECT_URL: "https://<addresse-authentik>/application/o/grafana/end-session/"
        # Optionally enable auto-login (bypasses Grafana login screen)
        #GF_AUTH_OAUTH_AUTO_LOGIN: "true"
        # Optionally map user entitlements to Grafana roles
        GF_AUTH_GENERIC_OAUTH_ROLE_ATTRIBUTE_PATH: "contains(entitlements[*], 'Grafana Admins') && 'Admin' || contains(entitlements[*], 'Grafana Edito> 
        # Required if Grafana is running behind a reverse proxy
        GF_SERVER_ROOT_URL: "http://<ipgrafana>:3000"
        GF_AUTH_GENERIC_OAUTH_REDIRECT_URI: "http://<ipgrafana>:3000/login/generic_oauth"
```
> ⚠️ Penser a bien modifier les variables avec les bonne informations qu'on récupère sur Authentik 


- Toujours dans le fichier `docker-compose.yaml` rajouter de quoi pouvoir résoudre les demandes DNS dans le service `grafana` :

```yaml
services:
  bookstack:
    dns:
      - 10.42.2.10          # Samba AD DC (DNS interne du domaine)
    extra_hosts:
      - "authentik.delphin-lab.fr:10.42.0.5"   # Pointe vers NPM (DMZ)
```

- Ensuite on redémarre Grafana 
```bash
docker compose down
docker compose up -d
```

## 3. Test et validation

