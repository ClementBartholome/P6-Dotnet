CREATE DATABASE P6_Dotnet;

USE P6_Dotnet;

CREATE TABLE Produit (
  id INT PRIMARY KEY,
  nom VARCHAR(255),
  version_actuelle VARCHAR(255)
);

CREATE TABLE SystemeExploitation (
  id INT PRIMARY KEY,
  nom VARCHAR(255)
);

CREATE TABLE Version (
  id INT PRIMARY KEY,
  produit_id INT,
  numero_version VARCHAR(255),
  FOREIGN KEY (produit_id) REFERENCES Produit(id)
);

CREATE TABLE VersionSystemeExploitation (
  version_id INT,
  systeme_exploitation_id INT,
  PRIMARY KEY (version_id, systeme_exploitation_id),
  FOREIGN KEY (version_id) REFERENCES Version(id),
  FOREIGN KEY (systeme_exploitation_id) REFERENCES SystemeExploitation(id)
);

CREATE TABLE Probleme (
  id INT PRIMARY KEY,
  description VARCHAR(255),
  date_signalement DATE,
  statut VARCHAR(255) CHECK (statut IN ('En cours', 'R�solu')),
  version_id INT,
  FOREIGN KEY (version_id) REFERENCES Version(id)
);

CREATE TABLE Resolution (
  id INT PRIMARY KEY,
  probleme_id INT,
  description VARCHAR(255),
  date_resolution DATE,
  FOREIGN KEY (probleme_id) REFERENCES Probleme(id)
);

-- Insertion des donn�es dans la table Produit
INSERT INTO Produit (id, nom, version_actuelle) VALUES (1, 'Trader en Herbe', '1.3');
INSERT INTO Produit (id, nom, version_actuelle) VALUES (2, 'Ma�tre des Investissements', '2.1');
INSERT INTO Produit (id, nom, version_actuelle) VALUES (3, 'Planificateur d�Entra�nement', '2.0');
INSERT INTO Produit (id, nom, version_actuelle) VALUES (4, 'Planificateur d�Anxi�t� Sociale', '1.1');

-- Insertion des donn�es dans la table SystemeExploitation
INSERT INTO SystemeExploitation (id, nom) VALUES (1, 'Linux');
INSERT INTO SystemeExploitation (id, nom) VALUES (2, 'MacOS');
INSERT INTO SystemeExploitation (id, nom) VALUES (3, 'Windows');
INSERT INTO SystemeExploitation (id, nom) VALUES (4, 'Android');
INSERT INTO SystemeExploitation (id, nom) VALUES (5, 'iOS');
INSERT INTO SystemeExploitation (id, nom) VALUES (6, 'Windows Mobile');

-- Insertion des donn�es dans la table Version
INSERT INTO Version (id, produit_id, numero_version) VALUES (1, 1, '1.0');
INSERT INTO Version (id, produit_id, numero_version) VALUES (2, 1, '1.1');
INSERT INTO Version (id, produit_id, numero_version) VALUES (3, 1, '1.2');
INSERT INTO Version (id, produit_id, numero_version) VALUES (4, 1, '1.3');
INSERT INTO Version (id, produit_id, numero_version) VALUES (5, 2, '1.0');
INSERT INTO Version (id, produit_id, numero_version) VALUES (6, 2, '2.0');
INSERT INTO Version (id, produit_id, numero_version) VALUES (7, 2, '2.1');
INSERT INTO Version (id, produit_id, numero_version) VALUES (8, 3, '1.0');
INSERT INTO Version (id, produit_id, numero_version) VALUES (9, 3, '1.1');
INSERT INTO Version (id, produit_id, numero_version) VALUES (10, 3, '2.0');
INSERT INTO Version (id, produit_id, numero_version) VALUES (11, 4, '1.0');
INSERT INTO Version (id, produit_id, numero_version) VALUES (12, 4, '1.1');

