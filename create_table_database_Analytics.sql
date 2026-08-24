---create database
CREATE DATABASE Weather_Analytics;
GO

USE Weather_Analytics;
GO

------create table
CREATE TABLE Weather_Data
(
    Weather_ID BIGINT IDENTITY(1,1) PRIMARY KEY,
    [Date/Time] DATETIME2,
    City VARCHAR(50),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Temp_C DECIMAL(6,2),
    [Dew Point Temp_C] DECIMAL(6,2),
    [Rel Hum_%] INT,
    [Wind Speed_km/h] DECIMAL(8,2),
    Visibility_km DECIMAL(8,2),
    Press_kPa DECIMAL(8,2),
    Weather INT,
    Weather_Name VARCHAR(50)
);
--check data
select * from Weather_Data;
select count(*) from Weather_Data;--278400 rows
---check city
SELECT COUNT(DISTINCT City) AS Total_Cities
FROM Weather_Data;---50 cities

                                            ----EDA PART-------
----Top 10 hottest city
SELECT TOP 10
    City,
    ROUND(AVG(Temp_C), 2) AS Avg_Temp_C
FROM Weather_Data
GROUP BY City
ORDER BY Avg_Temp_C DESC;
---insights
--Madurai is the hottest city avg_temp_C = 29.98
--City	            Avg_Temp_C
--Madurai	         29.98
--Ahmedabad	         29.83
--Vijayawada	     29.82
--Nagpur	         29.57
--Chennai	         29.38
--Vadodara	         29.31
--Raipur	         28.73
--Navi Mumbai	     28.69
--Surat	             28.60
--Jodhpur	         28.53

--Top 10 coldest cities
SELECT TOP 10
    City,
    ROUND(AVG(Temp_C), 2) AS Avg_Temp_C
FROM Weather_Data
GROUP BY City
ORDER BY Avg_Temp_C ASC;
---City	    Avg_Temp_C
--Srinagar	13.02
--Dehradun	21.71
--Ranchi	23.95
--Guwahati	24.07
--Chandigarh	24.28
--Amritsar	24.34
--Bengaluru	24.77
--Ludhiana	24.83
--Mysuru	24.93
--Meerut	24.97

--- Top 10 Highest temperature recorded city
SELECT TOP 10
    City,
    [Date/Time],
    Temp_C
FROM Weather_Data
ORDER BY Temp_C DESC;
--City	Date/Time	                       Temp_C
--Kota	2026-05-28 14:00:00.0000000	        45.40
--Kota	2026-05-18 14:00:00.0000000	        45.00
--Kota	2026-05-18 13:00:00.0000000	        44.80
--Kota	2026-05-28 13:00:00.0000000	        44.80
--Nagpur	2026-04-26 13:00:00.0000000	    44.80
--Nagpur	2026-05-20 14:00:00.0000000	    44.80
--Kota	2026-05-18 15:00:00.0000000	        44.70
--Nagpur	2026-05-20 13:00:00.0000000	    44.70
--Ahmedabad	2026-05-11 16:00:00.0000000	    44.60
--Nagpur	2026-05-19 14:00:00.0000000	    44.60

--Lowest temperature recorded 
SELECT TOP 10
    City,
    [Date/Time],
    Temp_C
FROM Weather_Data
ORDER BY Temp_C ASC;

---City	    Date/Time	                 Temp_C
--Srinagar	2026-02-05 04:00:00.0000000	-12.40
--Srinagar	2026-02-05 07:00:00.0000000	-12.20
--Srinagar	2026-01-26 02:00:00.0000000	-11.90
--Srinagar	2026-02-05 03:00:00.0000000	-11.90
--Srinagar	2026-01-26 03:00:00.0000000	-11.80
--Srinagar	2026-02-08 07:00:00.0000000	-11.80
--Srinagar	2026-01-26 04:00:00.0000000	-11.70
--Srinagar	2026-02-05 08:00:00.0000000	-11.40
--Srinagar	2026-02-06 04:00:00.0000000	-11.40
--Srinagar	2026-02-05 02:00:00.0000000	-11.30

--Most humid cities
SELECT TOP 10
    City,
    ROUND(AVG([Rel Hum_%]), 2) AS Avg_Humidity
