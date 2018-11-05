drop table if exists produced_indicator;
drop table if exists test_procedure;
drop table if exists radiography;
drop table if exists indicator;
drop table if exists performed;
drop table if exists procedure_;

drop table if exists prescription;
drop table if exists medication;
drop table if exists consult_diagnosis;
drop table if exists diagnosis_code;

drop table if exists participation;
drop table if exists consult;
drop table if exists animal;

drop table if exists generalization_species;
drop table if exists species;
drop table if exists assistant;
drop table if exists veterinary;
drop table if exists phone_number;
drop table if exists client;
drop table if exists person;



create table person (
	VAT varchar(255),
	name varchar(255),
	address_street varchar(255),
	address_city varchar(255),
	address_zip varchar(255),
	primary key (VAT)
);

create table phone_number (
	VAT varchar(255),
	phone varchar(255),
	primary key(phone),
	foreign key(VAT) references person(VAT) on delete cascade
);

create table client (
	VAT varchar(255),
	foreign key(VAT) references person(VAT) on delete cascade
);

create table veterinary (
	VAT varchar(255),
	specialization varchar(255),
	bio varchar(255),
	foreign key(VAT) references person(VAT) on delete cascade
);

create table assistant (
	VAT varchar(255),
	foreign key(VAT) references person(VAT) on delete cascade
);

create table species (
	name varchar(255),
	descc varchar(255),
	primary key (name)
);

create table generalization_species (
	name1 varchar(255),
	name2 varchar(255),
	primary key(name1),
	foreign key (name1) references species(name),
	foreign key (name2) references species(name)
);

create table animal (
	name varchar(255),
	VAT varchar(255),
	species_name varchar(255),
	colour varchar(255),
	gender varchar(255),
	birth_year year,
	age int,
	primary key(name, VAT),
	foreign key (VAT) references client(VAT) on delete cascade,
	foreign key(species_name) references species(name) on delete cascade
);

create table consult (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	s varchar(255),
	o varchar(255),
	aa varchar(255),
	p varchar(255),
	VAT_client varchar(255),
	VAT_vet varchar(255),
	weight numeric(5,2),
	primary key(name, VAT_owner, date_timestamp),
	foreign key(name, VAT_owner) references animal(name,VAT) on delete cascade,
	foreign key(VAT_client) references client(VAT) on delete cascade, 
	foreign key(VAT_vet) references veterinary(VAT) on delete cascade
);

create table participation (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	VAT_assistant varchar(255),
	primary key(name, VAT_owner, date_timestamp, VAT_assistant),
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade,
	foreign key(VAT_assistant) references assistant(VAT) on delete cascade
);

create table diagnosis_code (
	code varchar(255),
	name varchar(255),
	primary key(code)
);

create table consult_diagnosis (
	code varchar(255),
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	primary key(code, name, VAT_owner, date_timestamp),
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade,
	foreign key(code) references diagnosis_code(code) on delete cascade
);

create table medication (
	name varchar(255),
	lab varchar(255),
	dosage varchar(255),
	primary key(name, lab, dosage)
);

create table prescription (
	code varchar(255),
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	name_med varchar(255),
	lab varchar(255),
	dosage varchar(255),
	regime varchar(255),
	primary key(code, name, VAT_owner, date_timestamp, name_med,lab,dosage),
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade,
	foreign key(name_med, lab, dosage) references medication(name,lab,dosage) on delete cascade,
	foreign key(code) references diagnosis_code(code) on delete cascade
);

create table indicator (
	name varchar(255),
	reference_value numeric(10,2),
	units varchar(255),
	description varchar(255),
	primary key(name)
);

create table procedure_ (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int,
	description varchar(255),
	primary key(name, VAT_owner, date_timestamp, num),
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade
);

create table performed (
	name varchar(255), 
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int, 
	VAT_assistant varchar(255),
	primary key(name, VAT_owner, date_timestamp,num,VAT_assistant),
	foreign key(name, VAT_owner, date_timestamp,num) references procedure_(name,VAT_owner,date_timestamp,num) on delete cascade,
	foreign key(VAT_assistant) references assistant(VAT) on delete cascade
);

