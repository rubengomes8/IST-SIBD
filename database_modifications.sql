 --**1** Change the address of the client named John Smith, to a different city and street of your choice.
 
update person
set person.address_street = 'Main St',
person.address_city = 'Croydon'
where person.name = 'John Smith' and person.VAT in (select client.VAT from client);

-- **2**  Change the reference value of all indicators used in blood tests and 
--measured in milligrams. The new reference values correspond to an
--increase in 10% from the old reference values


update indicator 
set indicator.reference_value = indicator.reference_value * 1.1
where indicator.units = 'milligrams' and indicator.name in 
(select produced_indicator.indicator_name 
from produced_indicator natural join test_procedure 
where test_procedure.type = 'blood');


-- **3**. Delete the customer named John Smith from the database, removing
--also all the animals and all the consults (including the associated
--procedures, diagnosis and prescriptions) in which he was involved.

delete from client
where client.VAT in (select person.VAT from person
where person.name = 'John Smith' and person.VAT = client.VAT);



-- **4**. Find the diagnostic code corresponding to kidney failure. Create
-- also a new diagnosis code corresponding to end-stage renal disease.
-- Change the diagnosis from kidney failure to end-stage renal disease
-- for all diagnosed animals where a blood test shows a value above 1.0
-- for the indicator named creatinine level.


insert into diagnosis_code values('RENDES','End-Stage renal disease');
update consult_diagnosis as cd
set cd.code = 'RENDES'
where exists (
select * from produced_indicator as pi
where pi.indicator_name = 'creatinine level' and pi.value > 1.0
and pi.name = cd.name and pi.VAT_owner = cd.VAT_owner and pi.date_timestamp = cd.date_timestamp);
