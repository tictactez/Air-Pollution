-- Creating the database 
CREATE DATABASE IF NOT EXISTS air_data;

-- Creating the Table

use air_data;
CREATE TABLE air (
    city VARCHAR(30),
    date DATE DEFAULT NULL,
    aqi SMALLINT DEFAULT NULL,
    Co DOUBLE DEFAULT NULL,
    no DOUBLE DEFAULT NULL,
    no2 DOUBLE DEFAULT NULL,
    o3 DOUBLE DEFAULT NULL,
    so2 DOUBLE DEFAULT NULL,
    pm2_5 DOUBLE DEFAULT NULL,
    pm10 DOUBLE DEFAULT NULL,
    nh3 INT DEFAULT NULL
);
  
SELECT 
    *
FROM
    air;

 -- Importing the data into mysql using data infile feature
 
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/air.csv" INTO TABLE air
 FIELDS TERMINATED BY ','
 IGNORE 1 LINES;

SELECT 
    *
FROM
    air;

-- Average Pollutant Concentration over different cities

SELECT 
    city,
    ROUND(AVG(no2), 2) AS Average_NO2,
    ROUND(AVG(o3), 2) AS Average_O3,
    ROUND(AVG(pm2_5), 2) AS Average_pm2_5,
    ROUND(AVG(pm10), 2) AS Average_pm10
FROM
    air
GROUP BY city
HAVING city IN ('Delhi' , 'Kolkata', 'Bengaluru', 'Mumbai')
ORDER BY city;

 
-- Time Series of Pollutant Concentration over different cities

SELECT
    city,
    date,
    no2,
    o3,
    pm2_5,
    pm10,
    ROW_NUMBER() OVER(PARTITION BY city ORDER BY date) AS row_num
FROM
    air
    where city in ('Delhi', 'Kolkata','Bengaluru','Mumbai');
    
    
-- Classifying air quality risk by PM2.5 Concentration

SELECT city,
CASE WHEN pm2_5 <= 50 THEN 'Good'
WHEN pm2_5 <= 100 THEN 'Moderate'
WHEN pm2_5 >= 300 THEN 'Hazardous'
ELSE 'Unhealthy' end as air_quality,
ROW_NUMBER() OVER (PARTITION BY city ORDER BY city) AS row_num
FROM air
WHERE city IN ('Delhi', 'Kolkata','Bengaluru','Mumbai');






 

