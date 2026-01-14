# 🪟 Windows – Kerberos & NTLM

## 🔹 Kerberos

Protocole d’authentification par tickets.

Fonctionne avec :
- DC
- tickets chiffrés
- horloge synchronisée

Avantages :
- plus sécurisé
- pas d’envoi de mot de passe

## 🔹 NTLM

Ancien protocole d’authentification.

Inconvénients :
- moins sécurisé
- vulnérable à certaines attaques
- utilisé en fallback

## 🔹 Comparaison

| Kerberos | NTLM |
|------|------|
| Tickets | Challenge-response |
| Sécurisé | Legacy |
| Moderne | À éviter |

## 🔹 Sécurité (AIS)

- NTLM doit être désactivé progressivement
- Kerberos ciblé par attaques avancées