
/*
CREATE TABLE Line(
                      line_id INT PRIMARY KEY,
                      duration_time INT,
                      arrival_terminal_name VARCHAR(255),
                      departure_terminal_name VARCHAR(255)
);

CREATE TABLE Terminal (
                          terminal_name VARCHAR(255) PRIMARY KEY,
                          county VARCHAR(255),
                          city VARCHAR(255)
);

CREATE TABLE Sea_Vehicle (
                             name VARCHAR(255) PRIMARY KEY,
                             type_name VARCHAR(255)
);

CREATE TABLE Sea_vehicle_type (
                                  type_name VARCHAR(255) PRIMARY KEY,
                                  max_seats INT,
                                  can_lpg_enter BIT,
                                  can_disabled_enter BIT
);

CREATE TABLE Line_Instance (
    line_id INT,
    line_instance_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    date DATE,
    sea_vehicle_name VARCHAR(255),
    PRIMARY KEY (line_id, line_instance_id),
    FOREIGN KEY (line_id) REFERENCES Line(line_id),
    FOREIGN KEY (sea_vehicle_name) REFERENCES Sea_Vehicle(name)
);

CREATE TABLE Ferry_Voyage (
                        line_id INT,
                        line_instance_id INT,
                        voyage_id INT PRIMARY KEY,
                        boarding_time DATETIME,
                        landing_time DATETIME,
                        duration_time INT,
                        no_of_available_seats INT,
                        boarding_terminal_name VARCHAR(255),
                        landing_terminal_name VARCHAR(255),
                        FOREIGN KEY (line_id, line_instance_id) REFERENCES Line_Instance(line_id, line_instance_id),
                        FOREIGN KEY (boarding_terminal_name) REFERENCES Terminal(terminal_name),
                        FOREIGN KEY (landing_terminal_name) REFERENCES Terminal(terminal_name)
);

CREATE TABLE has_line (
                          terminal_name_1 VARCHAR(255),
                          terminal_name_2 VARCHAR(255),
                          PRIMARY KEY (terminal_name_1, terminal_name_2),
                          FOREIGN KEY (terminal_name_1) REFERENCES Terminal(terminal_name),
                          FOREIGN KEY (terminal_name_2) REFERENCES Terminal(terminal_name)
);

CREATE TABLE can_approach (
                              terminal_name VARCHAR(255),
                              type_name VARCHAR(255),
                              PRIMARY KEY (terminal_name, type_name),
                              FOREIGN KEY (terminal_name) REFERENCES Terminal(terminal_name),
                              FOREIGN KEY (type_name) REFERENCES Sea_vehicle_type(type_name)
);

CREATE TABLE is_ferry_applicable (
                               line_id INT,
                               type_name VARCHAR(255),
                               PRIMARY KEY (line_id, type_name),
                               FOREIGN KEY (line_id) REFERENCES Line(line_id),
                               FOREIGN KEY (type_name) REFERENCES Sea_vehicle_type(type_name)
);
CREATE TABLE Martı (
                       martı_id INT PRIMARY KEY,
                       price_per_minute DECIMAL(10, 2),
                       current_longitude DECIMAL(9, 6),
                       current_latitude DECIMAL(8, 6),
                       current_charge INT,
                       need_driver_license BIT,
                       martı_type VARCHAR(255)
);

CREATE TABLE Martı_location_history (
                                        Martı_id INT,
                                        date DATE,
                                        latitude DECIMAL(8, 6),
                                        longitude DECIMAL(9, 6),
                                        time TIME,
                                        PRIMARY KEY (Martı_id, date, time),
                                        FOREIGN KEY (Martı_id) REFERENCES Martı(martı_id)
);
CREATE TABLE İzban (
                       izban_id INT PRIMARY KEY,
                       price DECIMAL(10, 2),
                       first_station_name VARCHAR(255),
                       last_station_name VARCHAR(255)
);

CREATE TABLE Station (
                         name VARCHAR(255) PRIMARY KEY,
                         county VARCHAR(255),
                         previous_station_name VARCHAR(255),
                         next_station_name VARCHAR(255)
);

CREATE TABLE Izban_Voyage (
                        izban_id INT,
                        voyage_instance_id INT PRIMARY KEY,
                        start_date DATE,
                        start_time TIME,
                        finish_date DATE,
                        finish_time TIME,
                        duration_time INT,
                        refund_amount DECIMAL(10, 2),
                        first_station_name VARCHAR(255),
                        last_station_name VARCHAR(255),
                        FOREIGN KEY (izban_id) REFERENCES İzban(izban_id),
                        FOREIGN KEY (first_station_name) REFERENCES Station(name),
                        FOREIGN KEY (last_station_name) REFERENCES Station(name)
);
CREATE TABLE Train_Line (
                            line_name VARCHAR(255) PRIMARY KEY,
                            duration_time INT,
                            arrival_station_name VARCHAR(255),
                            departure_station_name VARCHAR(255)
);

CREATE TABLE Train_Station (
                               station_name VARCHAR(255) PRIMARY KEY,
                               city VARCHAR(255),
                               county VARCHAR(255)
);

CREATE TABLE Train_type (
                            type_name VARCHAR(255) PRIMARY KEY,
                            max_seats INT
);

CREATE TABLE Train (
                       train_id INT PRIMARY KEY,
                       no_of_vagons INT,
                       capacity INT,
                       current_location VARCHAR(255),
                       type_name VARCHAR(255),
                       FOREIGN KEY (type_name) REFERENCES Train_type(type_name)
);

CREATE TABLE Vagon (
                       vagon_id INT PRIMARY KEY,
                       train_id INT,
                       min_price DECIMAL(10, 2),
                       FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Train_Line_Instance (
                                     line_name VARCHAR(255),
                                     Line_instance_id INT,
                                     departure_time DATETIME,
                                     arrival_time DATETIME,
                                     train_id INT,
                                     PRIMARY KEY(line_name, Line_instance_id),
                                     FOREIGN KEY (line_name) REFERENCES Train_Line(line_name),
                                     FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE passed_stations (
                                 line_name VARCHAR(255),
                                 station_name VARCHAR(255),
                                 PRIMARY KEY (line_name, station_name),
                                 FOREIGN KEY (line_name) REFERENCES Train_Line(line_name),
                                 FOREIGN KEY (station_name) REFERENCES Train_Station(station_name)
);

CREATE TABLE is_train_applicable (
                               line_name VARCHAR(255),
                               type_name VARCHAR(255),
                               PRIMARY KEY (line_name, type_name),
                               FOREIGN KEY (line_name) REFERENCES Train_Line(line_name),
                               FOREIGN KEY (type_name) REFERENCES Train_type(type_name)
);

CREATE TABLE Economy_Vagon (
                               vagon_id INT PRIMARY KEY,
                               no_of_seats INT,
                               train_id INT,
                               FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Sleeper_Vagon (
                               vagon_id INT PRIMARY KEY,
                               no_of_beds INT,
                               train_id INT,
                               FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Train_Voyage (
                              line_name VARCHAR(255),
                              Line_instance_id INT,
                              voyage_id INT PRIMARY KEY,
                              no_of_available_seats INT,
                              boarding_time DATETIME,
                              landing_time DATETIME,
                              duration_time INT,
                              boarding_station_name VARCHAR(255),
                              landing_station_name VARCHAR(255),
                              FOREIGN KEY (line_name, Line_instance_id) REFERENCES Train_Line_Instance(line_name, Line_instance_id),
                              FOREIGN KEY (boarding_station_name) REFERENCES Train_Station(station_name),
                              FOREIGN KEY (landing_station_name) REFERENCES Train_Station(station_name)
);

CREATE TABLE Airport (
                         airport_code VARCHAR(255) PRIMARY KEY,
                         city VARCHAR(255),
                         country VARCHAR(255),
                         airport_name VARCHAR(255)
);

CREATE TABLE Airplane_Type (
                               type_id VARCHAR(255) PRIMARY KEY,
                               type_name VARCHAR(255),
                               maximum_seat INT,
                               maximum_length INT,
                               maximum_speed INT,
                               length INT,
                               height INT,
                               wingspan INT
);

CREATE TABLE Airplane (
                          airplane_id INT PRIMARY KEY,
                          airplane_name VARCHAR(255),
                          total_no_of_seats INT,
                          current_location VARCHAR(255),
                          type_id VARCHAR(255),
                          FOREIGN KEY (type_id) REFERENCES Airplane_Type(type_id)
);

CREATE TABLE Flight (
                        flight_id INT PRIMARY KEY,
                        flight_duration INT,
                        is_domestic BIT,
                        arrival_airport_code VARCHAR(255),
                        departure_airport_code VARCHAR(255),
                        company_name VARCHAR(255),
                        FOREIGN KEY (arrival_airport_code) REFERENCES Airport(airport_code),
                        FOREIGN KEY (departure_airport_code) REFERENCES Airport(airport_code)
);

CREATE TABLE Flight_Leg (
                            flight_id INT,
                            leg_id INT,
                            available_no_of_seats INT,
                            base_fare DECIMAL(10, 2),
                            fuel_surcharge DECIMAL(10, 2),
                            flight_price DECIMAL(10, 2),
                            taxes DECIMAL(10, 2),
                            ticket_service_fee DECIMAL(10, 2),
                            airplane_id INT,
                            PRIMARY KEY(flight_id, leg_id),
                            FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
                            FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id)
);

CREATE TABLE can_land (
                          airport_code VARCHAR(255),
                          type_id VARCHAR(255),
                          PRIMARY KEY (airport_code, type_id),
                          FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
                          FOREIGN KEY (type_id) REFERENCES Airplane_Type(type_id)
);

CREATE TABLE Company (
                         company_name VARCHAR(255) PRIMARY KEY,
                         company_rating INT
);

CREATE TABLE Branch (
                        company_name VARCHAR(255),
                        branch_name VARCHAR(255) PRIMARY KEY,
                        branch_rating INT,
                        operating_hours VARCHAR(255),
                        county VARCHAR(255),
                        address_explanation VARCHAR(255),
                        phone_number VARCHAR(255),
                        postal_code VARCHAR(255),
                        city VARCHAR(255),
                        door_no VARCHAR(255),
                        street VARCHAR(255),
                        FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

CREATE TABLE Car (
                     Company_name VARCHAR(255),
                     license_plate VARCHAR(255),
                     car_type VARCHAR(255),
                     gear_type VARCHAR(255),
                     model VARCHAR(255),
                     brand VARCHAR(255),
                     fuel_type VARCHAR(255),
                     kilometer_made INT,
                     kilometer_limit INT,
                     price_per_day DECIMAL(10, 2),
                     current_branch_name VARCHAR(255),
                     arrival_date DATE,
                     arrival_time TIME,
                     PRIMARY KEY(Company_name, license_plate),
                     FOREIGN KEY (Company_name) REFERENCES Company(company_name),
                     FOREIGN KEY (current_branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE rent_condition (
                                Company_name VARCHAR(255),
                                license_plate VARCHAR(255),
                                condition_date DATE,
                                deposit DECIMAL(10, 2),
                                total_km_limit INT,
                                min_driver_age INT,
                                day_price DECIMAL(10, 2),
                                delivery_type VARCHAR(255),
                                PRIMARY KEY (Company_name, license_plate, condition_date),
                                FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate)
);

CREATE TABLE Company_business_areas (
                                        Company_name VARCHAR(255),
                                        business_area VARCHAR(255),
                                        PRIMARY KEY (Company_name, business_area),
                                        FOREIGN KEY (Company_name) REFERENCES Company(company_name)
);


CREATE TABLE Electrical_Car (
                                Company_name VARCHAR(255),
                                license_plate VARCHAR(255) PRIMARY KEY,
                                battery_life INT,
                                charging_time INT,
                                FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate)
);

CREATE TABLE Non_Electrical_Car (
                                    Company_name VARCHAR(255),
                                    license_plate VARCHAR(255) PRIMARY KEY,
                                    engine_cylinder_volume INT,
                                    FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate)
);

CREATE TABLE Bus(
                      license_plate VARCHAR(255) PRIMARY KEY,
                      capacity INT
);

CREATE TABLE Bus_Line (
                          line_name VARCHAR(255) PRIMARY KEY,
                          duration_time INT,
                          arrival_station_name VARCHAR(255),
                          departure_station_name VARCHAR(255)
);

CREATE TABLE Bus_Station (
                          station_name VARCHAR(255) PRIMARY KEY,
                          county VARCHAR(255),
                          city VARCHAR(255)
);

CREATE TABLE Bus_Line_Instance (
                               line_name VARCHAR(255),
                               line_instance_id INT PRIMARY KEY,
                               departure_time DATETIME,
                               arrival_time DATETIME,
                               date DATE,
                               bus_license_plate VARCHAR(255),
                               FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name),
                               FOREIGN KEY (bus_license_plate) REFERENCES Bus(license_plate)
);

CREATE TABLE Bus_Voyage (
                          line_name VARCHAR(255),
                          line_instance_id INT,
                          voyage_id INT PRIMARY KEY,
                          landing_time DATETIME,
                          boarding_time DATETIME,
                          duration_time INT,
                          no_of_available_seats INT,
                          arrival_station_name VARCHAR(255),
                          departure_station_name VARCHAR(255),
                          FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name),
                          FOREIGN KEY (line_instance_id) REFERENCES Bus_Line_Instance(line_instance_id)
);

CREATE TABLE owns_bus_line (
                          company_name VARCHAR(255),
                          line_name VARCHAR(255),
                          PRIMARY KEY (company_name, line_name),
                          FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

CREATE TABLE has_bus (
                          company_name VARCHAR(255),
                          license_plate VARCHAR(255),
                          PRIMARY KEY (company_name, license_plate),
                          FOREIGN KEY (company_name) REFERENCES Company(company_name),
                          FOREIGN KEY (license_plate) REFERENCES Bus(license_plate)
);

CREATE TABLE bus_line_passed_stations (
                          line_name VARCHAR(255),
                          passed_station_name VARCHAR(255),
                          PRIMARY KEY (line_name, passed_station_name),
                          FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name)
);



CREATE TABLE Customer (
                          customer_id INT PRIMARY KEY,
                          Fname VARCHAR(255),
                          Lname VARCHAR(255),
                          surname VARCHAR(255),
                          language VARCHAR(255),
                          TCKN VARCHAR(255),
                          passport_no VARCHAR(255),
                          nationality VARCHAR(255),
                          sex VARCHAR(10),
                          city VARCHAR(255),
                          country VARCHAR(255),
                          street VARCHAR(255),
                          phone_number VARCHAR(20),
                          gmail VARCHAR(255),
                          birthday DATE
);

CREATE TABLE Card (
                      Card_id INT PRIMARY KEY,
                      customer_id INT,
                      balance_amount DECIMAL(10, 2),
                      FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Search (
                        Card_id INT,
                        search_id INT PRIMARY KEY,
                        operation_date DATE,
                        operation_time TIME,
                        transportation_type VARCHAR(255),
                        starting_place VARCHAR(255),
                        end_place VARCHAR(255),
                        FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE History (
                         Card_id INT,
                         history_id INT PRIMARY KEY,
                         operation_date DATE,
                         operation_time TIME,
                         transportation_type VARCHAR(255),
                         departure_place VARCHAR(255),
                         destination VARCHAR(255),
                         payment_amount DECIMAL(10, 2),
                         FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Preferences (
                             Card_id INT,
                             preference_id INT PRIMARY KEY,
                             car_rent_preference BIT,
                             trip_day_preference VARCHAR(255),
                             airplane_trip_preference BIT,
                             train_preference BIT,
                             trip_time_preference VARCHAR(255),
                             marti_preference BIT,
                             izban_preference BIT,
                             ferry_preference BIT,
                             FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Marti_Rezervation (
                                   Card_id INT,
                                   Marti_id INT,
                                   taken_date DATE,
                                   taken_time TIME,
                                   left_date DATE,
                                   left_time TIME,
                                   rezerved_date DATE,
                                   photo_of_marti VARCHAR(255),
                                   left_latitude DECIMAL(8, 6),
                                   left_longitude DECIMAL(9, 6),
                                   taken_latitude DECIMAL(8, 6),
                                   taken_longitude DECIMAL(9, 6),
                                   PRIMARY KEY (Card_id, Marti_id),
                                   FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Train_Ticket (
                              Card_id INT,
                              line_name VARCHAR(255),
                              Line_instance_id INT,
                              voyage_id INT,
                              vagon_no INT,
                              seat INT,
                              PRIMARY KEY (Card_id, line_name, Line_instance_id, voyage_id),
                              FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Flight_Ticket (
                               Card_id INT,
                               flight_id INT,
                               leg_id INT,
                               seat INT,
                               flight_class VARCHAR(255),
                               ticket_class VARCHAR(255),
                               passenger_type VARCHAR(255),
                               lounge BIT,
                               pet BIT,
                               extra_baggage BIT,
                               sport_eq_s VARCHAR(255),
                               PRIMARY KEY (Card_id, flight_id, leg_id),
                               FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Izban_Journey (
                               Card_id INT,
                               Izban_id INT,
                               voyage_instance_id INT,
                               check_in_station VARCHAR(255),
                               check_in_date DATE,
                               check_in_time TIME,
                               check_out_station VARCHAR(255),
                               check_out_date DATE,
                               check_out_time TIME,
                               refund_amount DECIMAL(10, 2),
                               PRIMARY KEY (Card_id, Izban_id, voyage_instance_id),
                               FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Ferry_Ticket (
                              Card_id INT,
                              line_id INT,
                              line_instance_id INT,
                              voyage_id INT,
                              age_type VARCHAR(255),
                              is_disabled BIT,
                              with_car BIT,
                              class_type VARCHAR(255),
                              seat_no INT,
                              has_pet BIT,
                              is_close_to_veteran BIT,
                              is_press BIT,
                              is_ibb_council_member BIT,
                              PRIMARY KEY (Card_id, line_id, line_instance_id, voyage_id),
                              FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);


CREATE TABLE Car_rent_rezervation (
                                      rezervation_no INT PRIMARY KEY,
                                      card_id INT,
                                      rezerved_date DATE,
                                      taken_date DATE,
                                      dropped_date DATE,
                                      spent_day INT,
                                      total_price DECIMAL(10, 2),
                                      Company_name VARCHAR(255),
                                      license_plate VARCHAR(255),
                                      dropped_branch_name VARCHAR(255),
                                      taken_branch_name VARCHAR(255),
                                      FOREIGN KEY (card_id) REFERENCES Card(Card_id),
                                      FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate),
                                      FOREIGN KEY (dropped_branch_name) REFERENCES Branch(branch_name),
                                      FOREIGN KEY (taken_branch_name) REFERENCES Branch(branch_name)
);
*/

