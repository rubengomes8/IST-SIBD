-- Database insertions

-- species(name,desc)
-- generalization_species(name1,name2)

insert into species values ('cat', 'A cat is a small, typically furry, carnivorous mammal');

insert into generalization_species values ('cat','mammal');

insert into species values ('dog','Dogs (Canis lupus familiaris) are domesticated mammals, not natural wild animals. They were originally bred from wolves');

insert into generalization_species values ('dog','mammal');

insert into species values ('bird', 'Birds are a group of vertebrates which evolved from dinosaurs. They are endothermic, with feathers');

insert into generalization_species values ('bird','aviary');

insert into species values ('mouse','A mouse is a rodent, which is a kind of mammal. It has a pointed snout, small rounded ears, a body-length scaly tail and a high breeding rate');

insert into generalization_species values ('mouse','mammal');

insert into species values ('labrador','Labrador is a type of retriever-gun dog. The Labrador is one of the most popular breeds of dog in Canada, the United Kingdom and the United States.');

insert into generalization_species values ('labrador','dog');

insert into species values ('parrot','Parrots, also known as psittacines are birds of the roughly 393 species in 92 genera that make up the order Psittaciformes, found in most tropical and subtropical regions');

insert into generalization_species values ('parrot','bird');

insert into species values ('canary','The domestic canary, often simply known as the canary is a domesticated form of the wild canary, a small songbird in the finch family originating from the Macaronesian Islands');

insert into generalization_species values ('canary','bird');

insert into species values ('pug','The Pug is a breed of dog with physically distinctive features of a wrinkly, short-muzzled face, and curled tail.');

insert into generalization_species values ('pug','dog');

insert into species values ('siamese','The Siamese cat is one of the first distinctly recognized breeds of Asian cat.');

insert into generalization_species values ('siamese','cat');

insert into species values ('scottish fold','The Scottish Fold is a breed of domestic cat with a natural dominant-gene mutation that affects cartilage throughout the body, causing the ears to "fold,” bending forward and down towards the front of the head, which gives the cat what is often described as an "owl-like" appearance.');

insert into generalization_species values ('scottish fold','cat');


	-- Persons and their respective pets

--client
insert into person values ('EA 24 06 86','John Smith','Crown Street','London','SW3 1AQ');
insert into phone_number values('EA 24 06 86','070 2699 7334');
insert into veterinary values('EA 24 06 86', 'General Practicioneer', 'Pop culture geek. Vet. Unapologetic social media lover. Travel fanatic.');
insert into client values('EA 24 06 86');
insert into animal values('Shiro','EA 24 06 86','labrador','Brown','M','2017','1');

--veterinary
insert into person values('CY 10 60 11 A',' Liz Wilson','Guild Street','London','EC1P 1RE');
insert into phone_number values('CY 10 60 11 A','079 4132 9210');
insert into veterinary values('CY 10 60 11 A', 'Surgery', 'Coffee buff. Web enthusiast. Surgery Vet. Gamer. Avid organizer.');

--assistant
insert into person values('SM 62 10 29 D','Joshua Pearson','Parker Road','Croydon','CR7 QS8');
insert into phone_number values('SM 62 10 29 D','070 7514 9424');
insert into assistant values('SM 62 10 29 D');

--client
insert into person values('CB 46 16 95 B','Jon Arbuckle','Sumner Road','Croydon','CR7 H3P');
insert into phone_number values('CB 46 16 95 B','070 2149 6062');
insert into assistant values('CB 46 16 95 B');
insert into client values('CB 46 16 95 B');
insert into animal values('Garfield','CB 46 16 95 B','cat','Orange','M','2014','4');
insert into animal values('Odie','CB 46 16 95 B','pug','White','M','2015','3');

--client without animal
insert into person values('ZA 16 10 97','Walter White', 'Albuquerque','Albuquerque City', 'AB7 WWN');
insert into phone_number values('ZA 16 10 97','078 6911 1109');
insert into client  values('ZA 16 10 97');

--client
insert into person values('NH 08 51 10','Liam Morgan', 'Ecclesbourne Road','Croydon', 'CR7 7BN');
insert into phone_number values('NH 08 51 10','078 6008 1591');
insert into client  values('NH 08 51 10');
insert into animal values('Oscar','NH 08 51 10','labrador','Grey','M','2014','4');

--client
insert into person values('EM 97 43 84','Freya Bird','London Road','London','SW16 4DP');
insert into phone_number values('EM 97 43 84','077 7080 5592');
insert into client values('EM 97 43 84');
insert into animal values('Oreo','EM 97 43 84','siamese','White','M','2017','1');

