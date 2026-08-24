# 🌦️ India Weather Analytics – 50 Cities

## 📌 Project Overview

India Weather Analytics is an end-to-end data analytics project that analyzes hourly weather data for 50 major Indian cities.

The project uses the Open-Meteo API for weather data extraction and combines Python, SQL Server, and Power BI to transform raw weather data into meaningful analytical insights.

The project covers:

- API-based data extraction
- Python ETL
- Data cleaning and validation
- SQL Server data storage
- SQL-based EDA
- Analytical SQL views
- Power BI dashboard
- ETL automation
- Scheduled pipeline execution

---

## 🎯 Project Objectives

- Extract hourly weather data using an API
- Collect weather data for 50 Indian cities
- Clean and transform the raw API data
- Validate data quality
- Store the final dataset in SQL Server
- Perform exploratory data analysis using SQL
- Create reusable SQL views
- Build an interactive Power BI dashboard
- Identify weather trends and extreme weather conditions
- Automate the data pipeline

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Python | API extraction and ETL |
| Pandas | Data cleaning and transformation |
| Requests | API requests |
| Open-Meteo API | Weather data source |
| SQL Server | Data storage and analysis |
| SQL | Data validation, EDA and analytical views |
| Power BI | Dashboard and visualization |
| Jupyter Notebook | Python development and analysis |
| Windows Task Scheduler | Pipeline automation |
| GitHub | Version control and project documentation |

---

# 📊 Dataset

### Dataset Coverage

- **Cities:** 50
- **Frequency:** Hourly
- **Period:** January 2026 – August 2026
- **Total Records:** 278,400
- **Records per City:** 5,568

### Main Columns

| Column | Description |
|---|---|
| Date/Time | Weather observation date and time |
| City | Indian city |
| Latitude | City latitude |
| Longitude | City longitude |
| Temp_C | Temperature in Celsius |
| Dew Point Temp_C | Dew point temperature |
| Rel Hum_% | Relative humidity |
| Wind Speed_km/h | Wind speed |
| Visibility_km | Visibility in kilometers |
| Press_kPa | Surface pressure |
| Weather | Numerical weather code |
| Weather_Name | Weather condition |

---

# 🔄 Data Pipeline

```text
Open-Meteo API
      ↓
Python ETL
      ↓
Data Cleaning & Transformation
      ↓
Data Quality Validation
      ↓
SQL Server
      ↓
SQL EDA
      ↓
SQL Analytical Views
      ↓
Power BI
      ↓
Dashboard
