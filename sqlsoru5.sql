UPDATE Card
SET balance_amount = 850
WHERE Card_id = 12
UPDATE Card
SET balance_amount = 1100
WHERE Card_id = 7

UPDATE Sea_vehicle_type
SET max_seats = 750
WHERE type_name = 'Yuksek Hizli Hafif Yolcu Gemisi'
UPDATE Sea_vehicle_type
SET can_lpg_enter = 0
WHERE type_name = 'Yuksek Hizli Hafif Yolcu Feribotu'

DELETE FROM Marti_Rezervation
WHERE Card_id = 1 AND Marti_id = 1;

DELETE FROM Train_Voyage
WHERE voyage_id = 8;

DELETE FROM Search
WHERE search_id = 11;


-- Find flights with available leg information
SELECT f.flight_id, f.company_name, f.arrival_airport_code, f.departure_airport_code,
       fl.leg_id, fl.available_no_of_seats, fl.base_fare, fl.flight_price
FROM Flight f
JOIN Flight_Leg fl ON f.flight_id = fl.flight_id
WHERE fl.available_no_of_seats > 0;

-- Identify customers with Marti and Train preferences
SELECT c.customer_id, c.Fname, c.Lname, c.city, c.country,
       p.marti_preference, p.train_preference
FROM Customer c
JOIN Card ca ON c.customer_id = ca.customer_id
JOIN Preferences p ON ca.Card_id = p.Card_id
WHERE p.marti_preference = 1 AND p.train_preference = 1;

-- Retrieve Marti reservations with customer and Marti location history
SELECT mr.Card_id, mr.Marti_id, mr.taken_date, mr.taken_time, mr.left_date, mr.left_time,
       c.Fname, c.Lname, c.city, c.country,
       mlh.latitude AS taken_latitude, mlh.longitude AS taken_longitude
FROM Marti_Rezervation mr
JOIN Card ca ON mr.Card_id = ca.Card_id
JOIN Customer c ON c.customer_id = ca.customer_id
JOIN Martı_location_history mlh ON mr.Marti_id = mlh.Martı_id;

-- List ferry voyages with line and terminal information
SELECT fv.voyage_id, fv.boarding_time, fv.landing_time, fv.duration_time,
       t1.terminal_name AS boarding_terminal, t2.terminal_name AS landing_terminal,
       l.duration_time AS line_duration
FROM Ferry_Voyage fv
JOIN Line_Instance li ON fv.line_id = li.line_id AND fv.line_instance_id = li.line_instance_id
JOIN Terminal t1 ON fv.boarding_terminal_name = t1.terminal_name
JOIN Terminal t2 ON fv.landing_terminal_name = t2.terminal_name
JOIN Line l ON fv.line_id = l.line_id

-- List train voyages with line and train information
SELECT tv.voyage_id, tv.boarding_time, tv.landing_time, tv.duration_time,
       tl.line_name, tl.duration_time AS line_duration,
       tr.type_name AS train_type
FROM Train_Voyage tv
JOIN Train_Line_Instance tli ON tv.line_name = tli.line_name AND tv.Line_instance_id = tli.Line_instance_id
JOIN Train_Line tl ON tli.line_name = tl.line_name
JOIN Train tr ON tli.train_id = tr.train_id;




-- Retrieve customer information along with associated card details
SELECT c.customer_id, c.Fname, c.Lname, c.city, c.country, ca.Card_id, ca.balance_amount
FROM Customer c
JOIN Card ca ON c.customer_id = ca.customer_id;

-- Find available seats on a specific flight leg
SELECT fl.flight_id, fl.leg_id, fl.available_no_of_seats
FROM Flight_Leg fl
WHERE fl.flight_id = 1 AND fl.leg_id = 1;

-- List Marti reservations with location details
SELECT mr.Card_id, mr.Marti_id, mr.taken_date, mr.taken_time, mr.left_date, mr.left_time,
       mlh.latitude AS taken_latitude, mlh.longitude AS taken_longitude
FROM Marti_Rezervation mr
JOIN Martı_location_history mlh ON mr.Marti_id = mlh.Martı_id
WHERE mr.Card_id = 1;

-- Calculate total price for car reservations within a date range
SELECT cr.rezervation_no, cr.card_id, cr.rezerved_date, cr.total_price
FROM Car_rent_rezervation cr
WHERE cr.rezerved_date BETWEEN '2023-01-01' AND '2023-12-31';
