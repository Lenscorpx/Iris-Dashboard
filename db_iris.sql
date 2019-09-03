use master;
    if exists(select * from sys.databases where name='db_iris')
        drop database db_iris;
create database db_iris;
use db_iris;
create table t_settings
(
    num_settings int identity,
    date_settings date,
    nom_entreprise nvarchar(50),
    ville nvarchar(50),
	mot_de_passe nvarchar(50),
    constraint pk_settings primary key(num_settings)
);
create table t_patient
(
    id_patient nvarchar(50),
    noms nvarchar(100),
    date_naissance date,
    sexe nvarchar(50),
    phone nvarchar(50),
    profession nvarchar(100),
    statut_matrimonial nvarchar(100),
    provenance nvarchar(50),--goma, hors goma, hors rdc
    constraint pk_patient primary key(id_patient)
);
create table t_categorie_organisation
(
    id_categorie_organisation nvarchar(50),
    description_cat nvarchar(100),
    constraint pk_categorie primary key(id_categorie_organisation)
);
create table t_organisation
(
    code_organisation nvarchar(50),
    nom_organisation nvarchar(50),
    adresse nvarchar(100),
    num_phone nvarchar(50),
    id_categorie_organisation nvarchar(50),
	constraint pk_organisation primary key(code_organisation),
	constraint fk_categorie_org foreign key (id_categorie_organisation)
			references t_categorie_organisation(id_categorie_organisation) on delete cascade on update cascade
);
create table t_abonnement
(
    num_bon nvarchar(50),
    date_debut date,
    date_fin date,
    id_patient nvarchar(50),
    code_organisation nvarchar(50),
    constraint pk_abonnement primary key(num_bon),
    constraint fk_organisation foreign key(code_organisation) 
            references t_organisation(code_organisation) on delete cascade on update cascade,
    constraint fk_patient_abonnement foreign key(id_patient)
            references t_patient(id_patient) on delete cascade on update cascade
);
create table t_consultation
(
    num_consultation int identity, 
    type_consultation nvarchar(50), 
    date_consultation date not null,
    descript nvarchar(500), 
    abonnement nvarchar(50) not null, 
    id_patient nvarchar(50),
    constraint pk_consultation primary key(num_consultation),
    constraint fk_patient_consultation foreign key(id_patient) 
            references t_patient(id_patient),
);
create table t_pathologie
(
    code_pathologie nvarchar(50),
    description_pathologie nvarchar(100),
    constraint pk_pathologie primary key(code_pathologie)
);
create table t_erreur_refraction
(
    code_erreur_refraction nvarchar(50),
    description_erreur_refraction nvarchar(100),
    constraint pk_erreur_refraction primary key(code_erreur_refraction)
);
create table t_chirurgie
(
    code_chirurgie nvarchar(50),
    description_chirurgie nvarchar(100),
    constraint pk_chirurgie primary key(code_chirurgie)
);
create table t_analyse
(
    num_analyse int identity,
    date_analyse date,
    num_consultation int,
    constraint pk_analyse primary key(num_analyse),
    constraint fk_analyse_consultation foreign key(num_consultation)
            references t_consultation(num_consultation) on delete cascade on update cascade
);
create table t_tarif
(
	num_tarif int identity,
	date_ajout date,
	libelle_tarif nvarchar(50),
	prix decimal,
	constraint pk_tarif primary key(num_tarif)
);
create table t_details_pathologie
(
    num_details_path int identity,
    date_pathologie date,
    code_pathologie nvarchar(50),
    num_analyse int,
    noms_medecin nvarchar(50),
	num_tarif int,
    constraint pk_details_path primary key(num_details_path),
    constraint fk_pathologie_det foreign key(code_pathologie) 
            references t_pathologie(code_pathologie) on delete cascade on update cascade,
    constraint fk_analyse_det_path foreign key(num_analyse)
            references t_analyse(num_analyse) on delete cascade on update cascade,
	constraint fk_details_pathol_tarif foreign key (num_tarif)
			references t_tarif(num_tarif) on delete cascade on update cascade
);
create table t_details_erreurs
(
    num_details_erreur int identity,
    date_erreurs date,
    code_erreur_refraction nvarchar(50),
    num_analyse int,
    noms_medecin nvarchar(50),
	num_tarif int,
    constraint pk_details_erreurs primary key(num_details_erreur),
    constraint fk_erreurs_details foreign key(code_erreur_refraction)
            references t_erreur_refraction(code_erreur_refraction) on delete cascade on update cascade,
    constraint fk_analyse_det_erreur foreign key(num_analyse) 
            references t_analyse(num_analyse) on delete cascade on update cascade,
	constraint fk_details_erreur_tarif foreign key(num_tarif)
			references t_tarif(num_tarif) on delete cascade on update cascade
);
create table t_details_chirurgie
(
    num_details_chirurgie int identity,
    date_chirurgie date,
    code_chirurgie nvarchar(50),
    num_analyse int,
    noms_medecin nvarchar(50),
	num_tarif int,
    constraint pk_details_chirurgie primary key(num_details_chirurgie),
    constraint fk_chirurgie_details foreign key(code_chirurgie)
            references t_chirurgie(code_chirurgie) on delete cascade on update cascade,
    constraint fk_analyse_det_chirurgie foreign key(num_analyse) 
            references t_analyse(num_analyse) on delete cascade on update cascade,
	constraint fk_details_chir_tarif foreign key(num_tarif)
			references t_tarif(num_tarif) on delete cascade on update cascade
);
create table t_ordonnance
(
    num_ordonnance int,
    date_ordonnance date,
    description_ordonnance nvarchar(500),
    noms_medecin nvarchar(100),
    num_consultation int,
	constraint pk_ordonnance primary key(num_ordonnance),
	constraint fk_consultation_ordo foreign key(num_consultation)
		references t_consultation(num_consultation) on delete cascade on update cascade
);
create table t_fournisseur
(
	code_fournisseur nvarchar(50),
	designation_fournisseur nvarchar(50) not null,
	type_fournisseur nvarchar(50),
	constraint pk_fournisseur primary key(code_fournisseur) 
);
create table t_produit
(
	code_produit nvarchar(50),
	type_produit nvarchar(50),
	date_expiration date,
	constraint pk_produit primary key(code_produit)
);
create table t_approvisionnement
	(
		code_approvisionnement nvarchar(50),
		date_approvisionnement date,
		code_fournisseur nvarchar(50),
		code_produit nvarchar(50),
		quantite decimal,
		prix_unitaire decimal,
		cout_total decimal,
		constraint pk_approvisionnement primary key(code_approvisionnement),
		constraint fk_fournisseur_approv foreign key(code_fournisseur) references t_fournisseur(code_fournisseur) on delete cascade on update cascade,
		constraint fk_approv_produit foreign key(code_produit) references t_produit(code_produit) on delete cascade on update cascade
	);