create table radiography (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int, 
	file varchar(255),
	primary key(name, VAT_owner, date_timestamp, num),
	foreign key(name, VAT_owner, date_timestamp, num) references procedure_(name, VAT_owner, date_timestamp, num) on delete cascade
);

create table test_procedure (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int, 
	type varchar(255),
	primary key(name, VAT_owner, date_timestamp, num),
	foreign key(name, VAT_owner, date_timestamp, num) references procedure_(name, VAT_owner, date_timestamp, num) on delete cascade
);

create table produced_indicator (
	name varchar(255), 
	VAT_owner varchar(255), 
	date_timestamp timestamp,
	num int,
	indicator_name varchar(255), 
	value float,
	primary key(name, VAT_owner, date_timestamp, num, indicator_name),
	foreign key(name, VAT_owner, date_timestamp, num) references procedure_(name, VAT_owner, date_timestamp, num) on delete cascade,
	foreign key(indicator_name) references indicator(name) on delete cascade
);

	-- Database insertions


insert into species values ('cat',NULL);
	-- insert into generalization_species values ('cat','mammal')

insert into species values ('dog',NULL);
	-- insert into generalization_species values ('dog','mammal')

insert into species values ('bird',NULL);
	-- insert into generalization_species values ('bird','aviary')
insert into species values ('mouse',NULL);


	-- Persons and their respective pets

insert into person values ('EA 24 06 86','John Smith','Crown Street','London','SW3 1AQ');
insert into phone_number values('EA 24 06 86','070 2699 7334');
insert into veterinary values('EA 24 06 86', 'General Practicioneer', 'Pop culture geek. Vet. Unapologetic social media lover. Travel fanatic.');
insert into client values('EA 24 06 86');
insert into animal values('Shiro','EA 24 06 86','Dog','Orange','M','2017','1');

insert into person values('CY 10 60 11 A',' Liz Wilson','Guild Street','London','EC1P 1RE');
insert into phone_number values('CY 10 60 11 A','079 4132 9210');
insert into veterinary values('CY 10 60 11 A', 'Surgery', 'Coffee buff. Web enthusiast. Surgery Vet. Gamer. Avid organizer.');

insert into person values('SM 62 10 29 D','Joshua Pearson','Parker Road','Croydon','CR7 QS8');
insert into phone_number values('SM 62 10 29 D','070 7514 9424');
insert into assistant values('SM 62 10 29 D');

insert into person values('CB 46 16 95 B','Jon Arbuckle','Sumner Road','Croydon','CR7 H3P');
insert into phone_number values('CB 46 16 95 B','070 2149 6062');
insert into assistant values('CB 46 16 95 B');
insert into client values('CB 46 16 95 B');
insert into animal values('Garfield','CB 46 16 95 B','Cat','Orange','M','2014','4');
insert into animal values('Odie','CB 46 16 95 B','dog','White','M','2015','3');

insert into person values('ZA 16 10 97','Walter White', 'Albuquerque','Albuquerque City', 'AB7 WWN');
insert into phone_number values('ZA 16 10 97','078 6911 1109');
insert into client  values('ZA 16 10 97');

insert into person values('NH 08 51 10','Liam Morgan', 'Ecclesbourne Road','Croydon', 'CR7 7BN');
insert into phone_number values('NH 08 51 10','078 6008 1591');
insert into client  values('NH 08 51 10');
insert into animal values('Oscar','NH 08 51 10','dog','Grey','M','2014','4');

insert into person values('EM 97 43 84','Freya Bird','London Road','London','SW16 4DP');
insert into phone_number values('EM 97 43 84','077 7080 5592');
insert into client values('EM 97 43 84');
insert into animal values('Oreo','EM 97 43 84','cat','White','M','2017','1');

