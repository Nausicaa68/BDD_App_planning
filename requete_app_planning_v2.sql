select * from personne;
select * from cagnotte where total > 4000 ;

-- 1. Afficher toutes les informations relatives au dernier évènement qui a bien eu lieu : nom, date, nom de l’organisateur, liste des participants, endroit, dépenses
select nom_event, date_event, nom_orga, lieu, cout_event
from evenement join dates_event on evenement.id_date = dates_event.id_date
where date_event = (select max(date_event) from dates_event where date_event < DATE(now())) and annule = 0 ;

-- 2. Donner la liste des amis qui partagent avec vous le même loisir (donné en paramètre).
-- select personne.idPersonne, personne.nom, personne.prenom 
select *
from amis JOIN loisir_commun JOIN personne
ON amis.id_amis = loisir_commun.id_amis
and personne.idPersonne = amis.idPersonne_1
where amis.id_amis IN (Select id_amis
from loisir_commun 
where Nom_loisir = "Maquettes militaires" AND idUtilisateur=2);

-- 3. Donner le nombre de séances de révision organisées pendant le mois dernier.
select count(*)
from seance_revision join evenement join dates_event
on seance_revision.idEvenement = evenement.idEvenement
and evenement.id_date = dates_event.id_date
where month(date_event) = month(now()) - 1;

-- 4. Donner la liste des camarades de classe qui ne sont pas considérés comme amis.
select * 
from personne join amis
on personne.idPersonne = amis.idPersonne_1
where idUtilisateur = 1;

select * from personne join camarades
on personne.idPersonne = camarades.idPersonne_1
where idPersonne not in (
							select idPersonne
							from personne join amis
							on personne.idPersonne = amis.idPersonne_1
							where idUtilisateur = 1
						)
and idUtilisateur = 1;

-- 5. Donner la liste des amis qui habitent la même ville où aura lieu un évènement donné.
select *
from personne join amis
on personne.idPersonne = amis.idPersonne_1
where idUtilisateur = 2 and ville_residence in (
													select lieu from evenement
													where nom_event = "road trip en corée"
												);
                                                

-- 6. Donner la liste des adresses favorites qui n’ont jamais hébergé d’évènements jusque-là.
select distinct * from adresse_favorites
where ville not in (select lieu from evenement);

-- 7. Afficher la liste des dépenses ainsi que des rentrées d’argent du mois en cours.

-- 8. Donner le taux d’acceptation des évènements (nombre d’évènements validés sur le nombre total d’évènements proposés) pour chaque organisateur.
select * -- distinct nom_orga
from evenement join dates_event
on evenement.id_date = dates_event.id_date;