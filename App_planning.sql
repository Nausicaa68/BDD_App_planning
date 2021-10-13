-- -------------------------------------------------
-- Nom de la base de donnees : recherche          --
-- SGBD : MySql                                   --
-- Date de creation : 08/10/2021                  --
-- Auteurs : Guillaume DUMAS / Jérémy GRELAUD --
-- -------------------------------------------------


-- create database app_planning;
use app_planning;

-- Destruction des tables

SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Personne ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Camarades_classes ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Comptes_Reseaux_sociaux ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Amis_de_l_utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Calendrier ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Cagnotte ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Objectif ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Anciens_objectifs ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Objectif_ultime_actuel ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Dates_évènement ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS loisir_commun ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Adresse_favorites_du_loisir ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Budget_utilisateur ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Evénement ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS Séance_révision ; SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS présent ; SET FOREIGN_KEY_CHECKS=1;

-- Creation de tables

CREATE TABLE Personne(
   idPersonne INT,
   Nom VARCHAR(50) NOT NULL,
   Prenom VARCHAR(50) NOT NULL,
   ville_résidence VARCHAR(50),
   téléphone VARCHAR(50),
   PRIMARY KEY(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Camarades_classes(
   idPersonne INT,
   PRIMARY KEY(idPersonne),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Comptes_Reseaux_sociaux(
   idReseauxSociaux INT,
   Nom_reseau VARCHAR(50) NOT NULL,
   idPersonne INT NOT NULL,
   PRIMARY KEY(idReseauxSociaux),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Utilisateur(
   idUtilisateur INT,
   idPersonne INT NOT NULL,
   PRIMARY KEY(idUtilisateur),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Amis_de_l_utilisateur(
   idPersonne INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idPersonne),
   FOREIGN KEY(idPersonne) REFERENCES Personne(idPersonne),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Calendrier(
   Date_activité DATE,
   Nom_activité VARCHAR(50),
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(Date_activité, Nom_activité),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Cagnotte(
   Nom_cagnotte VARCHAR(50),
   Total_cagnotte INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(Nom_cagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Objectif(
   idObjectif INT,
   Nom_objectif VARCHAR(50) NOT NULL,
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

CREATE TABLE Objectif_ultime_actuel(
   idObjectif INT,
   Nom_cagnotte VARCHAR(50) NOT NULL,
   PRIMARY KEY(idObjectif),
   FOREIGN KEY(idObjectif) REFERENCES Objectif(idObjectif),
   FOREIGN KEY(Nom_cagnotte) REFERENCES Cagnotte(Nom_cagnotte)
)Engine = 'InnoDb';

CREATE TABLE Dates_évènement(
   Date_event DATE,
   Accord_sur_la_date BOOLEAN,
   idUtilisateur INT NOT NULL,
   idPersonne INT NOT NULL,
   PRIMARY KEY(Date_event),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne) REFERENCES Amis_de_l_utilisateur(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE loisir_commun(
   Nom_loisir VARCHAR(50),
   idPersonne INT NOT NULL,
   PRIMARY KEY(Nom_loisir),
   FOREIGN KEY(idPersonne) REFERENCES Amis_de_l_utilisateur(idPersonne)
)Engine = 'InnoDb';

CREATE TABLE Adresse_favorites_du_loisir(
   Numéro_Rue VARCHAR(50),
   Nom_Rue VARCHAR(50),
   Département VARCHAR(50),
   Ville VARCHAR(50),
   Nom_loisir VARCHAR(50) NOT NULL,
   PRIMARY KEY(Numéro_Rue, Nom_Rue, Département, Ville),
   FOREIGN KEY(Nom_loisir) REFERENCES loisir_commun(Nom_loisir)
)Engine = 'InnoDb';

CREATE TABLE Budget_utilisateur(
   id_Budget INT,
   rentrée_d_argent INT,
   dépenses_du_mois INT,
   En_déficit BOOLEAN,
   Nom_cagnotte VARCHAR(50) NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(id_Budget),
   FOREIGN KEY(Nom_cagnotte) REFERENCES Cagnotte(Nom_cagnotte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Evénement(
   Nom_evenement VARCHAR(50),
   Nom_organisateur VARCHAR(50),
   Lieu VARCHAR(50),
   Annulé BOOLEAN,
   coût_évènement INT,
   id_Budget INT NOT NULL,
   Date_event DATE NOT NULL,
   Date_activité DATE NOT NULL,
   Nom_activité VARCHAR(50) NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(Nom_evenement, Nom_organisateur),
   FOREIGN KEY(id_Budget) REFERENCES Budget_utilisateur(id_Budget),
   FOREIGN KEY(Date_event) REFERENCES Dates_évènement(Date_event),
   FOREIGN KEY(Date_activité, Nom_activité) REFERENCES Calendrier(Date_activité, Nom_activité),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE Séance_révision(
   id_Seance_revision INT,
   Matière VARCHAR(50),
   Travail_a_faire VARCHAR(50),
   date_rendu DATE,
   date_seance DATE,
   heure_seance TIME,
   coût_séance INT,
   id_Budget INT NOT NULL,
   Date_activité DATE NOT NULL,
   Nom_activité VARCHAR(50) NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(id_Seance_revision),
   FOREIGN KEY(id_Budget) REFERENCES Budget_utilisateur(id_Budget),
   FOREIGN KEY(Date_activité, Nom_activité) REFERENCES Calendrier(Date_activité, Nom_activité),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)Engine = 'InnoDb';

CREATE TABLE présent(
   idUtilisateur INT,
   idPersonne INT,
   id_Seance_revision INT,
   idPersonne_1 INT,
   PRIMARY KEY(idUtilisateur, idPersonne, id_Seance_revision, idPersonne_1),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
   FOREIGN KEY(idPersonne) REFERENCES Amis_de_l_utilisateur(idPersonne),
   FOREIGN KEY(id_Seance_revision) REFERENCES Séance_révision(id_Seance_revision),
   FOREIGN KEY(idPersonne_1) REFERENCES Camarades_classes(idPersonne)
)Engine = 'InnoDb';

  
-- remplissage des tables

INSERT INTO Personne (idPersonne, Nom,Prenom,ville_résidence,téléphone) VALUES  
(1, 'DUMAS', 'Guillaume', 'l_hay_rose','0769696969'),
(2, 'GRELAUD', 'Jérémy', 'clamart','0669696969'),
(3, 'JONG UN', 'Kim','Pyongyang','+380808080'),
(4, 'GEVARA', 'Che','cuba','0111111111');


INSERT INTO Camarades_classes (idPersonne) VALUES  
(2),
(3),
(4);

INSERT INTO Utilisateur (idUtilisateur, idPersonne) VALUES 
(1,1); 

INSERT INTO Comptes_Reseaux_sociaux (idReseauxSociaux,Nom_reseau, idPersonne) VALUES 
(1,'Facebook',1),
(2,'Whatsapp',1),
(3,'Twitter',2),
(4,'Whatsapp',2),  
(5,'Snapchat',3);  

INSERT INTO Amis_de_l_utilisateur (idPersonne,idUtilisateur) VALUES 
(2,1), 
(3,1); 

INSERT INTO Calendrier (Date_activité,Nom_activité,idUtilisateur) VALUES 
('2021-07-05','Assassinat',1),
('2021-10-05' ,'Enquete Ingénieure',1),
('2021-09-14','Révision et DM',1),
('2022-11-01','Stage de recherche', 1);

INSERT INTO Cagnotte (Nom_cagnotte,Total_cagnotte,idUtilisateur) VALUES 
('USA',500,1),
('MATHS',314,1),
('Envahissement de la corée du Sud',157844,1);

INSERT INTO Objectif (idObjectif,Nom_objectif,description,type,somme_cible,idUtilisateur) VALUES 
(1,'Avoir son diplome','Efrei Paris','question d honneur',120000,1),
(2,'Trouver l_amour','avec Belle D','romantiku',777,1),
(3,'Dominer le monde','comme Lelouch','primordial',10000000,1),
(4,'Dieu des mathematiques','comme M Teller', 'indispensable',0,1);

INSERT INTO anciens_objectifs (idObjectif) VALUES 
(1),
(2);

INSERT INTO Objectif_ultime_actuel (idObjectif,Nom_cagnotte) VALUES 
(4,'MATHS');

INSERT INTO Dates_évènement (Date_event,Accord_sur_la_date,idUtilisateur,idPersonne) VALUES 
('2021-07-05',TRUE,'1','3'),
('2021-10-05',TRUE,'1','2'),
('2022-11-01',TRUE,'1','2');

INSERT INTO loisir_commun (Nom_loisir,idPersonne) VALUES 
('Base de données','2'),
('Maquettes militaires','3');

INSERT INTO Adresse_favorites_du_loisir (Numéro_Rue,Nom_Rue,Département,Ville,Nom_loisir) VALUES 
('5','Rue des Galvents','92140','Clamart','Base de données'),
('7','Rue Gustave','94240','l_hay_rose','Base de données'),
('55','Ryongsong','Pyongyang','Pyongyang','Maquettes militaires');

INSERT INTO Budget_utilisateur(id_Budget,rentrée_d_argent,dépenses_du_mois,En_déficit,Nom_cagnotte,idUtilisateur) VALUES 
(1,1100,859,FALSE,'MATHS',1);

INSERT INTO Evénement(Nom_evenement,Nom_organisateur,Lieu,Annulé,coût_évènement,id_Budget,Date_event,Date_activité,Nom_activité,idUtilisateur) VALUES
('road trip en corée','JONG UN','Corée',FALSE,10000,1,'2021-07-05','2021-07-05','Assassinat',1),
('enquete ingé','GRELAUD','Paris',FALSE,10,1,'2021-10-05','2021-10-05','Enquete Ingénieure',1),
('stage japon','DUMAS','Nagoya',FALSE,3000,1,'2022-11-01','2022-11-01','Stage de recherche',1);


INSERT INTO Séance_révision(id_Seance_revision,Matière,Travail_a_faire,date_rendu,date_seance,heure_seance,coût_séance,id_Budget,Date_activité,Nom_activité,idUtilisateur) VALUES
(1,'Maths','Exo matrices','2021-09-14','2021-09-10','13:30',0,1,'2021-09-14','Révision et DM',1);


-- idPersonne les amis et idPersonne_1 un camarade de classe
INSERT INTO présent(idUtilisateur,idPersonne,id_Seance_revision,idPersonne_1) VALUES
(1,2,1,2),
(1,2,1,4);


COMMIT;