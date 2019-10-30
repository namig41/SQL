--START
DROP TABLE CARS                 CASCADE;
DROP TABLE DISLOCATION          CASCADE;
DROP TABLE ORDERS               CASCADE;
DROP TABLE ROUTERS;
DROP TABLE STATIONS             CASCADE;
DROP TABLE STATIONS_ROADS       CASCADE;
DROP TABLE STATIONS_OTDELENIES;
DROP TABLE OTDELENIES;
DROP TABLE ROADS;
DROP TABLE SCHEDULE             CASCADE;
DROP TABLE EMPTY_CARS;
DROP TABLE BIG;

CREATE TABLE CARS (
    car_type_id                 INT NOT NULL,
    car_type_name               VARCHAR(100) NOT NULL
);

CREATE TABLE DISLOCATION (
    id                          INT NOT NULL,
    station_id                  INT NOT NULL,
    loaded_empty                INT NOT NULL,
    cars_quantity               INT NOT NULL,
    car_type                    INT NOT NULL,
    period                      INT NOT NULL,
    wait_time                   INT NOT NULL
);


CREATE TABLE ORDERS (
    order_id                    INT NOT NULL,
    station_from                INT NOT NULL,
    station_to                  INT NOT NULL,
    revenue_per_car             FLOAT NOT NULL,
    car_required                INT NOT NULL,
    car_type                    INT NOT NULL,
    NKO_load                    FLOAT NOT NULL,
    NKO_loaded_run_unload       FLOAT NOT NULL,
    must_do                     INT
);

CREATE TABLE ROUTERS (
    route_id                    INT NOT NULL,
    station_from                INT NOT NULL,
    station_to                  INT NOT NULL,
    Avg_cost                    INT NOT NULL
);

CREATE TABLE STATIONS (
    station_id                  INT NOT NULL,
    station_name                VARCHAR(100) NOT NULL,
    min                         INT NOT NULL,
    max                         INT NOT NULL,
    wait_cost                   INT NOT NULL
);

CREATE TABLE STATIONS_ROADS (
    station_id                  INT NOT NULL,
    station_road_id             INT NOT NULL
);

CREATE TABLE STATIONS_OTDELENIES (
    station_id                 INT NOT NULL,
    otdelenie_id               INT NOT NULL

);

CREATE TABLE OTDELENIES (
    otdelenie_id                INT NOT NULL,
    station_otdelenie           VARCHAR(100) NOT NULL
);

CREATE TABLE ROADS (
    station_road_id             INT NOT NULL,
    station_otdelenie           VARCHAR(100) NOT NULL
);

CREATE TABLE SCHEDULE (
    order_id                    INT NOT NULL,
    period                      INT NOT NULL,
    Sum_cars_quatity            INT NOT NULL
);

CREATE TABLE EMPTY_CARS (
	
	cars_quantity               INT NOT NULL,
	car_type                    INT NOT NULL,
	wait_time                   INT NOT NULL,
	period                      INT NOT NULL,
	station_id                  INT NOT NULL
);

\COPY CARS                  FROM 'DataBase/CARS.csv'                    DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY DISLOCATION           FROM 'DataBase/DISLOCATON.csv'              DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ORDERS                FROM 'DataBase/ORDERS.csv'                  DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ROUTERS               FROM 'DataBase/ROUTERS.csv'                 DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS              FROM 'DataBase/STATIONS.csv'                DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS_ROADS        FROM 'DataBase/STATIONS_ROADS.csv'          DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS_OTDELENIES   FROM 'DataBase/STATIONS_OTDELENIES.csv'     DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY OTDELENIES            FROM 'DataBase/OTDELENIES.csv'              DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ROADS                 FROM 'DataBase/ROADS.csv'                   DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY SCHEDULE              FROM 'DataBase/SCHEDULE.csv'                DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;

--PRIMARY KEYS
ALTER TABLE STATIONS            ADD PRIMARY KEY (station_id);
ALTER TABLE DISLOCATION         ADD PRIMARY KEY (id);
ALTER TABLE ORDERS              ADD PRIMARY KEY (order_id);
ALTER TABLE CARS                ADD PRIMARY KEY (car_type_id);
ALTER TABLE OTDELENIES          ADD PRIMARY KEY (otdelenie_id);
ALTER TABLE ROUTERS             ADD PRIMARY KEY (route_id);
ALTER TABLE STATIONS_OTDELENIES ADD PRIMARY KEY (station_id);
ALTER TABLE ROADS               ADD PRIMARY KEY (station_road_id);
ALTER TABLE SCHEDULE            ADD PRIMARY KEY (order_id, period);

