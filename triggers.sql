DELIMITER //
CREATE TRIGGER update_marti_location_history
BEFORE UPDATE ON Martı
FOR EACH ROW
BEGIN
    IF NEW.current_latitude <> OLD.current_latitude OR NEW.current_longitude <> OLD.current_longitude THEN
        INSERT INTO Martı_location_history (Martı_id, date, latitude, longitude, time)
        VALUES (NEW.martı_id, CURRENT_DATE, NEW.current_latitude, NEW.current_longitude, CURRENT_TIME);
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER track_train_line_instance_changes
AFTER UPDATE ON Train_Line_Instance
FOR EACH ROW
BEGIN
    INSERT INTO Train_Line_Instance_History (line_name, Line_instance_id, departure_time, arrival_time, train_id, modification_date)
    VALUES (OLD.line_name, OLD.Line_instance_id, OLD.departure_time, OLD.arrival_time, OLD.train_id, CURRENT_DATE);
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER enforce_ferry_ticket_availability
BEFORE INSERT ON Ferry_Ticket
FOR EACH ROW
BEGIN
    DECLARE available_seats INT;
    SELECT no_of_available_seats INTO available_seats
    FROM Ferry_Voyage
    WHERE line_id = NEW.line_id AND line_instance_id = NEW.line_instance_id AND voyage_id = NEW.voyage_id;

    IF available_seats <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No available seats for the selected Ferry voyage';
    END IF;
END;
//
DELIMITER ;
