--1--
DELIMITER $$
CREATE TRIGGER comp_ins
BEFORE INSERT
ON compartment_385 
FOR EACH ROW BEGIN 
    DECLARE error_msg VARCHAR(300);
    DECLARE cnt_comp INT;
    
     
    
    SELECT COUNT(compartment_385.Compartment_No) 
    INTO cnt_comp FROM compartment_385 
    WHERE NEW.Train_No = compartment_385.Train_No 
    AND compartment_385.Availability > 0;

    IF cnt_comp > 3 THEN 
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = error_msg;
    END IF;
END $$

DELIMITER ;
INSERT INTO compartment_385 VALUES('S03', 'III Class', 30, 6, 62621);
INSERT INTO compartment_385 VALUES('S03', 'III Class', 30, 6, 25260);


--2--
ALTER TABLE payment_info_385
drop CONSTRAINT payment_info_385_ibfk_1;

ALTER TABLE payment_info_385
    add constraint payment_info_385_ibfk_1
    FOREIGN KEY (PNR)
    REFERENCES ticket_385(PNR)
    ON DELETE CASCADE;

ALTER TABLE ticket_passenger_385_385
drop CONSTRAINT ticket_passenger_385_385_ibfk_1;

ALTER TABLE ticket_passenger_385_385
    add constraint ticket_passenger_385_385_ibfk_1
    FOREIGN KEY (PNR)
    REFERENCES ticket_385(PNR)
    ON DELETE CASCADE;
    
CREATE TABLE payment_info_385_backup_385(Transaction_ID varchar(20) NOT NULL,
    Bank varchar(50),
    Card_Number bigint(20),
    Price decimal(10,2),
    PNR varchar(10),
    PRIMARY KEY (Transaction_ID)
);

DELIMITER $$
CREATE TRIGGER backup_pay_info_385
BEFORE DELETE
ON ticket_385
FOR EACH ROW
BEGIN 
    INSERT INTO payment_info_385_backup_385 SELECT * FROM payment_info_385 WHERE PNR = old.PNR;
END $$

DELIMITER ;
DELETE FROM ticket_385 WHERE PNR = 'PNR006';
select * from payment_info_backup_385;


drop trigger backup_pay_info_385;
DROP TABLE payment_info_backup_385;

INSERT INTO ticket_385 VALUES ('PNR006', 58450, '2033-08-04', 'Mangaluru', 'Bengaluru', '08:00:00', '10:15:00', 'USR_002','Fast','II Class', 'S01');
INSERT INTO ticket_passenger_385 VALUES('S01-35','Smriti Irani', 40, 'PNR006');
INSERT INTO payment_info_385 values(146445, 'HDFC', '1234330000000000', 806.40, 'PNR006');


ticket_385
PNR    | Train_No | Travel_Date | Departure  | Arrival   | Departure_Time | Arrival_Time | User_ID | Train_Type | Compartment_Type | Compartment_No
| PNR007 |    62621 | 2022-08-07  | Bangarpet  | Chennai   | 18:00:00       | 20:30:00     | ADM_002 | Superfast  | II Class         | S01

payment info
 Transaction_id | Bank        | Card_Number      | Price   | PNR
  576768         | ICICI       | 7563560000000000 |  558.72 | PNR007

ticket_passenger_385
Seat_No | Name             | Age  | PNR
 S01-14  | Christon D Souza |   27 | PNR007



-----------------------

CREATE TABLE backup1_385 (
PNR varchar(50) DEFAULT NULL,
Train_No int(11) DEFAULT NULL,
Travel_Date date DEFAULT NULL,
Departure varchar(50) DEFAULT NULL,
Arrival varchar(50) DEFAULT NULL,
Departure_Time time DEFAULT NULL,
Arrival_Time time DEFAULT NULL,
User_ID varchar(50) DEFAULT NULL,
Train_Type varchar(50) DEFAULT NULL,
Compartment_Type varchar(50) DEFAULT NULL,
Compartment_No varchar(50) DEFAULT NULL,
Transaction_id int(11) DEFAULT NULL,
Bank varchar(50) DEFAULT NULL,
Card_Number bigint(20) DEFAULT NULL,
Price int(11) DEFAULT NULL,
Seat_No varchar(50) DEFAULT NULL,
Name varchar(50) DEFAULT NULL,
Age int(11) DEFAULT NULL
);



DELIMITER $$
CREATE procedure Delete_ticket_info_385(delete_PNR varchar(50))
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE val int;
DECLARE pnr varchar(50);
DECLARE train_no int;
DECLARE travel_date date;
DECLARE departure varchar(50);
DECLARE arrival varchar(50);
DECLARE departure_time time;
DECLARE arrival_time time;
DECLARE user_id varchar(50);
DECLARE train_type varchar(50);
DECLARE compartment_type varchar(50);
DECLARE compartment_no varchar(50);
DECLARE transaction_id int;
DECLARE bank varchar(50);
DECLARE card_number bigint;
DECLARE price int;
DECLARE seat_no varchar(50);
DECLARE name varchar(50);
DECLARE age int ;

DECLARE cur1 CURSOR FOR SELECT
ticket_385.PNR, ticket_385.Train_No, ticket_385.Travel_Date,
ticket_385.Departure, ticket_385.Arrival, ticket_385.Departure_Time, ticket_385.Arrival_Time,
ticket_385.User_ID, ticket_385.Train_Type, ticket_385.Compartment_Type, ticket_385.Compartment_No,
payment_info_385.Transaction_ID, payment_info_385.Bank, 
payment_info_385.Card_Number, payment_info_385.Price,
ticket_passenger_385.Seat_No, ticket_passenger_385.Name, ticket_passenger_385.Age
FROM ticket_385, payment_info_385, ticket_passenger_385
WHERE ticket_385.PNR=ticket_passenger_385.PNR
AND ticket_385.PNR=payment_info_385.PNR
AND ticket_385.PNR=delete_PNR;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;



OPEN cur1;
LABEL:loop
FETCH cur1 INTO pnr, train_no, travel_date,
departure, arrival, departure_time, arrival_time,
user_id, train_type, compartment_type, compartment_no,
transaction_id, bank, card_number, price,
seat_no, name, Age;
INSERT INTO backup1_385 VALUES(pnr,train_no, travel_date,
departure, arrival, departure_time, arrival_time,
user_id, train_type, compartment_type, compartment_no,
transaction_id, bank, card_number, price,
seat_no, name, Age);

IF done = 1 THEN LEAVE LABEL;
END IF;
END loop;
CLOSE cur1;
SET val=(select count(*) from backup1_385 where backup1_385.PNR=delete_PNR);

IF val > 0 THEN
DELETE FROM payment_info_385
WHERE payment_info_385.pnr=delete_PNR;
DELETE FROM ticket_passenger_385
WHERE ticket_passenger_385.PNR=delete_PNR;
END IF;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER ticket_backup_385
BEFORE DELETE
ON ticket_385
FOR EACH ROW
BEGIN 
    CALL Delete_ticket_info_385(old.PNR);
END $$



DELETE FROM ticket_385 WHERE PNR = 'PNR006';

drop procedure Delete_ticket_info_385;
drop trigger ticket_backup_385;
select * from backup1_385;