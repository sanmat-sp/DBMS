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



--2.1--
GRANT SELECT, INSERT, DELETE, UPDATE ON user_phone_385 TO 'root'@'localhost';
GRANT ALL ON user_train_385 TO 'root'@'localhost';
GRANT SELECT ON user_385 TO 'root'@'localhost';

--2.2-
REVOKE DELETE AND UPDATE ON ticket_385 FROM 'root'@'localhost';

--2.3--
SET AUTOCOMMIT = 1