--client
insert into person values('GS 14 83 38 A','Ethan Peacock','Streatham Vale','London', 'SW16 5TB');
insert into phone_number values('GS 14 83 38 A','079 7140 4420');
insert into client values('GS 14 83 38 A');
insert into animal values('Bob','GS 14 83 38 A','parrot','Green','M','2017','1');

--client
insert into person values('YL 71 92 45 B','Henry Dennis', 'Grove Road','Mitcham','CR4 1AB');
insert into phone_number values('YL 71 92 45 B','079 1080 0169');
insert into client values('YL 71 92 45 B');
insert into animal values('Luna','YL 71 92 45 B','labrador','Black','F','2010','8');

--client
insert into person values('ZJ 37 07 20','Ethan Bennett','Jebb Avenue','London','SW2 5XF');
insert into phone_number values('ZJ 37 07 20','079 7422 0554');
insert into client values('ZJ 37 07 20');
insert into animal values('Marley','ZJ 37 07 20','pug','Brown','M','2012','6');

--client
insert into person values('WT 72 72 72 A','Megan Leonard','Streatham Road','London','SW16 1BS');
insert into phone_number values('WT 72 72 72 A','077 7408 9030');
insert into client values('WT 72 72 72 A');
insert into animal values('Francis','WT 72 72 72 A','siamese','Black','M','2016','2');
insert into animal values('Minnie','WT 72 72 72 A','scottish fold','Black','F','2016','2');

--client
insert into person values('CB 46 92 95 B', 'John Doe','Crown Lane', 'London', 'SW16 3JG');
insert into phone_number values('CB 46 92 95 B', '070 2179 6060');
insert into client values('CB 46 92 95 B');
insert into animal values('Jerry','CB 46 92 95 B','mouse','Brown','M','2015','3');

--client
insert into person values('ZJ 17 07 20', 'Ethan Williams','Sutton Ct Road', 'Sutton', 'SM1 4RQ');
insert into phone_number values('ZJ 17 07 20', '079 7422 0004');
insert into client values('ZJ 17 07 20');
insert into animal values('Tom','ZJ 17 07 20','scottish fold','Grey','M','2015','3');
insert into animal values('Bob','ZJ 17 07 20','canary','Grey','M','2018','0');



	--Consults and respective tests, diagnostics, medications

insert into consult values('Tom','ZJ 17 07 20','2018-01-05 09:00:00','Tail appears broken after an iron fell on top of it','several fractures appeard on radiography','several fractures from trauma','cast on the tail','ZJ 17 07 20','EA 24 06 86',1.5);

insert into consult values('Tom','ZJ 17 07 20','2018-02-24 14:00:00','Tom altough disturbed from the presence of the cast, managed to continue normal life','full healing as shown radiography','clear','remove cast','ZJ 17 07 20','EA 24 06 86',1.7);
insert into diagnosis_code values('BRKTAIL','Broken tail');
insert into procedure_ values ('Tom','ZJ 17 07 20','2018-02-24 14:00:00',3,'Tail X-Ray');
insert into radiography values ('Tom','ZJ 17 07 20','2018-02-24 14:00:00',3,'C:x-ray');
insert into consult_diagnosis values('BRKTAIL','Tom','ZJ 17 07 20','2018-01-05 09:00:00');
insert into performed values('Tom','ZJ 17 07 20','2018-02-24 14:00:00',3,'SM 62 10 29 D');
insert into medication values('Paracetemol','Dayer','100mg');
insert into prescription values('BRKTAIL','Tom','ZJ 17 07 20','2018-02-24 14:00:00','Paracetemol','Dayer','100mg','12/12h');


insert into consult values('Bob','ZJ 17 07 20','2018-05-30 14:00:00','Nothing of concern','','','','ZJ 17 07 20','EA 24 06 86',0.5);


insert into consult values('Jerry','CB 46 92 95 B','2018-01-05 10:00:00','Jerry doesnt want to eat and remains still all the time','urinanalysis shows presence of toxin','poisioning','admission to clinic and surveillance','CB 46 92 95 B','EA 24 06 86',0.15);
insert into consult values('Jerry','CB 46 92 95 B','2018-01-25 16:00:00','Jerry eats and plays','urinanalysis shows no presence of toxin','clear','discharge','CB 46 92 95 B','EA 24 06 86',0.2);
insert into diagnosis_code values('POSN','Poisoning');
insert into procedure_ values ('Jerry','CB 46 92 95 B','2018-01-25 16:00:00',4,'Poison');
insert into test_procedure values ('Jerry','CB 46 92 95 B','2018-01-25 16:00:00',4,'urine');

