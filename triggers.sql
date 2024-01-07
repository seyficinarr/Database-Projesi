CREATE TRIGGER update_marti_location_history ON Martı
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(current_latitude) OR UPDATE(current_longitude) BEGIN
        INSERT INTO Martı_location_history (Martı_id, date, latitude, longitude, time)
        SELECT
            i.martı_id,
            CONVERT(DATE, GETDATE()),
            i.current_latitude,
            i.current_longitude,
            GETDATE()
        FROM INSERTED i;
    END
END;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TRIGGER track_train_line_instance_changes ON Train_Line_Instance
AFTER UPDATE
  AS
BEGIN
    -- SQLINES LICENSE FOR EVALUATION USE ONLY
    INSERT INTO Train_Line_Instance_History (line_name, Line_instance_id, departure_time, arrival_time, train_id, modification_date)
    VALUES (OLD.line_name, OLD.Line_instance_id, OLD.departure_time, OLD.arrival_time, OLD.train_id, CONVERT(DATE, GETDATE()));
END
END;
GO
GO

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TRIGGER enforce_ferry_ticket_availability ON Ferry_Ticket
INSTEAD OF INSERT
  AS
BEGIN
    DECLARE @available_seats INT;
WHILE 1=0 BEGIN
IF @@FETCH_STATUS <> 0 BREAK;
    SELECT @available_seats = no_of_available_seats
    FROM Ferry_Voyage
    WHERE line_id = NEW.line_id AND line_instance_id = NEW.line_instance_id AND voyage_id = NEW.voyage_id;

    IF @available_seats <= 0 BEGIN
        RAISERROR(SQLSTATE '45000', 16, 1)
        SET @MESSAGE_TEXT = 'No available seats for the selected Ferry voyage';
    END 
END
END;
GO
GO
