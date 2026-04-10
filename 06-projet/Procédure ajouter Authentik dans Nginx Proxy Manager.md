##  Ajouter Authentik dans Nginx Proxy Manager


Dans NginxProxy Manager ( port 81 ), cliquer **Ajouter Hôte proxy** et renseigner :

| Champ | Valeur |
|---|---|
| **Domain Names** | `authentik.delphin-lab.fr` |
| **Scheme** | `http` |
| **Forward Hostname / IP** | `10.42.1.10` |
| **Forward Port** | `9000` |
| **Block Common Exploits** | ✅ |
| **Websockets Support** | ✅ |

Dans l'onglet **SSL** :

- Sélectionner **Request a new SSL Certificate** (Let's Encrypt)
- Cocher **Force SSL**
- Cocher **HTTP/2 Support**

Valider et vérifier que le proxy host passe en statut **En ligne**.

**Test** : accéder à `https://authentik.delphin-lab.fr` depuis un navigateur et vérifier que l'interface Authentik s'affiche sans erreur de certificat.