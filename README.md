# 🌦️ India Weather Analytics – 50 Indian Cities

## 📌 Project Overview

**India Weather Analytics** is an end-to-end data analytics project that analyzes hourly weather data collected for **50 major Indian cities** using the **Open-Meteo API**.

The project demonstrates the complete analytics workflow from API data extraction and Python-based transformation to SQL Server data validation, exploratory data analysis, analytical SQL views, and an interactive Power BI dashboard.

### Project Workflow

```text
Open-Meteo API
      ↓
Python + Pandas ETL
      ↓
Data Cleaning & Transformation
      ↓
SQL Server
      ↓
Data Quality Validation
      ↓
SQL Exploratory Data Analysis
      ↓
SQL Analytical Views
      ↓
Power BI Dashboard
```

---

# 🎯 Project Objectives

* Extract hourly weather data using a REST API
* Collect weather data for 50 major Indian cities
* Transform raw API responses into a structured dataset
* Clean and validate weather data
* Store the processed data in SQL Server
* Perform exploratory data analysis using SQL
* Create analytical SQL views
* Connect SQL Server data with Power BI
* Build an interactive weather analytics dashboard
* Identify temperature, humidity, rainfall, visibility, and weather-condition patterns

---

# 🛠️ Technologies Used

| Technology           | Purpose                                   |
| -------------------- | ----------------------------------------- |
| **Python**           | API extraction and ETL                    |
| **Pandas**           | Data cleaning and transformation          |
| **Requests**         | API requests                              |
| **Open-Meteo API**   | Weather data source                       |
| **SQL Server**       | Data storage and analysis                 |
| **SQL**              | Data validation, EDA and analytical views |
| **Power BI**         | Dashboard and visualization               |
| **Jupyter Notebook** | Python development and analysis           |
| **GitHub**           | Version control and project documentation |

---

# 📊 Dataset

## Dataset Coverage

| Attribute                 | Details                    |
| ------------------------- | -------------------------- |
| **Geographical Coverage** | 50 Indian Cities           |
| **Frequency**             | Hourly                     |
| **Period**                | January 2026 – August 2026 |
| **Total Records**         | 278,400                    |
| **Records per City**      | 5,568                      |
| **Data Source**           | Open-Meteo API             |

Each city contains hourly observations for the selected period.

---

# 📋 Dataset Columns

| Column             | Description                                 |
| ------------------ | ------------------------------------------- |
| `Date/Time`        | Weather observation date and time           |
| `City`             | Indian city name                            |
| `Latitude`         | Latitude of the city                        |
| `Longitude`        | Longitude of the city                       |
| `Temp_C`           | Temperature in Celsius                      |
| `Dew Point Temp_C` | Dew point temperature                       |
| `Rel Hum_%`        | Relative humidity percentage                |
| `Wind Speed_km/h`  | Wind speed in km/h                          |
| `Visibility_km`    | Visibility in kilometers                    |
| `Press_kPa`        | Surface pressure in kPa                     |
| `Weather`          | Numerical weather code                      |
| `Weather_Name`     | Weather condition derived from weather code |

---

# 🐍 Python ETL

Python was used for extracting and transforming weather data from the Open-Meteo API.

## ETL Process

1. Define the 50 Indian cities and their coordinates
2. Send API requests to Open-Meteo
3. Extract hourly weather observations
4. Convert API responses into Pandas DataFrames
5. Combine data from all cities
6. Convert date/time fields into proper datetime format
7. Process weather variables
8. Convert visibility from meters to kilometers
9. Map numerical weather codes to readable weather conditions
10. Check missing values
11. Check duplicate records
12. Prepare the final dataset for SQL Server

### Record Uniqueness

Each weather observation is identified using:

```text
City + Date/Time
```

This combination is used to identify duplicate hourly observations.

---

# 🧹 Data Quality Validation

Data quality checks were performed before and after loading the data into SQL Server.

## Total Records

```sql
SELECT COUNT(*) AS TotalRows
FROM Weather_Data;
```

Expected:

```text
278400
```

## Total Cities

```sql
SELECT COUNT(DISTINCT City) AS TotalCities
FROM Weather_Data;
```

Expected:

```text
50
```

## Duplicate Check

```sql
SELECT
    City,
    [Date/Time],
    COUNT(*) AS DuplicateCount
FROM Weather_Data
GROUP BY City, [Date/Time]
HAVING COUNT(*) > 1;
```

Expected result:

```text
0 rows
```

## Data Quality Checks

The dataset was checked for:

* Duplicate records
* Missing values
* Invalid temperature values
* Invalid humidity values
* Invalid wind-speed values
* Visibility values
* Pressure values
* Weather codes
* Number of cities
* Date/time consistency

