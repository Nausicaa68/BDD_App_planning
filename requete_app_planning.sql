select * from personne;
select * from cagnotte where total_cagnotte > 400 ;

-- 1. Afficher toutes les informations relatives au dernier évènement qui a bien eu lieu : nom, date, nom de l’organisateur, liste des participants, endroit, dépenses
select nom_evenement, Date_event, Nom_organisateur, lieu, coût_évènement from evénement
where Date_event = (select max(Date_event) from evénement where Date_event < DATE(now())) and Annulé = 0 ;

-- 2. Donner la liste des amis qui partagent avec vous le même loisir (donné en paramètre).
select personne.idPersonne, personne.Nom, personne.Prenom from utilisateur join amis_de_l_utilisateur join personne join loisir_commun
on utilisateur.idUtilisateur = amis_de_l_utilisateur.idUtilisateur
and amis_de_l_utilisateur.idPersonne = personne.idPersonne
and personne.idPersonne = loisir_commun.idPersonne
where Nom_loisir = "Maquettes militaires";

-- 3. Donner le nombre de séances de révision organisées pendant le mois dernier.
select count(*) from séance_révision 
where month(date_seance) = month(now()) - 1;


