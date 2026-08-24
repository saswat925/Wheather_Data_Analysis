

--For Power BI views

--1. KPI View

USE Weather_Analytics;
GO


CREATE VIEW vw_Weather_KPI
AS
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT City) AS Total_Cities,
    ROUND(AVG(Temp_C), 2) AS Avg_Temperature_C,
    ROUND(MAX(Temp_C), 2) AS Max_Temperature_C,
    ROUND(MIN(Temp_C), 2) AS Min_Temperature_C,
    ROUND(AVG([Rel Hum_%]), 2) AS Avg_Humidity,
    ROUND(AVG([Wind Speed_km/h]), 2) AS Avg_Wind_Speed_kmh,
    ROUND(AVG(Visibility_km), 2) AS Avg_Visibility_km,
    ROUND(AVG(Press_kPa), 2) AS Avg_Pressure_kPa
FROM Weather_Data;

--2. City Weather Summary View
CREATE VIEW vw_City_Weather_Summary
AS
SELECT
    City,
    ROUND(AVG(Temp_C), 2) AS Avg_Temp_C,
    ROUND(MIN(Temp_C), 2) AS Min_Temp_C,
    ROUND(MAX(Temp_C), 2) AS Max_Temp_C,


    ROUND(AVG([Dew Point Temp_C]), 2) AS Avg_Dew_Point_C,


    ROUND(AVG([Rel Hum_%]), 2) AS Avg_Humidity,


    ROUND(AVG([Wind Speed_km/h]), 2) AS Avg_Wind_Speed_kmh,


    ROUND(AVG(Visibility_km), 2) AS Avg_Visibility_km,


    ROUND(AVG(Press_kPa), 2) AS Avg_Pressure_kPa,


    COUNT(*) AS Total_Records,


    SUM(
        CASE
            WHEN Visibility_km < 2 THEN 1
            ELSE 0
        END
    ) AS Low_Visibility_Records,


    SUM(
        CASE
            WHEN Temp_C >= 40 THEN 1
            ELSE 0
        END
    ) AS Extreme_Heat_Records


FROM Weather_Data
GROUP BY City;

--3. Monthly Temperature Trend View
CREATE VIEW vw_Monthly_Weather_Trend
AS
SELECT
    MONTH([Date/Time]) AS Month_Number,
    DATENAME(MONTH, [Date/Time]) AS Month_Name,


    ROUND(AVG(Temp_C), 2) AS Avg_Temp_C,
    ROUND(MIN(Temp_C), 2) AS Min_Temp_C,
    ROUND(MAX(Temp_C), 2) AS Max_Temp_C,


    ROUND(AVG([Rel Hum_%]), 2) AS Avg_Humidity,


    ROUND(AVG([Wind Speed_km/h]), 2) AS Avg_Wind_Speed_kmh,


    ROUND(AVG(Visibility_km), 2) AS Avg_Visibility_km,


    COUNT(*) AS Total_Records


FROM Weather_Data
GROUP BY
    MONTH([Date/Time]),
    DATENAME(MONTH, [Date/Time]);


--4. Weather Distribution View
CREATE VIEW vw_Weather_Distribution
AS
SELECT
    Weather_Name,
    COUNT(*) AS Total_Records,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Weather_Data),
        2
    ) AS Percentage
FROM Weather_Data
GROUP BY Weather_Name;
--5. Extreme Weather View
CREATE VIEW vw_Extreme_Weather
AS
SELECT
    City,
    [Date/Time],
    Temp_C,
    [Rel Hum_%],
    [Wind Speed_km/h],
    Visibility_km,
    Press_kPa,
    Weather_Name,

    CASE
        WHEN Temp_C >= 40 THEN 'Extreme Heat'
        WHEN Temp_C <= 0 THEN 'Freezing'
        WHEN Visibility_km < 2 THEN 'Low Visibility'
        WHEN [Wind Speed_km/h] >= 30 THEN 'High Wind'
        ELSE 'Normal'
    END AS Extreme_Category

FROM Weather_Data;



--check all views
SELECT * FROM vw_Weather_KPI;

SELECT * FROM vw_City_Weather_Summary;

SELECT * FROM vw_Monthly_Weather_Trend;

SELECT * FROM vw_Weather_Distribution;

SELECT * FROM vw_Extreme_Weather;

