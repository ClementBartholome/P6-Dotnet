CREATE DATABASE P6_Dotnet;

USE P6_Dotnet;

-- Table des produits
CREATE TABLE Produit (
  id INT PRIMARY KEY,
  nom VARCHAR(255)
);

-- Table des syst�mes d'exploitation
CREATE TABLE SystemeExploitation (
  id INT PRIMARY KEY,
  nom VARCHAR(255)
);

-- Table des versions
CREATE TABLE Version (
  id INT PRIMARY KEY,
  numero_version VARCHAR(255)
);

-- Table des versions de produits
CREATE TABLE ProduitVersion (
  id INT PRIMARY KEY,
  produit_id INT,
  version_id INT,
  FOREIGN KEY (produit_id) REFERENCES Produit(id),
  FOREIGN KEY (version_id) REFERENCES Version(id)
);

-- Table pour l'association entre versions et syst�mes d'exploitation
CREATE TABLE ProduitVersionSystemeExploitation (
    id INT PRIMARY KEY,
    produit_version_id INT NOT NULL REFERENCES ProduitVersion(id),
    systeme_exploitation_id INT NOT NULL REFERENCES SystemeExploitation(id)
);


-- Table des probl�mes
CREATE TABLE Probleme (
  id INT PRIMARY KEY,
  description VARCHAR(255),
  date_signalement DATE,
  statut VARCHAR(255) CHECK (statut IN ('En cours', 'R�solu')),
  produit_version_id INT,
  FOREIGN KEY (produit_version_id) REFERENCES ProduitVersion(id)
);

-- Table des r�solutions de probl�mes
CREATE TABLE Resolution (
  id INT PRIMARY KEY,
  probleme_id INT,
  description VARCHAR(255),
  date_resolution DATE,
  FOREIGN KEY (probleme_id) REFERENCES Probleme(id)
);

-- Insertion des donn�es dans la table Produit
INSERT INTO Produit (id, nom) VALUES 
(1, 'Trader en Herbe'),
(2, 'Ma�tre des Investissements'),
(3, 'Planificateur d�Entra�nement'),
(4, 'Planificateur d�Anxi�t� Sociale');

-- Insertion des donn�es dans la table SystemeExploitation
INSERT INTO SystemeExploitation (id, nom) VALUES 
(1, 'Linux'),
(2, 'MacOS'),
(3, 'Windows'),
(4, 'Android'),
(5, 'iOS'),
(6, 'Windows Mobile');

-- Insertion des donn�es dans la table Version
INSERT INTO Version (id, numero_version) VALUES 
(1, '1.0'),
(2, '1.1'),
(3, '1.2'),
(4, '1.3'),
(5, '2.0'),
(6, '2.1');

-- Insertion des donn�es dans la table ProduitVersion
INSERT INTO ProduitVersion (id, produit_id, version_id) VALUES 
(1, 1, 1), -- Trader en Herbe - 1.0
(2, 1, 2), -- Trader en Herbe - 1.1
(3, 1, 3), -- Trader en Herbe - 1.2
(4, 1, 4), -- Trader en Herbe - 1.3
(5, 2, 1), -- Ma�tre des Investissements - 1.0
(6, 2, 5), -- Ma�tre des Investissements - 2.0
(7, 2, 6), -- Ma�tre des Investissements - 2.1
(8, 3, 1), -- Planificateur d�Entra�nement - 1.0
(9, 3, 2), -- Planificateur d�Entra�nement - 1.1
(10, 3, 5), -- Planificateur d�Entra�nement - 2.0
(11, 4, 1), -- Planificateur d�Anxi�t� Sociale - 1.0
(12, 4, 2); -- Planificateur d�Anxi�t� Sociale - 1.1



-- Insertion des donn�es dans la table ProduitVersionSystemeExploitation
	-- Trader en Herbe
INSERT INTO ProduitVersionSystemeExploitation (id, produit_version_id, systeme_exploitation_id) VALUES
(1, 1, 1), -- 1.0 Linux
(2, 1, 3), -- 1.0 Windows
(3, 2, 1), -- 1.1 Linux
(4, 2, 2), -- 1.1 MacOS
(5, 2, 3), -- 1.1 Windows
(6, 3, 1), -- 1.2 Linux
(7, 3, 2), -- 1.2 MacOS
(8, 3, 3), -- 1.2 Windows
(9, 3, 4), -- 1.2 Android
(10, 3, 5), -- 1.2 iOS
(11, 3, 6), -- 1.2 Windows Mobile
(12, 4, 2), -- 1.3 MacOS
(13, 4, 3), -- 1.3 Windows
(14, 4, 4), -- 1.3 Android
(15, 4, 5); -- 1.3 iOS

	-- Ma�tre des Investissements