FROM Weather_Data
GROUP BY City
ORDER BY Avg_Humidity DESC;
--City	              Avg_Humidity
--Guwahati	            82
--Thiruvananthapuram	80
--Kochi	                79
--Howrah	            77
--Bhubaneswar	        75
--Kolkata	            73
--Visakhapatnam	        73
--Srinagar	            71
--Mumbai	            68
--Chennai	            68

--Highest wind-speed cities 
SELECT TOP 10
    City,
    [Date/Time],
    [Wind Speed_km/h]
FROM Weather_Data
ORDER BY [Wind Speed_km/h] DESC;     
--City	        Date/Time	                    Wind Speed_km/h
--Chandigarh	2026-01-23 12:00:00.0000000	      44.20
--Chandigarh	2026-01-23 16:00:00.0000000	      39.80
--Chandigarh	2026-01-23 14:00:00.0000000	      38.20
--Chandigarh	2026-01-23 11:00:00.0000000	      37.90
--Chandigarh	2026-01-23 10:00:00.0000000	      37.70
--Chandigarh	2026-01-23 13:00:00.0000000	      37.40
--Chandigarh	2026-01-23 15:00:00.0000000	      37.20
--Nashik	    2026-07-23 03:00:00.0000000	      37.20
--Nashik	    2026-07-23 02:00:00.0000000	      35.90
--Raipur	    2026-05-30 19:00:00.0000000	      35.90

--Weather condition distribution
SELECT
    Weather_Name,
    COUNT(*) AS Total_Records,
    ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER(),2) AS Percentage
FROM Weather_Data
GROUP BY Weather_Name
ORDER BY Total_Records DESC;
                   ---Method 2 — CTE approach
WITH WeatherSummary AS
(
    SELECT
        Weather_Name,
        COUNT(*) AS Total_Records
    FROM Weather_Data
    GROUP BY Weather_Name
)
SELECT
    Weather_Name,
    Total_Records,
    ROUND(
        Total_Records * 100.0 /
        (SELECT SUM(Total_Records) FROM WeatherSummary),
        2
    ) AS Percentage
FROM WeatherSummary
ORDER BY Total_Records DESC;

----Weather_Name	     Total_Records	Percentage
--Clear Sky	              125984	     45.25
--Overcast	               59778	     21.47
--Mainly Clear	           30416	     10.93
--Light Drizzle	           26244	      9.43
--Partly Cloudy	           18363	      6.60
--Moderate Drizzle	        7257	      2.61
--Slight Rain	            4272	      1.53
--Moderate Rain	            3274	      1.18
--Dense Drizzle	            2224	      0.80
--Heavy Rain	             417	      0.15
--Moderate Snow	              69	      0.02
--Heavy Snow	              67	      0.02
--Slight Snow	              35	      0.01

--Monthly Temperature Trend
SELECT
    MONTH([Date/Time]) AS Month_Number,
    DATENAME(MONTH, [Date/Time]) AS Month_Name,
    ROUND(AVG(Temp_C), 2) AS Avg_Temp_C,
    ROUND(MIN(Temp_C), 2) AS Min_Temp_C,
    ROUND(MAX(Temp_C), 2) AS Max_Temp_C
FROM Weather_Data
GROUP BY
    MONTH([Date/Time]),
    DATENAME(MONTH, [Date/Time]) 
    ORDER BY Month_Number;

---Month_Number	Month_Name	Avg_Temp_C	Min_Temp_C	Max_Temp_C
--1	            January	    18.140000	-11.90	     35.00
--2	            February	22.060000	-12.40	     38.00
--3	             March	    26.380000	-4.10	     42.70
--4	             April	    29.490000	3.10	     44.80
--5	             May	    31.090000	6.30	     45.40
--6	             June	    30.630000	12.00	     43.60
--7	             July	    28.270000	15.90	     41.00
--8	           August	    27.610000	17.50	     39.40

--Poor visibility analysis
SELECT
    City,
    COUNT(*) AS Low_Visibility_Hours
FROM Weather_Data
WHERE Visibility_km < 2
GROUP BY City
ORDER BY Low_Visibility_Hours DESC;
--Ludhiana recorded the highest low-visibility observations (423).
--Dehradun (392) and Srinagar (389) followed closely.
--Northern cities generally showed more low-visibility conditions.
--Bhubaneswar recorded 205 low-visibility observations.
--Hyderabad had the lowest count, with only 1 observation.
--Overall, low visibility varied significantly across the 50 cities.

