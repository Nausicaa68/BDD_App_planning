-- -------------------------------------------------
-- Nom de la base de donnees : recherche          --
-- SGBD : MySql                                   --
-- Date de creation : 13/10/2021                  --
-- Auteurs : Guillaume DUMAS / Jérémy GRELAUD     --
-- -------------------------------------------------


-- create database app_planning_v2;
use app_planning_v2;

-- Destruction des tables

SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Personne ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Camarades ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Comptes_Reseaux_sociaux ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Amis ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Cagnotte ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Objectif ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Anciens_objectifs ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Objectif_ultime ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Dates_event ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Loisir_commun ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Adresse_favorites ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Budget_utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Evenement ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Calendrier ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Seance_revision ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Participer ; SET FOREIGN_KEY_CHECKS=1;

-- Creation de tables

CREATE TABLE Personne(
   idPersonne INT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   ville_residence VARCHAR(50),
   telephone VARCHAR(50),
   PRIMARY KEY(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Utilisateur(
   idUtilisateur INT,
   PRIMARY KEY(idUtilisateur),
   FOREIGN KEY(idUtilisateur) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Camarades(
   idPersonne_1 INT, -- id du camarade
   idUtilisateur INT NOT NULL, -- id de l'utilisateur
   PRIMARY KEY(idPersonne_1),
   FOREIGN KEY(idPersonne_1) REFERENCES Personne(idPersonne),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Comptes_Reseaux_sociaux(
   id_reseau INT NOT NULL,
   nom_reseau VARCHAR(50) NOT NULL,
   idPersonne INT NOT NULL,
   PRIMARY KEY(id_reseau),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Amis(
   idPersonne_1 INT, -- id de l'ami
   idUtilisateur INT NOT NULL, -- id de l'utilisateur
   PRIMARY KEY(idPersonne_1),
   FOREIGN KEY(idPersonne_1) REFERENCES Personne(idPersonne),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Cagnotte(
   idCagnotte INT,
   nom VARCHAR(50) NOT NULL,
   total INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idCagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Objectif(
   idObjectif INT,
   nom_objectif VARCHAR(50) NOT NULL,
   description VARCHAR(50),
   type VARCHAR(50),
   somme_cible INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Anciens_objectifs(
   idObjectif INT,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idObjectif) REFERENCES Objectif(idObjectif)
)Engine = 'InnoDb';

CREATE TABLE Objectif_ultime(
   idObjectif INT,
   idCagnotte INT NOT NULL,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idObjectif) REFERENCES Objectif(idObjectif),
   FOREIGN KEY(idCagnotte) REFERENCES Cagnotte(idCagnotte)
)Engine = 'InnoDb';

CREATE TABLE Dates_event(
   date_event DATE,
   accord BOOLEAN,
   idUtilisateur INT NOT NULL,
   idPersonne_1 INT NOT NULL,
   PRIMARY KEY(date_event),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne_1) REFERENCES Amis(idPersonne_1)
)Engine = 'InnoDb';

CREATE TABLE Loisir_commun(
   nom_loisir VARCHAR(50),
   idUtilisateur INT NOT NULL,
   idPersonne_1 INT NOT NULL,
   PRIMARY KEY(nom_loisir),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne_1) REFERENCES Amis(idPersonne_1)
)Engine = 'InnoDb';

CREATE TABLE Adresse_favorites(
   num_rue VARCHAR(50),
   nom_rue VARCHAR(50),
   codepostal VARCHAR(50),
   ville VARCHAR(50),
   nom_loisir VARCHAR(50) NOT NULL,
   PRIMARY KEY(num_rue, nom_rue, codepostal, ville),
   FOREIGN KEY(nom_loisir) REFERENCES Loisir_commun(nom_loisir)
)Engine = 'InnoDb';

CREATE TABLE Budget_utilisateur(
   id_Budget INT,
   rentree_d_argent INT,
   depenses_du_mois INT,
   deficit BOOLEAN,
   idCagnotte INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(id_Budget),
   FOREIGN KEY(idCagnotte) REFERENCES Cagnotte(idCagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Evenement(
   idEvenement INT,
   nom_event VARCHAR(50) NOT NULL,
   nom_orga VARCHAR(50) NOT NULL,
   lieu VARCHAR(50),
   annule BOOLEAN,
   cout_event INT,
   idUtilisateur INT NOT NULL,
   idPersonne_1 INT NOT NULL,
   date_event DATE NOT NULL,
   id_Budget INT NOT NULL,
   PRIMARY KEY(idEvenement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne_1) REFERENCES Amis(idPersonne_1),
   FOREIGN KEY(date_event) REFERENCES Dates_event(date_event),
   FOREIGN KEY(id_Budget) REFERENCES Budget_utilisateur(id_Budget)
)Engine = 'InnoDb';

CREATE TABLE Calendrier(
   idCalendar INT,
   idEvenement INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idCalendar),
   FOREIGN KEY(idEvenement) REFERENCES Evenement(idEvenement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Seance_revision(
   idEvenement INT,
   matiere VARCHAR(50),
   travail_a_faire VARCHAR(50),
   date_rendu DATE,
   heure_seance TIME,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idEvenement),
   FOREIGN KEY(idEvenement) REFERENCES Evenement(idEvenement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Participer(
   idEvenement INT,
   idPersonne INT,
   PRIMARY KEY(idEvenement, idPersonne),
   FOREIGN KEY(idEvenement) REFERENCES Evenement(idEvenement),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';


-- remplissage des tables

INSERT INTO Personne (idPersonne, nom, prenom, ville_residence, telephone) VALUES  
(1, 'DUMAS', 'Guillaume', 'l_hay_rose','0769696969'),
(2, 'GRELAUD', 'Jérémy', 'clamart','0669696969'),
(3, 'ROSSIGNOL', 'Amaury', 'Savigny','0569696969'),
(4, 'Helltaker', 'Cerberus', 'Hell','0466666666'),
(5, 'Helltaker', 'Justice', 'Hell','0466666666'),
(6, 'JONG UN', 'Kim','Pyongyang','+380 8080-80'),
(7, 'GEVARA', 'Che','cuba','+1 555-555-5555');

INSERT INTO Utilisateur (idUtilisateur) VALUES 
(1),
(2); 


INSERT INTO Camarades (idPersonne_1, idUtilisateur) VALUES 
(2,1),
(3,1),
(4,1),
(5,1),
(6,1);
-- (1,2),
-- (3,2),
-- (7,2);


INSERT INTO Comptes_Reseaux_sociaux (id_reseau, nom_reseau, idPersonne) VALUES 
(1, 'Facebook',1),
(2, 'Facebook',2),
(3, 'Facebook',3),
(4, 'Facebook',4),
(5, 'Facebook',5),
(6, 'Facebook',6),
(7, 'Facebook',7),

(8, 'Whatsapp',1),
(9, 'Whatsapp',2),
(10, 'Whatsapp',3),
  
(11, 'Snapchat',1),
(12, 'Snapchat',4),
(13, 'Snapchat',5),
(14, 'Snapchat',6),

(15, 'Twitter', 2),
(16, 'Twitter', 3);


-- INSERT INTO Amis (idPersonne_1, idUtilisateur) VALUES 
-- (2,1), 
-- (3,1), 
-- (4,1),
-- (5,1),
-- (1,2),
-- (3,2),
-- (6,2);

INSERT INTO Cagnotte (idCagnotte, nom, total, idUtilisateur) VALUES 
(1, 'CagnotteGuillaume', 9000, 1),
(2, 'CagnotteJeremy', 3400, 2),
(3, 'CagnotteSecrete', 100000, 2);


INSERT INTO Objectif (idObjectif, nom_objectif, description, type, somme_cible, idUtilisateur) VALUES 
(1, 'Bac', 'Avoir son bac', 'professionnel', 100, 1),
(2, 'Diplome', 'Avoir son diplome avec honneur', 'professionnel', 120000, 1),
(3, 'Trouver l_amour', 'avec Belle', 'sentimental', 777, 1),
(4, 'Dominer le monde', 'comme Lelouch', 'militaire', 10000000, 2),
(5,'Dieu des mathematiques','comme M Teller', 'indispensable', 0, 2);

INSERT INTO Anciens_objectifs (idObjectif) VALUES 
(1);

INSERT INTO Objectif_ultime (idObjectif, idCagnotte) VALUES 
(3, 1),
(4, 3);

-- INSERT INTO Dates_event (date_event, accord, idUtilisateur, idPersonne_1) VALUES 
-- ('2021-07-05', TRUE, 1, 3),
-- ('2021-10-05', TRUE, 1, 2),
-- ('2022-11-01', FALSE, 1, 5);

-- INSERT INTO Loisir_commun (nom_loisir, idUtilisateur, idPersonne_1) VALUES 
-- ('Base de données', 1, 2),
-- ('Maquettes militaires', 2, 6),
-- ('Cuisine', 1, 5),
-- ('LoL', 2, 6);

INSERT INTO Adresse_favorites (num_rue, nom_rue, codepostal, ville, nom_loisir) VALUES 
('5','Rue des Galvents','92140','Clamart','Base de données'),
('7','Rue Gustave','94140','l_hay_rose','Base de données'),
('55','Ryongsong','Pyongyang','Pyongyang','Maquettes militaires'),
('1','Rue de Lucifer','66666','Hell','Cuisine'),
('5','Rue des Galvents','92140','Clamart','LoL');

INSERT INTO Budget_utilisateur(id_Budget, rentree_d_argent, depenses_du_mois, deficit, idCagnotte, idUtilisateur) VALUES 
(1, 1100, 859, FALSE, 1, 1),
(2, 100, 200, TRUE, 2, 2),
(3, 11000, 10000, FALSE, 3, 2);

INSERT INTO Evenement(idEvenement, nom_event, nom_orga, lieu, annule, cout_event, idUtilisateur, idPersonne_1, date_event, id_Budget) VALUES
(1, 'road trip en corée', 'GRELAUD', 'Corée', FALSE, 10000, 2, 6, '2021-06-05', 3),
(2, 'enquete ingé', 'GRELAUD', 'Paris', FALSE, 10, 2, 3, '2021-10-05', 2),
(3, 'stage japon', 'DUMAS', 'Nagoya', FALSE, 3000, 1, 3, '2022-11-01', 1),
(4, 'revision math', 'DUMAS', 'Villejuif', FALSE, 0, 1, 2, '2021-10-20', 1);

INSERT INTO Calendrier (idCalendar, idEvenement, idUtilisateur) VALUES 
(1, 1, 2),
(1, 2, 2),
(2, 3, 1),
(2, 4, 1);


INSERT INTO Seance_revision(idEvenement, matiere, travail_a_faire, date_rendu, heure_seance, idUtilisateur) VALUES
(4, 'Maths', 'Exo matrices', '2021-11-01', '13:30', 1);


INSERT INTO Participer (idEvenement, idPersonne) VALUES
(1, 2),
(1, 6),
(2, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 1),
(4, 2),
(4, 3);



COMMIT;