INSERT INTO ProduitVersionSystemeExploitation (id, produit_version_id, systeme_exploitation_id) VALUES
(16, 5, 2), -- 1.0 MacOS
(17, 5, 5), -- 1.0 iOS
(18, 6, 2), -- 2.0 MacOS
(19, 6, 4), -- 2.0 Android
(20, 6, 5), -- 2.0 iOS
(21, 7, 2), -- 2.1 MacOS
(22, 7, 3), -- 2.1 Windows
(23, 7, 4), -- 2.1 Android
(24, 7, 5); -- 2.1 iOS

	-- Planificateur d�Entra�nement
INSERT INTO ProduitVersionSystemeExploitation (id, produit_version_id, systeme_exploitation_id) VALUES
(25, 8, 1), -- 1.0 Linux
(26, 8, 2), -- 1.0 MacOS
(27, 9, 1), -- 1.1 Linux
(28, 9, 2), -- 1.1 MacOS
(29, 9, 3), -- 1.1 Windows
(30, 9, 4), -- 1.1 Android
(31, 9, 5), -- 1.1 iOS
(32, 9, 6), -- 1.1 Windows Mobile
(33, 10, 2), -- 2.0 MacOS
(34, 10, 3), -- 2.0 Windows
(35, 10, 4), -- 2.0 Android
(36, 10, 5); -- 2.0 iOS

	-- Planificateur d�Anxi�t� Sociale
INSERT INTO ProduitVersionSystemeExploitation (id, produit_version_id, systeme_exploitation_id) VALUES
(37, 11, 2), -- 1.0 MacOS
(38, 11, 3), -- 1.0 Windows
(39, 11, 4), -- 1.0 Android
(40, 11, 5), -- 1.0 iOS
(41, 12, 2), -- 1.1 MacOS
(42, 12, 3), -- 1.1 Windows
(43, 12, 4), -- 1.1 Android
(44, 12, 5); -- 1.1 iOS


