DROP TABLE IF EXISTS CARS                 CASCADE;
DROP TABLE IF EXISTS DISLOCATION          CASCADE;
DROP TABLE IF EXISTS ORDERS               CASCADE;
DROP TABLE IF EXISTS STATIONS             CASCADE;
DROP TABLE IF EXISTS STATIONS_ROADS       CASCADE;
DROP TABLE IF EXISTS SCHEDULE             CASCADE;
DROP TABLE IF EXISTS ROUTES;
DROP TABLE IF EXISTS STATIONS_OTDELENIES;
DROP TABLE IF EXISTS OTDELENIES;
DROP TABLE IF EXISTS ROADS;
DROP TABLE IF EXISTS EMPTY_CARS;

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

CREATE TABLE ROUTES (
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
    station_id                  INT NOT NULL,
    otdelenie_id                INT NOT NULL

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
\COPY ROUTES                    FROM 'DataBase/ROUTES.csv'                 DELIMITER ';' ENCODING 'WIN1251' CSV HEADER;
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
ALTER TABLE ROUTES              ADD PRIMARY KEY (route_id);
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
--SELECT * FROM ROUTES, STATIONS WHERE ROUTES.station_from=STATIONS.station_id AND STATIONS.station_name='Бирюсинск' AND ROUTES.Avg_cost>=7000 LIMIT 7 ;

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

--SELECT B.station_id, B.period, SUM(B.sum) OVER(PARTITION BY station_id, period), B.type FROM (
--   SELECT station_id, period, AVG(cars_quantity), SUM(cars_quantity), CASE WHEN loaded_empty = 1 THEN 'загружен' ELSE 'не загружен' END AS type FROM DISLOCATION
--   GROUP BY period, station_id, loaded_empty ORDER BY station_id
--) AS B
--WHERE CAST(B.station_id AS TEXT) LIKE '%0%0%' AND CAST(B.sum AS TEXT) NOT LIKE '%0%';

--Ex3
--SELECT * FROM 
--(
--    SELECT period, AVG(cars_quantity), count(DISTINCT station_id) FROM DISLOCATION GROUP BY period
--) as A WHERE (SELECT MAX(B.avg) FROM (SELECT period, AVG(cars_quantity), count(DISTINCT station_id) FROM DISLOCATION GROUP BY period) AS B) - A.avg < 5;

--Ex4
--SELECT STATIONS_UNIQUE.station_name
--FROM 
--STATIONS AS STATIONS_UNIQUE
--LEFT JOIN
--(
--    SELECT station_from FROM ORDERS 
--) AS STATIONS_FROM ON STATIONS_UNIQUE.station_id = STATIONS_FROM.station_from
--WHERE STATIONS_FROM.station_from is NULL;

--SELECT station_name FROM STATIONS WHERE station_id != ANY (SELECT id FROM A);
--SELECT COUNT(station_name) FROM STATIONS WHERE station_id != ALL (SELECT station_from FROM ORDERS);

--EX5
--SELECT station_name, STATIONS_TO.Avg_cost
--FROM 
--STATIONS AS STATIONS_UNIQUE
--LEFT JOIN
--(
--    SELECT station_to, Avg_cost FROM ROUTES WHERE Avg_cost > 7700
--) AS STATIONS_TO ON STATIONS_UNIQUE.station_id = STATIONS_TO.station_to
--WHERE STATIONS_TO.station_to IS NOT NULL;

--SELECT station_name FROM STATIONS WHERE station_id IN (SELECT station_to FROM ROUTES WHERE Avg_cost > 7700);

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
--
--
--SELECT DISTINCT (SELECT station_name FROM STATIONS WHERE station_id = station_from) ||'_to_'|| (SELECT station_name FROM STATIONS WHERE station_id = station_to) as flight
--FROM STATIONS, ORDERS
--WHERE car_required BETWEEN 29 AND 41;

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
--
--CREATE INDEX ON BIG1 (name);

--LAB 4

--Ex 1
--DROP TABLE STATIONS_OTDELENIES_NAME;
--
--CREATE TABLE STATIONS_OTDELENIES_NAME AS
--SELECT STATIONS.station_name, OTDELENIES.station_otdelenie
--FROM STATIONS, STATIONS_OTDELENIES, OTDELENIES
--WHERE
--LOWER(station_name) SIMILAR TO '([бвгджзйклмнпрстфхцчшщ]*[ауоыиэяюёе][бвгджзйклмнпрстфхцчшщ]*[\d\-\(]*){4}' AND
--STATIONS.station_id = STATIONS_OTDELENIES.station_id
--AND STATIONS_OTDELENIES.otdelenie_id = OTDELENIES.otdelenie_id;

--Ex2
--SELECT R.station_otdelenie name_road_otdel, R.station_name name_station 
--FROM
--(
--    SELECT ROW_NUMBER() OVER (PARTITION BY station_otdelenie) count, station_otdelenie, station_name
--    FROM
--    (
--        SELECT station_id, station_name FROM STATIONS
--    ) AS STATIONS, OTDELENIES, STATIONS_OTDELENIES
--    WHERE
--    STATIONS.station_id = STATIONS_OTDELENIES.station_id AND
--    OTDELENIES.otdelenie_id = STATIONS_OTDELENIES.otdelenie_id
--) AS R
--WHERE R.count <= 2
--UNION ALL
--SELECT R.station_otdelenie, station_name
--FROM
--(
--    SELECT ROW_NUMBER() OVER (PARTITION BY station_otdelenie) count, station_otdelenie, station_name
--    FROM
--    (
--        SELECT station_id, station_name FROM STATIONS
--    ) AS STATIONS, ROADS, STATIONS_ROADS 
--    WHERE
--    STATIONS.station_id = STATIONS_ROADS.station_id AND
--    ROADS.station_road_id = STATIONS_ROADS.station_road_id
--) AS R
--WHERE R.count <= 2;

--Ex3
--SELECT * FROM 
--(
--    SELECT station_to start_st, station_from finish_st, COUNT(station_id) OVER(PARTITION BY station_to) FROM 
--    (
--        SELECT station_id FROM STATIONS
--
--    ) AS STATIONS
--    INNER JOIN
--    ROUTES 
--    ON station_id = station_to OR station_id = station_from
--) AS R ORDER BY R.count;

--Ex4
--SELECT
--COUNT(*) OVER(PARTITION BY station_name), station_name, sum, wait_time
--FROM
--(
--    SELECT station_id, wait_time FROM DISLOCATION WHERE wait_time BETWEEN 0 AND 20 
--) AS DISLOCATION
--INNER JOIN
--(
--    SELECT station_id, station_name, SUM(char_length(station_name)) FROM STATIONS GROUP BY station_name, station_id
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id ORDER BY sum DESC;


--Ex5
--INSERT INTO STATIONS VALUES (7777, 'Горький', 1, 0, 600);
--INSERT INTO STATIONS VALUES (337755, 'Сладкий', 0, 1, 500);
--INSERT INTO DISLOCATION VALUES (5555, 337755, 0, 1, 1, 1, 21);


--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--INNER JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--LEFT JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--RIGHT JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--FULL OUTER JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--CROSS JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS;

--Ex6
--DROP TABLE IF EXISTS COPY_STATIONS;
--CREATE TABLE COPY_STATIONS AS SELECT * FROM STATIONS;
--DELETE FROM COPY_STATIONS WHERE max IN (SELECT max FROM STATIONS GROUP BY max HAVING COUNT(max) > 1); 
--(
--    SELECT ROW_NUMBER() OVER(ORDER BY station_name) AS row, station_name FROM STATIONS
--    WHERE station_id IN (SELECT station_to FROM ORDERS WHERE car_required > 29 AND car_required < 41)
--) AS _TO,
--(
--    SELECT ROW_NUMBER() OVER(ORDER BY station_name) AS row, station_name FROM STATIONS
--    WHERE station_id IN (SELECT station_from FROM ORDERS WHERE car_required > 29 AND car_required < 41)
--) AS _FROM
--WHERE _TO.row = _FROM.row;
--
--
--SELECT DISTINCT (SELECT station_name FROM STATIONS WHERE station_id = station_from) ||'_to_'|| (SELECT station_name FROM STATIONS WHERE station_id = station_to) as flight
--FROM STATIONS, ORDERS
--WHERE car_required BETWEEN 29 AND 41;

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
--
--CREATE INDEX ON BIG1 (name);

--LAB 4

--Ex 1
--DROP TABLE STATIONS_OTDELENIES_NAME;
--
--CREATE TABLE STATIONS_OTDELENIES_NAME AS
--SELECT
--    STATIONS.station_name, OTDELENIES.station_otdelenie
--FROM
--    STATIONS, STATIONS_OTDELENIES, OTDELENIES
--WHERE
--    LOWER(station_name) SIMILAR TO'([бвгджзйклмнпрстфхцчшщ]*[ауоыиэяюёе][бвгджзйклмнпрстфхцчшщ]*[\-\(]*){4}' AND
--    STATIONS.station_id = STATIONS_OTDELENIES.station_id AND
--    STATIONS_OTDELENIES.otdelenie_id = OTDELENIES.otdelenie_id;
--
--Ex2
--SELECT
--    R.station_otdelenie name_road_otdel, R.station_name name_station 
--FROM
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY station_otdelenie) count, station_otdelenie, station_name
--    FROM
--    (
--        SELECT station_id, station_name FROM STATIONS
--    ) AS STATIONS, OTDELENIES, STATIONS_OTDELENIES
--    WHERE
--        STATIONS.station_id = STATIONS_OTDELENIES.station_id AND
--        OTDELENIES.otdelenie_id = STATIONS_OTDELENIES.otdelenie_id
--) AS R
--WHERE R.count <= 2
--UNION ALL
--SELECT
--    R.station_otdelenie, station_name
--FROM
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY station_otdelenie) count, station_otdelenie, station_name
--    FROM
--    (
--        SELECT station_id, station_name FROM STATIONS
--    ) AS STATIONS, ROADS, STATIONS_ROADS 
--    WHERE
--        STATIONS.station_id = STATIONS_ROADS.station_id AND
--        ROADS.station_road_id = STATIONS_ROADS.station_road_id
--) AS R
--WHERE R.count <= 2;

