--1-- 
  --First view--
CREATE VIEW compute_price_385 AS 
SELECT ticket_385.PNR, ticket_385.Train_No, ticket_385.Departure, ticket_385.Arrival,
route_info_385.Distance, fare_table_385.FarePerKM
FROM ticket_385, route_info_385, fare_table_385
WHERE (ticket_385.Train_No = route_info_385.Train_No AND
       ticket_385.Departure = route_info_385.From_Station_Name AND
       ticket_385.Arrival = route_info_385.To_Station_Name AND
       fare_table_385.Train_Type = ticket_385.Train_Type AND
       fare_table_385.Compartment_Type = ticket_385.Compartment_type);

  --second view--
CREATE VIEW passenger_num_385 AS SELECT ticket_passenger_385.PNR, COUNT(ticket_passenger_385.PNR) as numbers from ticket_passenger_385 GROUP BY ticket_passenger_385.PNR;
  --final query--
UPDATE payment_info_385 AS pi INNER JOIN compute_price_385 AS cp ON pi.PNR = cp.PNR INNER JOIN passenger_num_385 AS pn on cp.PNR = pn.PNR SET pi.Price = cp.Distance * cp.FarePerKM * pn.numbers;

--2--
SELECT train_385.Train_No, train_385.Name, route_info_385.From_Station_No, route_info_385.From_Station_Name, route_info_385.To_Station_Name, route_info_385.To_Station_No, route_info_385.Distance from train_385 NATURAL JOIN route_info_385;

--3--
 SELECT * FROM (SELECT * FROM train_385 WHERE train_385.Source = "Bengaluru" AND train_385.Destination = "Chennai") AS V1,
    -> (SELECT compartment_385.Train_No AS Train_No, SUM(compartment_385.Availability) AS Avai FROM compartment_385 GROUP BY compartment_385.Train_No) AS V2
    -> WHERE V1.Train_No = V2.Train_No AND V2.Avai > 10;

--4--
SELECT user_385.Fname, user_385.Lname, V1.Price FROM ( SELECT payment_info_385.Price, payment_info_385.PNR, ticket_385.User_ID FROM payment_info_385 INNER JOIN ticket_385 ON payment_info_385.PNR = ticket_385.PNR) AS V1 INNER JOIN user_385 ON V1.User_ID = user_385.User_ID WHERE V1.Price > 500;

--5--
SELECT user_385.Fname, user_385.Lname, user_385.DOB, ticket_385.PNR FROM user_385 LEFT OUTER JOIN ticket_385 ON user_385.User_ID = ticket_385.User_ID

--6--
SELECT * FROM ( SELECT user_385.Fname, user_385.Lname, ticket_385.PNR FROM user_385 LEFT OUTER JOIN ticket_385 ON user_385.User_ID = ticket_385.User_ID) AS T1 WHERE T1.PNR IS NULL

--7--
SELECT ticket_385.PNR, ticket_385.Train_No, ticket_385.Travel_Date, user_385.Fname, user_385.Lname FROM ticket_385 RIGHT OUTER JOIN user_385 ON ticket_385.User_ID = user_385.User_ID

--8--
SELECT ticket_385.User_ID, ticket_385.Train_No, train_385.Name from ticket_385 RIGHT OUTER JOIN train_385 ON ticket_385.Train_No = train_385.Train_No

--9--
SELECT train_385.Train_No, train_385.Name FROM train_385 WHERE train_385.Destination IN (
    ->     SELECT train_385.Destination FROM train_385 WHERE train_385.Destination != "Mangaluru")
    ->     AND
    ->     train_385.Train_No IN (SELECT ticket_385.Train_No FROM ticket_385 WHERE Departure_Time >= '20:30:00');

--10--
SELECT ticket_385.User_ID
FROM payment_info_385 NATURAL JOIN ticket_385
where payment_info_385.price > (SELECT AVG(payment_info_385.Price) FROM payment_info_385) 