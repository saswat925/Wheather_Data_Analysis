import requests
import pandas as pd
import pyodbc
from datetime import datetime

# ---------------------------------------
# 1. City Coordinates
# ---------------------------------------

cities = {
    "Delhi": (28.6139, 77.2090),
    "Mumbai": (19.0760, 72.8777),
    "Bengaluru": (12.9716, 77.5946),
    "Hyderabad": (17.3850, 78.4867),
    "Ahmedabad": (23.0225, 72.5714),
    "Chennai": (13.0827, 80.2707),
    "Kolkata": (22.5726, 88.3639),
    "Pune": (18.5204, 73.8567),
    "Jaipur": (26.9124, 75.7873),
    "Surat": (21.1702, 72.8311),
    "Lucknow": (26.8467, 80.9462),
    "Kanpur": (26.4499, 80.3319),
    "Nagpur": (21.1458, 79.0882),
    "Indore": (22.7196, 75.8577),
    "Bhopal": (23.2599, 77.4126),
    "Patna": (25.5941, 85.1376),
    "Vadodara": (22.3072, 73.1812),
    "Ludhiana": (30.9010, 75.8573),
    "Agra": (27.1767, 78.0081),
    "Nashik": (19.9975, 73.7898),
    "Faridabad": (28.4089, 77.3178),
    "Meerut": (28.9845, 77.7064),
    "Rajkot": (22.3039, 70.8022),
    "Varanasi": (25.3176, 82.9739),
    "Srinagar": (34.0837, 74.7973),
    "Aurangabad": (19.8762, 75.3433),
    "Dhanbad": (23.7957, 86.4304),
    "Amritsar": (31.6340, 74.8723),
    "Prayagraj": (25.4358, 81.8463),
    "Ranchi": (23.3441, 85.3096),
    "Howrah": (22.5958, 88.2636),
    "Coimbatore": (11.0168, 76.9558),
    "Jabalpur": (23.1815, 79.9864),
    "Gwalior": (26.2183, 78.1828),
    "Vijayawada": (16.5062, 80.6480),
    "Jodhpur": (26.2389, 73.0243),
    "Madurai": (9.9252, 78.1198),
    "Raipur": (21.2514, 81.6296),
    "Kota": (25.2138, 75.8648),
    "Chandigarh": (30.7333, 76.7794),
    "Guwahati": (26.1445, 91.7362),
    "Bhubaneswar": (20.2961, 85.8245),
    "Thiruvananthapuram": (8.5241, 76.9366),
    "Kochi": (9.9312, 76.2673),
    "Visakhapatnam": (17.6868, 83.2185),
    "Mysuru": (12.2958, 76.6394),
    "Dehradun": (30.3165, 78.0322),
    "Noida": (28.5355, 77.3910),
    "Gurugram": (28.4595, 77.0266),
    "Navi Mumbai": (19.0330, 73.0297)
}

all_data = []

# ---------------------------------------
# 2. API Extraction
# ---------------------------------------

for city, (latitude, longitude) in cities.items():

    print(f"Fetching {city}...")

    url = "https://api.open-meteo.com/v1/forecast"

    params = {
        "latitude": latitude,
        "longitude": longitude,
        "hourly": (
            "temperature_2m,"
            "dew_point_2m,"
            "relative_humidity_2m,"
            "wind_speed_10m,"
            "visibility,"
            "surface_pressure,"
            "weather_code"
        ),
        "timezone": "Asia/Kolkata",
        "start_date": "2026-01-01",
        "end_date": "2026-08-24"
    }

    response = requests.get(url, params=params)
    response.raise_for_status()

    data = response.json()

    hourly = data["hourly"]

    df = pd.DataFrame({
        "Date_Time": hourly["time"],
        "City": city,
        "Latitude": latitude,
        "Longitude": longitude,
        "Temp_C": hourly["temperature_2m"],
        "Dew_Point_Temp_C": hourly["dew_point_2m"],
        "Rel_Hum_Percent": hourly["relative_humidity_2m"],
        "Wind_Speed_kmh": hourly["wind_speed_10m"],
        "Visibility_km": [
            x / 1000 if x is not None else None
            for x in hourly["visibility"]
        ],
        "Press_kPa": hourly["surface_pressure"],
        "Weather": hourly["weather_code"]
    })

    all_data.append(df)

# ---------------------------------------
# 3. Combine Data
# ---------------------------------------

weather_df = pd.concat(all_data, ignore_index=True)

weather_df["Date_Time"] = pd.to_datetime(weather_df["Date_Time"])

# ---------------------------------------
# 4. Remove Duplicates
# ---------------------------------------

weather_df.drop_duplicates(
    subset=["City", "Date_Time"],
    inplace=True
)

# ---------------------------------------
# 5. Weather Code Mapping
# ---------------------------------------

weather_mapping = {
    0: "Clear Sky",
    1: "Mainly Clear",
    2: "Partly Cloudy",
    3: "Overcast",
    51: "Light Drizzle",
    53: "Moderate Drizzle",
    55: "Dense Drizzle",
    61: "Slight Rain",
    63: "Moderate Rain",
    65: "Heavy Rain",
    71: "Slight Snow",
    73: "Moderate Snow",
    75: "Heavy Snow",
    80: "Slight Rain Showers",
    81: "Moderate Rain Showers",
    82: "Violent Rain Showers"
}

weather_df["Weather_Name"] = (
    weather_df["Weather"]
    .map(weather_mapping)
    .fillna("Other")
)

# ---------------------------------------
# 6. Data Quality Validation
# ---------------------------------------

print("\nData Quality Check")

print("Total Rows:", len(weather_df))
print("Total Cities:", weather_df["City"].nunique())

duplicates = weather_df.duplicated(
    subset=["City", "Date_Time"]
).sum()

print("Duplicates:", duplicates)

# ---------------------------------------
# 7. SQL Server Connection
# ---------------------------------------

server = r"LAPTOP-71G1NMQR\SQLEXPRESS"
database = "Weather_Analytics"

connection_string = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={server};"
    f"DATABASE={database};"
    "Trusted_Connection=yes;"
)

conn = pyodbc.connect(connection_string)

cursor = conn.cursor()

# ---------------------------------------
# 8. Load Data
# ---------------------------------------

insert_query = """
INSERT INTO Weather_Data
(
    [Date_Time],
    City,
    Latitude,
    Longitude,
    Temp_C,
    Dew_Point_Temp_C,
    Rel_Hum_Percent,
    Wind_Speed_kmh,
    Visibility_km,
    Press_kPa,
    Weather,
    Weather_Name
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
"""

for row in weather_df.itertuples(index=False):

    cursor.execute(
        insert_query,
        row.Date_Time,
        row.City,
        row.Latitude,
        row.Longitude,
        row.Temp_C,
        row.Dew_Point_Temp_C,
        row.Rel_Hum_Percent,
        row.Wind_Speed_kmh,
        row.Visibility_km,
        row.Press_kPa,
        row.Weather,
        row.Weather_Name
    )

conn.commit()

# ---------------------------------------
# 9. Execute Stored Procedure
# ---------------------------------------

cursor.execute("EXEC sp_Weather_Data_Validation")

conn.commit()

cursor.close()
conn.close()

print("\nWeather ETL completed successfully.")
