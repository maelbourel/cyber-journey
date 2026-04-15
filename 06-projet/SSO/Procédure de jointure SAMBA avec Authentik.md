# Procédure de jointure [[SAMBA]] avec Authentik

## Prérequis 

Il faut créer un compte de service sur le [[Samba]] AD DC. Ce compte sera utilisé par Authentik pour interroger l'annuaire et synchroniser les utilisateurs/groupes. 

Depuis les outils [[RSAT]] crée un utilisateur, par exemple svc-authentik, avec un mot de passe solide. Ce compte n'a pas besoin de droits admin il lui faut juste la permission de lire l'annuaire.


## Procédure

Depuis l'interface Web Authentik aller dans l'interface Administration   

```Répertoire > Fédération & connection sociale > Créer```  



__Remplir les champs__:
* __<u>Dans général</u>__
* Nom : ```Samba AD - stage.lan```
* Slug : ```samba-ad-stage-lan```
* Activé : coché
* Synchronistation des __utilisateurs__ et des __groupes__ : coché (pour importer automatiquement l'annuaire dans Authentik)
* Réécriture du mot de passe utilisateur: coché (permet à Authentik de garder un hash du mot de passe en cache => si serveur LDAP temporairement injoignable, les utilisateurs peuvent quand même se connecter)
* __<u>Dans Paramètres de connexion</u>__
* URI du serveur : ```ldap://10.42.2.10```
* Bind DN : ```svc-authentik@stage.lan```
* Mettre un __Mot de passe__
* DN racine : ```DC=stage,DC=lan```
* __<u>Dans Mappage des attributs LDAP</u>__
* Pour Mappage des propriétés des utilisateurs : sélectionner tous les mapping commençant par```authentik default LDAP```
* Pour mappage des propriétés des groupes : sélectionner ```authentik default LDAP Mapping: Name```
* __<u>Dans Paramètres additionnels</u>__
* Filtre des objets utilisateur : ```(&(objectClass=user)(!(objectClass=computer)))``` (exclut les compte machines de la synchronisation)
* Filtres des objets de groupe : ```(objectClass=group)```
* Champ d'unicité de l'objet : ```objectSid```
* On peut maintenant __Valider__

Authentik va lancer la synchronistation en arrière-plan. On peut vérifier l'avancement dans ```Tableau de bord > Tâches du système```

Le statut des tâches passe en ```Réussite```


