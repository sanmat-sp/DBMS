--1--
select Train_No, AVG(Distance) from route_info_385 GROUP BY Train_No;

--2--
select Train_No, AVG(Distance) from route_info_385 GROUP BY Train_No ORDER BY AVG(Distance) DESC;

--3--
select Train_No, SUM(Distance) from route_info_385 GROUP BY Train_No ORDER BY AVG(Distance) DESC;

--4--
 MAX
select Train_No, MAX(total_avai) AS Max_Avai FROM (select SUM(compartment_385.Availability) AS total_avai, Train_No from compartment_385 group by Train_No) AS Total_Availability;  
 MIN 
select Train_No, MIN(total_avai) AS Max_Avai FROM (select SUM(compartment_385.Availability) AS total_avai, Train_No from compartment_385 group by Train_No) AS Total_Availability;   

--5--
select User_ID, Phone_No from user_phone_385 where User_ID IN ('ADM_001', 'USR_006', 'USR_010');

--6--
select Train_Type, AVG(FarePerKM) AS Avg_Fare from fare_table_385 GROUP BY Train_Type ORDER BY Avg_Fare DESC;

--7--
select * from user_385 where Age = (select MAX(Age) AS Age from user_385);

--8--
select COUNT(Name) FROM ticket_passenger_385 where Name LIKE '%Ullal';
