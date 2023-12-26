CREATE TABLE USER_385 (
    User_ID varchar(20) NOT NULL, 
    User_Type varchar(20),
    FName varchar(50),
    LName varchar(20),
    Age int(3),
    DOB date,
    PinCode int(6),
    Street varchar(100),
    PRIMARY KEY (User_ID)
);


CREATE TABLE FARE_TABLE_385 (
    Train_Type varchar(20) NOT NULL,
    Compartment_Type varchar(20) NOT NULL,
    FarePerKM decimal(4,2),
    PRIMARY KEY (Train_Type, Compartment_Type)
);


CREATE TABLE TRAIN_385 (
    Train_No varchar(6) NOT NULL,
    Name varchar(100), 
    Train_Type varchar(20), 
    Source varchar(30),
    Destinationn varchar(30), 
    Availability varchar(30), 
    PRIMARY KEY (Train_No)
);


CREATE TABLE ROUTE_INFO_385 (
    From_Station_No int(6),
    To_Station_No int(6),
    From_Station_name varchar(50),
    To_Station_Name varchar(50),
    Distance decimal(7,2),
    Train_No varchar(6),
    FOREIGN KEY (Train_No) REFERENCES TRAIN_385 (Train_No)
);


CREATE TABLE COMPARTMENT_385 (
    Compartment_No varchar(3),
    Compartment_Type varchar(20),
    Capacity int(3),
    Availability int(3),
    Train_No varchar(6),
    FOREIGN KEY (Train_No) REFERENCES TRAIN_385 (Train_No)
);


CREATE TABLE TICKET_385 (
    PNR varchar(10) NOT NULL,
	Train_No int(6),
    Travel_Date date, 
    Departure varchar(50),
    Arrival varchar(50),
    Departure_Time time,
    Arrival_Time time,
    User_ID varchar(20),
    Train_Type varchar(20),
    Compartment_Type varchar(20),
    Compartment_No varchar(3),
    PRIMARY KEY (PNR),
    FOREIGN KEY (User_ID) REFERENCES USER_385 (User_ID),
    FOREIGN KEY (Train_Type) REFERENCES FARE_TABLE_385 (Train_Type)
);


CREATE TABLE TICKET_PASSENGER_385 (
    Seat_No varchar(6) NOT NULL,
	Name varchar(70),
    Age int(3),
    PNR varchar(10),
    PRIMARY KEY (Seat_No),
    FOREIGN KEY (PNR) REFERENCES TICKET_385 (PNR)
);


CREATE TABLE PAYMENT_INFO_385 (
    Transaction_ID varchar(20) NOT NULL,
    Bank varchar(50),
    Card_Number bigint(20),
    Price decimal(10,2),
    PNR varchar(10),
    PRIMARY KEY (Transaction_ID),
    FOREIGN KEY (PNR) REFERENCES TICKET_385 (PNR)
);



CREATE TABLE USER_PHONE_385 (
    User_ID varchar(20), 
    Phone_No bigint(12),
    FOREIGN KEY (User_ID) REFERENCES USER_385 (User_ID)
);


CREATE TABLE USER_TRAIN_385 (
    User_ID varchar(20),
    Train_No varchar(6),
    DATETIMESTAMP datetime,
    FOREIGN KEY (Train_No) REFERENCES TRAIN_385 (Train_No),
    FOREIGN KEY (User_ID) REFERENCES USER_385 (User_ID)
);