SELECT RRESULT.otdel, RRESULT.road, RRESULT.station_name, RRESULT.num FROM
(
    SELECT ROW_NUMBER() OVER(PARTITION BY RESULT.otdel, RESULT.road) as count,
    RESULT.otdel, RESULT.road, RESULT.station_name_otdel station_name,
    COUNT(*) OVER(ORDER BY RESULT.otdel, RESULT.road) as num
    FROM
    (
        (
            SELECT * FROM    
            (
                SELECT
                    station_otdelenie as otdel, station_name as station_name_otdel
                FROM
                (
                    SELECT station_id, station_name FROM STATIONS
                ) AS STATIONS, ROADS, STATIONS_ROADS 
                WHERE
                    STATIONS.station_id = STATIONS_ROADS.station_id AND
                    ROADS.station_road_id = STATIONS_ROADS.station_road_id
            ) AS O
        ) AS O 
        INNER JOIN
        (
            SELECT * FROM 
            (
                SELECT
                    station_otdelenie as road, station_name as station_name_road
                FROM
                (
                    SELECT station_id, station_name FROM STATIONS
                ) AS STATIONS, OTDELENIES, STATIONS_OTDELENIES
                WHERE
                    STATIONS.station_id = STATIONS_OTDELENIES.station_id AND
                    OTDELENIES.otdelenie_id = STATIONS_OTDELENIES.otdelenie_id
            ) AS R    
        ) AS R
        ON R.station_name_road = O.station_name_otdel
    ) AS RESULT
) AS RRESULT WHERE RRESULT.count <= 2;

