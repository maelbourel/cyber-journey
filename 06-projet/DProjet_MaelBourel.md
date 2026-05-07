# DOSSIER PROJET

Titre Professionnel : Administrateur d’Infrastructures Sécurisées




MAEL BOUREL

BLABLA BLABLA

Période de stage / tuteur entreprise

# Sommaire 

1. Page de garde

2. Présentation de l’entreprise et du contexte  
	2.1 Présentation de la structure d’accueil  
	2.2 Contexte du projet  
	2.3 Objectif de la mission   

3. Analyse et conception de la solution  
	3.1 Choix de l’approche open-source  
	3.2 Architecture globale  
	3.3 Plan d’adressage réseau  

4. Gestion de projet


# 2. Présentation de l'entreprise et du contexte

## 2.1 Présentation de la structure d'accueil 

Delphin Informatique est une entreprise de services numériques dans l'administration système et réseau, le conseil en systèmes d'information et le développement web. Elle est dirigée par Baptiste Delphin et intervient principalement auprès de TPE et PME souhaitant moderniser ou sécuriser leur infrastructure informatique.

Son positionnement est résolument orienté vers les solutions libres et open-source. 

## 2.2 Contexte du projet

La mission confiée s'inscrit dans la continuité de l'activité de Delphin Informatique : concevoir une infrastructure informatique complète open-source qui peut répondre aux besoins des TPE et PME.

Ce type de structure présente généralement les problématiques suivantes :

- Gestion des comptes utilisateurs dispersée et manuelle sur chaque service.

- Absence de SSO : Entraînant de multiple identifiants et mot de passe différents selon les applications.

- Aucune supervision de l'infrastructure : les pannes et anomalies ne sont détectées qu'a posteriori.

- Pas de solution de partage de fichiers collaborative et sécurisée.

- Pas de serveur de messagerie professionnel.
  
- Exposition aux menaces extérieur.

## 2.3 Objectif de la mission

L'objectif est de concevoir et déployer un proof of concept (PoC) d'infrastructure complète, entièrement basé sur des logiciels libres et open-source, démontrant qu'une TPE ou PME peut disposer d'un système d'information structuré, sécurisé et maintenable sans coût de licence logicielle.



L'ensemble de la démarche donne également lieu à une documentation technique complète, réutilisable par Delphin Informatique dans ses interventions clients.

# 3. Analyse et conception de la solution  

## 3.1 Choix de l’approche open-source  

Le choix d’une stack exclusivement open source répond à plusieurs enjeux rencontrés par les TPE/PME, notamment les contraintes budgétaires liées aux licences logicielles (Microsoft 365, Windows Server, etc.), d’éviter le verrouillage propriétaire (« vendor lock-in »), la volonté de réduire la dépendance aux GAFAM, ainsi que le besoin de reprendre le contrôle sur les données et l’infrastructure informatique. Car cette démarche s’inscrit également dans une logique d’hébergement maîtrisé, soit en infrastructure on-premise, soit sur des serveurs hébergés en France ou en Europe, par exemple chez OVHcloud, afin de garantir une meilleure maîtrise des données, de leur localisation et des services associés.

Au-delà de l’aspect économique, cette approche favorise la souveraineté numérique, une meilleure compatibilité avec les standards ouverts, ainsi que la transparence des solutions utilisées. Enfin, elle contribue à renforcer l’indépendance numérique de l’entreprise, un enjeu devenu important à prendre en compte.

## 3.2 Architecture globale

