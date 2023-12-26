-- Inserting given data --
INSERT INTO ticket_385 (
        PNR,
        Train_No,
        Travel_Date,
        Departure,
        Arrival,
        Departure_Time,
        Arrival_Time,
        User_ID,
        Train_Type,
        Compartment_Type,
        Compartment_No
    )
VALUES (
        'PNR021',
        62621,
        '2021-10-22',
        'Bengaluru',
        'Chennai',
        '16:00:00',
        '20:30:00',
        'USR_008',
        'Superfast',
        'I Class',
        'F01'
    );

-- given trim query --
update train_385
set Source = trim(Source),
    Destination = trim(Destination);

-- Q1--UNION --
SELECT T1.User_ID,
    T2.User_Type,
    T2.FName,
    T2.LName
FROM ticket_385 T1
    JOIN user_385 T2 ON T1.User_ID = T2.User_ID
WHERE T1.Travel_Date BETWEEN '2021-10-01' AND '2021-10-31'
    AND T1.Departure = 'Bengaluru'
    AND T1.Arrival = 'Chennai'
UNION
(
    SELECT T3.User_ID,
        T4.User_Type,
        T4.FName,
        T4.LName
    FROM ticket_385 T3
        JOIN user_385 T4 ON T3.User_ID = T4.User_ID
    WHERE T3.Travel_Date BETWEEN '2022-08-01' AND '2022-08-31'
        AND T3.Departure = 'Bengaluru'
        AND T3.Arrival = 'Chennai'
);

-- Q2--INTERSECT --
SELECT T1.User_ID,
    T2.User_Type,
    T2.FName,
    T2.LName
FROM ticket_385 T1
    JOIN user_385 T2 ON T1.User_ID = T2.User_ID
WHERE T1.Travel_Date BETWEEN '2021-10-01' AND '2021-10-31'
    AND T1.Departure = 'Bengaluru'
    AND T1.Arrival = 'Chennai'
INTERSECT
(
    SELECT T3.User_ID,
        T4.User_Type,
        T4.FName,
        T4.LName
    FROM ticket_385 T3
        JOIN user_385 T4 ON T3.User_ID = T4.User_ID
    WHERE T3.Travel_Date BETWEEN '2022-08-01' AND '2022-08-31'
        AND T3.Departure = 'Bengaluru'
        AND T3.Arrival = 'Chennai'
);

-- Q3--EXCEPT --
SELECT T1.User_ID,
    T2.User_Type,
    T2.FName,
    T2.LName
FROM ticket_385 T1
    JOIN user_385 T2 ON T1.User_ID = T2.User_ID
WHERE T1.Travel_Date BETWEEN '2022-08-01' AND '2022-08-31'
    AND T1.Departure = 'Bengaluru'
    AND T1.Arrival = 'Chennai'
EXCEPT(
        SELECT T3.User_ID,
            T4.User_Type,
            T4.FName,
            T4.LName
        FROM ticket_385 T3
            JOIN user_385 T4 ON T3.User_ID = T4.User_ID
        WHERE T3.Travel_Date BETWEEN '2021-10-01' AND '2021-10-31'
            AND T3.Departure = 'Bengaluru'
            AND T3.Arrival = 'Chennai'
    );

-- Q4--EXISTS --
SELECT T1.User_ID,
    T2.User_Type,
    T2.FName,
    T2.LName
FROM ticket_385 T1
    JOIN user_385 T2 ON T1.User_ID = T2.User_ID
WHERE T1.Departure = 'Bengaluru'
    AND T1.Arrival = 'Chennai'
    AND EXISTS(
        SELECT T3.User_ID,
            T4.User_Type,
            T4.FName,
            T4.LName
        FROM ticket_385 T3
            JOIN user_385 T4 ON T3.User_ID = T4.User_ID
        WHERE T3.User_ID = T1.User_ID
            AND T3.Arrival = 'Bengaluru'
            AND DATEDIFF(T3.Travel_Date, T1.Travel_Date) < 8
    );

-- Q5--NOT EXISTS --
SELECT T1.User_ID,
    T2.User_Type,
    T2.FName,
    T2.LName
FROM ticket_385 T1
    JOIN user_385 T2 ON T1.User_ID = T2.User_ID
WHERE T1.Departure = 'Bengaluru'
    AND T1.Arrival = 'Chennai'
    AND NOT EXISTS(
        SELECT T3.User_ID,
            T4.User_Type,
            T4.FName,
            T4.LName
        FROM ticket_385 T3
            JOIN user_385 T4 ON T3.User_ID = T4.User_ID
        WHERE T3.User_ID = T1.User_ID
            AND T3.Arrival = 'Bengaluru'
            AND T3.Travel_Date >= T1.Travel_Date
    );