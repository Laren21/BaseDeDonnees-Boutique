BEGIN TRANSACTION;
--TVA
CREATE TABLE IF NOT EXISTS "TVA" (
	"NumTVA"	INTEGER NOT NULL,
	"TauxTVA"	INTEGER NOT NULL,
	PRIMARY KEY("NumTVA" AUTOINCREMENT)
);

--Fournisseur
CREATE TABLE IF NOT EXISTS "Fournisseur" (
	"NumFournisseur"	INTEGER NOT NULL,
	"NomFournisseur"	TEXT NOT NULL,
	"LocFournisseur"	TEXT NOT NULL,
	"MailFournisseur"	TEXT NOT NULL,
	"TélFournisseur"	TEXT NOT NULL,
	PRIMARY KEY("NumFournisseur" AUTOINCREMENT)
);

--Vendeur
CREATE TABLE IF NOT EXISTS "Vendeur" (
	"NumVendeur"	INTEGER NOT NULL,
	"NomVendeur"	TEXT NOT NULL,
	"PrénomVendeur"	TEXT NOT NULL,
	"StatutVendeur"	TEXT NOT NULL,
	PRIMARY KEY("NumVendeur")
);

--Client
CREATE TABLE IF NOT EXISTS "Client" (
	"NumClient"	INTEGER NOT NULL,
	"NomClient"	TEXT NOT NULL,
	"PrénomClient"	TEXT NOT NULL,
	"CPClient"	TEXT NOT NULL,
	"MailClient"	TEXT NOT NULL,
	"TelClient"	TEXT NOT NULL,
	PRIMARY KEY("NumClient" AUTOINCREMENT)
);

--Ticket
CREATE TABLE IF NOT EXISTS "Ticket" (
	"NumTicket"	INTEGER NOT NULL,
	"QuantitéeArticleTicket"	REAL NOT NULL,
	"TotalHTTicket"	REAL NOT NULL,
	"TotalTVATicket"	REAL NOT NULL,
	"TotalTTCTicket"	REAL NOT NULL,
	"ModeReglementTicket"	TEXT NOT NULL,
	"InfoJuridiTicket"	TEXT NOT NULL,
	PRIMARY KEY("NumTicket" AUTOINCREMENT)
);

--Article
CREATE TABLE IF NOT EXISTS "Article" (
	"RefArticle"	INTEGER NOT NULL,
	"NomArticle"	TEXT NOT NULL,
	"PrixArticle"	INTEGER NOT NULL,
	"CouleurArticle"	TEXT,
	"TailleArticle"	REAL,
	"NumFournisseur"	INTEGER NOT NULL,
	"NumTVA"	INTEGER NOT NULL,
	FOREIGN KEY("NumFournisseur") REFERENCES "Fournisseur"("NumFournisseur"),
	FOREIGN KEY("NumTVA") REFERENCES "TVA"("NumTVA"),
	PRIMARY KEY("RefArticle")
);

--Commande
CREATE TABLE IF NOT EXISTS "Commande" (
	"NumTicket"	INTEGER NOT NULL,
	"RefArticle"	INTEGER NOT NULL,
	FOREIGN KEY("RefArticle") REFERENCES "Article"("RefArticle"),
	FOREIGN KEY("NumTicket") REFERENCES "Ticket"("NumTicket"),
	PRIMARY KEY("NumTicket","RefArticle")
);

--Achat
CREATE TABLE IF NOT EXISTS "Achat" (
	"NumTicket"	INTEGER NOT NULL,
	"NumClient"	INTEGER NOT NULL,
	FOREIGN KEY("NumTicket") REFERENCES "Ticket"("NumTicket"),
	FOREIGN KEY("NumClient") REFERENCES "Client"("NumClient"),
	PRIMARY KEY("NumTicket","NumClient")
);

--Vente
CREATE TABLE IF NOT EXISTS "Vente" (
	"NumTicket"	INTEGER NOT NULL,
	"NumVendeur"	INTEGER NOT NULL,
	FOREIGN KEY("NumTicket") REFERENCES "Ticket"("NumTicket"),
	FOREIGN KEY("NumVendeur") REFERENCES "Vendeur"("NumVendeur"),
	PRIMARY KEY("NumVendeur","NumTicket")
);
COMMIT;