--Feribot
INSERT INTO Line (line_id, duration_time, arrival_terminal_name, departure_terminal_name) VALUES
(1, 120, 'Kadikoy', 'Bursa'),
(2, 120, 'Armutlu', 'Bursa'),
(3, 150, 'Yenikapi', 'Bursa'),
(4, 150, 'Kabatas', 'Bursa'),
(5, 150, 'Pendik', 'Yalova'),
(6, 150, 'Yenikapi', 'Yalova'),
(7, 150, 'Yalova', 'Pendik'),
(8, 120, 'Yalova', 'Yenikapi');

INSERT INTO Terminal (terminal_name, county, city)
VALUES
('Bursa', 'Mudanya', 'Bursa'),
('Yalova', 'Suleyman Bey', 'Yalova'),
('Kadikoy', 'Kadikoy', 'Istanbul'),
('Armutlu', 'Armutlu', 'Istanbul'),
('Yenikapi', 'Yenikapi', 'Istanbul'),
('Kabatas', 'Kabatas', 'Istanbul'),
('Pendik', 'Pendik', 'Istanbul');

INSERT INTO Sea_Vehicle (name, type_name) VALUES
('Murat Reis-7', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Salih Reis-4', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Burak Reis-3', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Kemal Reis-5', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Adnan Menderes', 'Yuksek Hizli Hafif Yolcu Feribotu'),
('Sadabant', 'Araba Ferisi'),
('Sahilbent', 'Araba Ferisi'),
('Suhulet', 'Araba Ferisi'),
('Fatih Sultan Mehmet', 'Hafif Yolcu Feribotu'),
('Kanuni Sultan Suleyman', 'Hafif Yolcu Feribotu');

