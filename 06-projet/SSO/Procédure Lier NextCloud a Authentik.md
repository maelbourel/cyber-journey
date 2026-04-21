# Intégration de Nextcloud avec Authentik (SSO via OIDC)

## Prérequis

- Authentik installé et fonctionnel
- NextCloud installé et fonctionnel
- Nginx Proxy Manager (NPM) configuré ( voir [Procédure ajouter Authentik dans Nginx Proxy Manager]())
- DNS interne résolvant les sous-domaines `*.delphin-lab.fr` vers le reverse proxy



## 1 Créer un property mapping ( optionnel mais recommandé )

Cette étape permet de synchroniser les groupes, gérer les quotas de stockage et désigner les administrateurs Nextcloud depuis Authentik.  

- Se connecter à l'interface admin Authentik
- Naviguer vers Customization → Property mappings
- Cliquer Create → sélectionner Scope mapping
- Renseigner les champs suivants :

Champ | Valeur 
---|---
Name | Nextcloud Profile 
Scope Name | nextcloud  

- Dans le champ Expression, coller le code suivant : 

```bash
# Récupérer tous les groupes de l'utilisateur
groups = [group.name for group in user.groups.all()]

# Les admins Nextcloud doivent être dans un groupe nommé "admin" (statique, imposé par Nextcloud)
if user.is_superuser and "admin" not in groups:
    groups.append("admin")

return {
    "name": request.user.name,
    "groups": groups,
    # Quota de stockage (définir l'attribut "nextcloud_quota" sur l'utilisateur ou le groupe dans Authentik)
    "quota": user.group_attributes().get("nextcloud_quota", None),
    # Pour lier un utilisateur Nextcloud existant, définir l'attribut "nextcloud_user_id" dans Authentik
    "user_id": user.attributes.get("nextcloud_user_id", str(user.uuid)),
}
```

>💡 Quotas : pour définir un quota, ajouter l'attribut nextcloud_quota (ex : 15 GB) sur un utilisateur ou un groupe dans Authentik. Sans cet attribut, le stockage est illimité.

>💡 Lier un utilisateur existant : pour connecter un compte Nextcloud déjà existant, ajouter l'attribut nextcloud_user_id sur l'utilisateur dans Authentik, avec comme valeur le nom d'utilisateur Nextcloud.


## 2 Créer l'application et le provider

- Se connecter à l'interface admin Authentik
- Naviguer vers **Applications → Applications**
- Cliquer sur **Create with Provider** 

**Étape 1 — Application :**

| Champ | Valeur |
|---|---|
| **Nom** | `Nextcloud` |
| **Slug** | `nextcloud` |


**Étape 2 — Choisir un fournisseur :**

- Sélectionner **OAuth2/OpenID Connect Provider**

**Étape 3 — Configurer le fournisseur :**

| Champ | Valeur |
|---|---|
| **Flux d'autorisation** | `default-provider-authorization-implicit-consent` |
| **URI/Origines de redirection** | `Strict` — `https://cloud.delphin-lab.fr/apps/user_oidc/code` |

| **Clé de signature** | `authentik Self-signed Certificate` |


Dans Paramètres avancés du protocole :

Champ |	Valeur 
---|---
Scopes sélectionnés | Ajouter Nextcloud Profile (si créé à l'étape 1) en plus des scopes par défaut
Subject Mode |	Based on the User's UUID


**Étape 4 — Soumettre**


## 3. Configurer NextCloud

**Étape 1 — Installer l'app OpenID Connect**  

- Se connecter à Nextcloud en tant qu'administrateur
- Naviguer vers Apps → Vos applications (icône profil en haut à droite)
- Rechercher OpenID Connect user backend
- Cliquer Installer et activer  

**Étape 2 — Configurer le provider OIDC** 

- Naviguer vers Paramètres → OpenID Connect
- Cliquer sur le bouton + pour ajouter un nouveau provider
- Renseigner les champs suivants :  


Champ	| Valeur
---|---
Identifier |	authentik
Client ID |	Client ID copié depuis Authentik
Client secret |	Client Secret copié depuis Authentik
Discovery endpoint |	https://auth.delphin-lab.fr/application/o/nextcloud/.well-known/openid-configuration
Scope |	email profile nextcloud openid  

> ⚠️ Si le property mapping Nextcloud Profile n'a pas été créé, mettre uniquement email profile openid dans le champ Scope (sans nextcloud).

Champ	| Valeur
---|---
User ID mapping |	sub
Display name mapping |	name
Email mapping |	email
Quota mapping |	quota (laisser vide si pas de property mapping Nextcloud Profile)
Groups mapping |	groups (laisser vide si pas de property mapping Nextcloud Profile)

- Decocher `Utiliser un ID utilisateur unique` 
- Cocher `Utilisez le provisionnement de groupe`

> ⚠️ Administrateurs : si vous utilisez le property mapping Nextcloud Profile et que vous voulez que les admins conservent leurs droits, assurez-vous que Use unique user ID est désactivé. Sinon, les admins seront retirés du groupe admin interne et crée un groupe `admin` dans Authentik


## 4. Modifier le fichier `docker-compose.yml`

Si problème de connexion le conteneur doit pouvoir résoudre authentik.delphin-lab.fr Rajouter dans le docker-compose.yml :

```bash
services:
  nextcloud:
    dns:
      - 10.42.2.10    # Samba AD DC (DNS interne du domaine)
    extra_hosts:
      - "auth.delphin-lab.fr:10.42.0.5"   # Pointe vers NPM (DMZ)
```

Puis stopper et relancer le service 

```bash
sudo docker compose down
sudo docker compose up -d
```


## 5. Test et validation

1. Accéder à `https://cloud.delphin-lab.fr/`
2. Un bouton **Se connecter avec Authentik** doit apparaître sous le formulaire classique
3. Cliquer sur le bouton → redirection vers Authentik
4. Se connecter avec un compte du domaine (synchronisé depuis Samba AD)
5. Après authentification, retour automatique vers Nextcloud, session ouverte
