--Afficher tout les fournisseurs dont le numéro commence par 08 ou 01.
SELECT NomFournisseur, TélFournisseur
FROM Fournisseur
WHERE (TélFournisseur LIKE "%+33 8%") OR (TélFournisseur LIKE "%+33 1%")

--Afficher le montant total des achats réalisés par chaque client, en indiquant également le montant total de TVA payé.
SELECT c.NumClient, c.NomClient, c.PrénomClient, SUM(t.TotalTTCTicket) AS MontantTotalAchatsTTC, SUM(t.TotalTVATicket) AS MontantTotalTVA
FROM Client c
INNER JOIN Achat a ON a.NumClient = c.NumClient
INNER JOIN Ticket t ON a.NumTicket = t.NumTicket
GROUP BY c.NumClient, c.NomClient, c.PrénomClient;

--Afficher la quantité totale d'articles vendus par chaque vendeur pour chaque mode de règlement.
SELECT v.NumVendeur, v.NomVendeur, v.PrénomVendeur, t.ModeReglementTicket, SUM(t.QuantitéeArticleTicket) AS QuantitéTotaleVendue
FROM Vendeur v
INNER JOIN Vente ve ON ve.NumVendeur = v.NumVendeur
INNER JOIN Ticket t ON t.NumTicket = t.NumTicket
GROUP BY v.NumVendeur, v.NomVendeur, v.PrénomVendeur, t.ModeReglementTicket;

--Afficher le montant total des ventes réalisées pour chaque mode de règlement, en indiquant le pourcentage par rapport au total des ventes.
SELECT ModeReglementTicket, SUM(TotalTTCTicket) AS MontantTotalVentes,
       (SUM(TotalTTCTicket) / (SELECT SUM(TotalTTCTicket) FROM Ticket)) * 100 AS PourcentageTotal
FROM Ticket
GROUP BY ModeReglementTicket;

--Trouver les fournisseurs avec au moins un article à 5% de TVA.
SELECT F.NumFournisseur, F.NomFournisseur
FROM Fournisseur F
INNER JOIN Article A ON A.NumFournisseur = F.NumFournisseur
INNER JOIN TVA ON TVA.NumTVA = A.NumTVA
WHERE TVA.TauxTVA = 0.05;

--Afficher quel vendeur a fait le plus grand nombre de vente
SELECT V.PrénomVendeur ||  " " || V.NomVendeur AS MeilleurVendeur
FROM Vendeur V
INNER JOIN Vente Ve ON Ve.NumVendeur = V.NumVendeur
INNER JOIN Ticket T ON T.NumTicket = Ve.NumTicket
GROUP BY V.NumVendeur, V.NomVendeur
ORDER BY COUNT(T.NumTicket) DESC
LIMIT 1;

--Afficher le prénom et le nom du client avec le plus achat
SELECT C.PréNomClient ||  " " || C.NomClient AS ClientAvecLePlusGrosAchat
FROM Client C
INNER JOIN Achat Ach ON Ach.NumClient = C.NumClient
INNER JOIN Ticket T ON T.NumTicket = Ach.NumTicket
GROUP BY C.NumClient, C.NomClient
ORDER BY SUM(T.TotalHTTicket) DESC
LIMIT 1;

--Afficher le nombre total d'articles, de ventes, de vendeur, de clients et de fournisseurs.
SELECT 
	COUNT(DISTINCT A.RefArticle)	AS NombreDArticle,
	COUNT(DISTINCT T.NumTicket)		AS NombreDeTicket,
	COUNT(DISTINCT V.NumVendeur)	AS NombreDeVendeur,
	COUNT(DISTINCT C.NumClient)		AS NombreDeClients
FROM
	Article	A,
	Ticket	T,
	Vendeur	V,
	Client	C
;

--Afficher le total de TVA payé à l'État
--Si l'on souhaite utiliser les bonnes insertions:
SELECT SUM(Ticket.TotalTVATicket) AS TotalTVAPayée
FROM Ticket;

--Si l'on souhaite recalculer manuellement:
SELECT SUM(Ticket.QuantitéeArticleTicket * A.PrixArticle * TVA.TauxTVA) AS TotalTVAPayée
FROM Ticket
INNER JOIN Commande C ON C.NumTicket = Ticket.NumTicket
INNER JOIN Article A ON A.RefArticle = C.RefArticle
INNER JOIN TVA ON TVA.NumTVA = A.NumTVA;

