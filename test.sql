﻿DROP TABLE CARS CASCADE;
DROP TABLE DISLOCATION;
DROP TABLE ORDERS;
DROP TABLE ROUTERS;
DROP TABLE STATIONS CASCADE;
DROP TABLE STATIONS_ROADS;
DROP TABLE STATIONS_OTDELENIES;
DROP TABLE OTDELENIES;
DROP TABLE ROADS;
DROP TABLE SCHEDULE;
DROP TABLE EMPTY_WAGONS;
 
CREATE TABLE CARS (
    car_type_id INT NOT NULL,
    car_type_name VARCHAR(100)
);

CREATE TABLE DISLOCATION (
    id INT NOT NULL,
    station_id INT NOT NULL,
    loaded_empty INT NOT NULL,
    cars_quantity INT NOT NULL,
    car_type INT NOT NULL,
    period INT NOT NULL,
    wait_time INT NULL
);


CREATE TABLE ORDERS (
    order_id INT NOT NULL,
    station_from INT NOT NULL,
    station_to INT NOT NULL,
    revenue_per_car FLOAT NOT NULL,
    car_required INT NOT NULL,
    car_type INT NOT NULL,
    NKO_load FLOAT NOT NULL,
    NKO_loaded_run_unload FLOAT NOT NULL,
    must_do INT
);

CREATE TABLE ROUTERS (
    route_id INT NOT NULL,
    station_from INT NOT NULL,
    station_to INT NOT NULL,
    Avg_cost INT NOT NULL
);

CREATE TABLE STATIONS (
    station_id INT NOT NULL,
    station_name VARCHAR(100) NOT NULL,
    min INT NOT NULL,
    max INT NOT NULL,
    wait_cost INT NOT NULL
);


CREATE TABLE STATIONS_ROADS (
    station_id INT NOT NULL,
    otdelenie_id INT NOT NULL
);

CREATE TABLE STATIONS_OTDELENIES (
    otdelenie_id INT NOT NULL,
    station_otdelenie VARCHAR(100) NOT NULL

);

CREATE TABLE OTDELENIES (
    otdelenie_id INT NOT NULL,
    station_road VARCHAR(100) NOT NULL
);

CREATE TABLE ROADS (
    station_road_id INT NOT NULL,
    station_otdelenie VARCHAR(100) NOT NULL
);

CREATE TABLE SCHEDULE (
    order_id INT NOT NULL,
    period INT NOT NULL,
    Sum_cars_quatity INT NOT NULL
);


--KEY-
ALTER TABLE STATIONS ADD PRIMARY KEY (station_id);
ALTER TABLE DISLOCATION ADD PRIMARY KEY (id);
ALTER TABLE ORDERS ADD PRIMARY KEY (order_id);
ALTER TABLE CARS ADD PRIMARY KEY (car_type_id);
ALTER TABLE OTDELENIES ADD PRIMARY KEY (otdelenie_id);

--FOREIGN KEY 
ALTER TABLE DISLOCATION ADD FOREIGN KEY (car_type) REFERENCES CARS(car_type_id);
ALTER TABLE STATIONS_ROADS ADD FOREIGN KEY (station_id) REFERENCES STATIONS(station_id);
ALTER TABLE ORDERS ADD FOREIGN KEY (car_type) REFERENCES CARS(car_type_id);


\COPY CARS                  FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\CARS.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY DISLOCATION           FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\DISLOCATON.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ORDERS                FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\ORDERS.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ROUTERS               FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\ROUTERS.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS              FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\STATIONS.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS_ROADS        FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\STATIONS_ROADS.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS_OTDELENIES   FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\STATIONS_OTDELENIES.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY OTDELENIES            FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\OTDELENIES.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ROADS                 FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\ROADS.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY SCHEDULE              FROM 'C:\\Users\\gusei\\Source\\SQL\\DataBase\\SCHEDULE.csv' DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;


SELECT * FROM STATIONS WHERE LEFT(CAST(station_id as VARCHAR(100)), 1) = RIGHT(CAST(station_id as VARCHAR(100)), 1);
ALTER TABLE STATIONS ALTER COLUMN station_name TYPE TEXT;
SELECT * FROM STATIONS WHERE char_length(station_name) > 8 AND LOWER(station_name) LIKE '%о%о%';
SELECT DISTINCT station_id, car_type, wait_time  FROM DISLOCATION ORDER BY wait_time;

SELECT order_id ,revenue_per_car, car_required, NKO_loaded_run_unload FROM ORDERS WHERE car_required BETWEEN 20 AND 30 OR car_required=71 OR car_required=20;

SELECT * FROM ROUTERS, STATIONS WHERE ROUTERS.station_from=STATIONS.station_id AND STATIONS.station_name='Бирюсинск' AND ROUTERS.Avg_cost>=7000 LIMIT 7 ;
SELECT order_id FROM ORDERS WHERE  must_do  IS NULL;
SELECT * FROM STATIONS WHERE STATIONS.* IS NULL;
DELETE FROM DISLOCATION WHERE id=666;
INSERT INTO DISLOCATION VALUES 

((SELECT MAX(id)+1 FROM DISLOCATION),971201,0,1,1,1,7), 
((SELECT MAX(id)+2 FROM DISLOCATION),921202,2,1,1,1,6), 
((SELECT MAX(id)+3 FROM DISLOCATION),843408,1,1,1,1,6), 
((SELECT MAX(id)+4 FROM DISLOCATION),843408,1,1,1,1,6);
SELECT * FROM DISLOCATION;


CREATE TABLE EMPTY_CARS (
	
	cars_quantity INT NOT NULL,
	car_type INT NOT NULL,
	wait_time INT NOT NULL,
	period INT NOT NULL,
	station_id INT NOT NULL
	);



INSERT INTO EMPTY_CARS(cars_quantity,car_type,wait_time, period,station_id) SELECT cars_quantity,car_type,wait_time, period, station_id FROM DISLOCATION WHERE loaded_empty=0;
SELECT * FROM EMPTY_CARS;
SELECT car_type, station_id, period FROM EMPTY_CARS GROUP BY car_type, station_id, period HAVING COUNT(*)>1;
 UPDATE STATIONS SET wait_cost = wait_cost + wait_cost * 0.02 WHERE min > 0; 