insert into indicator values ('Poison','0','picograms','Amount of poison');
insert into indicator values ('Kidney Enzime 2','150','milligrams','Level of enzimes of kidney function 2');
insert into indicator values ('Kidney Enzime 3','50','milligrams','Level of enzimes of kidney function 3');
insert into indicator values ('Carnine Enzime','250','picograms','Level of enzimes of Carnine');

insert into produced_indicator values ('Jerry','CB 46 92 95 B','2018-01-25 16:00:00',4,'Poison','9');

insert into medication values('Tarinum Forte','Dayer','10mg');
insert into prescription values('POSN','Jerry','CB 46 92 95 B','2018-01-25 16:00:00','Tarinum Forte','Dayer','10mg','12/12h for 5 days IV');
insert into consult_diagnosis values('POSN','Jerry','CB 46 92 95 B','2018-01-05 10:00:00');

insert into consult values('Marley','ZJ 37 07 20','2018-03-14 10:00:00','Looks fat and is unable to jump','Obesity','high weight ','Medication, meal cut and excercise','ZJ 37 07 20','EA 24 06 86',40.2);
insert into diagnosis_code values('DIBT','Diabetes');
insert into consult_diagnosis values('DIBT','Marley','ZJ 37 07 20','2018-03-14 10:00:00');	

insert into consult values('Marley','ZJ 37 07 20','2017-09-08 08:00:00','Doesnt want to eat or play','High level of enzimes','Kidney failure','Medication and admission','ZJ 37 07 20','CY 10 60 11 A',30.8);
insert into diagnosis_code values('KDNFLR','Kidney failure');
insert into medication values('Adaytidah polipstiso','Dayer','50mg');
insert into prescription values('KDNFLR','Marley','ZJ 37 07 20','2017-09-08 08:00:00','Adaytidah polipstiso','Dayer','50mg','everyday for 2 weeks');
insert into procedure_ values ('Marley','ZJ 37 07 20','2017-09-08 08:00:00',1,'Enzime test');
insert into test_procedure values ('Marley','ZJ 37 07 20','2017-09-08 08:00:00',1,'blood');
insert into indicator values ('Kidney Enzime','115','milligrams','Level of enzimes of kidney function');
insert into produced_indicator values ('Marley','ZJ 37 07 20','2017-09-08 08:00:00',1,'Kidney Enzime','2');
insert into consult_diagnosis values('KDNFLR','Marley','ZJ 37 07 20','2017-09-08 08:00:00');
insert into participation values ('Marley','ZJ 37 07 20','2018-03-14 10:00:00','CB 46 16 95 B');

insert into consult values('Marley','ZJ 37 07 20','2017-06-12 15:00:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','ZJ 37 07 20','EA 24 06 86',28);
insert into consult values('Marley','ZJ 37 07 20','2017-09-28 18:00:00','Limps on the left paw','X-ray shows broken limb','Broken paw','Cast','ZJ 37 07 20','CY 10 60 11 A',27);
insert into diagnosis_code values('BRKPAW','Broken paw');
insert into procedure_ values ('Marley','ZJ 37 07 20','2017-09-28 18:00:00',5,'paw X-Ray');
insert into radiography values ('Marley','ZJ 37 07 20','2017-09-28 18:00:00',5,'C:x-ray');
insert into consult_diagnosis values('BRKPAW','Marley','ZJ 37 07 20','2017-06-12 15:00:00');

insert into consult values('Francis','WT 72 72 72 A','2018-06-08 10:00:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','WT 72 72 72 A','EA 24 06 86',2.0);
insert into consult values('Francis','WT 72 72 72 A','2017-12-15 12:30:00','Sneezes a lot, doesnt eat or play','High temperature and reddish throat','Feline Flue','Medication','WT 72 72 72 A','CY 10 60 11 A',0.7);
insert into diagnosis_code values('FLFLU','Feline Flu');
insert into medication values('Ibuprofen','Mistic','35mg');
insert into prescription values('FLFLU','Francis','WT 72 72 72 A','2017-12-15 12:30:00','Paracetemol','Dayer','100mg','12/12h until next consult');
insert into prescription values('FLFLU','Francis','WT 72 72 72 A','2017-12-15 12:30:00','Ibuprofen','Mistic','35mg','12/12h until next consult');
insert into consult_diagnosis values('FLFLU','Francis','WT 72 72 72 A','2018-06-08 10:00:00');	

