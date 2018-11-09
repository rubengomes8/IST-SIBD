--Suggest database indexes that could be used to improve the performance
--of the first two queries, from the list of information needs. Justify your
--choice, and provide SQL instructions for implementing the indexes.

--**1**

create index person_client
on client(VAT);

create index animal_client
on animal(VAT);

create index vet_person
on veterinary(VAT);


--Indexar estas tabelas acelera o processo de join nas query.

--**2**

create nonclustered index ind_units
on indicator(units);


create index ind_ref
on indicator(reference_value);