--Ex3
--SELECT * FROM 
--(
--    SELECT station_to start_st, station_from finish_st, COUNT(station_id) OVER(PARTITION BY station_to) FROM 
--    (
--        SELECT station_id FROM STATIONS
--
--    ) AS STATIONS
--    INNER JOIN
--    ROUTES 
--    ON station_id = station_to OR station_id = station_from
--) AS R ORDER BY R.count LIMIT 5;

--Ex4
--SELECT
--COUNT(*) OVER(PARTITION BY station_name), station_name, sum, wait_time
--FROM
--(
--    SELECT station_id, wait_time FROM DISLOCATION WHERE wait_time BETWEEN 0 AND 20 
--) AS DISLOCATION
--INNER JOIN
--(
--    SELECT station_id, station_name, SUM(char_length(station_name)) FROM STATIONS GROUP BY station_name, station_id
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id ORDER BY sum DESC;


--Ex5
--INSERT INTO STATIONS VALUES (7777, 'Горький', 1, 0, 600);
--INSERT INTO STATIONS VALUES (337755, 'Сладкий', 0, 1, 500);
--INSERT INTO DISLOCATION VALUES (5555, 337755, 0, 1, 1, 1, 21);


--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--INNER JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--LEFT JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--RIGHT JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--FULL OUTER JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS
--ON DISLOCATION.station_id = STATIONS.station_id;

--SELECT * FROM 
--(
--    SELECT * FROM DISLOCATION
--) AS DISLOCATION
--CROSS JOIN
--(
--    SELECT * FROM STATIONS
--) AS STATIONS;

--Ex6
--DROP TABLE IF EXISTS COPY_STATIONS;
--CREATE TABLE COPY_STATIONS AS SELECT * FROM STATIONS;
--DELETE FROM COPY_STATIONS WHERE max IN (SELECT max FROM STATIONS GROUP BY max HAVING COUNT(max) > 1); 

--Ex7
--SELECT * FROM 
--(
--    SELECT ROW_NUMBER() OVER (PARTITION BY STATIONS.station_id ORDER BY STATIONS.station_id) AS row, 
--    STATIONS.station_id, STATIONS.station_to, STATIONS.station_from,
--    CASE WHEN must_do = 1 THEN 'обязательная' ELSE 'необязательная' END
--    FROM
--    (
--        (
--            SELECT station_to, station_from, must_do FROM ORDERS
--        ) AS ORDERS
--        JOIN 
--        (
--            SELECT station_id FROM DISLOCATION 
--        ) AS STATIONS 
--        ON station_id = station_from
--    ) AS STATIONS
--    INNER JOIN
--    (
--        SELECT * FROM ROUTES ORDER BY Avg_cost
--    ) AS ROUTES
--    ON STATIONS.station_id = ROUTES.station_to
--) AS RESULT
--WHERE RESULT.row <= 5;

--Ex8
--SELECT COUNT(*), R.station_id, STATIONS.station_name FROM
--(
--    SELECT * FROM 
--    (
--        SELECT ROW_NUMBER() OVER (PARTITION BY STATIONS.station_id ORDER BY STATIONS.station_id) AS row, 
--        STATIONS.station_id
--        FROM
--        (
--            (
--                SELECT station_to, station_from, must_do FROM ORDERS
--            ) AS ORDERS
--            JOIN 
--            (
--                SELECT station_id FROM DISLOCATION 
--            ) AS STATIONS 
--            ON station_id = station_from
--        ) AS STATIONS
--        INNER JOIN
--        (
--            SELECT * FROM ROUTES ORDER BY Avg_cost
--        ) AS ROUTES
--        ON STATIONS.station_id = ROUTES.station_to
--    ) AS RESULT
--    WHERE RESULT.row <= 5
--) AS R, STATIONS
--WHERE R.station_id = STATIONS.station_id
--GROUP BY R.station_id, STATIONS.station_name
--ORDER BY R.station_id;

--Ex9
--SELECT RESULT.station_from, RESULT.case as type FROM 
--(
--    SELECT ROW_NUMBER() OVER (PARTITION BY ORDERS.station_from ORDER BY ORDERS.station_from) AS row, 
--    ORDERS.station_from,
--    CASE WHEN must_do = 1 THEN 'обязательная' ELSE 'необязательная' END
--    FROM
--    (
--        SELECT station_to, station_from, must_do FROM ORDERS
--    ) AS ORDERS
--    INNER JOIN
--    ROUTES
--    ON ORDERS.station_from = ROUTES.station_to AND ORDERS.station_to = ROUTES.station_from
--) AS RESULT
--WHERE RESULT.row <= 5;

--Ex10
--SELECT R.row, R.station_from, STATIONS.station_name FROM 
--(
--    SELECT * FROM
--    (
--        SELECT ROW_NUMBER() OVER (PARTITION BY ORDERS.station_from ORDER BY ORDERS.station_from) AS row, 
--        ORDERS.station_from, ORDERS.station_to,
--        CASE WHEN must_do = 1 THEN 'обязательная' ELSE 'необязательная' END
--        FROM
--        (
--            SELECT station_to, station_from, must_do FROM ORDERS
--        ) AS ORDERS
--        INNER JOIN
--        ROUTES
--        ON ORDERS.station_from = ROUTES.station_to AND ORDERS.station_to = ROUTES.station_from
--    ) AS RESULT
--    WHERE RESULT.row <= 5
--) AS R, STATIONS
--WHERE R.station_to = STATIONS.station_id
--ORDER BY R.station_from;

--Ex11
--SELECT station_id, station_from, station_to 
--FROM
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY station_id ORDER BY station_id) AS row,
--        station_id, ROUTES.station_from, ROUTES.station_to
--    FROM
--    (
--        SELECT DISTINCT
--            station_id, station_from, station_to
--        FROM
--        (
--            SELECT
--                ORDERS.station_from, ORDERS.station_to 
--            FROM
--                ORDERS
--            WHERE
--                ORDERS.must_do = 1
--            EXCEPT 
--            SELECT
--                ORDERS.station_from, ORDERS.station_to
--            FROM
--                ORDERS, ROUTES
--            WHERE
--                ORDERS.station_from = ROUTES.station_from AND
--                ORDERS.station_to = ROUTES.station_from AND
--                ORDERS.must_do = 1
--        ) AS ORDERS, DISLOCATION
--        WHERE
--            DISLOCATION.station_id = ORDERS.station_from OR
--            DISLOCATION.station_id = ORDERS.station_to
--    ) AS DISLOCATION, ROUTES
--    WHERE
--        DISLOCATION.station_id = DISLOCATION.station_to AND
--        DISLOCATION.station_from = ROUTES.station_to
--        OR
--        DISLOCATION.station_id = DISLOCATION.station_from AND
--        DISLOCATION.station_to = ROUTES.station_from
--) AS DISLOCATION
--WHERE
--    row <= 5;