-- Insertion des donn�es dans la table Probleme
INSERT INTO Probleme (id, description, date_signalement, statut, produit_version_id) VALUES
(1, 'L''application se bloque lors de l''ouverture du graphique des actions.', '2023-03-01', 'En cours', 1), -- Trader en Herbe v1.0
(2, 'Les notifications de prix ne sont pas envoy�es.', '2023-03-02', 'En cours', 6), -- Ma�tre des Investissements v2.0
(3, 'L''application se ferme lors de l''ajout d''un nouvel entra�nement.', '2023-03-03', 'R�solu', 8), -- Planificateur d�Entra�nement v1.0
(4, 'Les rappels ne sont pas affich�s � l''heure pr�vue.', '2023-03-04', 'R�solu', 11), -- Planificateur d�Anxi�t� Sociale v1.0
(5, 'L''application ne se met pas � jour avec les derni�res donn�es du march�.', '2023-03-05', 'R�solu', 2), -- Trader en Herbe v1.1
(6, 'L''application se bloque lors de l''ouverture du tableau de bord.', '2023-03-06', 'En cours', 7), -- Ma�tre des Investissements v2.1
(7, 'L''application ne sauvegarde pas les param�tres de l''utilisateur.', '2023-03-07', 'R�solu', 9), -- Planificateur d�Entra�nement v1.1
(8, 'L''application ne synchronise pas les donn�es entre diff�rents appareils.', '2023-03-08', 'R�solu', 12), -- Planificateur d�Anxi�t� Sociale v1.1
(9, 'L''application ne charge pas les graphiques des actions.', '2023-03-09', 'R�solu', 3), -- Trader en Herbe v1.2
(10, 'L''application ne permet pas de changer le mot de passe.', '2023-03-10', 'En cours', 5), -- Ma�tre des Investissements v1.0
(11, 'Les calculs de charge d''entra�nement sont erron�s.', '2023-03-11', 'R�solu', 10), -- Planificateur d�Entra�nement v2.0
(12, 'L''application ne permet pas de supprimer un rappel.', '2023-03-12', 'En cours', 11), -- Planificateur d�Anxi�t� Sociale v1.0
(13, 'L''application ne permet pas de se d�connecter.', '2023-03-13', 'En cours', 4), -- Trader en Herbe v1.3
(14, 'L''application ne permet pas de modifier le profil de l''utilisateur.', '2023-03-14', 'En cours', 6), -- Ma�tre des Investissements v2.0
(15, 'L''application ne permet pas de partager un entra�nement.', '2023-03-15', 'R�solu', 8), -- Planificateur d�Entra�nement v1.0
(16, 'L''application ne permet pas de programmer des rappels r�currents.', '2023-03-16', 'En cours', 12), -- Planificateur d�Anxi�t� Sociale v1.1
(17, 'L''utilisateur ne re�oit aucune notification lors de variations significatives des march�s financiers.', '2023-03-17', 'R�solu', 1), -- Trader en Herbe v1.0
(18, 'Les donn�es du comparateur de fonds sont obsol�tes.', '2023-03-18', 'R�solu', 7), -- Ma�tre des Investissements v2.1
(19, 'L''application ne permet pas de synchroniser les entra�nements avec le calendrier de l''appareil.', '2023-03-19', 'R�solu', 9), -- Planificateur d�Entra�nement v1.1
(20, 'L''application ne permet pas de programmer des rappels � des heures pr�cises.', '2023-03-20', 'R�solu', 11), -- Planificateur d�Anxi�t� Sociale v1.0
(21, 'L''application ne permet pas de visualiser l''historique des transactions.', '2023-03-21', 'En cours', 4), -- Trader en Herbe v1.3
(22, 'Les imports de relev� bancaire sont incomplets.', '2023-03-22', 'R�solu', 5), -- Ma�tre des Investissements v1.0
(23, 'L''application ne permet pas d''ajouter des exercices personnalis�s.', '2023-03-23', 'En cours', 10), -- Planificateur d�Entra�nement v2.0
(24, 'L''application ne permet pas de supprimer un rappel.', '2023-03-24', 'R�solu', 12), -- Planificateur d�Anxi�t� Sociale v1.1
(25, 'L''application ne permet pas de visualiser l''historique des transactions.', '2023-03-25', 'En cours', 1); -- Trader en Herbe v1.0


-- Insertion des donn�es dans la table Resolution
INSERT INTO Resolution (id, probleme_id, description, date_resolution) VALUES
(1, 4, 'Correction du service de rappels.', '2023-03-14'),
(2, 5, 'Correction du service de mise � jour des donn�es du march�.', '2023-03-15'),
(3, 7, 'Ajout de la fonctionnalit� de sauvegarde des param�tres de l''utilisateur.', '2023-03-17'), 
(4, 8, 'Correction du service de synchronisation.', '2023-03-18'),
(5, 9, 'Correction du service de chargement des graphiques des actions.', '2023-03-19'),
(6, 11, 'Correction des algorithmes de calcul de charge.', '2023-03-21'),
(7, 15, 'Ajout de la fonctionnalit� de partage d''entra�nement.', '2023-03-25'),
(8, 17, 'Red�marrage du microservice d''alertes et v�rification des certificats d''authentification aux API financi�res.', '2023-03-27'),
(9, 18, 'Mise � jour des sources de donn�es financi�res.', '2023-03-28'),
(10, 19, 'Ajout de la fonctionnalit� de synchronisation des entra�nements avec le calendrier de l''appareil.', '2023-03-29'),
(11, 22, 'Correction du mapping de donn�es.', '2023-04-02'),
(12, 24, 'Ajout de la fonctionnalit� de suppression de rappel.', '2023-04-04'),
(13, 3, 'Le probl�me �tait d� � une exception non g�r�e lors de la tentative d''ajout d''un nouvel entra�nement. Le correctif a impliqu� l''ajout d''une gestion d''exceptions appropri�e pour �viter que l''application ne se ferme lors de l''ajout d''un nouvel entra�nement.', '2023-03-23'), 
(14, 20, 'Ajout de la fonctionnalit� de programmation de rappels � des heures pr�cises.', '2023-04-10'); 