insert into person values('GS 14 83 38 A','Ethan Peacock','Streatham Vale','London', 'SW16 5TB');
insert into phone_number values('GS 14 83 38 A','079 7140 4420');
insert into client values('GS 14 83 38 A');
insert into animal values('Bob','GS 14 83 38 A','bird','Green','M','2017','1');

insert into person values('YL 71 92 45 B','Henry Dennis', 'Grove Road','Mitcham','CR4 1AB');
insert into phone_number values('YL 71 92 45 B','079 1080 0169');
insert into client values('YL 71 92 45 B');
insert into animal values('Luna','YL 71 92 45 B','dog','Black','F','2010','8');

insert into person values('ZJ 37 07 20','Ethan Bennett','Jebb Avenue','London','SW2 5XF');
insert into phone_number values('ZJ 37 07 20','079 7422 0554');
insert into client values('ZJ 37 07 20');
insert into animal values('Marley','ZJ 37 07 20','dog','Brown','M','2012','6');

insert into person values('WT 72 72 72 A','Megan Leonard','Streatham Road','London','SW16 1BS');
insert into phone_number values('WT 72 72 72 A','077 7408 9030');
insert into client values('WT 72 72 72 A');
insert into animal values('Francis','WT 72 72 72 A','cat','Black','M','2016','2');
insert into animal values('Minnie','WT 72 72 72 A','cat','Black','F','2016','2');

insert into person values('CB 46 92 95 B', 'John Doe','Crown Lane', 'London', 'SW16 3JG');
insert into phone_number values('CB 46 92 95 B', '070 2179 6060');
insert into client values('CB 46 92 95 B');
insert into animal values('Jerry','CB 46 92 95 B','mouse','Brown','M','2015','3');

insert into person values('ZJ 17 07 20', 'Ethan Williams','Sutton Ct Road', 'Sutton', 'SM1 4RQ');
insert into phone_number values('ZJ 17 07 20', '079 7422 0004');
insert into client values('ZJ 17 07 20');
insert into animal values('Tom','ZJ 17 07 20','cat','Grey','M','2015','3');
insert into animal values('Bob','ZJ 17 07 20','bird','Grey','M','2018','0');



	--Consults and respective tests, diagnostics, medications

insert into consult values('Tom','ZJ 17 07 20','2018-01-05 09:00:00','Tail appears broken after an iron fell on top of it','several fractures appeard on radiography','several fractures from trauma','cast on the tail','ZJ 17 07 20','EA 24 06 86',1.5);
insert into consult values('Tom','ZJ 17 07 20','2018-02-24 14:00:00','Tom altough disturbed from the presence of the cast, managed to continue normal life','full healing as shown radiography','clear','remove cast','ZJ 17 07 20','EA 24 06 86',1.7);
insert into diagnosis_code values('BRKTAIL','Broken tail');
insert into procedure_ values ('Tom','ZJ 17 07 20','2018-02-24 14:00:00',3,'Tail X-Ray');
insert into radiography values ('Tom','ZJ 17 07 20','2018-02-24 14:00:00',3,'C:x-ray');
insert into consult_diagnosis values('BRKTAIL','Tom','ZJ 17 07 20','2018-01-05 09:00:00');
insert into performed values('Tom','ZJ 17 07 20','2018-02-24 14:00:00',3,'SM 62 10 29 D');
insert into medication values('Paracetemol','Dayer','100mg');
insert into prescription values('BRKTAIL','Tom','ZJ 17 07 20','2018-02-24 14:00:00','Paracetemol','Dayer','100mg','12/12h');


insert into consult values('Bob','ZJ 17 07 20','2018-05-30 14:00:00','Nothing of concern','','','','ZJ 17 07 20','EA 24 06 86',0.5);