--Ex12
--SELECT row count, station_id, station_from, station_to 
--FROM
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY station_id ORDER BY station_id) AS row,
--        station_id, ROUTES.station_from, ROUTES.station_to
--    FROM
--    (
--        SELECT DISTINCT
--            station_id, station_from, station_to
--        FROM
--        (
--            SELECT
--                ORDERS.station_from, ORDERS.station_to 
--            FROM
--                ORDERS
--            WHERE
--                ORDERS.must_do = 1
--            EXCEPT 
--            SELECT
--                ORDERS.station_from, ORDERS.station_to
--            FROM
--                ORDERS, ROUTES
--            WHERE
--                ORDERS.station_from = ROUTES.station_from AND
--                ORDERS.station_to = ROUTES.station_from AND
--                ORDERS.must_do = 1
--        ) AS ORDERS, DISLOCATION
--        WHERE
--            DISLOCATION.station_id = ORDERS.station_from OR
--            DISLOCATION.station_id = ORDERS.station_to
--    ) AS DISLOCATION, ROUTES
--    WHERE
--        DISLOCATION.station_id = DISLOCATION.station_to AND
--        DISLOCATION.station_from = ROUTES.station_to
--        OR
--        DISLOCATION.station_id = DISLOCATION.station_from AND
--        DISLOCATION.station_to = ROUTES.station_from
--) AS DISLOCATION
--WHERE
--    row <= 5;

