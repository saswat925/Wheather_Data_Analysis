USE Weather_Analytics;
GO

CREATE OR ALTER PROCEDURE sp_Weather_Data_Validation
AS
BEGIN

    SET NOCOUNT ON;

    PRINT 'Starting Weather Data Validation...';

    -- Total Records
    SELECT
        COUNT(*) AS TotalRows
    FROM Weather_Data;


    -- Total Cities
    SELECT
        COUNT(DISTINCT City) AS TotalCities
    FROM Weather_Data;


    -- Duplicate Records
    SELECT
        City,
        Date_Time,
        COUNT(*) AS DuplicateCount
    FROM Weather_Data
    GROUP BY
        City,
        Date_Time
    HAVING COUNT(*) > 1;


    -- NULL Check
    SELECT
        COUNT(*) AS NullRows
    FROM Weather_Data
    WHERE
        City IS NULL
        OR Date_Time IS NULL
        OR Temp_C IS NULL
        OR Rel_Hum_Percent IS NULL
        OR Wind_Speed_kmh IS NULL
        OR Press_kPa IS NULL;


    -- Humidity Validation
    SELECT
        COUNT(*) AS InvalidHumidityRows
    FROM Weather_Data
    WHERE
        Rel_Hum_Percent < 0
        OR Rel_Hum_Percent > 100;


    -- Temperature Validation
    SELECT
        COUNT(*) AS InvalidTemperatureRows
    FROM Weather_Data
    WHERE
        Temp_C < -50
        OR Temp_C > 60;


    PRINT 'Weather Data Validation Completed.';

END;
GO
