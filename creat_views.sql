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
	(select da.name as name, da.VAT as vat, dd.date_timestamp as timestamp, tp.num as num_procedures, p.name_med as num_medications
	 from dim_animal da,dim_date dd inner join prescription p inner join test_procedure tp
	 on  p.date_timestamp = dd.date_timestamp
	 where p.name = da.name
	 and tp.name = p.name);
	 
create view facts_consults as
	(select da.name as name, da.VAT as vat, dd.date_timestamp as timestamp, tp.num as num_procedures, p.name_med as num_medications
	 from dim_animal da, dim_date dd, prescription p, test_procedure tp
	 where dd.date_timestamp = p.date_timestamp 
	 and tp.date_timestamp = p.date_timestamp
	 and tp.name = da.name
	 and da.animal_vat = tp.VAT_owner
	 and tp.name = p.name
	 and tp.VAT_owner = p.VAT_owner
	 and tp.date_timestamp = p.date_timestamp
	 and tp.num = p.num);
	 
	 


--Present the SQL code for creating each of the views corresponding to
--the tables in the previous model, so that the views list the corresponding
--records in the database (i.e., information on all the animals that had
--consults, together with the associated number of procedures and number
--of prescribed medications). 