--Afficher tout les articles dont la taille est inférieure à 50cm ordonné du plus grand au plus petit
SELECT RefArticle, NomArticle, TailleArticle
FROM Article
WHERE TailleArticle < 50
ORDER BY TailleArticle DESC;

--Afficher tout les articles (son nom) avec un prix comprit entre 30 et 10 euros.
SELECT NomArticle
FROM Article
WHERE PrixArticle < 30 AND PrixArticle > 10
ORDER BY PrixArticle;

--Afficher toutes les ventes avec une TVA supérieure ou égale à 15%
SELECT T.NumTicket
FROM Ticket T
INNER JOIN Commande C ON C.NumTicket = T.NumTicket
INNER JOIN Article A ON A.RefArticle = C.RefArticle
INNER JOIN TVA ON A.NumTVA = TVA.NumTVA
WHERE TVA.TauxTVA >= 0.15;

--Afficher tout les produits du Fournisseur "Dansons" (son identifiant, et son Nom)
SELECT
	A.RefArticle AS RéférenceArticle,
	A.NomArticle AS NomArticle
FROM Article A
INNER JOIN 
	Fournisseur F 
		ON F.NomFournisseur = "Dansons"
		AND F.NumFournisseur = A.NumFournisseur
;

--Afficher tout les articles Rose et leur taux de TVA en pourcentage. (Nom et identifiant)
SELECT
	A.RefArticle AS RéférenceArticle,
	A.NomArticle AS NomArticle,
	T.TauxTVA * 100 AS TauxTVA
FROM Article A
INNER JOIN TVA T ON T.NumTVA = A.NumTVA
WHERE A.CouleurArticle = "Rose"
;

--Afficher tout les clients qui ont achetés à chaque vendeur.
SELECT
	Ve.NomVendeur,
	C.NomClient
FROM Vendeur Ve
INNER JOIN Vente V ON V.NumVendeur = Ve.NumVendeur
INNER JOIN Achat A ON A.NumTicket = V.NumTicket
INNER JOIN Client C ON C.NumClient = A.NumClient
;

--Afficher la somme des articles vendus aux clients qui ont une adresse d'un compte Microsoft (hotmail ou outlook), et ceux des comptes Gmail.
SELECT
    SUM(CASE WHEN C.MailClient LIKE "%gmail.com%" THEN T.QuantitéeArticleTicket ELSE 0 END) AS SumGmail,
    SUM(CASE WHEN C.MailClient LIKE "%hotmail.com%" OR C.MailClient LIKE "%outlook.fr%" THEN T.QuantitéeArticleTicket ELSE 0 END) AS SumMicrosoft
FROM
    Client C
INNER JOIN
    Achat Ach ON Ach.NumClient = C.NumClient
INNER JOIN
    Ticket T ON T.NumTicket = Ach.NumTicket;
;

--Obtenir la somme des achats hors-taxe des personnes dont le code postal commence par 91.
SELECT SUM(T.TotalHTTicket) AS SommeTotaleDesAchatsDePersonnesDu91
FROM Ticket T
INNER JOIN Achat A ON A.NumTicket = T.NumTicket
INNER JOIN Client C ON A.NumClient = C.NumClient
WHERE C.CPClient LIKE '%91%'
;

--Obtenir la somme rapportés par chaque vendeur selon leur prénoms (hors-taxe, car l'argent de la TVA ne leur revient pas)
SELECT V.PrénomVendeur, SUM(T.TotalHTTicket) AS TotalVente
FROM Vendeur V
INNER JOIN Vente Ve ON Ve.NumVendeur = V.NumVendeur
INNER JOIN Ticket T ON T.NumTicket = Ve.NumTicket
GROUP BY V.PrénomVendeur;

--Lister tout les articles selon les fournisseurs, et si au moins l'un d'entre eux a été vendu ou non.
SELECT
	F.NomFournisseur,
	A.NomArticle,
	CASE WHEN COUNT(T.NumTicket) > 0
		THEN 'true'
		ELSE 'false' 
	END AS EstVendu
FROM
	Fournisseur F
INNER JOIN
	Article		A ON A.NumFournisseur = F.NumFournisseur
LEFT JOIN
	Commande	C ON C.RefArticle = A.RefArticle
LEFT JOIN
	Ticket		T ON T.NumTicket = C.NumTicket
GROUP BY
	F.NomFournisseur, A.NomArticle, A.RefArticle;


