--• Create views over the tables in the database model, corresponding to the
--following relational schema.


--dim_date(date_timestamp,day,month,year)
--RI: date_timestamp corresponds to a date existing in consults

create view dim_date as 
	(select date_timestamp, day(date_timestamp), month(date_timestamp), year (date_timestamp) from consult);


--dim_animal(animal_name,animal_vat,species,age)
--animal_name,animal_vat: FK(animal)

create view dim_animal as 
	(select animal.name, animal.VAT, animal.species_name, animal.age from animal)

--facts_consults(name,vat,timestamp,num_procedures,num_medications)
--name,vat: FK(dim_animal)
--timestamp: FK(dim_date)

create view facts_consults as
	(select da.name as name, da.VAT as VAT, dd.date_timestamp as timestamp, p.name_med as num_medications,tp.num as num_procedures
	 from dim_animal da,dim_date dd inner join prescription p inner join test_procedure tp
	 on  p.date_timestamp = dd.date_timestamp
	 where p.name = da.name
	 and tp.name = p.name);


--Present the SQL code for creating each of the views corresponding to
--the tables in the previous model, so that the views list the corresponding
--records in the database (i.e., information on all the animals that had
--consults, together with the associated number of procedures and number
--of prescribed medications).