insert into consult values('Jerry','CB 46 92 95 B','2018-01-05 10:00:00','Jerry doesnt want to eat and remains still all the time','urinanalysis shows presence of toxin','poisioning','admission to clinic and surveillance','CB 46 92 95 B','EA 24 06 86',0.15);
insert into consult values('Jerry','CB 46 92 95 B','2018-01-25 16:00:00','Jerry eats and plays','urinanalysis shows no presence of toxin','clear','discharge','CB 46 92 95 B','EA 24 06 86',0.2);
insert into diagnosis_code values('POSN','Poisoning');
insert into procedure_ values ('Jerry','CB 46 92 95 B','2018-01-25 16:00:00',4,'Poison');
insert into test_procedure values ('Jerry','CB 46 92 95 B','2018-01-25 16:00:00',4,'urine');
insert into indicator values ('Poison','0','picograms','Amount of poison');
insert into produced_indicator values ('Jerry','CB 46 92 95 B','2018-01-25 16:00:00',4,'Poison','9');
insert into medication values('Tarinum Forte','Dayer','10mg');
insert into prescription values('POSN','Jerry','CB 46 92 95 B','2018-01-25 16:00:00','Tarinum Forte','Dayer','10mg','12/12h for 5 days IV');
insert into consult_diagnosis values('POSN','Jerry','CB 46 92 95 B','2018-01-05 10:00:00');




insert into consult values('Marley','ZJ 37 07 20','2018-03-14 10:00:00','Looks fat and is unable to jump','Obesity','high weight ','Medication, meal cut and excercise','ZJ 37 07 20','EA 24 06 86',40.2);
insert into diagnosis_code values('DIBT','Diabetes');
insert into consult_diagnosis values('DIBT','Marley','ZJ 37 07 20','2018-03-14 10:00:00');	

insert into consult values('Marley','ZJ 37 07 20','2017-09-08 08:00:00','Doesnt want to eat or play','High level of enzimes','Kidney failure','Medication and admission','ZJ 37 07 20','CY 10 60 11 A',30.8);
insert into diagnosis_code values('KDNFLR','Kidney failure');
insert into medication values('Adaytidah polipstiso','Dayer','50mg');
insert into prescription values('KDNFLR','Marley','ZJ 37 07 20','2017-09-08 08:00:00','Adaytidah polipstiso','Dayer','50mg','everyday for 2 weeks');
insert into procedure_ values ('Marley','ZJ 37 07 20','2017-09-08 08:00:00',1,'Enzime test');
insert into test_procedure values ('Marley','ZJ 37 07 20','2017-09-08 08:00:00',1,'blood');
insert into indicator values ('Kidney Enzime','115','milligrams','Level of enzimes of kidney function');
insert into produced_indicator values ('Marley','ZJ 37 07 20','2017-09-08 08:00:00',1,'Kidney Enzime','2');
insert into consult_diagnosis values('KDNFLR','Marley','ZJ 37 07 20','2017-09-08 08:00:00');
insert into participation values ('Marley','ZJ 37 07 20','2018-03-14 10:00:00','CB 46 16 95 B');

insert into consult values('Marley','ZJ 37 07 20','2017-06-12 15:00:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','ZJ 37 07 20','EA 24 06 86',28);
insert into consult values('Marley','ZJ 37 07 20','2017-09-28 18:00:00','Limps on the left paw','X-ray shows broken limb','Broken paw','Cast','ZJ 37 07 20','CY 10 60 11 A',27);
insert into diagnosis_code values('BRKPAW','Broken paw');
insert into procedure_ values ('Marley','ZJ 37 07 20','2017-09-28 18:00:00',5,'paw X-Ray');
insert into radiography values ('Marley','ZJ 37 07 20','2017-09-28 18:00:00',5,'C:x-ray');
insert into consult_diagnosis values('BRKPAW','Marley','ZJ 37 07 20','2017-06-12 15:00:00');




