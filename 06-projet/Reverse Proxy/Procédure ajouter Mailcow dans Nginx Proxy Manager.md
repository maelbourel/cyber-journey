##  Ajouter Mailcow dans Nginx Proxy Manager


Dans NginxProxy Manager ( port 81 ), cliquer **Ajouter Hôte proxy** et renseigner :

| Champ | Valeur |
|---|---|
| **Domain Names** | `mail.delphin-lab.fr` |
| **Scheme** | `https` |
| **Forward Hostname / IP** | `10.42.1.20` |
| **Forward Port** | `443` |
| **Block Common Exploits** | ✅ |
| **Websockets Support** | ✅ |

Dans l'onglet **SSL** :

- Sélectionner **Request a new SSL Certificate** (Let's Encrypt)
- Cocher **Force SSL**
- Cocher **HTTP/2 Support**

Valider et vérifier que le proxy host passe en statut **En ligne**.

**Test** : accéder à `https://mail.delphin-lab.fr` depuis un navigateur et vérifier que l'interface Mailcow s'affiche sans erreur de certificat.  

> ⚠️ Attention : si vous êtes sur le réseau interne, afin d'éviter des problèmes de DNS, configurez dans pfSense le DNS Resolver en ajoutant le sous-domaine `mail.delphin-lab.fr` dans les Host Overrides.