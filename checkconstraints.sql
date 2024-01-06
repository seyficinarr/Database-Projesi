ALTER TABLE Train_Line
ADD CONSTRAINT chk_positive_duration_time
CHECK (duration_time > 0);

ALTER TABLE Flight_Leg
ADD CONSTRAINT chk_non_negative_seats
CHECK (available_no_of_seats >= 0);

ALTER TABLE Electrical_Car
ADD CONSTRAINT chk_valid_battery_life
CHECK (battery_life >= 0 AND battery_life <= 100);
