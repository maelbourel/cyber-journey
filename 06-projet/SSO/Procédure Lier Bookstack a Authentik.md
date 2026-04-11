# Intégration de Bookstack avec Authentik (SSO via OIDC)

## Prérequis

- Authentik installé et fonctionnel
- Bookstack installé et fonctionnel
- Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter Authentik dans Nginx Proxy Manager]())
- DNS interne résolvant les sous-domaines `*.delphin-lab.fr` vers le reverse proxy



## 1 Créer l'application et le provider

- Se connecter à l'interface admin Authentik
- Naviguer vers **Applications → Applications**
- Cliquer sur **Create with Provider** 

**Étape 1 — Application :**

| Champ | Valeur |
|---|---|
| **Nom** | `Bookstack` |
| **Slug** | `bookstack` |

  
> ⚠️ Noter le **slug** de coter, il sera utilisé dans l'URL de l'OIDC Issuer.  

**Étape 2 — Choisir un fournisseur :**

- Sélectionner **OAuth2/OpenID Connect Provider**

**Étape 3 — Configurer le fournisseur :**

| Champ | Valeur |
|---|---|
| **Flux d'autorisation** | `default-provider-authorization-implicit-consent` |
| **URI/Origines de redirection** | `Strict` — `https://bookstack.delphin-lab.fr/oidc/callback` |
| **URI de déconnexion** | *(laisser vide)* |
| **Clé de signature** | `authentik Self-signed Certificate` |

> **Pourquoi implicit-consent ?** Pour des applications internes, ce flux évite l'écran de consentement à chaque connexion. L'utilisateur est redirigé automatiquement sans validation intermédiaire.

**Étape 4 — Configurer les liaisons :**

- Optionnel : permet de restreindre l'accès à certains groupes/utilisateurs
- Peut être laissé vide pour un accès ouvert à tous les utilisateurs synchronisés

**Étape 5 — Soumettre**

## 2 Récupérer les informations du provider

Après la création, naviguer vers **Applications → Providers** et cliquer sur le provider Bookstack.

Noter les trois informations suivantes :

| Information | Où la trouver | Exemple |
|---|---|---|
| **Client ID** | En haut de la page du provider | `ihvM4oZ6IDs58Xeq4PRmDM7Dgho...` |
| **Client Secret** | En haut de la page du provider | `OygLwrUwATHlbJdi2NdCvV5Ol4...` |
| **OpenID Configuration Issuer** | Section "Related objects" | `https://authentik.delphin-lab.fr/application/o/bookstack/` |


## 3. Configurer Bookstack

- Aller dans le dossier docker du Bookstack  
- Dans le fichier `compose.yaml` rajouter les variables dans la section `environment` du service `bookstack` :

```yaml
environment:
  - AUTH_METHOD=oidc
  - AUTH_AUTO_INITIATE=false
  - OIDC_NAME=Authentik
  - OIDC_DISPLAY_NAME_CLAIMS=name
  - OIDC_CLIENT_ID=<Client ID depuis Authentik>
  - OIDC_CLIENT_SECRET=<Client Secret depuis Authentik>
  - OIDC_ISSUER=https://authentik.delphin-lab.fr/application/o/bookstack/
  - OIDC_ISSUER_DISCOVER=true
  - OIDC_END_SESSION_ENDPOINT=true
```
> ⚠️ Penser a bien modifier les variables avec les 3 informations qu'on a préalablement mis de coter 

> `AUTH_AUTO_INITIATE=false` Affiche un bouton "Login with Authentik". Mettre `true` pour redirection automatique une fois validé

- Toujours dans le fichier `compose.yaml` rajouter de quoi pouvoir résoudre les demandes DNS dans le service `bookstack` :

```yaml
services:
  bookstack:
    dns:
      - 10.42.2.10          # Samba AD DC (DNS interne du domaine)
    extra_hosts:
      - "authentik.delphin-lab.fr:10.42.0.5"   # Pointe vers NPM (DMZ)
```

- Ensuite on redémarre Bookstack 
```bash
docker compose up -d
```

## 4. Test et validation

1. Accéder à `https://bookstack.delphin-lab.fr/login`
2. Un bouton **Login with Authentik** doit apparaître sous le formulaire classique
3. Cliquer sur le bouton → redirection vers Authentik
4. Se connecter avec un compte du domaine (synchronisé depuis Samba AD)
5. Après authentification, retour automatique vers Bookstack, session ouverte

