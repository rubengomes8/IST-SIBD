--1.(CORRECT) List the name, owner name, species, and age, for all animals that
--participated in consults with a veterinary doctor named John Smith.


select animal.name, person.name, species_name, age from animal inner join client inner join person
    where exists( 
        select consult.name, consult.VAT_owner from consult
        where consult.VAT_vet in(
            select VAT from person natural join veterinary 
            where person.name = 'John Smith')
        and consult.name = animal.name
        and consult.VAT_owner = animal.VAT)
    and animal.VAT = client.VAT
    and client.VAT=person.VAT;

--John Smith.VAT é EA 24 06 86; acho que está bem (Rúben&Renato)
--não se pode fazer natural join a estas tabelas porque os nomes, VATs estão todos misturados e têm valores diferentes 
--entre tabelas!



--2.(CORRECT) List the name of all indicators measured in milligrams and with a
--reference value above 100. The names should be presented together
--with the corresponding reference value, and sorted according to the
--reference value, in descending order

select name, reference_value from indicator 
    where units = 'milligrams' 
    and reference_value > 100
        order by reference_value desc;
        
        
--acho que está bem (Rúben&Renato)



--3.(CORRECT)List the name, owner name, species and age for all animals with the
--most recent weight above 30 kilograms, and where the objective part
--of any SOAP note, associated to consults of that animal, mentions
--terms like obesity or obese.

select animal.name, person.name, species_name, age from animal inner join person
where
exists(
select distinct c1.name, date_timestamp from consult c1
where date_timestamp = 
(select max(date_timestamp) from consult c2 where c1.name = c2.name and c1.VAT_owner = c2.VAT_owner)
and c1.weight > 30
and c1.o like '%obese%' or c1.o like '%obesity%'
and c1.VAT_owner = animal.VAT
and c1.VAT_owner = person.VAT);

select animal.name, person.name, species_name, age from animal, person, consult c
where c.name = animal.name and c.VAT_owner = animal.VAT 
and animal.VAT = person.VAT
and c.o like '%obese%' or c.o like '%obesity%'
and exists(
select distinct c1.name, date_timestamp from consult c1
where date_timestamp = 
(select max(date_timestamp) from consult c2 where 
 c1.name = c2.name and c1.VAT_owner = c2.VAT_owner 
 and c1.date_timestamp = c2.date_timestamp)
and c1.weight > 30
and c1.VAT_owner = animal.VAT
and c1.VAT_owner = person.VAT
and c.name = c1.name 
and c.VAT_owner = c1.VAT_owner
and c.date_timestamp = c1.date_timestamp
);
    	
--convem adicionar uma consulta recente com peso > 30 mas sem obesidades


--4.(CORRECT) List the name, VAT and address of all clients of the hospital that are not owners of animals

select person.name, person.VAT, person.address_street, person.address_city, person.address_zip from person, client
where person.VAT = client.VAT and
client.VAT not in (select animal.VAT from animal);

--acho que está bem (Rúben&Renato)


--5. (CORRECT) For each possible diagnosis, list the number of distinct medication
--names that have been prescribed to treat that condition. Sort the
--results according to the number of distinct medication names, in
--ascending order.

select count(distinct m.name), dc.code from medication m, diagnosis_code dc, prescription p
where m.name = p.name_med and m.lab = p.lab and m.dosage = p.dosage and
p.code = dc.code
group by dc.code
order by count(m.name);

--acho que está bem (Rúben&Renato)

--6. (CORRECT) Present the average number of assistants, procedures, diagnostic codes,
--and prescriptions involved in consults from the year of 2017.

select count(name_med)/(select count(*) from consult where year(date_timestamp) = 2017) as avg_prescriptions, 
count(VAT_assistant)/(select count(*) from consult where year(date_timestamp) = 2017) as avg_assistants,
count(num)/(select count(*) from consult where year(date_timestamp) = 2017) as avg_procedures,
count(consult_diagnosis.code)/(select count(*) from consult where year(date_timestamp) = 2017) as avg_diagnosis_codes
from consult left outer join prescription on consult.VAT_owner = prescription.VAT_owner and consult.name = prescription.name and consult.date_timestamp = prescription.date_timestamp 
left outer join participation on consult.VAT_owner = participation.VAT_owner and consult.name = participation.name and consult.date_timestamp = participation.date_timestamp 
left outer join procedure_ on consult.VAT_owner = procedure_.VAT_owner and consult.name = procedure_.name and consult.date_timestamp = procedure_.date_timestamp 
left outer join consult_diagnosis on consult.VAT_owner = consult_diagnosis.VAT_owner and consult.name = consult_diagnosis.name and consult.date_timestamp = consult_diagnosis.date_timestamp 
where year(consult.date_timestamp) = 2017;
		



--7.For each animal sub-species of dog, present the name of the most common disease (i.e., the name associated to the most frequent diagnostic code for consults involving animals of that species). 



select species_name, name from ( select a.species_name, cd.code, dc.name, count(cd.code) from animal a inner join consult_diagnosis cd on a.name = cd.name and a.VAT = cd.VAT_owner, generalization_species,diagnosis_code as dc
where a.species_name = generalization_species.name1 
and generalization_species.name2 = 'dog'
and cd.code = dc.code
group by a.species_name, cd.code 
order by count(cd.code) desc) as t
group by species_name;





--8.(CORRECT) List the names of individuals that are simultaneously clients of the
--hospital (i.e., owners of animals or clients that have brought animals
--to consults) and employees of the hospital (i.e., veterinary doctors or
--assistants).

select person.name from person natural join client
    where client.VAT in 
	    (select veterinary.VAT from veterinary union select assistant.VAT from assistant);
	    
--acho que está bem (Rúben&Renato) porque todos os owners são clientes!
	
	
--9.(CORRECT-mas não sei porque) List the names and addresses of clients that only own birds as their
--pets (i.e., the clients for whom all the owned animals contain the
--word bird as part of the species name).

select distinct p.name, p.address_street, p.address_city, p.address_zip from client c natural join person p
where exists(
    select animal.name, animal.VAT from animal 
        where animal.species_name like '%bird%'
        and animal.VAT = c.VAT
        and not exists(
            select a2.name, a2.VAT from animal a2, client c2
                    where a2.species_name not like '%bird%'
                    and a2.VAT = c2.VAT
                    and a2.VAT = animal.VAT
            )
    );


--Renato: Achamos que falta um pormenor, porque se o species_name fôr papagaio, não vai aparecer, mas é um bird
--(Tem aqui a questão de a key ser dupla e nao sei muito bem se é "animal.name,animal.VAT not in")

	
