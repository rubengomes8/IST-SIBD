--• Create views over the tables in the database model, corresponding to the
--following relational schema.


--dim_date(date_timestamp,day,month,year)
--RI: date_timestamp corresponds to a date existing in consults

create view dim_date as 
	(select distinct date_timestamp, day(date_timestamp) as day, month(date_timestamp) as month, year(date_timestamp) as year from consult);


--dim_animal(animal_name,animal_vat,species,age)
--animal_name,animal_vat: FK(animal)

create view dim_animal as 
	(select animal.name as animal_name, animal.VAT as animal_vat, animal.species_name as species, animal.age as age from animal)

--facts_consults(name,vat,timestamp,num_procedures,num_medications)
--name,vat: FK(dim_animal)
--timestamp: FK(dim_date)

create view facts_consults as
(select da.animal_name as name, da.animal_vat as vat, dd.date_timestamp as timestamp, 
max(p.num) as num_procedures, count(pr.name_med) as num_medications
from dim_animal da, dim_date dd, procedure_ p, prescription pr, consult c
where c.name = da.animal_name and c.date_timestamp = dd.date_timestamp 
and p.date_timestamp = c.date_timestamp and pr.date_timestamp = c.date_timestamp
group by dd.date_timestamp);

(Se houver algum campo a null não o inclui)
	 


--Present the SQL code for creating each of the views corresponding to
--the tables in the previous model, so that the views list the corresponding
--records in the database (i.e., information on all the animals that had
--consults, together with the associated number of procedures and number
--of prescribed medications). 
