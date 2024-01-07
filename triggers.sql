--Trigger for updating marti_location_history
CREATE TRIGGER update_marti_location_history ON Martı
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(current_latitude) OR UPDATE(current_longitude) BEGIN
        -- Your original insert statement
        INSERT INTO Martı_location_history (Martı_id, date, latitude, longitude, time)
        SELECT
            i.martı_id,
            CONVERT(DATE, GETDATE()),
            i.current_latitude,
            i.current_longitude,
            GETDATE()
        FROM INSERTED i;

        -- Send a message
        DECLARE @Message NVARCHAR(255) = 'Martı location history updated.';
        PRINT @Message; -- veya RAISEERROR(@Message, 0, 1);

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


-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TRIGGER update_preferences_after_reservation ON Marti_Rezervation
AFTER INSERT AS, Train_Ticket, Flight_Ticket, Ferry_Ticket, Car_rent_rezervation
FOR EACH ROW
BEGIN
    DECLARE @preference_id INT;

    -- SQLINES DEMO *** e_id associated with the Card_id
    -- SQLINES LICENSE FOR EVALUATION USE ONLY
    SELECT @preference_id = @preference_id
    FROM Preferences
    WHERE Card_id = NEW.Card_id;

    -- SQLINES DEMO *** tion type and update preferences accordingly
    IF NEW.transportation_type = 'Marti' BEGIN
        UPDATE Preferences
        SET marti_preference = TRUE
        WHERE @preference_id = @preference_id;
    END
    ELSE IF NEW.transportation_type = 'Train' BEGIN
        UPDATE Preferences
        SET train_preference = TRUE
        WHERE @preference_id = @preference_id;
    END
    ELSE IF NEW.transportation_type = 'Flight' BEGIN
        UPDATE Preferences
        SET airplane_trip_preference = TRUE
        WHERE @preference_id = @preference_id;
    END
    ELSE IF NEW.transportation_type = 'Ferry' BEGIN
        UPDATE Preferences
        SET ferry_preference = TRUE
        WHERE @preference_id = @preference_id;
    END
    ELSE IF NEW.transportation_type = 'Car' BEGIN
        UPDATE Preferences
        SET car_rent_preference = TRUE
        WHERE @preference_id = @preference_id;
    -- SQLINES DEMO *** ns for other transportation types as needed

    END 
END;
//