insert into consult values('Minnie','WT 72 72 72 A','2018-06-08 10:30:00','Large belly','Eco shows 3 fetus','Pregnant','No action required','WT 72 72 72 A','EA 24 06 86',2.6);
insert into procedure_ values ('Minnie','WT 72 72 72 A','2018-06-08 10:30:00',2,'Abdominal Eco');
insert into radiography values ('Minnie','WT 72 72 72 A','2018-06-08 10:30:00',2,'C:Ecos');

insert into consult values('Luna','YL 71 92 45 B','2018-05-12 14:00:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','YL 71 92 45 B','EA 24 06 86',14);
insert into consult values('Luna','YL 71 92 45 B','2018-08-26 10:30:00','Nothing in particular','No indication of problems','Healthy','Annual vaccination','YL 71 92 45 B','EA 24 06 86',13);	

insert into consult values('Bob','GS 14 83 38 A','2017-10-12 17:45:00','Nothing in particular','No indication of problems','Healthy','No action required','GS 14 83 38 A','EA 24 06 86',0.8);	
insert into consult values('Bob','GS 14 83 38 A','2018-02-25 17:00:00','Found outdoors, appears lost','No indication of problems','Healthy','No action required','ZJ 17 07 20','EA 24 06 86',0.7);

insert into consult values('Oreo','EM 97 43 84','2018-06-10 17:00:00','Sneezes a lot, doesnt eat or play','High temperature and reddish throat','Feline Flue','Medication','EM 97 43 84','CY 10 60 11 A',4);
insert into prescription values('FLFLU','Oreo','EM 97 43 84','2018-06-10 17:00:00','Paracetemol','Dayer','100mg','12/12h until next consult');
insert into prescription values('FLFLU','Oreo','EM 97 43 84','2018-06-10 17:00:00','Ibuprofen','Mistic','35mg','12/12h until next consult');		
insert into consult_diagnosis values('FLFLU','Oreo','EM 97 43 84','2018-06-10 17:00:00');

insert into consult values('Oscar','NH 08 51 10','2018-04-14 15:00:00','Looks fat and is unable to jump','Obese','high weight and fat','Medication, meal cut and excercise','NH 08 51 10','EA 24 06 86',40.2);
insert into consult values('Oscar','NH 08 51 10','2018-08-14 15:00:00','Nothing in particular','No indication of problems','Healthy','No action required','NH 08 51 10','EA 24 06 86',28.2);

insert into consult values('Odie','CB 46 16 95 B','2018-01-30 17:45:00','Nothing in particular','No indication of problems','Healthy','No action required','CB 46 16 95 B','EA 24 06 86',10);

insert into consult values('Garfield','CB 46 16 95 B','2018-01-31 18:00:00','Looks fat and is unable to jump','Obese','High weight and fat percentage','Medication, meal cut and excercise','NH 08 51 10','EA 24 06 86',6.2);
insert into consult_diagnosis values ('DIBT','Garfield','CB 46 16 95 B','2018-01-31 18:00:00');

insert into consult values ('Shiro', 'EA 24 06 86', '2018-01-30 17:45:00', 'Nothing in particular', 'No indication of problems', 'Healthy', 'No action required', 'EA 24 06 86', 'CY 10 60 11 A', 8);

-- Add 2 same diagnosis for the dog Luna (To validate query 7)
insert into consult values('Luna','YL 71 92 45 B','2018-10-07 17:00:00','Tail injury due a fight','Lose a big quantity of blood','Broken tail','Medication','YL 71 92 45 B','EA 24 06 86', 28.2);
insert into prescription values('BRKTAIL','Luna','YL 71 92 45 B','2018-10-07 17:00:00','Paracetemol','Dayer','100mg','12/12h until next consult');
insert into consult_diagnosis values('BRKTAIL','Luna','YL 71 92 45 B','2018-10-07 17:00:00');

insert into consult values('Luna','YL 71 92 45 B','2018-11-07 17:00:00','Check tail injury due a fight','Still lose a big quantity of blood','Broken tail','Medication','YL 71 92 45 B','EA 24 06 86', 28.2);
insert into prescription values('BRKTAIL','Luna','YL 71 92 45 B','2018-11-07 17:00:00','Paracetemol','Dayer','100mg','12/12h until next consult');
insert into consult_diagnosis values('BRKTAIL','Luna','YL 71 92 45 B','2018-11-07 17:00:00');

-- Add a recent consult with weight > 30 without %obese% or %obesity%
insert into consult values ('Luna', 'YL 71 92 45 B', '2018-11-08 17:45:00', 'Nothing in particular', 'No indication of problems', 'Healthy', 'No action required', 'YL 71 92 45 B', 'CY 10 60 11 A', 30.1);