---

# 🗄️ SQL Server

The processed weather dataset was stored and analyzed using **Microsoft SQL Server**.

## Database

```text
Weather_Analytics
```

## Main Table

```text
Weather_Data
```

The table contains the weather observations collected from the API.

### Main Fields

```text
Weather_ID
Date/Time
City
Latitude
Longitude
Temp_C
Dew Point Temp_C
Rel Hum_%
Wind Speed_km/h
Visibility_km
Press_kPa
Weather
Weather_Name
```

---

# 📈 SQL Exploratory Data Analysis

SQL was used to perform exploratory data analysis on the weather dataset.

The analysis included:

* City-wise temperature analysis
* Hottest cities
* Coldest cities
* Maximum temperature
* Minimum temperature
* Humidity analysis
* Wind-speed analysis
* Rain and drizzle analysis
* Extreme heat analysis
* Low-visibility analysis
* High-humidity and low-visibility analysis
* Monthly weather trends
* Weather-condition distribution

---

# 🔥 Temperature Analysis

## Highest Recorded Temperature

The maximum recorded temperature in the dataset was:

```text
45.40°C
```

Location:

```text
Kota
```

## Lowest Recorded Temperature

The minimum recorded temperature in the dataset was:

```text
-12.40°C
```

Location:

```text
Srinagar
```

---

# 🌡️ Average Temperature by City

The average temperature was calculated for each city to compare overall temperature patterns.

### Hottest Cities by Average Temperature

The analysis identified cities such as:

1. Madurai
2. Ahmedabad
3. Vijayawada
4. Nagpur
5. Chennai
6. Vadodara
7. Raipur
8. Navi Mumbai
9. Surat
10. Jodhpur

### Coldest Cities by Average Temperature

The analysis identified cities such as:

1. Srinagar
2. Dehradun
3. Ranchi
4. Guwahati
5. Chandigarh
6. Amritsar
7. Bengaluru
8. Ludhiana
9. Mysuru
10. Meerut

---

# 💧 Humidity Analysis

Relative humidity was analyzed across the 50 cities.

Guwahati showed the highest average humidity among the analyzed cities.

Other cities with high humidity levels included:

* Thiruvananthapuram
* Kochi
* Howrah
* Bhubaneswar
* Kolkata
* Visakhapatnam

---

# 💨 Wind Speed Analysis

Wind-speed patterns were analyzed by city and observation period.

The highest recorded wind speed was:

```text
44.20 km/h
```

Location:

```text
Chandigarh
```

---

# 🌧️ Rain & Drizzle Analysis

Weather codes were mapped into readable weather conditions to analyze rainfall and drizzle patterns.

The analysis included conditions such as:

* Light Drizzle
* Moderate Drizzle
* Dense Drizzle
* Slight Rain
* Moderate Rain
* Heavy Rain

Cities with high rain/drizzle observations included:

* Kochi
* Thiruvananthapuram
* Guwahati
* Navi Mumbai
* Mumbai
* Kolkata
* Howrah

---

# 🔥 Extreme Heat Analysis

Extreme heat observations were identified using:

```text
Temp_C >= 40°C
```

Cities such as:

* Nagpur
* Ahmedabad
* Kota

showed a high number of extreme-heat observations.

---

# 🌫️ Low Visibility Analysis

Low visibility was analyzed using:

```text
Visibility_km < 2
```

Cities with high numbers of low-visibility observations included:

* Ludhiana
* Dehradun
* Srinagar
* Amritsar

---

# 🌫️ High Humidity + Low Visibility

A combined condition was analyzed using:

```text
Relative Humidity >= 80%
AND
Visibility < 2 km
```

This helped identify weather observations associated with potentially foggy or hazy conditions.

Cities such as Ludhiana, Dehradun, Amritsar and Srinagar showed high numbers of such observations.

---

# 📅 Monthly Weather Analysis

Monthly trends were analyzed using:

* Average temperature
* Minimum temperature
* Maximum temperature
* Average humidity
* Average wind speed
* Average visibility

This analysis helps understand how weather conditions changed throughout the analyzed period.

---

# 🌤️ Weather Condition Distribution

The numerical weather codes from the API were converted into readable weather conditions.

Major weather conditions included:

* Clear Sky
* Mainly Clear
* Partly Cloudy
* Overcast
* Light Drizzle
* Moderate Drizzle
* Dense Drizzle
* Slight Rain
* Moderate Rain
* Heavy Rain
* Snow

Clear Sky was one of the dominant weather conditions in the dataset.

---

# 📊 Power BI Dashboard

Power BI was used to create an interactive weather analytics dashboard using the SQL Server dataset.