insert into consult values('Francis','WT 72 72 72 A','2018-06-08 10:00:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','WT 72 72 72 A','EA 24 06 86',2.0);
insert into consult values('Francis','WT 72 72 72 A','2017-12-15 12:30:00','Sneezes a lot, doesnt eat or play','High temperature and reddish throat','Feline Flue','Medication','WT 72 72 72 A','CY 10 60 11 A',0.7);
insert into diagnosis_code values('FLFLU','Feline Flu');
insert into medication values('Ibuprofen','Mistic','35mg');
insert into prescription values('FLFLU','Francis','WT 72 72 72 A','2017-12-15 12:30:00','Paracetemol','Dayer','100mg','12/12h until next consult');
insert into prescription values('FLFLU','Francis','WT 72 72 72 A','2017-12-15 12:30:00','Ibuprofen','Mistic','35mg','12/12h until next consult');
insert into consult_diagnosis values('FLFLU','Francis','WT 72 72 72 A','2018-06-08 10:00:00');	



insert into consult values('Minnie','WT 72 72 72 A','2018-06-08 10:30:00','Large belly','Eco shows 3 fetus','Pregnant','No action required','WT 72 72 72 A','EA 24 06 86',2.6);
insert into procedure_ values ('Minnie','WT 72 72 72 A','2018-06-08 10:30:00',2,'Abdominal Eco');
insert into radiography values ('Minnie','WT 72 72 72 A','2018-06-08 10:30:00',2,'C:Ecos');



insert into consult values('Luna','YL 71 92 45 B','2018-05-12 14:00:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','YL 71 92 45 B','EA 24 06 86',14);
insert into consult values('Luna','YL 71 92 45 B','2018-08-26 10:30:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','YL 71 92 45 B','EA 24 06 86',13);	



insert into consult values('Bob','GS 14 83 38 A','2017-10-12 17:45:00','Nothing in particular','No indication of problems','Healthy','No action required','GS 14 83 38 A','EA 24 06 86',0.8);	
insert into consult values('Bob','GS 14 83 38 A','2018-02-25 17:00:00','Found outdoors, appears lost','No indication of problems','Healthy','No action required','ZJ 17 07 20','EA 24 06 86',0.7);



insert into consult values('Oreo','EM 97 43 84','2018-06-10 17:00:00','Sneezes a lot, doesnt eat or play','High temperature and reddish throat','Feline Flue','Medication','EM 97 43 84','CY 10 60 11 A',4);
insert into prescription values('FLFLU','Oreo','EM 97 43 84','2018-06-10 17:00:00','Paracetemol','Dayer','100mg','12/12h until next consult');
insert into prescription values('FLFLU','Oreo','EM 97 43 84','2018-06-10 17:00:00','Ibuprofen','Mistic','35mg','12/12h until next consult');		
insert into consult_diagnosis values('FLFLU','Oreo','EM 97 43 84','2018-06-10 17:00:00');



insert into consult values('Oscar','NH 08 51 10','2018-04-14 15:00:00','Looks fat and is unable to jump','Obese','high weight and fat','Medication, meal cut and excercise','NH 08 51 10','EA 24 06 86',40.2);
insert into consult values('Oscar','NH 08 51 10','2018-08-14 15:00:00','Nothing in particular','No indication of problems','Healthy','No action required','NH 08 51 10','EA 24 06 86',28.2);



insert into consult values('Odie','CB 46 16 95 B','2018-01-30 17:45:00','Nothing in particular','No indication of problems','Healthy','No action required','CB 46 16 95 B','EA 24 06 86',10);



insert into consult values('Garfield','CB 46 16 95 B','2018-01-31 18:00:00','Looks fat and is unable to jump','Obese','High weight and fat percentage','Medication, meal cut and excercise','NH 08 51 10','EA 24 06 86',6.2);
insert into consult_diagnosis values ('DIBT','Garfield','CB 46 16 95 B','2018-01-31 18:00:00');



insert into consult values ('Shiro', 'EA 24 06 86', '2018-01-30 17:45:00', 'Nothing in particular', 'No indication of problems', 'Healthy', 'No action required', 'EA 24 06 86', 'CY 10 60 11 A', 8);

insert into indicator values ('Kidney Enzime 2','150','milligrams','Level of enzimes of kidney function 2');
insert into indicator values ('Kidney Enzime 3','50','milligrams','Level of enzimes of kidney function 3');

insert into indicator values ('Carnine Enzime','250','picograms','Level of enzimes of Carnine');