--Ex13 (7, 9, 11)
--SELECT
--    RESULT.station_id, RESULT.station_to, RESULT.station_from  pp
--FROM 
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY DISLOCATION.station_id ORDER BY DISLOCATION.station_id) AS row, 
--        DISLOCATION.station_id, DISLOCATION.station_to, DISLOCATION.station_from,
--    CASE WHEN must_do = 1 THEN 'обязательная' ELSE 'необязательная' END
--    FROM
--    (
--        (
--            SELECT station_to, station_from, must_do FROM ORDERS
--        ) AS ORDERS
--        JOIN 
--        (
--            SELECT station_id FROM DISLOCATION 
--        ) AS DISLOCATION 
--        ON station_id = station_from
--    ) AS DISLOCATION
--    INNER JOIN
--    (
--        SELECT * FROM ROUTES ORDER BY Avg_cost
--    ) AS ROUTES
--    ON DISLOCATION.station_id = ROUTES.station_to
--) AS RESULT
--WHERE
--    RESULT.row <= 5
--UNION
--SELECT
--    RESULT.order_id, RESULT.station_to, RESULT.station_from 
--FROM
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY ORDERS.station_from ORDER BY ORDERS.station_from) AS row,
--        ORDERS.station_to, ORDERS.station_from, ORDERS.order_id,
--        CASE WHEN must_do = 1 THEN 'обязательная' ELSE 'необязательная' END
--    FROM
--    (
--        SELECT order_id, station_to, station_from, must_do FROM ORDERS
--    ) AS ORDERS
--    INNER JOIN
--    ROUTES ON 
--        ORDERS.station_from = ROUTES.station_to AND 
--        ORDERS.station_to = ROUTES.station_from
--) AS RESULT
--WHERE
--    RESULT.row <= 5
--UNION
--SELECT
--    station_id, station_from, station_to 
--FROM
--(
--    SELECT
--        ROW_NUMBER() OVER (PARTITION BY station_id ORDER BY station_id) AS row,
--        station_id, ROUTES.station_from, ROUTES.station_to
--    FROM
--    (
--        SELECT DISTINCT
--            station_id, station_from, station_to
--        FROM
--        (
--            SELECT
--                ORDERS.station_from, ORDERS.station_to 
--            FROM
--                ORDERS
--            WHERE
--                ORDERS.must_do = 1
--            EXCEPT 
--            SELECT
--                ORDERS.station_from, ORDERS.station_to
--            FROM
--                ORDERS, ROUTES
--            WHERE
--                ORDERS.station_from = ROUTES.station_from AND
--                ORDERS.station_to = ROUTES.station_from AND
--                ORDERS.must_do = 1
--        ) AS ORDERS, DISLOCATION
--        WHERE
--            DISLOCATION.station_id = ORDERS.station_from OR
--            DISLOCATION.station_id = ORDERS.station_to
--    ) AS DISLOCATION, ROUTES
--    WHERE
--        DISLOCATION.station_id = DISLOCATION.station_to AND
--        DISLOCATION.station_from = ROUTES.station_to
--        OR
--        DISLOCATION.station_id = DISLOCATION.station_from AND
--        DISLOCATION.station_to = ROUTES.station_from
--) AS DISLOCATION
--WHERE
--    row <= 5 ORDER BY station_id DESC;