INSERT INTO Sea_vehicle_type (type_name, max_seats, can_lpg_enter, can_disabled_enter) VALUES
('Yuksek Hizli Hafif Yolcu Gemisi', 449, 1, 1),
('Yuksek Hizli Hafif Yolcu Feribotu', 962, 1, 0),
('Araba Ferisi', 596, 0, 1),
('Hafif Yolcu Feribotu', 580, 1, 1);

INSERT INTO Line_Instance (line_id, line_instance_id, departure_time, arrival_time, date, sea_vehicle_name) VALUES
(1, 1, '2023-01-04 15:30:00', '2023-01-04 17:30:00', '2023-01-04', 'Murat Reis-7'),
(1, 2, '2023-01-03 15:30:00', '2023-01-03 17:30:00', '2023-01-03', 'Murat Reis-7'),
(1, 3, '2023-01-02 15:30:00', '2023-01-02 17:30:00', '2023-01-02', 'Murat Reis-7'),
(2, 4, '2023-01-02 12:30:00', '2023-01-02 14:30:00', '2023-01-02', 'Adnan Menderes'),
(2, 5, '2023-01-03 12:30:00', '2023-01-03 14:30:00', '2023-01-03', 'Adnan Menderes'),
(3, 6, '2023-01-01 17:00:00', '2023-01-01 19:30:00', '2023-01-01', 'Sadabant'),
(3, 7, '2023-01-03 17:00:00', '2023-01-03 19:30:00', '2023-01-03', 'Sadabant'),
(4, 8, '2023-01-01 19:00:00', '2023-01-01 21:30:00', '2023-01-01', 'Fatih Sultan Mehmet'),
(4, 9, '2023-01-02 19:00:00', '2023-01-02 21:30:00', '2023-01-02', 'Fatih Sultan Mehmet'),
(5, 10, '2023-01-03 20:00:00', '2023-01-03 22:30:00', '2023-01-03', 'Salih Reis-4'),
(6, 11, '2023-01-04 20:00:00', '2023-01-04 22:30:00', '2023-01-04', 'Burak Reis-3'),
(7, 12, '2023-01-03 23:00:00', '2023-01-04 01:30:00', '2023-01-03', 'Suhulet'),
(8, 12, '2023-01-02 22:30:00', '2023-01-03 00:30:00', '2023-01-02', 'Sahilbent'),
(8, 14, '2023-01-03 08:30:00', '2023-01-03 10:30:00', '2023-01-03', 'Sahilbent');

INSERT INTO Ferry_Voyage (line_id, line_instance_id, voyage_id, boarding_time, landing_time, duration_time, no_of_available_seats, boarding_terminal_name, landing_terminal_name) VALUES
(1, 1, 1, '2023-01-04 15:30:00', '2023-01-04 17:30:00', 120, 148, 'Bursa', 'Kadikoy'),
(1, 2, 2, '2023-01-03 15:30:00', '2023-01-03 17:30:00', 120, 128, 'Bursa', 'Kadikoy'),
(1, 3, 3, '2023-01-02 15:30:00', '2023-01-02 17:30:00', 120, 141, 'Bursa', 'Kadikoy'),
(2, 4, 4, '2023-01-02 12:30:00', '2023-01-02 14:30:00', 120, 123, 'Bursa', 'Armutlu'),
(2, 5, 5, '2023-01-03 12:30:00', '2023-01-03 14:30:00', 120, 179, 'Bursa', 'Armutlu'),
(3, 6, 6, '2023-01-01 17:00:00', '2023-01-01 19:30:00', 150, 235, 'Bursa', 'Yenikapi'),
(3, 7, 7, '2023-01-03 17:00:00', '2023-01-03 19:30:00', 150, 332, 'Bursa', 'Yenikapi'),
(4, 8, 8, '2023-01-01 19:00:00', '2023-01-01 21:30:00', 150, 321, 'Bursa', 'Kabatas'),
(4, 9, 9, '2023-01-02 19:00:00', '2023-01-02 21:30:00', 150, 125, 'Bursa', 'Kabatas'),
(5, 10, 10, '2023-01-03 20:00:00', '2023-01-03 22:30:00', 150, 188, 'Yalova', 'Pendik'),
(6, 11, 11, '2023-01-04 20:00:00', '2023-01-04 22:30:00', 150, 92, 'Yalova', 'Yenikapi'),
(7, 12, 12, '2023-01-03 23:00:00', '2023-01-04 01:30:00', 150, 63, 'Pendik', 'Yalova'),
(8, 12, 12, '2023-01-02 22:30:00', '2023-01-03 00:30:00', 120, 143, 'Yenikapi', 'Yalova'),
(8, 14, 14, '2023-01-03 08:30:00', '2023-01-03 10:30:00', 120, 148, 'Yenikapi', 'Yalova');

INSERT INTO has_line (terminal_name_1, terminal_name_2) VALUES
('Bursa', 'Kadikoy'),
('Bursa', 'Armutlu'),
('Bursa', 'Yenikapi'),
('Bursa', 'Kabatas'),
('Yalova', 'Yenikapi'),
('Yalova', 'Pendik');