## Dashboard KPIs

The dashboard includes metrics such as:

* Total Weather Records
* Total Cities
* Average Temperature
* Maximum Temperature
* Minimum Temperature
* Average Humidity
* Average Wind Speed
* Average Visibility
* Average Pressure

---

# 📍 Dashboard Analysis

## City-wise Analysis

The dashboard provides city-level analysis for:

* Average temperature
* Minimum temperature
* Maximum temperature
* Humidity
* Wind speed
* Visibility
* Extreme heat observations
* Low visibility observations

## Monthly Analysis

The dashboard analyzes:

* Monthly average temperature
* Monthly minimum temperature
* Monthly maximum temperature
* Monthly weather trends

## Weather Distribution

Weather conditions can be analyzed through categories such as:

* Clear
* Cloudy
* Drizzle
* Rain
* Snow

## Filters / Slicers

The Power BI dashboard supports filtering by:

* City
* Date
* Month
* Weather Condition

---

# 🗃️ SQL Analytical Views

SQL Server analytical views were created to provide analysis-ready data for Power BI.

Examples include:

```text
vw_Weather_KPI
```

```text
vw_City_Weather_Summary
```

```text
vw_Monthly_Weather_Trend
```

```text
vw_Weather_Distribution
```

```text
vw_Extreme_Weather
```

These views simplify the connection between SQL Server analysis and Power BI visualization.

---

# 🔄 Current Project Architecture

The currently implemented project workflow is:

```text
                 Open-Meteo API
                       ↓
                Python / Requests
                       ↓
                 Pandas ETL
                       ↓
           Cleaning & Transformation
                       ↓
                  SQL Server
                       ↓
             Data Quality Checks
                       ↓
                 SQL EDA
                       ↓
              Analytical SQL Views
                       ↓
                   Power BI
                       ↓
               Interactive Dashboard
```

---

# 📁 Project Structure

```text
India-Weather-Analytics/
│
├── python/
│   └── weather_etl.py
│
├── sql/
│   ├── 01_Create_Database.sql
│   ├── 02_Create_Table.sql
│   ├── 03_Data_Load.sql
│   ├── 04_Data_Quality.sql
│   ├── 05_EDA_Queries.sql
│   └── 06_Create_Views.sql
│
├── data/
│   └── India_Weather_2026_50_Cities_Final.csv
│
├── powerbi/
│   └── India_Weather_Analytics.pbix
│
├── notebook/
│   └── Weather_Analysis.ipynb
│
└── README.md
```

---

# 💡 Key Insights

* Kota recorded the highest temperature of **45.40°C**.
* Srinagar recorded the lowest temperature of **-12.40°C**.
* Madurai was among the cities with the highest average temperatures.
* Srinagar was among the cities with the lowest average temperatures.
* Guwahati showed very high average humidity.
* Chandigarh recorded the highest observed wind speed of **44.20 km/h**.
* Kochi and Thiruvananthapuram showed high rain/drizzle activity.
* Northern cities showed more low-visibility observations.
* Nagpur, Ahmedabad and Kota showed high extreme-heat observations.
* Weather conditions varied considerably across different regions of India.

---

# 🚀 Future Improvements

The following features are planned for future development:

* Implement incremental ETL loading
* Create SQL Server stored procedures
* Add automated ETL logging
* Add error handling and retry mechanisms
* Automate Python ETL using Windows Task Scheduler
* Configure Power BI Service scheduled refresh
* Add email notifications for pipeline failures
* Implement real-time weather monitoring
* Add weather forecasting
* Add anomaly detection
* Add machine-learning-based temperature prediction
* Deploy the pipeline to cloud infrastructure

> **Note:** Automation and Windows Task Scheduler are currently planned improvements and are not part of the implemented pipeline.

---

# 👨‍💻 Skills Demonstrated

* Python
* Pandas
* REST API
* API Data Extraction
* ETL
* Data Cleaning
* Data Validation
* SQL Server
* SQL
* Exploratory Data Analysis
* SQL Views
* Power BI
* Data Visualization
* Dashboard Development
* GitHub

---

# 📌 Project Outcome

This project demonstrates an end-to-end data analytics workflow using real API-based weather data.

```text
API
 ↓
Python ETL
 ↓
Data Cleaning
 ↓
SQL Server
 ↓
Data Validation
 ↓
SQL EDA
 ↓
SQL Views
 ↓
Power BI Dashboard
```

The project transforms hourly weather observations from **50 Indian cities** into a structured analytical dataset and interactive Power BI dashboard.

It demonstrates practical skills in **API integration, Python ETL, SQL Server, data quality, exploratory data analysis, SQL views, and Power BI dashboard development**.
