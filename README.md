# Projet de Création d'une base de données pour une boutique d'accessoire de danse 

## Décomposition en 3 fichiers : 
* Un fichier contient la base en elle-même, avec les tables, les clés étrangères, et toutes les contraintes qui peuvent être associées  
* Un fichier contient les insertions effectuées dans la base en respectant les différentes contraintes  
* Un fichier contient différentes requêtes SQL pour interroger la base sur différents aspects (Client, Vendeur et autres)

## Déroulement du projet :  

### Cibler les besoins du client  
Nous avons d'abord interrogé la boutique pour savoir qu'est-ce qu'ils attendaient de la base de données (jusqu'où devait elle être modélisés).
Après avoir obtenu les informations nécessaires nous avons débuté la partie conception de la base.  

### Conception de la base de données
Nous avons ensuite modélisé la base de données dans un MCD (Modèle Conceptuel de Données) sur Looping que nous avons ensuite converti en 
schéma relationnel sur Mocodo pour ensuite l'implémenter en SQL. 

### Réalisation de la base de données 
Une fois la conception réalisée nous avons donc implémenté en SQL la base de données avec les différentes contraintes qui pouvaient être modélisées.
Pour tester la base nous avons donc inséré un jeu de données assez large que nous ensuite appelé dans un ensemble de requêtes SQL. 
