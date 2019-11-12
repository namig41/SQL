DROP TABLE IF EXISTS CARS                 CASCADE;
DROP TABLE IF EXISTS DISLOCATION          CASCADE;
DROP TABLE IF EXISTS ORDERS               CASCADE;
DROP TABLE IF EXISTS ROUTERS;
DROP TABLE IF EXISTS STATIONS             CASCADE;
DROP TABLE IF EXISTS STATIONS_ROADS       CASCADE;
DROP TABLE IF EXISTS STATIONS_OTDELENIES;
DROP TABLE IF EXISTS OTDELENIES;
DROP TABLE IF EXISTS ROADS;
DROP TABLE IF EXISTS SCHEDULE             CASCADE;
DROP TABLE IF EXISTS EMPTY_CARS;
DROP TABLE IF EXISTS BIG1;
DROP TABLE IF EXISTS BIG2;

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

\COPY CARS                      FROM 'DataBase/CARS.csv'                    DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY DISLOCATION               FROM 'DataBase/DISLOCATON.csv'              DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ORDERS                    FROM 'DataBase/ORDERS.csv'                  DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ROUTERS                   FROM 'DataBase/ROUTERS.csv'                 DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS                  FROM 'DataBase/STATIONS.csv'                DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS_ROADS            FROM 'DataBase/STATIONS_ROADS.csv'          DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY STATIONS_OTDELENIES       FROM 'DataBase/STATIONS_OTDELENIES.csv'     DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY OTDELENIES                FROM 'DataBase/OTDELENIES.csv'              DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY ROADS                     FROM 'DataBase/ROADS.csv'                   DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
\COPY SCHEDULE                  FROM 'DataBase/SCHEDULE.csv'                DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;

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
--SELECT station_name, wait_cost, 'max' type_cost FROM STATIONS WHERE wait_cost=(SELECT MAX(wait_cost) FROM STATIONS)
--UNION ALL
--SELECT station_name, wait_cost, 'min' FROM STATIONS WHERE wait_cost=(SELECT MIN(wait_cost) FROM STATIONS);

--Ex2
--SELECT DISTINCT
--avg_cars.id, avg_cars.avg_period, avg_cars.loaded_avg, avg_cars.unloaded_avg, foo.sum_cars
--FROM 
--(
--    (
--        SELECT LOADED_CARS.LOADED_CARS_period avg_period, LOADED_CARS.avg loaded_avg, 
--        UNLOADED_CARS.avg unloaded_avg, LOADED_CARS.id id FROM
--        (
--            (
--                SELECT AVG(cars_quantity) avg, period LOADED_CARS_period,station_id id FROM DISLOCATION
--                WHERE loaded_empty = 1 GROUP BY station_id, period
--            ) AS LOADED_CARS
--            INNER JOIN
--            (
--                SELECT AVG(cars_quantity) avg, period UNLOADED_CARS_period, station_id id FROM DISLOCATION
--                WHERE loaded_empty = 0 GROUP BY station_id, period
--            ) AS UNLOADED_CARS
--            ON LOADED_CARS.LOADED_CARS_period = UNLOADED_CARS.UNLOADED_CARS_period AND LOADED_CARS.id = UNLOADED_CARS.id
--        )
--    ) AS avg_cars 
--    INNER JOIN
--    ( 
--        SELECT SUM(cars_quantity) sum_cars, period SUM_CARS_period, station_id id FROM DISLOCATION GROUP BY station_id, period
--    ) AS foo
--    ON foo.SUM_CARS_period = avg_cars.avg_period and foo.id = avg_cars.id
--) WHERE CAST(avg_cars.id AS TEXT) LIKE '%0%0%' AND CAST(foo.sum_cars AS TEXT) NOT LIKE '%0%' ORDER BY avg_cars.avg_period DESC;

--Ex3
--SELECT D.count, D.avg, D.period FROM
--(
--    (
--        SELECT count(*), A.period FROM
--        (
--            SELECT count(*) as count,station_id, period FROM DISLOCATION GROUP BY period,station_id ORDER BY period,station_id
--        ) as A GROUP BY A.period
--    ) AS K
--    LEFT JOIN
--    (
--        SELECT AVG(cars_quantity), period per FROM DISLOCATION GROUP BY period
--    ) AS C ON K.period=C.per
--) AS D 
--WHERE ABS((SELECT MAX(F.avg) FROM (SELECT AVG(cars_quantity), period per FROM DISLOCATION GROUP BY period)as F) - D.avg) < 5

--Ex4
--SELECT STATIONS_UNIQUE.station_name
--FROM 
--STATIONS AS STATIONS_UNIQUE
--LEFT JOIN
--(
--    SELECT station_from FROM ORDERS 
--) AS STATIONS_FROM ON STATIONS_UNIQUE.station_id = STATIONS_FROM.station_from
--WHERE STATIONS_FROM.station_from is NULL;

--SELECT station_name FROM STATIONS WHERE station_id NOT IN (SELECT station_from FROM ORDERS);
--SELECT station_name FROM STATIONS WHERE station_id != ALL (SELECT station_from FROM ORDERS);

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
--SELECT _FROM.station_name || ' to ' ||  _TO.station_name AS flight 
--FROM 
--(
--    SELECT ROW_NUMBER() OVER(ORDER BY station_name) AS row, station_name FROM STATIONS
--    WHERE station_id IN (SELECT station_to FROM ORDERS WHERE car_required > 29 AND car_required < 41)
--) AS _TO,
--(
--    SELECT ROW_NUMBER() OVER(ORDER BY station_name) AS row, station_name FROM STATIONS
--    WHERE station_id IN (SELECT station_from FROM ORDERS WHERE car_required > 29 AND car_required < 41)
--) AS _FROM
--WHERE _TO.row = _FROM.row;

--Ex7
--CREATE TABLE BIG1 (
--    id      INT NOT NULL,
--    name    TEXT NOT NULL,
--    surname TEXT NOT NULL,
--    age     INT NOT NULL
--);
--
--CREATE TABLE BIG2 (
--    id      INT NOT NULL,
--    name    TEXT NOT NULL,
--    surname TEXT NOT NULL,
--    age     INT NOT NULL
--);
--
--\COPY BIG1                 FROM 'DataBase/BIG.csv'                    DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
--\COPY BIG2                 FROM 'DataBase/BIG.csv'                    DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
--
--ALTER TABLE BIG1 ADD PRIMARY KEY (id);
--ALTER TABLE BIG2 ADD PRIMARY KEY (id);
--
--CREATE INDEX ON BIG1 (name);
