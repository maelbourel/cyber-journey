# 🪟 Windows – Logs événements (Sécurité)

## 🔹 Rôle des logs

Les logs permettent de :
- détecter des incidents
- analyser des attaques
- enquêter après coup


## 🔹 Event Viewer

Outil central de visualisation des événements.


## 🔹 Logs importants

| Journal | Contenu |
|------|-------|
| Security | authentification, accès |
| System | services, démarrage |
| Application | erreurs applicatives |


## 🔹 Événements clés (SOC)

| Event ID | Signification |
|-------|--------------|
| 4624 | connexion réussie |
| 4625 | échec de connexion |
| 4672 | privilèges spéciaux |
| 4688 | création de processus |
| 4720 | création utilisateur |
| 4728 | ajout à groupe |


## 🔹 Sécurité (AIS)

- brute force détectable via 4625
- élévation de privilèges
- mouvements latéraux

## 🔹 Centralisation

- SIEM recommandé
- corrélation d’événements
- alertes automatiques
