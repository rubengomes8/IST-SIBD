--1.
DROP TRIGGER update_age;
DROP TRIGGER already_vet_insert;
DROP TRIGGER already_assistant_insert;
DROP TRIGGER already_assistant_update;
DROP TRIGGER already_veterinary_update;
DROP TRIGGER cell_n;
DROP TRIGGER cell_n_update;
DROP FUNCTION n_consults;
DROP PROCEDURE ref_values;





delimiter //
CREATE TRIGGER update_age AFTER INSERT ON consult
FOR EACH ROW 
BEGIN
update animal
set age = YEAR(NOW()) - animal.birth_year;
END;//
delimiter ;


--2.

delimiter //
CREATE TRIGGER already_vet_insert BEFORE INSERT ON assistant
FOR EACH ROW
BEGIN


IF NEW.VAT IN (
SELECT v.VAT FROM veterinary v)
THEN SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This veterinary already exist';
END IF;
END;
//
delimiter ;

delimiter //
CREATE TRIGGER already_assistant_insert BEFORE INSERT ON veterinary
FOR EACH ROW
BEGIN

IF NEW.VAT IN (
SELECT a.VAT FROM assistant a)
THEN SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This assistant already exist';
END IF;
END;
//
delimiter ;


delimiter //
CREATE TRIGGER already_assistant_update BEFORE update ON veterinary
FOR EACH ROW
BEGIN

IF NEW.VAT IN (
SELECT a.VAT FROM assistant a)
THEN SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This assistant already exist';
END IF;
END;
//
delimiter ;


delimiter //
CREATE TRIGGER already_veterinary_update BEFORE UPDATE ON assistant
FOR EACH ROW
BEGIN

IF NEW.VAT IN (
SELECT v.VAT FROM veterinary v)
THEN SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This veterinary already exist';
END IF;
END;
//
delimiter ;



--3.

delimiter //
CREATE TRIGGER cell_n BEFORE INSERT ON phone_number
FOR EACH ROW
BEGIN
IF NEW.phone IN (
SELECT pn.phone FROM phone_number pn)
THEN SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This phone numbe already exist';
END IF;
END;
//
delimiter ;

delimiter //
CREATE TRIGGER cell_n_update BEFORE UPDATE ON phone_number
FOR EACH ROW
BEGIN
IF NEW.phone IN (
SELECT pn.phone FROM phone_number pn)
THEN SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This phone numbe already exist';
END IF;
END;
//
delimiter ;

--4.

delimiter //
create function n_consults(animal_name varchar(255), animal_vat varchar(255), c_year year )
returns integer

begin
declare num integer;
select count(date_timestamp) into num
from consult c
where c.name = animal_name
and c.VAT_owner = animal_vat
and year(c.date_timestamp) = c_year;

return num;
end
//
delimiter ;



--5.

delimiter //
create procedure ref_values()
begin

update produced_indicator pi
set pi.value = pi.value / 10,
pi.name = pi.name,
pi.VAT_owner = pi.VAT_owner,
pi.date_timestamp = pi.date_timestamp,
pi.num = pi.num
where pi.indicator_name in (
select i.name from indicator i
where i.units = 'milligrams');


update indicator i
set i.reference_value = i.reference_value / 10, i.units = 'centigrams'
where i.units = 'milligrams';

end
//
delimiter ;