-- Insertion des donn�es dans la table VersionSystemeExploitation
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (1, 1), (1, 2);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (2, 1), (2, 2), (2, 3);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (4, 1), (4, 2), (4, 3), (4, 4);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (5, 1), (5, 2);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (6, 1), (6, 2), (6, 3);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (7, 1), (7, 2), (7, 3), (7, 4);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (8, 1), (8, 2);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (10, 1), (10, 2), (10, 3), (10, 4);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (11, 1), (11, 2), (11, 3), (11, 4);
INSERT INTO VersionSystemeExploitation (version_id, systeme_exploitation_id) VALUES (12, 1), (12, 2), (12, 3), (12, 4);

-- Insertion des donn�es dans la table Probleme
INSERT INTO Probleme (id, description, date_signalement, statut, version_id) VALUES
(1, 'L''application se bloque lors de l''ouverture du graphique des actions.', '2023-03-01', 'En cours', 1),
(2, 'Les notifications de prix ne sont pas envoy�es.', '2023-03-02', 'En cours', 6), 
(3, 'L''application se ferme lors de l''ajout d''un nouvel entra�nement.', '2023-03-03', 'R�solu', 8),
(4, 'Les rappels ne sont pas affich�s � l''heure pr�vue.', '2023-03-04', 'R�solu', 11),
(5, 'L''application ne se met pas � jour avec les derni�res donn�es du march�.', '2023-03-05', 'R�solu', 2),
(6, 'L''application se bloque lors de l''ouverture du tableau de bord.', '2023-03-06', 'En cours', 7), 
(7, 'L''application ne sauvegarde pas les param�tres de l''utilisateur.', '2023-03-07', 'R�solu', 9),
(8, 'L''application ne synchronise pas les donn�es entre diff�rents appareils.', '2023-03-08', 'R�solu', 12),
(9, 'L''application ne charge pas les graphiques des actions.', '2023-03-09', 'R�solu', 3),
(10, 'L''application ne permet pas de changer le mot de passe.', '2023-03-10', 'En cours', 5), 
(11, 'Les calculs de charge d''entra�nement sont erron�s.', '2023-03-11', 'R�solu', 10), 
(12, 'L''application ne permet pas de supprimer un rappel.', '2023-03-12', 'En cours', 11),
(13, 'L''application ne permet pas de se d�connecter.', '2023-03-13', 'En cours', 4),
(14, 'L''application ne permet pas de modifier le profil de l''utilisateur.', '2023-03-14', 'En cours', 6), 
(15, 'L''application ne permet pas de partager un entra�nement.', '2023-03-15', 'R�solu', 8),
(16, 'L''application ne permet pas de programmer des rappels r�currents.', '2023-03-16', 'En cours', 12),
(17, 'L''utilisateur ne re�oit aucune notification lors de variations significatives des march�s financiers.', '2023-03-17', 'R�solu', 1),
(18, 'Les donn�es du comparateur de fonds sont obsol�tes.', '2023-03-18', 'R�solu', 7),
(19, 'L''application ne permet pas de synchroniser les entra�nements avec le calendrier de l''appareil.', '2023-03-19', 'R�solu', 9), 
(20, 'L''application ne permet pas de programmer des rappels � des heures pr�cises.', '2023-03-20', 'R�solu',11),
(21, 'L''application ne permet pas de visualiser l''historique des transactions.', '2023-03-21', 'En cours',  4),
(22, 'Les imports de relev� bancaire sont incomplets.', '2023-03-22', 'R�solu', 5),
(23, 'L''application ne permet pas d''ajouter des exercices personnalis�s.', '2023-03-23', 'En cours', 10),
(24, 'L''application ne permet pas de supprimer un rappel.', '2023-03-24', 'R�solu', 12),
(25, 'L''application ne permet pas de visualiser l''historique des transactions.', '2023-03-25', 'En cours', 1);

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