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
	foreign key(VAT) references person(VAT) on delete cascade on update cascade
);

create table client (
	VAT varchar(255),
	foreign key(VAT) references person(VAT) on delete cascade on update cascade
);

create table veterinary (
	VAT varchar(255),
	specialization varchar(255),
	bio varchar(255),
	foreign key(VAT) references person(VAT) on delete cascade on update cascade
);

create table assistant (
	VAT varchar(255),
	foreign key(VAT) references person(VAT) on delete cascade on update cascade
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
	foreign key (name1) references species(name) on delete cascade on update cascade,
	foreign key (name2) references species(name) on delete cascade on update cascade
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
	foreign key (VAT) references client(VAT) on delete cascade on update cascade,
	foreign key(species_name) references species(name) on delete cascade on update cascade
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
	foreign key(name, VAT_owner) references animal(name,VAT) on delete cascade on update cascade,
	foreign key(VAT_client) references client(VAT) on delete cascade on update cascade, 
	foreign key(VAT_vet) references veterinary(VAT) on delete cascade on update cascade,
	check(weight>0)
);

create table participation (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	VAT_assistant varchar(255),
	primary key(name, VAT_owner, date_timestamp, VAT_assistant),
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade on update cascade,
	foreign key(VAT_assistant) references assistant(VAT) on delete cascade on update cascade
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
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade on update cascade,
	foreign key(code) references diagnosis_code(code) on delete cascade on update cascade
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
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade on update cascade,
	foreign key(name_med, lab, dosage) references medication(name,lab,dosage) on delete cascade on update cascade,
	foreign key(code) references diagnosis_code(code) on delete cascade on update cascade
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
	foreign key(name, VAT_owner, date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade on update cascade
);

create table performed (
	name varchar(255), 
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int, 
	VAT_assistant varchar(255),
	primary key(name, VAT_owner, date_timestamp,num,VAT_assistant),
	foreign key(name, VAT_owner, date_timestamp,num) references procedure_(name,VAT_owner,date_timestamp,num) on update cascade,
	foreign key(VAT_assistant) references assistant(VAT) on delete cascade on update cascade
);

create table radiography (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int, 
	file varchar(255),
	primary key(name, VAT_owner, date_timestamp, num),
	foreign key(name, VAT_owner, date_timestamp, num) references procedure_(name, VAT_owner, date_timestamp, num) on delete cascade on update cascade
);

create table test_procedure (
	name varchar(255),
	VAT_owner varchar(255),
	date_timestamp timestamp,
	num int, 
	type varchar(255),
	primary key(name, VAT_owner, date_timestamp, num),
	foreign key(name, VAT_owner, date_timestamp, num) references procedure_(name, VAT_owner, date_timestamp, num) on delete cascade on update cascade,
	check(type = 'blood' or type='urine')
);

create table produced_indicator (
	name varchar(255), 
	VAT_owner varchar(255), 
	date_timestamp timestamp,
	num int,
	indicator_name varchar(255), 
	value float,
	primary key(name, VAT_owner, date_timestamp, num, indicator_name),
	foreign key(name, VAT_owner, date_timestamp, num) references procedure_(name, VAT_owner, date_timestamp, num) on delete cascade on update cascade,
	foreign key(indicator_name) references indicator(name) on delete cascade on update cascade
);