INSERT INTO can_approach (terminal_name, type_name) VALUES
('Bursa', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Bursa', 'Araba Ferisi'),
('Bursa', 'Hafif Yolcu Feribotu'),
('Kabatas', 'Hafif Yolcu Feribotu'),
('Armutlu', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Kadikoy', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Yenikapi', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Yenikapi', 'Araba Ferisi'),
('Pendik', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Pendik', 'Araba Ferisi'),
('Yalova', 'Yuksek Hizli Hafif Yolcu Gemisi'),
('Yalova', 'Araba Ferisi');

INSERT INTO is_ferry_applicable (line_id, type_name) VALUES
(1, 'Yuksek Hizli Hafif Yolcu Gemisi'),
(2, 'Yuksek Hizli Hafif Yolcu Feribotu'),
(3, 'Araba Ferisi'),
(4, 'Hafif Yolcu Feribotu'),
(5, 'Yuksek Hizli Hafif Yolcu Gemisi'),
(6, 'Yuksek Hizli Hafif Yolcu Gemisi'),
(7, 'Araba Ferisi'),
(8, 'Araba Ferisi');

--Martı
INSERT INTO Martı (martı_id, price_per_minute ,current_longitude, current_latitude, current_charge, need_driver_license, martı_type) VALUES
(1, 6.75, 41.0082, 28.5865, 42, 1, 'E-mopped'),
(2, 5.5, 41.2389, 29.1761, 42, 0, 'Scooter'),
(3, 6.75, 41.5627, 28.3769, 42, 1, 'E-mopped'),
(4, 5.5, 41.9253, 28.8863, 42, 0, 'Scooter'),
(5, 5.5, 42.6221, 28.3562, 42, 0, 'Scooter');

INSERT INTO Martı_location_history (Martı_id, date, longitude, latitude, time) VALUES
(1, '2023-01-04 15:32:27', 41.5226, 29.7254, 6),
(1, '2023-01-06 22:18:22', 41.8263, 28.4337, '22:18:22'),
(1, '2023-01-07 07:22:35', 42.5458, 28.1478, '07:32:35'),
(2, '2023-01-05 16:41:35', 41.4391, 29.1933, '16:41:35'),
(2, '2023-01-06 11:16:17', 41.7812, 28.2681, '11:16:17'),
(3, '2023-01-02 12:22:15', 41.3985, 28.5681, '12:22:15'),
(3, '2023-01-03 17:16:35', 42.6141, 28.1281, '17:16:35'),
(4, '2023-01-04 15:23:32', 41.3678, 28.7145, '15:23:32'),
(4, '2023-01-05 12:33:11', 41.2696, 28.6008, '12:33:11'),
(5, '2023-01-05 12:41:21', 42.2359, 29.3316, '12:41:21');


--Airline Companies
INSERT INTO Company (company_name, company_rating)
VALUES
('Qatar Airways', 8.38),
('Eurowings', 8.27),
('LOT Polish Airlines', 8.11),
('Etihad Airways', 8.09),
('All Nippon Airways', 8.09),
('Austrian Airlines', 8.07),
('American Airlines', 7.97),
('China Airlines', 7.92),
('Widerøe', 7.89),
('United Airlines', 7.88),
('Delta Air Lines', 7.88),
('Brussels Airlines', 7.84),
('Finnair', 7.82),
('Oman Air', 7.79),
('Icelandair', 7.77),
('KLM Royal Dutch Airlines', 7.76),
('Malaysia Airlines', 7.64),
('SAS Scandinavian Airlines', 7.63),
('Iberia', 7.62),
('Croatia Airlines', 7.55),
('Atlantic Airways', 7.48),
('airBaltic', 7.46),
('Garuda Indonesia', 7.45),
('Emirates', 7.43),
('Air France', 7.41),
('Singapore Airlines', 7.35),
('EVA Airways', 7.21),
('Japan Airlines (JAL)', 7.2),
('Air Tahiti Nui', 7.18),
('Aeromexico', 7.17),
('Tap Air Portugal', 7.16),
('Transavia', 7.16),
('Air Caraïbes', 7.1),
('Royal Jordanian', 7.09),
('Virgin Atlantic', 7.07),
('ITA Airways', 7.05),
('Air Dolomiti', 7.04),
('Wizz Air', 7.01),
('Norwegian', 7),
('Aer Lingus', 6.98),
('Westjet', 6.96),
('Avianca', 6.95),
('Korean Air', 6.85),
('Condor', 6.84),
('easyJet', 6.79),
('Cathay Pacific', 6.77),
('Azul Airlines', 6.74),
('Swiss International Air Lines', 6.72),
('Aegean Airlines', 6.68),
('TUI Airways', 6.6),
('SunExpress', 6.52),
('Ryanair', 6.46),
('Turkish Airlines', 6.46),
('Alaska Airlines', 6.41),
('Air Malta', 6.26),
('Saudia', 6.25),
('Lufthansa', 6.21),
('Cyprus Airways', 6.21),
('JetBlue', 6.21),
('Virgin Australia', 6.16);

--Airline Companies
INSERT INTO Company (company_name, company_rating)
VALUES
('Qatar Airways', 8.38),
('Eurowings', 8.27),
('LOT Polish Airlines', 8.11),
('Etihad Airways', 8.09),
('All Nippon Airways', 8.09),
('Austrian Airlines', 8.07),
('American Airlines', 7.97),
('China Airlines', 7.92),
('Widerøe', 7.89),
('United Airlines', 7.88),
('Delta Air Lines', 7.88),
('Brussels Airlines', 7.84),
('Finnair', 7.82),
('Oman Air', 7.79),
('Icelandair', 7.77),
('KLM Royal Dutch Airlines', 7.76),
('Malaysia Airlines', 7.64),
('SAS Scandinavian Airlines', 7.63),
('Iberia', 7.62),
('Croatia Airlines', 7.55),
('Atlantic Airways', 7.48),
('airBaltic', 7.46),
('Garuda Indonesia', 7.45),
('Emirates', 7.43),
('Air France', 7.41),
('Cathay Pacific', 6.77),
('Azul Airlines', 6.74),
('Swiss International Air Lines', 6.72),
('Aegean Airlines', 6.68),
('TUI Airways', 6.6),
('SunExpress', 6.52),
('Ryanair', 6.46),
('Turkish Airlines', 6.46);

--Car Companies
INSERT INTO Company (company_name, company_rating)
VALUES
('Europcar', 4.25),
('Greenmotion', 3.75),
('Goldcar', 4.12),
('Budget', 3.98),
('AVIS', 4.45),
('SIXT', 4.03),
('Mayrent', 3.92),
('Central', 4.17),
('Windycar', 3.88),
('Çizgi', 4.05),
('Rentgo', 4.34),
('Novacar', 3.79),
('Turmobil', 4.22),
('B2 Carlease', 3.96),
('Wish', 4.11);

INSERT INTO Company_business_areas (Company_name, business_area)
VALUES
('Europcar', 'car'),
('Greenmotion', 'car'),
('Goldcar', 'car'),
('Budget', 'car'),
('AVIS', 'car'),
('SIXT', 'car'),
('Mayrent', 'car'),
('Central', 'car'),
('Windycar', 'car'),
('Çizgi', 'car'),
('Rentgo', 'car'),
('Novacar', 'car'),
('Turmobil', 'car'),
('B2 Carlease', 'car'),
('Wish', 'car');

--Branches
INSERT INTO Branch VALUES
('Europcar', 'Istanbul_Europcar_1', 4, '09:00-18:00', 'Istanbul', 'Istiklal Avenue No:123', '+90 212 123 4567', '34000', 'Istanbul', '123', 'Istiklal Avenue');

INSERT INTO Branch VALUES
('Europcar', 'Ankara_Europcar_1', 3, '10:00-17:30', 'Ankara', 'Kizilay Square No:456', '+90 312 987 6543', '06000', 'Ankara', '456', 'Kizilay Square');

INSERT INTO Branch VALUES
('Greenmotion', 'Izmir_Greenmotion_1', 4, '08:30-19:00', 'Izmir', 'Konak Street No:789', '+90 232 789 0123', '35000', 'Izmir', '789', 'Konak Street');

INSERT INTO Branch VALUES
('Greenmotion', 'Antalya_Greenmotion_1', 3, '09:30-18:30', 'Antalya', 'Kaleici Street No:234', '+90 242 345 6789', '07000', 'Antalya', '234', 'Kaleici Street');

INSERT INTO Branch VALUES
('Goldcar', 'Bursa_Goldcar_1', 3, '10:00-18:00', 'Bursa', 'Uludag Avenue No:567', '+90 224 567 8901', '16000', 'Bursa', '567', 'Uludag Avenue');

INSERT INTO Branch VALUES
('Goldcar', 'Adana_Goldcar_1', 4, '09:30-17:30', 'Adana', 'Seyhan Boulevard No:890', '+90 322 901 2345', '01100', 'Adana', '890', 'Seyhan Boulevard');

INSERT INTO Branch VALUES
('Budget', 'Istanbul_Budget_1', 4, '08:00-18:30', 'Istanbul', 'Taksim Square No:123', '+90 212 345 6789', '34300', 'Istanbul', '123', 'Taksim Square');

INSERT INTO Branch VALUES
('Budget', 'Izmir_Budget_1', 3, '09:30-17:00', 'Izmir', 'Alsancak Street No:456', '+90 232 901 2345', '35000', 'Izmir', '456', 'Alsancak Street');

INSERT INTO Branch VALUES
('AVIS', 'Ankara_AVIS_1', 4, '09:00-18:30', 'Ankara', 'Kocatepe Street No:345', '+90 312 567 8901', '06000', 'Ankara', '345', 'Kocatepe Street');

INSERT INTO Branch VALUES
('AVIS', 'Izmir_AVIS_1', 3, '10:30-17:00', 'Izmir', 'Bornova Avenue No:678', '+90 232 901 2345', '35000', 'Izmir', '678', 'Bornova Avenue');

INSERT INTO Branch VALUES
('SIXT', 'Istanbul_SIXT_1', 4, '08:00-19:00', 'Istanbul', 'Levent Street No:901', '+90 212 345 6789', '34300', 'Istanbul', '901', 'Levent Street');

INSERT INTO Branch VALUES
('SIXT', 'Antalya_SIXT_1', 3, '09:30-18:30', 'Antalya', 'Konyaalti Avenue No:234', '+90 242 567 8901', '07000', 'Antalya', '234', 'Konyaalti Avenue');

INSERT INTO Branch VALUES
('Mayrent', 'Istanbul_Mayrent_1', 3, '09:00-18:00', 'Istanbul', 'Kadikoy Street No:123', '+90 212 345 6789', '34700', 'Istanbul', '123', 'Kadikoy Street');

INSERT INTO Branch VALUES
('Mayrent', 'Ankara_Mayrent_1', 4, '10:30-17:30', 'Ankara', 'Cankaya Avenue No:456', '+90 312 567 8901', '06000', 'Ankara', '456', 'Cankaya Avenue');

INSERT INTO Branch VALUES
('Central', 'Izmir_Central_1', 4, '08:30-19:00', 'Izmir', 'Alsancak Street No:789', '+90 232 901 2345', '35000', 'Izmir', '789', 'Alsancak Street');

INSERT INTO Branch VALUES
('Central', 'Antalya_Central_1', 3, '09:00-18:30', 'Antalya', 'Muratpasa Avenue No:1011', '+90 242 345 6789', '07000', 'Antalya', '1011', 'Muratpasa Avenue');

INSERT INTO Branch VALUES
('Windycar', 'Bursa_Windycar_1', 3, '10:00-18:00', 'Bursa', 'Osmangazi Street No:1212', '+90 224 567 8901', '16000', 'Bursa', '1212', 'Osmangazi Street');

INSERT INTO Branch VALUES
('Windycar', 'Adana_Windycar_1', 4, '09:30-17:30', 'Adana', 'Seyhan Boulevard No:1415', '+90 322 901 2345', '01100', 'Adana', '1415', 'Seyhan Boulevard');

INSERT INTO Branch VALUES
('Çizgi', 'Istanbul_Çizgi_1', 4, '08:00-18:30', 'Istanbul', 'Taksim Square No:1617', '+90 212 345 6789', '34300', 'Istanbul', '1617', 'Taksim Square');

INSERT INTO Branch VALUES
('Çizgi', 'Izmir_Çizgi_1', 3, '09:30-17:00', 'Izmir', 'Bornova Avenue No:1819', '+90 232 901 2345', '35000', 'Izmir', '1819', 'Bornova Avenue');

INSERT INTO Branch VALUES
('Rentgo', 'Istanbul_Rentgo_1', 4, '09:00-18:00', 'Istanbul', 'Kadikoy Street No:2123', '+90 212 345 6789', '34700', 'Istanbul', '2123', 'Kadikoy Street');

INSERT INTO Branch VALUES
('Rentgo', 'Ankara_Rentgo_1', 3, '10:30-17:30', 'Ankara', 'Cankaya Avenue No:2325', '+90 312 567 8901', '06000', 'Ankara', '2325', 'Cankaya Avenue');

INSERT INTO Branch VALUES
('Novacar', 'Izmir_Novacar_1', 4, '08:30-19:00', 'Izmir', 'Alsancak Street No:2527', '+90 232 901 2345', '35000', 'Izmir', '2527', 'Alsancak Street');

INSERT INTO Branch VALUES
('Novacar', 'Antalya_Novacar_1', 3, '09:00-18:30', 'Antalya', 'Muratpasa Avenue No:2729', '+90 242 345 6789', '07000', 'Antalya', '2729', 'Muratpasa Avenue');

INSERT INTO Branch VALUES
('Turmobil', 'Bursa_Turmobil_1', 3, '10:00-18:00', 'Bursa', 'Osmangazi Street No:2931', '+90 224 567 8901', '16000', 'Bursa', '2931', 'Osmangazi Street');

INSERT INTO Branch VALUES
('Turmobil', 'Adana_Turmobil_1', 4, '09:30-17:30', 'Adana', 'Seyhan Boulevard No:3123', '+90 322 901 2345', '01100', 'Adana', '3123', 'Seyhan Boulevard');

INSERT INTO Branch VALUES
('B2 Carlease', 'Istanbul_B2_Carlease_1', 4, '08:00-18:30', 'Istanbul', 'Taksim Square No:3335', '+90 212 345 6789', '34300', 'Istanbul', '3335', 'Taksim Square');

INSERT INTO Branch VALUES
('B2 Carlease', 'Izmir_B2_Carlease_1', 3, '09:30-17:00', 'Izmir', 'Bornova Avenue No:3537', '+90 232 901 2345', '35000', 'Izmir', '3537', 'Bornova Avenue');

INSERT INTO Branch VALUES
('Wish', 'Istanbul_Wish_1', 4, '08:00-19:00', 'Istanbul', 'Levent Street No:3739', '+90 212 345 6789', '34300', 'Istanbul', '3739', 'Levent Street');

INSERT INTO Branch VALUES
('Wish', 'Antalya_Wish_1', 3, '09:30-18:30', 'Antalya', 'Konyaalti Avenue No:3941', '+90 242 567 8901', '07000', 'Antalya', '3941', 'Konyaalti Avenue');

--Car
INSERT INTO Car (Company_name, license_plate, car_type, gear_type, model, brand, fuel_type, kilometer_made, 
kilometer_limit, price_per_day, current_branch_name, arrival_date, arrival_time) VALUES
('Europcar', '34ABC01', 'Sedan', 'Automatic', 2000, 'Toyota', 'Gasoline', 173788, 971, 2816, 'Istanbul_Europcar_1', '2023-01-01', 6),
('Greenmotion', '06DEF02', 'SUV', 'Manual', 2001, 'Ford', 'Diesel', 93496, 2335, 1221, 'Izmir_Greenmotion_1', '2023-01-01', 6),
('Goldcar', '35GHI03', 'Hatchback', 'Automatic', 2002, 'Honda', 'Hybrid', 8102, 2783, 2567, 'Bursa_Goldcar_1', '2023-01-01', 6),
('Budget', '16JKL04', 'Convertible', 'Manual', 2003, 'Volkswagen', 'Electric', 128238, 1512, 1635, 'Istanbul_Budget_1', '2023-01-01', 6),
('AVIS', '34MNO05', 'Sedan', 'Automatic', 2004, 'BMW', 'Gasoline', 109360, 2968, 1274, 'Ankara_AVIS_1', '2023-01-01', 6),
('SIXT', '06PQR06', 'SUV', 'Manual', 2005, 'Mercedes-Benz', 'Diesel', 90829, 2035, 1085, 'Istanbul_SIXT_1', '2023-01-01', 6),
('Mayrent', '35STU07', 'Hatchback', 'Automatic', 2006, 'Chevrolet', 'Hybrid', 174293, 1514, 1794, 'Istanbul_Mayrent_1', '2023-01-01', 6),
('Central', '16VWX08', 'Convertible', 'Manual', 2007, 'Nissan', 'Electric', 156486, 1647, 2529, 'Izmir_Central_1', '2023-01-01', 6),
('Windycar', '34YZA09', 'Sedan', 'Automatic', 2008, 'Audi', 'Gasoline', 199875, 1806, 1463, 'Bursa_Windycar_1', '2023-01-03', 6),
('Çizgi', '06BCD10', 'SUV', 'Manual', 2009, 'Hyundai', 'Diesel', 170859, 1845, 2047, 'Istanbul_Çizgi_1', '2023-01-03', 6),
('Rentgo', '35EFG11', 'Hatchback', 'Automatic', 2010, 'Kia', 'Hybrid', 147014, 1159, 1072, 'Istanbul_Rentgo_1', '2023-01-03', 6),
('Novacar', '16HIJ12', 'Convertible', 'Manual', 2011, 'Fiat', 'Electric', 92416, 1979, 758, 'Izmir_Novacar_1', '2023-01-03', 6),
('Turmobil', '34KLM12', 'Sedan', 'Automatic', 2012, 'Volvo', 'Gasoline', 64719, 987, 2616, 'Bursa_Turmobil_1', '2023-01-03', 6),
('B2 Carlease', '06NOP14', 'SUV', 'Manual', 2012, 'Porsche', 'Diesel', 154480, 2712, 2114, 'Istanbul_B2_Carlease_1', '2023-01-03', 6),
('Wish', '35QRS15', 'Hatchback', 'Automatic', 2014, 'Tesla', 'Hybrid', 175039, 2627, 1185, 'Istanbul_Wish_1', '2023-01-03', 6);

--Izban
INSERT INTO İzban (izban_id, price, first_station_name, last_station_name) VALUES
(1, 54.59, 'Aliaga', 'Selcuk'),
(2, 15.01, 'Aliaga', 'Menemen'),
(3, 45.39, 'Menemen', 'Cumaovasi'),
(4, 25.87, 'Cumaovasi', 'Selcuk');

INSERT INTO Station (name, county, previous_station_name, next_station_name) VALUES
('Aliaga', 'Aliaga', null, 'Bicerova'),
('Menemen', 'Menemen', 'Hatundere', 'Egekent-2'),
('Cumaovasi', 'Cumaovasi', 'Havalimani', 'Develi'),
('Selcuk', 'Selcuk', 'Belevi', null),
('Hilal', 'Konak', 'Alsancak', 'Kemer'),
('Kemer', 'Konak', 'Hilal', 'Sirinyer'),
('Sirinyer', 'Buca', 'Kemer', 'Kosu'),
('Kosu', 'Buca', 'Sirinyer', 'Inkilap'),
('Inkilap', 'Buca', 'Kosu', 'Semt Garaji'),
('Semt Garaji', 'Gaziemir', 'Inkilap', 'Esbas'),
('Esbas', 'Gaziemir', 'Semt Garaji', 'Gaziemir'),
('Gaziemir', 'Gaziemir', 'Esbas', 'Sarnic');

INSERT INTO Izban_Voyage (izban_id, voyage_instance_id, start_date, start_time, finish_date, finish_time, duration_time, refund_amount, first_station_name, last_station_name) VALUES
(1, 1, '2023-01-05', '12:00:00', '2023-01-05', '13:12:00', 72, 17.11, 'Aliaga', 'Selcuk'),
(1, 2, '2023-01-05', '08:00:00', '2023-01-05', '09:12:00', 72, 10.18, 'Aliaga', 'Selcuk'),
(2, 3, '2023-01-05', '11:00:00', '2023-01-05', '11:30:00', 30, 16.21, 'Aliaga', 'Menemen'),
(2, 4, '2023-01-06', '13:30:00', '2023-01-06', '14:00:00', 30, 8.55, 'Aliaga', 'Menemen'),
(3, 5, '2023-01-06', '16:30:00', '2023-01-06', '17:12:00', 42, 12.26, 'Menemen', 'Cumaovasi'),
(3, 6, '2023-01-05', '08:30:00', '2023-01-05', '09:12:00', 42, 9.35, 'Menemen', 'Cumaovasi'),
(4, 7, '2023-01-06', '19:45:00', '2023-01-06', '20:25:00', 40, 11.45, 'Cumaovasi', 'Selcuk'),
(4, 8, '2023-01-07', '22:15:00', '2023-01-07', '22:55:00', 40, 16.33, 'Cumaovasi', 'Selcuk');

INSERT INTO Electrical_Car(Company_name, license_plate, battery_life, charging_time) VALUES
('Europcar', '34ABC01', 100000, 8),
('Greenmotion', '06DEF02', 130000, 9),
('Goldcar', '35GHI03', 120000, 14),
('Budget', '16JKL04', 160000, 12),
('AVIS', '34MNO05', 200000, 10),
('SIXT', '06PQR06', 115000, 7),
('Mayrent', '35STU07', 180000, 11);

INSERT INTO Non_Electrical_Car(Company_name, license_plate, engine_cylinder_volume) VALUES
('Central', '16VWX08', 1900),
('Windycar', '34YZA09', 2000),
('Çizgi', '06BCD10', 1800),
('Rentgo', '35EFG11', 2200),
('Novacar', '16HIJ12', 1700),
('Turmobil', '34KLM12', 1500),
('B2 Carlease', '06NOP14', 2100),
('Wish', '35QRS15', 2500);

INSERT INTO rent_condition (Company_name, license_plate, condition_date, deposit, total_km_limit, min_driver_age, day_price, delivery_type)
VALUES
('Europcar', '34ABC01', '2023-01-01', 500.00, 1000, 21, 150.00, 'Pickup'),
('Greenmotion', '06DEF02', '2023-01-01', 600.00, 1200, 23, 180.00, 'Delivery'),
('Goldcar', '35GHI03', '2023-01-01', 450.00, 800, 20, 160.00, 'Pickup'),
('Budget', '16JKL04', '2023-01-01', 700.00, 1500, 25, 200.00, 'Delivery'),
('AVIS', '34MNO05', '2023-01-01', 550.00, 2000, 22, 170.00, 'Pickup'),
('SIXT', '06PQR06', '2023-01-01', 650.00, 1000, 24, 190.00, 'Delivery'),
('Mayrent', '35STU07', '2023-01-01', 480.00, 1200, 21, 160.00, 'Pickup'),
('Central', '16VWX08', '2023-01-01', 800.00, 1500, 26, 220.00, 'Delivery'),
('Windycar', '34YZA09', '2023-01-03', 600.00, 1800, 23, 190.00, 'Pickup'),
('Çizgi', '06BCD10', '2023-01-03', 550.00, 2000, 22, 170.00, 'Delivery'),
('Rentgo', '35EFG11', '2023-01-03', 480.00, 1000, 21, 160.00, 'Pickup'),
('Novacar', '16HIJ12', '2023-01-03', 700.00, 1500, 25, 200.00, 'Delivery'),
('Turmobil', '34KLM12', '2023-01-03', 650.00, 1000, 24, 190.00, 'Pickup'),
('B2 Carlease', '06NOP14', '2023-01-03', 750.00, 2000, 26, 230.00, 'Delivery'),
('Wish', '35QRS15', '2023-01-03', 580.00, 1800, 24, 180.00, 'Pickup');

INSERT INTO Bus (license_plate, capacity)
VALUES
  ('34ABC01', 45),
  ('06DEF02', 32),
  ('35GHI03', 50),
  ('16JKL04', 40),
  ('34MNO05', 35),
  ('06PQR06', 55),
  ('35STU07', 48),
  ('16VWX08', 37),
  ('34YZA09', 42),
  ('06BCD10', 30),
  ('35EFG11', 58),
  ('16HIJ12', 33),
  ('34KLM12', 56),
  ('06NOP14', 38),
  ('35QRS15', 47),
  ('16TUV16', 52),
  ('34XYZ17', 30),
  ('06ABC18', 46),
  ('35DEF19', 31),
  ('16GHI20', 55),
  ('34JKL21', 42),
  ('06MNO22', 36),
  ('35PQR23', 51),
  ('16STU24', 40),
  ('34VWX25', 33),
  ('06YZA26', 47),
  ('35BCD27', 39),
  ('16EFG28', 50),
  ('34HIJ29', 44),
  ('06KLM30', 58);

INSERT INTO Bus_Station (station_name, county, city)
VALUES
  ('Esenler Otogarı', 'Bayrampaşa', 'Istanbul'),
  ('AŞTİ', 'Çankaya', 'Ankara'),
  ('Harem Otogarı', 'Üsküdar', 'Istanbul'),
  ('Samsun Otogarı', 'İlkadım', 'Samsun'),
  ('Konya Otogarı', 'Selçuklu', 'Konya'),
  ('Antalya Otogarı', 'Muratpaşa', 'Antalya'),
  ('İzmir Otogarı', 'Konak', 'Izmir'),
  ('Adana Otogarı', 'Seyhan', 'Adana'),
  ('Trabzon Otogarı', 'Ortahisar', 'Trabzon'),
  ('Bursa Otogarı', 'Osmangazi', 'Bursa');

INSERT INTO Bus_Line (line_name, duration_time, arrival_station_name, departure_station_name)
VALUES
  ('M1', 120, 'Esenler Otogarı', 'AŞTİ'),
  ('A2', 180, 'Harem Otogarı', 'Samsun Otogarı'),
  ('K5', 150, 'Konya Otogarı', 'Antalya Otogarı'),
  ('I7', 200, 'İzmir Otogarı', 'Adana Otogarı'),
  ('T3', 130, 'Trabzon Otogarı', 'Bursa Otogarı'),
  ('B4', 170, 'Bursa Otogarı', 'Esenler Otogarı'),
  ('A9', 160, 'AŞTİ', 'Antalya Otogarı'),
  ('I2', 140, 'İzmir Otogarı', 'Samsun Otogarı'),
  ('K8', 190, 'Konya Otogarı', 'Trabzon Otogarı'),
  ('B1', 180, 'Bursa Otogarı', 'Esenler Otogarı');

INSERT INTO bus_line_passed_stations (line_name, passed_station_name)
VALUES
  ('M1', 'AŞTİ'),
  ('M1', 'Konya Otogarı'),
  ('M1', 'Antalya Otogarı'),
  ('M1', 'Adana Otogarı'),
  ('A2', 'Samsun Otogarı'),
  ('A2', 'Ankara Otogarı'),
  ('A2', 'İzmir Otogarı'),
  ('K5', 'Antalya Otogarı'),
  ('K5', 'Mersin Otogarı'),
  ('K5', 'Bursa Otogarı'),
  ('I7', 'Adana Otogarı'),
  ('I7', 'Nevşehir Otogarı'),
  ('I7', 'İstanbul Otogarı'),
  ('T3', 'Trabzon Otogarı'),
  ('T3', 'Samsun Otogarı'),
  ('T3', 'Bolu Otogarı'),
  ('B4', 'Bursa Otogarı'),
  ('B4', 'İstanbul Otogarı'),
  ('B4', 'Ankara Otogarı');

INSERT INTO Bus_Line_Instance (line_name, line_instance_id, departure_time, arrival_time, date, bus_license_plate)
VALUES
  ('M1', 1, '2023-01-10 08:00', '2023-01-10 10:00', '2023-01-10', '34ABC01'),
  ('A2', 2, '2023-01-10 09:30', '2023-01-10 12:30', '2023-01-10', '06DEF02'),
  ('K5', 3, '2023-01-10 11:00', '2023-01-10 12:30', '2023-01-10', '35GHI03'),
  ('I7', 4, '2023-01-10 13:00', '2023-01-10 15:20', '2023-01-10', '16JKL04'),
  ('T3', 5, '2023-01-10 14:30', '2023-01-10 16:40', '2023-01-10', '34MNO05'),
  ('B4', 6, '2023-01-10 16:00', '2023-01-10 18:00', '2023-01-10', '06PQR06'),
  ('A9', 7, '2023-01-10 17:30', '2023-01-10 19:30', '2023-01-10', '35STU07'),
  ('I2', 8, '2023-01-10 19:00', '2023-01-10 21:00', '2023-01-10', '16VWX08'),
  ('K8', 9, '2023-01-10 20:30', '2023-01-10 22:30', '2023-01-10', '34YZA09'),
  ('B1', 10, '2023-01-10 22:00', '2023-01-11 00:00', '2023-01-10', '06BCD10');

-- Bus_Voyage
INSERT INTO Bus_Voyage (line_name, line_instance_id, voyage_id, boarding_time, landing_time, duration_time, no_of_available_seats, arrival_station_name, departure_station_name)
VALUES
  ('M1', 1, 101, '2023-01-10 07:30', '2023-01-10 10:30', 180, 40, 'AŞTİ', 'Esenler Otogarı'),
  ('A2', 2, 102, '2023-01-10 09:00', '2023-01-10 12:00', 180, 35, 'Samsun Otogarı', 'Harem Otogarı'),
  ('K5', 3, 103, '2023-01-10 10:30', '2023-01-10 12:00', 90, 50, 'Bursa Otogarı', 'Konya Otogarı'),
  ('I7', 4, 104, '2023-01-10 12:00', '2023-01-10 15:20', 200, 30, 'Adana Otogarı', 'İzmir Otogarı'),
  ('T3', 5, 105, '2023-01-10 13:30', '2023-01-10 15:40', 130, 45, 'Bolu Otogarı', 'Trabzon Otogarı'),
  ('B4', 6, 106, '2023-01-10 15:00', '2023-01-10 17:00', 120, 25, 'İstanbul Otogarı', 'Bursa Otogarı'),
  ('A9', 7, 107, '2023-01-10 16:30', '2023-01-10 18:30', 120, 38, 'Antalya Otogarı', 'AŞTİ'),
  ('I2', 8, 108, '2023-01-10 18:00', '2023-01-10 20:00', 120, 42, 'Samsun Otogarı', 'İzmir Otogarı'),
  ('K8', 9, 109, '2023-01-10 19:30', '2023-01-10 21:30', 120, 48, 'Trabzon Otogarı', 'Konya Otogarı'),
  ('B1', 10, 110, '2023-01-10 21:00', '2023-01-10 23:00', 120, 30, 'Esenler Otogarı', 'Bursa Otogarı');
/*
INSERT INTO owns_bus_line (company_name, line_name)
VALUES
  ('Europcar', 'M1'),
  ('Greenmotion', 'A2'),
  ('Goldcar', 'K5'),
  ('Budget', 'I7'),
  ('AVIS', 'T3'),
  ('SIXT', 'B4'),
  ('Mayrent', 'A9'),
  ('Central', 'I2'),
  ('Windycar', 'K8'),
  ('Çizgi', 'B1');
*/
INSERT INTO has_bus (company_name, license_plate)
VALUES
  ('Europcar', '34ABC01'),
  ('Greenmotion', '06DEF02'),
  ('Goldcar', '35GHI03'),
  ('Budget', '16JKL04'),
  ('AVIS', '34MNO05'),
  ('SIXT', '06PQR06'),
  ('Mayrent', '35STU07'),
  ('Central', '16VWX08'),
  ('Windycar', '34YZA09'),
  ('Çizgi', '06BCD10');

--Airportlar
INSERT INTO Airport (airport_code, city, country, airport_name)
VALUES 
('IST', 'Istanbul', 'Turkey', 'Istanbul Airport'),
('SAW', 'Istanbul', 'Turkey', 'Sabiha Gökçen Airport'),
('LHR', 'London', 'United Kingdom', 'Heathrow Airport'),
('CDG', 'Paris', 'France', 'Charles de Gaulle Airport'),
('JFK', 'New York', 'United States', 'John F. Kennedy International Airport'),
('DXB', 'Dubai', 'United Arab Emirates', 'Dubai International Airport'),
('FRA', 'Frankfurt', 'Germany', 'Frankfurt Airport'),
('AMS', 'Amsterdam', 'Netherlands', 'Amsterdam Schiphol Airport'),
('BCN', 'Barcelona', 'Spain', 'Barcelona-El Prat Airport'),
('FCO', 'Rome', 'Italy', 'Leonardo da Vinci–Fiumicino Airport'),
('ZRH', 'Zurich', 'Switzerland', 'Zurich Airport'),
('ESB', 'Ankara', 'Turkey', 'Esenboğa Airport');

--Flight
INSERT INTO Flight (flight_id, flight_duration, is_domestic, arrival_airport_code, departure_airport_code, company_name)
VALUES
(1, 180, 0, 'IST', 'LHR', 'Turkish Airlines'),
(2, 240, 1, 'AMS', 'CDG', 'KLM Royal Dutch Airlines'),
(3, 120, 1, 'FCO', 'BCN', 'Eurowings'),
(4, 300, 0, 'IST', 'JFK', 'Turkish Airlines'),
(5, 180, 1, 'LHR', 'AMS', 'British Airways'),
(6, 150, 0, 'IST', 'FRA', 'Lufthansa'),
(7, 200, 1, 'CDG', 'AMS', 'Air France'),
(8, 240, 1, 'FCO', 'ZRH', 'Swiss International Air Lines'),
(9, 90, 0, 'JFK', 'IST', 'Delta Air Lines'),
(10, 180, 1, 'AMS', 'BCN', 'Vueling Airlines'),
(11, 120, 0, 'IST', 'FCO', 'Turkish Airlines'),
(12, 210, 1, 'CDG', 'AMS', 'Air France'),
(13, 180, 0, 'FCO', 'BCN', 'Iberia'),
(14, 240, 1, 'IST', 'JFK', 'Emirates'),
(15, 180, 0, 'LHR', 'AMS', 'British Airways'),
(16, 150, 1, 'FRA', 'IST', 'Lufthansa'),
(17, 200, 0, 'AMS', 'CDG', 'KLM Royal Dutch Airlines'),
(18, 240, 1, 'ZRH', 'FCO', 'Swiss International Air Lines'),
(19, 90, 0, 'IST', 'JFK', 'Turkish Airlines'),
(20, 180, 1, 'BCN', 'FCO', 'Vueling Airlines');

-- Airplane_Type 
INSERT INTO Airplane_Type (type_id, type_name, maximum_seat, maximum_length, maximum_speed, length, height, wingspan)
VALUES
('A320', 'Airbus A320', 240, 4500, 900, 380, 110, 360),
('B737', 'Boeing 737', 215, 4200, 850, 350, 120, 320),
('A380', 'Airbus A380', 853, 7200, 940, 560, 79, 80),
('B777', 'Boeing 777', 396, 6300, 950, 290, 61, 65),
('E190', 'Embraer E190', 114, 3600, 870, 36, 11, 28),
('CRJ900', 'Bombardier CRJ900', 90, 3000, 880, 36, 7, 24),
('MD80', 'McDonnell Douglas MD-80', 172, 5000, 925, 45, 10, 33),
('ATR72', 'ATR 72', 78, 2700, 510, 27, 7, 27),
('Dash8', 'Bombardier Dash 8', 90, 3200, 520, 32, 8, 28),
('F50', 'Fokker 50', 58, 2500, 530, 25, 8, 30);

-- Airplane 
INSERT INTO Airplane (airplane_id, airplane_name, total_no_of_seats, current_location, type_id)
VALUES
(1, 'Airbus A320-200', 180, 'IST', 'A320'),
(2, 'Boeing 737-800', 160, 'AMS', 'B737'),
(3, 'Airbus A380-800', 550, 'JFK', 'A380'),
(4, 'Boeing 777-300ER', 350, 'LHR', 'B777'),
(5, 'Embraer E190', 100, 'FCO', 'E190'),
(6, 'Bombardier CRJ900', 80, 'CDG', 'CRJ900'),
(7, 'McDonnell Douglas MD-80', 150, 'BCN', 'MD80'),
(8, 'ATR 72-600', 70, 'FRA', 'ATR72'),
(9, 'Bombardier Dash 8 Q400', 80, 'ZRH', 'Dash8'),
(10, 'Fokker 50', 50, 'IST', 'F50'),
(11, 'Airbus A320-200', 180, 'AMS', 'A320'),
(12, 'Boeing 737-800', 160, 'CDG', 'B737'),
(13, 'Airbus A380-800', 550, 'FCO', 'A380'),
(14, 'Boeing 777-300ER', 350, 'JFK', 'B777'),
(15, 'Embraer E190', 100, 'LHR', 'E190'),
(16, 'Bombardier CRJ900', 80, 'IST', 'CRJ900'),
(17, 'McDonnell Douglas MD-80', 150, 'AMS', 'MD80'),
(18, 'ATR 72-600', 70, 'BCN', 'ATR72'),
(19, 'Bombardier Dash 8 Q400', 80, 'FRA', 'Dash8'),
(20, 'Fokker 50', 50, 'ZRH', 'F50');

-- can_land
INSERT INTO can_land (airport_code, type_id)
VALUES
('IST', 'B737'),
('AMS', 'B737'),
('AMS', 'A320'),
('JFK', 'A380'),
('JFK', 'B777'),
('LHR', 'B777'),
('LHR', 'A380'),
('FCO', 'E190'),
('FCO', 'A380'),
('CDG', 'CRJ900'),
('CDG', 'MD80'),
('BCN', 'MD80'),
('BCN', 'ATR72'),
('FRA', 'ATR72'),
('FRA', 'Dash8'),
('ZRH', 'Dash8'),
('ZRH', 'F50'),
('IST', 'F50'),
('AMS', 'F50'),
('IST', 'A320'),
('CDG', 'A320'),
('FCO', 'B777'),
('AMS', 'CRJ900'),
('JFK', 'CRJ900'),
('LHR', 'MD80'),
('FCO', 'Dash8'),
('IST', 'E190'),
('IST', 'ATR72');

-- Flight_Leg
INSERT INTO Flight_Leg (flight_id, leg_id, available_no_of_seats, base_fare, fuel_surcharge, flight_price, taxes, ticket_service_fee, airplane_id)
VALUES
(1, 1, 150, 250.00, 50.00, 300.00, 30.00, 10.00, 1),
(2, 1, 180, 200.00, 40.00, 240.00, 20.00, 8.00, 2),
(2, 2, 160, 180.00, 35.00, 215.00, 18.00, 7.00, 12),
(3, 1, 80, 120.00, 25.00, 145.00, 15.00, 5.00, 13),
(3, 2, 90, 130.00, 27.00, 157.00, 16.00, 6.00, 18),
(4, 1, 200, 300.00, 60.00, 360.00, 40.00, 15.00, 14),
(5, 1, 170, 220.00, 45.00, 265.00, 25.00, 9.00, 3),
(6, 1, 140, 180.00, 35.00, 215.00, 18.00, 7.00, 6),
(7, 1, 180, 240.00, 50.00, 290.00, 30.00, 12.00, 16),
(8, 1, 160, 200.00, 40.00, 240.00, 20.00, 8.00, 8),
(8, 2, 70, 100.00, 20.00, 120.00, 12.00, 4.00, 9),
(9, 1, 80, 130.00, 25.00, 157.00, 16.00, 6.00, 5),
(10, 1, 150, 180.00, 35.00, 215.00, 18.00, 7.00, 10),
(11, 1, 140, 200.00, 40.00, 240.00, 20.00, 8.00, 1),
(12, 1, 170, 240.00, 50.00, 290.00, 30.00, 12.00, 12),
(13, 1, 90, 130.00, 27.00, 157.00, 16.00, 6.00, 13),
(14, 1, 200, 300.00, 60.00, 360.00, 40.00, 15.00, 14),
(15, 1, 180, 220.00, 45.00, 265.00, 25.00, 9.00, 3),
(16, 1, 160, 180.00, 35.00, 215.00, 18.00, 7.00, 6),
(17, 1, 70, 100.00, 20.00, 120.00, 12.00, 4.00, 2),
(18, 1, 90, 130.00, 27.00, 157.00, 16.00, 6.00, 8),
(19, 1, 150, 250.00, 50.00, 300.00, 30.00, 10.00, 1),
(20, 1, 140, 180.00, 35.00, 215.00, 18.00, 7.00, 10);

INSERT INTO Customer (customer_id, FName, Lname, surname, language, TCKN, passport_no, nationality, sex ,city, country, street , phone_number, gmail, birthday) VALUES
(1, 'John', 'Doe', 'Smith', 'English', '12345678901', 'ABC123456', 'USA', 'Male', 'New York', 'United States', '123 Main St', '+1234567890', 'john.doe@gmail.com', '1990-01-15'),
(2, 'Jane', 'Smith', 'Doe', 'English', '98765432109', 'XYZ987654', 'Canada', 'Female', 'Toronto', 'Canada', '456 Oak St', '+0987654321', 'jane.smith@gmail.com', '1985-08-20'),
(3, 'Robert', 'Johnson', 'White', 'Spanish', '23456789012', 'RJW345678', 'Spain', 'Male', 'Madrid', 'Spain', '789 Maple St', '+2345678901', 'robert.johnson@gmail.com', '1978-03-10'),
(4, 'Emily', 'Brown', 'Davis', 'French', '34567890123', 'EBD456789', 'France', 'Female', 'Paris', 'France', '234 Birch St', '+3456789012', 'emily.brown@gmail.com', '1995-05-25'),
(5, 'Ahmet', 'Yılmaz', 'Çelik', 'Turkish', '12345678902', 'AYC123457', 'Turkey', 'Male', 'Istanbul', 'Turkey', '567 Pine St', '+1234567891', 'ahmet.yilmaz@gmail.com', '1982-12-18'),
(6, 'Ayşe', 'Kaya', 'Şahin', 'Turkish', '23456789013', 'AKS234567', 'Turkey', 'Female', 'Ankara', 'Turkey', '789 Cedar St', '+2345678902', 'ayse.kaya@gmail.com', '1991-06-30'),
(7, 'Mehmet', 'Arslan', 'Demir', 'Turkish', '34567890124', 'MAD345678', 'Turkey', 'Male', 'Izmir', 'Turkey', '890 Oak St', '+3456789013', 'mehmet.arslan@gmail.com', '1975-09-12'),
(8, 'Zeynep', 'Öztürk', 'Aksoy', 'Turkish', '45678901235', 'ZOA456789', 'Turkey', 'Female', 'Antalya', 'Turkey', '123 Birch St', '+4567890123', 'zeynep.ozturk@gmail.com', '1988-04-03'),
(9, 'Michael', 'Jordan', 'Brown', 'English', '45678901234', 'MJK567890', 'Australia', 'Male', 'Sydney', 'Australia', '789 Pine St', '+9876543210', 'michael.jordan@gmail.com', '1973-02-17'),
(10, 'Mia', 'Williams', 'Johnson', 'English', '56789012345', 'MWJ987654', 'India', 'Female', 'Mumbai', 'India', '890 Cedar St', '+8765432109', 'mia.williams@gmail.com', '1988-11-30'),
(11, 'Ali', 'Yılmaz', 'Koç', 'Turkish', '56789012346', 'AYK567890', 'Turkey', 'Male', 'Bursa', 'Turkey', '456 Maple St', '+5678901234', 'ali.yilmaz@gmail.com', '1993-07-22'),
(12, 'Aysun', 'Demir', 'Çetin', 'Turkish', '67890123456', 'ADC678901', 'Turkey', 'Female', 'Izmir', 'Turkey', '234 Oak St', '+6789012345', 'aysun.demir@gmail.com', '1980-10-14'),
(13, 'David', 'Anderson', 'Smith', 'English', '78901234567', 'DAS789012', 'Canada', 'Male', 'Vancouver', 'Canada', '567 Cedar St', '+7890123456', 'david.anderson@gmail.com', '1970-04-28'),
(14, 'Elif', 'Kurt', 'Güneş', 'Turkish', '89012345678', 'EKG890123', 'Turkey', 'Female', 'Istanbul', 'Turkey', '345 Birch St', '+8901234567', 'elif.kurt@gmail.com', '1997-09-05'),
(15, 'Cem', 'Öztürk', 'Gür', 'Turkish', '90123456789', 'COG901234', 'Turkey', 'Male', 'Ankara', 'Turkey', '678 Maple St', '+9012345678', 'cem.ozturk@gmail.com', '1987-01-08'),
(16, 'Olivia', 'Martin', 'Johnson', 'English', '12345678910', 'OMJ123456', 'USA', 'Female', 'Los Angeles', 'United States', '456 Pine St', '+1234567899', 'olivia.martin@gmail.com', '1994-11-15'),
(17, 'Can', 'Aydın', 'Güneş', 'Turkish', '23456789014', 'CAG234567', 'Turkey', 'Male', 'Antalya', 'Turkey', '789 Cedar St', '+2345678903', 'can.aydin@gmail.com', '1996-03-19'),
(18, 'Leyla', 'Arslan', 'Yıldız', 'Turkish', '34567890125', 'LAY345678', 'Turkey', 'Female', 'Izmir', 'Turkey', '890 Oak St', '+3456789014', 'leyla.arslan@gmail.com', '1983-06-27'),
(19, 'Eren', 'Şahin', 'Kaya', 'Turkish', '45678901236', 'ESK456789', 'Turkey', 'Male', 'Istanbul', 'Turkey', '123 Main St', '+4567890124', 'eren.sahin@gmail.com', '1992-02-14'),
(20, 'Melis', 'Güzel', 'Koç', 'Turkish', '56789012347', 'MGK567890', 'Turkey', 'Female', 'Ankara', 'Turkey', '234 Birch St', '+5678901235', 'melis.guzel@gmail.com', '1986-07-03');

INSERT INTO Card (Card_id, customer_id, balance_amount) VALUES
(1, 1, 1000.00),
(2, 2, 1500.50),
(3, 3, 2000.25),
(4, 4, 1200.75),
(5, 5, 800.00),
(6, 6, 2500.50),
(7, 7, 1800.25),
(8, 8, 3000.75),
(9, 9, 1600.00),
(10, 10, 900.50),
(11, 11, 1300.25),
(12, 12, 2200.75),
(13, 13, 1700.00),
(14, 14, 1400.50),
(15, 15, 1900.25),
(16, 16, 2800.75),
(17, 17, 1100.00),
(18, 18, 2400.50),
(19, 19, 2100.25),
(20, 20, 2600.75);