--City-wise overall weather score
SELECT
    City,
    ROUND(AVG(Temp_C), 2) AS Avg_Temp,
    ROUND(AVG([Rel Hum_%]), 2) AS Avg_Humidity,
    ROUND(AVG([Wind Speed_km/h]), 2) AS Avg_Wind,
    ROUND(AVG(Visibility_km), 2) AS Avg_Visibility
FROM Weather_Data
GROUP BY City
ORDER BY Avg_Visibility DESC;

--1. Visibility Range & Extremes
--Madurai has the highest visibility at 29.40, while Guwahati is the lowest at 9.56, creating a wide 19.84-point gap across all 50 cities.

--2. Wind as the Visibility Driver
--High wind speeds (10 km/h or more) in cities like Mysuru, Aurangabad, and Bengaluru strongly correlate with the best visibility scores (above 23.0).

--3. Indo-Gangetic Basin Fog & Haze Trap
--Northern and eastern plains cities (Delhi-NCR, Lucknow, Patna, Howrah) dominate the bottom ranks with low visibility (under 15.0) due to weak wind dispersion and high humidity.

--4. Temperature & Moisture Outliers
--Srinagar is the only major cold outlier at 13.02°C (against the 26.70°C average), while Guwahati (82%) and Jodhpur/Nagpur (45%) sit at opposite extremes of humidity.

--Rainfall/Drizzle-prone cities
SELECT
    City,
    COUNT(*) AS Rain_Drizzle_Records
FROM Weather_Data
WHERE Weather_Name IN
(
    'Light Drizzle',
    'Moderate Drizzle',
    'Dense Drizzle',
    'Slight Rain',
    'Moderate Rain',
    'Heavy Rain'
)
GROUP BY City
ORDER BY Rain_Drizzle_Records DESC;
---CITY              Rain_Drizzle_Records   
---Kochi	              2035
--Thiruvananthapuram	  1999
---Guwahati	              1985
--Navi Mumbai	          1547
--Mumbai	              1524
--Kolkata	              1323
--Howrah	              1295

--Extreme heat events 
SELECT
    City,
    COUNT(*) AS Extreme_Heat_Records
FROM Weather_Data
WHERE Temp_C >= 40
GROUP BY City
ORDER BY Extreme_Heat_Records DESC;
--Central and north-inland cities like Nagpur (333), Ahmedabad (257), and Kota (246) heavily dominate extreme heat records, while coastal and southern cities like Chennai (2), Hyderabad (3), and Visakhapatnam (12) report the fewest.

--High humidity + low visibility combination
SELECT
    City,
    COUNT(*) AS High_Humidity_Low_Visibility
FROM Weather_Data
WHERE [Rel Hum_%] >= 80
  AND Visibility_km < 2
GROUP BY City
ORDER BY High_Humidity_Low_Visibility DESC;

--1. Dense Fog Hotspots: North Indian and Himalayan-foothill cities (Ludhiana at 421, Dehradun at 366, Amritsar at 361, and Srinagar at 349) heavily lead in severe low-visibility fog events.

--2. Dry & Well-Ventilated Outliers: Arid and southern plateau cities (Hyderabad at 1, Madurai at 5, and Nagpur at 8) rarely experience high-humidity visibility drops below 2 km.



SELECT
    MONTH([Date/Time]) AS Month_Number,
    DATENAME(MONTH, [Date/Time]) AS Month_Name,
    Weather_Name,
    COUNT(*) AS Total_Records
FROM Weather_Data
GROUP BY
    MONTH([Date/Time]),
    DATENAME(MONTH, [Date/Time]),
    Weather_Name
ORDER BY
    Month_Number,
    Total_Records DESC;

    --1. Pre-Monsoon Clear Skies (Jan–May)
--Clear Sky is the single most dominant condition from January to May, consistently staying above 19,000 to 23,000 records each month.

--2. Monsoon Shift (July–August)
--Clear sky counts drop drastically from 13,104 in June to just 2,156 in July and 1,150 in August as Overcast conditions take over.

--3. Peak Rainfall & Drizzle (July–August)
--Total rain and drizzle events surge to their highest levels during July (16,782 records) and August (11,476 records), heavily driven by Light and Moderate Drizzle.

--4. Winter-Only Snowfall (Jan–Mar)
--Snowfall occurrences appear exclusively in January (100 records), February (53 records), and March (18 records), and disappear entirely from April onward.