--FOREIGN KEY 
ALTER TABLE DISLOCATION         ADD FOREIGN KEY (car_type)          REFERENCES CARS(car_type_id);
ALTER TABLE DISLOCATION         ADD FOREIGN KEY (station_id)        REFERENCES STATIONS(station_id);
ALTER TABLE ORDERS              ADD FOREIGN KEY (car_type)          REFERENCES CARS(car_type_id);
ALTER TABLE ORDERS              ADD FOREIGN KEY (station_from)      REFERENCES STATIONS(station_id);
ALTER TABLE ORDERS              ADD FOREIGN KEY (station_to)        REFERENCES STATIONS(station_id);
ALTER TABLE SCHEDULE            ADD FOREIGN KEY (order_id)          REFERENCES ORDERS(order_id);
ALTER TABLE STATIONS_ROADS      ADD FOREIGN KEY (station_id)        REFERENCES STATIONS(station_id);
ALTER TABLE STATIONS_ROADS      ADD FOREIGN KEY (station_road_id)   REFERENCES ROADS(station_road_id);
ALTER TABLE STATIONS_OTDELENIES ADD FOREIGN KEY (station_id)        REFERENCES STATIONS(station_id);
ALTER TABLE STATIONS_OTDELENIES ADD FOREIGN KEY (otdelenie_id)      REFERENCES OTDELENIES(otdelenie_id);

--LAB 1

--Ex1
--SELECT * FROM STATIONS WHERE LEFT(CAST(station_id as VARCHAR(100)), 1) = RIGHT(CAST(station_id as VARCHAR(100)), 1);

--Ex2
--SELECT * FROM STATIONS WHERE char_length(CAST(station_name AS TEXT)) > 8 AND LOWER(CAST(station_name AS TEXT)) LIKE '%о%о%';

--Ex3
--SELECT DISTINCT station_id, car_type, wait_time  FROM DISLOCATION ORDER BY wait_time DESC;

--Ex4
--SELECT * FROM ROUTERS, STATIONS WHERE ROUTERS.station_from=STATIONS.station_id AND STATIONS.station_name='Бирюсинск' AND ROUTERS.Avg_cost>=7000 LIMIT 7 ;

--Ex5
--SELECT order_id ,revenue_per_car, car_required, NKO_loaded_run_unload FROM ORDERS WHERE car_required BETWEEN 20 AND 30 OR car_required=71 OR car_required=20;

--Ex6
--SELECT order_id FROM ORDERS WHERE  must_do  IS NULL;

--Ex7
--SELECT * FROM STATIONS WHERE STATIONS.* IS NULL;

--Ex8
--DELETE FROM DISLOCATION WHERE id=666;
--INSERT INTO DISLOCATION VALUES 
--
--((SELECT MAX(id)+1 FROM DISLOCATION),971201,0,1,1,1,7), 
--((SELECT MAX(id)+2 FROM DISLOCATION),921202,2,1,1,1,6), 
--((SELECT MAX(id)+3 FROM DISLOCATION),843408,1,1,1,1,6), 
--((SELECT MAX(id)+4 FROM DISLOCATION),843408,1,1,1,1,6);
--SELECT * FROM DISLOCATION;
--
--
--
--INSERT INTO EMPTY_CARS(cars_quantity,car_type,wait_time, period,station_id) SELECT cars_quantity,car_type,wait_time, period, station_id FROM DISLOCATION WHERE loaded_empty=0;
--SELECT * FROM EMPTY_CARS;
--SELECT car_type, station_id, period FROM EMPTY_CARS GROUP BY car_type, station_id, period HAVING COUNT(*)>1;

--Ex9
--UPDATE STATIONS SET wait_cost = 1.2 * wait_cost WHERE min > 0; 

--LAB 2

