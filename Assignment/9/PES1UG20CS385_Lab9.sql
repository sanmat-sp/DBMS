--1--
DELIMITER $$
CREATE TRIGGER comp_ins
BEFORE INSERT
ON compartment_385 
FOR EACH ROW BEGIN 
    DECLARE error_msg VARCHAR(300);
    DECLARE cnt_comp INT;
    
    SET error_msg = ("Total number of compartments available in the train shouldn't exceed 4");
    
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
INSERT INTO compartment_385 VALUES('S03', 'III Class', 30, 6, 62621); --error
INSERT INTO compartment_385 VALUES('S03', 'III Class', 30, 6, 25260);




--2--
ALTER TABLE payment_info_385
drop CONSTRAINT payment_info_385_ibfk_1;

ALTER TABLE payment_info_385
    add constraint payment_info_385_ibfk_1
    FOREIGN KEY (PNR)
    REFERENCES TICKET_385(PNR)
    ON DELETE CASCADE;

ALTER TABLE ticket_passenger_385
drop CONSTRAINT ticket_passenger_385_ibfk_1;

ALTER TABLE TICKET_PASSENGER_385
    add constraint ticket_passenger_385_ibfk_1
    FOREIGN KEY (PNR)
    REFERENCES TICKET_385(PNR)
    ON DELETE CASCADE;

CREATE TABLE payment_info_backup_385(Transaction_ID varchar(20) NOT NULL,
    Bank varchar(50),
    Card_Number bigint(20),
    Price decimal(10,2),
    PNR varchar(10),
    PRIMARY KEY (Transaction_ID)
);

DELIMITER $$
CREATE TRIGGER backup_pay_info_385
BEFORE DELETE
ON TICKET_385
FOR EACH ROW
BEGIN 
    INSERT INTO payment_info_backup_385 SELECT * FROM payment_info_385 WHERE PNR = old.PNR;
END $$

DELIMITER ;
DELETE FROM TICKET_385 WHERE PNR = 'PNR006';
select * from payment_info_backup_385;