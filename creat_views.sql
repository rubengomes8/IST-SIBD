--• Create views over the tables in the database model, corresponding to the
--following relational schema.


--dim_date(date_timestamp,day,month,year)
--RI: date_timestamp corresponds to a date existing in consults

create view dim_date as 
	(select distinct date_timestamp, day(date_timestamp) as day, month(date_timestamp) as month, year(date_timestamp) as year from consult);


--dim_animal(animal_name,animal_vat,species,age)
--animal_name,animal_vat: FK(animal)

create view dim_animal as 
	(select animal.name as animal_name, animal.VAT as animal_vat, animal.species_name as species, animal.age as age from animal);




--facts_consults(name,vat,timestamp,num_procedures,num_medications)
--name,vat: FK(dim_animal)
--timestamp: FK(dim_date)

create view prc_tbl as (select da.animal_name, da.animal_vat, dd.date_timestamp,count(prc.num) as procedures
from dim_date dd natural join consult c left outer join procedure_ prc
on c.name = prc.name and c.VAT_owner = prc.VAT_owner and c.date_timestamp = prc.date_timestamp
left outer join dim_animal as da
on c.name = da.animal_name and c.VAT_owner = da.animal_vat
group by dd.date_timestamp);


create view prs_tbl as (select da.animal_name, da.animal_vat, dd.date_timestamp,count(prs.name_med) as medications
from dim_date dd natural join consult c left outer join prescription prs
on c.name = prs.name and c.VAT_owner = prs.VAT_owner and c.date_timestamp = prs.date_timestamp
left join dim_animal as da
on c.name = da.animal_name and c.VAT_owner = da.animal_vat
group by dd.date_timestamp);


create view facts_consults as 
select prc_tbl.animal_name, prc_tbl.animal_vat, prc_tbl.date_timestamp, procedures, medications
from prc_tbl left join prs_tbl
on prc_tbl.animal_name= prs_tbl.animal_name and prc_tbl.animal_vat= prs_tbl.animal_vat and prc_tbl.date_timestamp = prs_tbl.date_timestamp
union
select prs_tbl.animal_name, prs_tbl.animal_vat, prs_tbl.date_timestamp, procedures, medications
from  prc_tbl right join prs_tbl
on prc_tbl.animal_name= prs_tbl.animal_name and prc_tbl.animal_vat= prs_tbl.animal_vat and prc_tbl.date_timestamp = prs_tbl.date_timestamp;
	 


--Present the SQL code for creating each of the views corresponding to
--the tables in the previous model, so that the views list the corresponding
--records in the database (i.e., information on all the animals that had
--consults, together with the associated number of procedures and number
--of prescribed medications). 













