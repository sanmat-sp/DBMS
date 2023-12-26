--TASK 1--
--1--
LOAD DATA INFILE "C:\\xampp\\mysql\\data\\My_DB\\Data_Railway_Reservation_Train.csv" INTO TABLE TRAIN_385
COLUMNS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
ESCAPED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;


--1.a--
INSERT INTO USER_385 (User_ID, User_Type, FName, LName, Age, DOB, PinCode, Street) VALUES
('USR_001',	'PSGR',	  'Ajit',	'Ullal',	NULL,	1971-01-01,	560001,	'10 Janpath'),
('USR_002',	'PSGR',	'Muhammed', 	'Ali',	NULL,	09-10-2000,	560003,	'10 Downing'),
('USR_003',	'PSGR',	'Sai Deepak',	'Reddy',	NULL,	12-12-1996,	600001,	'14 Kailsh Marg'),
('USR_004',	'PSGR',	'Rudra',	'Agarwal',	NULL,	13-12-1996,	600042,	'5 Lohia Garden'),
('USR_005',	'PSGR',	'Rahul',	'Khanna',	NULL,	14-12-1997,	600067,	'1 Pink Street'),
('USR_006',	'PSGR',	'Nirmala',	'Seturaman',	NULL,	15-12-1998,	560105,	'3 Blue Avenue'),
('USR_007',	'PSGR',	'Smriti',	'Irani',	NULL,	16-12-1999,	575014,	'4 Banyan Avenie'),
('USR_008',	'PSGR',	'Ajit',	'Sethi',	NULL,	14-04-1966,	575001,	'6 Poes Garden'),
('USR_009',	'PSGR',	'Arjun',	'Allu',	NULL,	08-04-1967,	575020,	'7 Dhamaka street'),
('USR_010',	'PSGR',	'Samanta',	'Prabhu',	NULL,	14-04-1968,	600042,	'8 Clone Colony'),
('USR_011',	'PSGR',	'Kiran', 	'Bedi',	NULL,	14-04-1969,	560003,	'56 Brigade Road'),
('USR_012',	'PSGR',	'Rahul', 	'Gandhi',	NULL,	08-04-1970,	475001,	'Mirza road'),
('USR_013',	'PSGR',	'Rashkit', 	'Shetty',	NULL,	14-04-1971,	560009,	'JC Road'),
('USR_014',	'PSGR',	'Rishi',	'Sunak',	NULL,	14-04-1972,	600034,	'Anna Sali'),
('USR_015',	'PSGR',	'Vedavalli',	'Srinath',	NULL,	14-04-1973,	560054,	'Church Street Bangalore'),
('USR_016',	'PSGR',	'Subbu',	'Saravana',	NULL,	14-04-1974,	600043,	'American Street'),
('USR_017',	'PSGR',	'Sheela',	'Dixit',	NULL,	08-04-1975,	560048,	'Kasturba Road'),
('USR_018',	'PSGR',	'Margaret',	'Alva',	NULL,	14-04-1976,	560008,	'New BEL Road'),
('USR_019',	'PSGR',	'Arun',	'Kumar',	NULL,	14-04-1977,	600046,	'Mint Street'),
('USR_020',	'PSGR',	'Anshu',	'Bhardwaj',	NULL,	14-04-1978,	575001,	'KSR Road'),
('USR_021',	'PSGR',	'Suma',	'Sampat',	NULL,	08-04-1979,	560012,	'Old Airport Road Bangalore'),
('USR_022',	'PSGR',	'Srihari',	'Udupa',	NULL,	14-04-1980,	560015,	'Suranjan Das Road'),
('USR_023',	'PSGR',	'Satish',	'Kotian',	NULL,	14-04-1981,	600044,	'T Nagar'),
('USR_024',	'PSGR',	'Shradha',	'Nayar',	NULL,	08-04-1982,	560006,	'M G Road Bangalore'),
('USR_025',	'PSGR',	'Manisha',	'Solanki',	NULL,	08-04-1983,	575030,	'M G Road'),
('USR_026',	'PSGR',	'Bharti',	'Devgan',	NULL,	14-04-1984,	560059,	'NAL Wind Tunnel Road'),
('USR_027',	'PSGR',	'Roopa',	'Ram	',NULL,	14-04-1985,	575023,	'Bunder Road'),
('USR_028',	'PSGR',	'Pallavi',	'Ram',	NULL,	08-04-1986,	560044,	'Lavelle Road'),
('USR_029',	'PSGR',	'Ravi',	'Naik',	NULL,	14-04-1987,	600045,	'Thiru V ka Salai'),
('USR_030',	'PSGR',	'Virat',	'Murthy',	NULL,	14-04-1988,	575011,	'Bejai New Road'),
('ADM_001',	'ADMIN',	'Narendra', 	'Modi',	NULL,	14-04-1989,	600047,	'Old Jail Road'),
('ADM_002',	'ADMIN',	'Droupadi',	'Murmu',	NULL,	14-04-1990,	640012,	'High Street'),
('ADM_003',	'ADMIN',	'Manmohan', 	'Singh',	NULL,	08-04-1991,	575003,	'Pumpwell Road');

--1.b--
LOAD DATA INFILE "C:\\xampp\\mysql\\data\\My_DB\\TRAIN_385.csv" INTO TABLE TRAIN_385
COLUMNS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
ESCAPED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

--1.c--
--IMPORT--


--2--
UPDATE user_385 set Age = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), DOB)), '%Y') + 0;
SELECT * FROM user_385;

--3--
SELECT * FROM route_info_385 WHERE Distance > 70 AND Distance < 150;

--4--
SELECT * FROM route_info_385 WHERE (From_Station_name = 'Chennai' AND To_Station_Name = 'Sholingur') OR (From_Station_name = 'Sholingur' AND To_Station_Name = 'Chennai');

--5--
SELECT * FROM `train_385` WHERE train_type != 'Mail';

--6--
SELECT Name, Source, Destination FROM train_385 WHERE Source = 'Bengaluru' AND Destination = 'Chennai';

--7--
SELECT Train_No, Departure, Arrival, Departure_Time, Arrival_Time, Train_Type FROM ticket_385 WHERE (Departure = 'Chennai' AND Departure_Time > '08:00:00');

--8--
SELECT * FROM user_385 WHERE DOB BETWEEN '1980-01-01' AND '1990-12-31';

--9--
SELECT * FROM `user_385` WHERE FName LIKE 's%' OR 'S%';

--10--
SELECT * FROM compartment_385 WHERE Compartment_Type = 'I Class' AND Train_No = '62621';

--11--
SELECT PNR, Transaction_id FROM payment_info_385 WHERE Bank = 'Union Bank';