# Procédure de jointure SAMBA avec Authentik

## Prérequis 

Il faut créer un compte de service sur le Samba AD DC. Ce compte sera utilisé par Authentik pour interroger l'annuaire et synchroniser les utilisateurs/groupes. 

Depuis les outils RSAT crée un utilisateur, par exemple svc-authentik, avec un mot de passe solide. Ce compte n'a pas besoin de droits admin il lui faut juste la permission de lire l'annuaire.


## Procédure

Depuis l'interface Web Authentik aller dans l'interface Administration   

Répertoire > Fédération &amp;Connection Social > Créer  

Choisir Source LDAP 
