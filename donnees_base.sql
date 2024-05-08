--Fournisseur
INSERT INTO Fournisseur (NomFournisseur, LocFournisseur, MailFournisseur, TélFournisseur) VALUES ("LaDanse",		"37 rue des coquelicots",		"contact@ladanse.com"		, "+33 1 14 18 39 45");
INSERT INTO Fournisseur (NomFournisseur, LocFournisseur, MailFournisseur, TélFournisseur) VALUES ("Dansons",		"10 rue Anatole France",		"contact@dansons.com"		, "+33 8 26 32 46 69");
INSERT INTO Fournisseur (NomFournisseur, LocFournisseur, MailFournisseur, TélFournisseur) VALUES ("SpectacleLoc",	"175 avenue de l'Étoile Noire",	"contact@spectacleloc.com"	, "+33 3 14 15 92 65");
INSERT INTO Fournisseur (NomFournisseur, LocFournisseur, MailFournisseur, TélFournisseur) VALUES ("Mior",			"54 rue Albus Dumbledore",		"contact@mior.com"			, "+33 1 46 85 39 45");

--Client
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Vanessa",		"Bottière",		"75001", "Vanessa@gmail.com",		"+33 6 95 83 98 72");
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Lynn",			"Lestrange",	"94600", "Lynn@hotmail.com",			"+33 6 60 28 78 00");
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Pimprenelle",	"Baunenuit",	"91600", "Pimprenelle@outlook.fr",	"+33 6 91 12 66 66");
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Nicolas",		"Laipeti",		"93100", "Nicolas@gmail.com",		"+33 6 40 13 69 19");
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Jean",			"Dubois",		"96500", "Jean@gmail.com",			"+33 6 75 19 21 28");
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Lucas",			"Sarazin",		"91400", "Lucas@gmail.com",			"+33 6 38 23 02 64");
INSERT INTO Client (PrénomClient, NomClient, CPClient, MailClient, TelClient) VALUES ("Jordan",			"Matira",		"75010", "Jordan@gmail.com",		"+33 6 91 18 20 43");

--TVA
INSERT INTO TVA (TauxTVA) VALUES (0.05);
INSERT INTO TVA (TauxTVA) VALUES (0.10);
INSERT INTO TVA (TauxTVA) VALUES (0.15);
INSERT INTO TVA (TauxTVA) VALUES (0.20);

--Article
INSERT INTO Article (NomArticle, PrixArticle, CouleurArticle, TailleArticle, NumTVA, NumFournisseur) VALUES ("Tutu",		28.99,		"Rose",		165.00,		4,		1);
INSERT INTO Article (NomArticle, PrixArticle, CouleurArticle, TailleArticle, NumTVA, NumFournisseur) VALUES ("Collants",	07.90,		"Blanc",	80.50,		3,		2);
INSERT INTO Article (NomArticle, PrixArticle, CouleurArticle, TailleArticle, NumTVA, NumFournisseur) VALUES ("Maquillage",	12.90,		"Beige",	20.00,		2,		3);
INSERT INTO Article (NomArticle, PrixArticle, CouleurArticle, TailleArticle, NumTVA, NumFournisseur) VALUES ("Ballerines",	39.99,		"Rose",		36.50,		1,		4);

--Vendeur
INSERT INTO Vendeur (NomVendeur, PrénomVendeur, StatutVendeur) VALUES ("Merlicot",		"Mireille",		"Stagiaire");
INSERT INTO Vendeur (NomVendeur, PrénomVendeur, StatutVendeur) VALUES ("Grantom",		"Gaston",		"Patron");
INSERT INTO Vendeur (NomVendeur, PrénomVendeur, StatutVendeur) VALUES ("Berlun",		"Matéo",		"Manager");

--Ticket
--Quelqu'un a acheté l'article à la référence 4 (Ballerines) à 39.99, le prix HT, avec TVA et TTC est automatiquement calculé par rapport à la référence de l'article.
INSERT INTO Ticket (QuantitéeArticleTicket, TotalHTTicket, TotalTVATicket, TotalTTCTicket, ModeReglementTicket, InfoJuridiTicket)
SELECT
	Quantity.QuantityValue,
	Article.PrixArticle * Quantity.QuantityValue, -- Prix HT
	Article.PrixArticle * TVA.TauxTVA * Quantity.QuantityValue, -- Prix TVA
	Article.PrixArticle * TVA.TauxTVA * Quantity.QuantityValue + Article.PrixArticle * Quantity.QuantityValue, -- Prix TTC
	'CB', -- Mode de règlement
	'Lorem ipsum dolor sit amet' -- Info juridiques
FROM (
	SELECT 4 AS QuantityValue --Quantité de cet article acheté
) AS Quantity
INNER JOIN Article ON Article.RefArticle = 4 -- Référence de l'article
INNER JOIN TVA ON Article.NumTVA = TVA.NumTVA
LIMIT 1;


INSERT INTO Ticket (QuantitéeArticleTicket, TotalHTTicket, TotalTVATicket, TotalTTCTicket, ModeReglementTicket, InfoJuridiTicket)
SELECT
	Quantity.QuantityValue,
	Article.PrixArticle * Quantity.QuantityValue, -- Prix HT
	Article.PrixArticle * TVA.TauxTVA * Quantity.QuantityValue, --Prix TVA
	Article.PrixArticle * TVA.TauxTVA * Quantity.QuantityValue + Article.PrixArticle * Quantity.QuantityValue, -- Prix TTC
	'Cash', -- Mode de règlement
	'Lorem ipsum dolor sit amet' -- Info juridiques
FROM (
	SELECT 1 AS QuantityValue --Quantité de cet article acheté
) AS Quantity
INNER JOIN Article ON Article.RefArticle = 2 -- Référence de l'article
INNER JOIN TVA ON Article.NumTVA = TVA.NumTVA
LIMIT 1;


INSERT INTO Ticket (QuantitéeArticleTicket, TotalHTTicket, TotalTVATicket, TotalTTCTicket, ModeReglementTicket, InfoJuridiTicket)
SELECT
	Quantity.QuantityValue,
	Article.PrixArticle * Quantity.QuantityValue, -- Prix HT
	Article.PrixArticle * TVA.TauxTVA * Quantity.QuantityValue, --Prix TVA
	Article.PrixArticle * TVA.TauxTVA * Quantity.QuantityValue + Article.PrixArticle * Quantity.QuantityValue, -- Prix TTC
	'CB', -- Mode de règlement
	'Lorem ipsum dolor sit amet' -- Info juridiques
FROM (
	SELECT 47 AS QuantityValue --Quantité de cet article acheté
) AS Quantity
INNER JOIN Article ON Article.RefArticle = 1 -- Référence de l'article
INNER JOIN TVA ON Article.NumTVA = TVA.NumTVA
LIMIT 1;


--Vente
INSERT INTO Vente (NumVendeur, NumTicket) VALUES (1,2);
INSERT INTO Vente (NumVendeur, NumTicket) VALUES (1,3);
INSERT INTO Vente (NumVendeur, NumTicket) VALUES (2,1);

--Achat
INSERT INTO Achat (NumClient, NumTicket) VALUES (3, 1);
INSERT INTO Achat (NumClient, NumTicket) VALUES (6, 2);
INSERT INTO Achat (NumClient, NumTicket) VALUES (2, 3);

--Commande
INSERT INTO Commande (NumTicket, RefArticle) VALUES (1, 4);
INSERT INTO Commande (NumTicket, RefArticle) VALUES (2, 2);
INSERT INTO Commande (NumTicket, RefArticle) VALUES (3, 1);