create table t_vente
	(
		numero_vente int identity,
		date_vente date,
		num_ordonnance int,
		constraint pk_vente primary key(numero_vente),
		constraint fk_ordonnance_vente foreign key(num_ordonnance) references t_ordonnance(num_ordonnance) on delete cascade on update cascade
	);
create table t_details_vente
	(
		numero_details_vente int identity,
		numero_vente int,
		code_approvisionnement nvarchar(50),
		quantite int,
		prix_unitaire decimal,
		constraint pk_details_vente primary key(numero_details_vente),
		constraint fk_produit_details foreign key(code_approvisionnement) references t_approvisionnement(code_approvisionnement) on delete cascade on update cascade,
		constraint fk_vente_details foreign	key(numero_vente) references t_vente(numero_vente) on delete cascade on update cascade
	);
create table t_paiement_vente
(
    num_paiement_vente int identity,
    numero_vente int,
    date_paiement_vente date,
    montant_paye decimal,
    type_paiement nvarchar(50),
    observation nvarchar(50),
    constraint pk_paiement_vente primary key(num_paiement_vente),
    constraint fk_vente foreign key(numero_vente) 
            references t_vente(numero_vente) on delete cascade on update cascade
);
create table t_paiement_consultation
(
    num_paiement_consultation int identity,
    num_consultation int,
    date_paiement_consultation date,
    montant_paye decimal,
    type_paiement nvarchar(50),
    observation nvarchar(50),
    constraint pk_paiement_consultation primary key(num_paiement_consultation),
    constraint fk_consultation foreign key(num_consultation) 
            references t_consultation(num_consultation) on delete cascade on update cascade
);