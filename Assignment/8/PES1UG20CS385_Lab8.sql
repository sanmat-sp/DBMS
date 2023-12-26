--1--
DELIMITER $$
CREATE FUNCTION count_tickets(ticket_385 int)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
DECLARE VALUE varchar(50);
IF ticket_385 > 3 then
set VALUE="Cannot purchase tickets Current limit is over";
    ELSE 
set VALUE ="Can Purchase ticket_385";
    end if;
    return value; 
END$$

DELIMITER ;
with t as (Select user_id, count(pnr) as count from ticket_385 group by user_id )
select user_id, count_tickets(count) as Validate, count as ticket_purchased from t;


--2--
DELIMITER $$
CREATE procedure age_updation(
IN UID varchar(30),IN DB date, OUT msg varchar(30))
BEGIN
DECLARE age int;
IF DB>sysdate() THEN
    set msg= 'Invalid DoB';
ELSE
    update user_385
    set Age=(datediff(sysdate(),DB))/365
    where User_ID= UID;
    update user_385
    set DOB=DB
    where User_ID=UID;
    set msg=' Age updated Successfully';
END IF;
END$$

DELIMITER ;
CALL age_updation('ADM_003','1991-04-08',@A);
SELECT @A;
select * from user_385 where User_ID='ADM_003';