--Ex 1
--SELECT
--STATIONS_MAX.station_name, STATIONS_MAX.wait_cost max_cost,
--STATIONS_MIN.station_name, STATIONS_MIN.wait_cost min_cost
--FROM 
--    STATIONS AS STATIONS_MAX
--    INNER JOIN
--    (
--        SELECT MAX(wait_cost) max_wait_cost FROM STATIONS
--    ) AS MAX_COST ON STATIONS_MAX.wait_cost = MAX_COST.max_wait_cost
--FULL OUTER JOIN
--(
--    STATIONS AS STATIONS_MIN
--    INNER JOIN
--    (
--        SELECT MIN(wait_cost) min_wait_cost FROM STATIONS
--    ) AS MIN_COST ON STATIONS_MIN.wait_cost = MIN_COST.min_wait_cost
--) AS STATIONS_MIN ON STATIONS_MIN.station_name = STATIONS_MAX.station_name;

--Ex2
--SELECT GET_LOADED_WAGON.station_id, GET_LOADED_WAGON.period,
--GET_LOADED_WAGON.cars_quantity loaded_wagon, GET_UNLOADED_WAGON.cars_quantity unloaded_wagon,
--GET_UNLOADED_WAGON.cars_quantity + GET_LOADED_WAGON.cars_quantity sum_cars_quatity
--FROM DISLOCATION AS GET_LOADED_WAGON
--INNER JOIN
--(
--    SELECT loaded_empty FROM DISLOCATION WHERE loaded_empty = 1
--) AS GET_LOADED ON GET_LOADED_WAGON.loaded_empty = GET_LOADED.loaded_empty
--LEFT JOIN
--(
--    SELECT GET_WAGON.cars_quantity, GET_WAGON.loaded_empty, GET_WAGON.id FROM DISLOCATION AS GET_WAGON
--    INNER JOIN
--    (
--        SELECT loaded_empty FROM DISLOCATION WHERE loaded_empty = 0
--    ) AS GET_UNLOADED ON GET_WAGON.loaded_empty = GET_UNLOADED.loaded_empty
--) AS GET_UNLOADED_WAGON ON GET_LOADED_WAGON.id != GET_UNLOADED_WAGON.id
--WHERE CAST(GET_LOADED_WAGON.station_id AS TEXT) LIKE '%0%0'
--ORDER BY GET_LOADED_WAGON.wait_time DESC
--LIMIT 10;

--Ex4
--SELECT STATIONS_UNIQUE.station_name
--FROM 
--STATIONS AS STATIONS_UNIQUE
--LEFT JOIN
--(
--    SELECT station_from FROM ROUTERS
--) AS STATIONS_FROM ON STATIONS_UNIQUE.station_id = STATIONS_FROM.station_from
--WHERE STATIONS_FROM.station_from is NULL;

--EX5
--SELECT station_name, STATIONS_TO.Avg_cost
--FROM 
--STATIONS AS STATIONS_UNIQUE
--LEFT JOIN
--(
--    SELECT station_to, Avg_cost FROM ROUTERS WHERE Avg_cost > 7700
--) AS STATIONS_TO ON STATIONS_UNIQUE.station_id = STATIONS_TO.station_to
--WHERE STATIONS_TO.station_to IS NOT NULL;

-- Ex6
--SELECT STATIONS_FROM.station_name || ' to ' || STATIONS_TO.station_name flights
--FROM
--STATIONS AS STATIONS_FROM
--INNER JOIN
--(
--    SELECT station_from FROM ROUTERS
--    INNER JOIN
--    (
--        SELECT station_id FROM DISLOCATION WHERE period > 10 AND period < 41
--    ) AS _PERIOD ON (ROUTERS.station_from = _PERIOD.station_id)
--) AS _FROM ON _FROM.station_from = STATIONS_FROM.station_id,
--STATIONS AS STATIONS_TO
--INNER JOIN
--(
--    SELECT station_to FROM ROUTERS
--    INNER JOIN
--    (
--        SELECT station_id FROM DISLOCATION WHERE period > 10 AND period < 41
--    ) AS _PERIOD ON (ROUTERS.station_from = _PERIOD.station_id)
--) AS _TO ON _TO.station_to = STATIONS_TO.station_id LIMIT 5;

--Ex7
--CREATE TABLE BIG (
--    count INT NOT NULL
--);
--
--\COPY BIG                  FROM 'DataBase/BIG.csv'                    DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
--ALTER TABLE BIG ADD PRIMARY KEY (count);
--CREATE INDEX ON BIG (count) WITH ();