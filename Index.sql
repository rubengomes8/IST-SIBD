--**1**

create index person_client
on client(VAT);

create index animal_client
on animal(VAT);


--Indexar estas tableas acelera o processo de join nas query.

--**2**

create nonclustered index ind_units
on indicator(units);


create index ind_ref
on indicator(reference_value);
