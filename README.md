# weather_app

🌦 Flutter Weather Application

A Flutter-based Android application that displays weather information based on the user's current location.
The application integrates multiple weather services to provide current weather, historical weather data, and interactive weather map layers.

This project demonstrates API integration, location services, and Google Maps weather overlays using Flutter.

🚀 Features
1️⃣ Current Weather

The application fetches the current weather data based on the user's location.

Information displayed includes:

Temperature

Weather condition

Humidity

Wind speed

Location name

API Used
https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}

Service Provider: OpenWeatherMap

📅 5-Day Weather History

The application displays actual weather data for the previous 5 days using the WeatherAPI historical endpoint.

Users can view:

Historical temperature

Weather conditions

Daily weather summary

API Used
http://api.weatherapi.com/v1/history.json?key={API_KEY}&q={lat},{lon}&dt={date}

Service Provider: WeatherAPI

🗺 Weather Map Layers

The application integrates Google Maps and overlays weather data tiles.

Users can view weather patterns geographically.

🌡 Temperature Layer

Displays temperature distribution across regions.

https://weathermaps.weatherapi.com/tmp2m/tiles/{0}{1}/{z}/{x}/{y}.png
🌧 Precipitation Layer

Displays rainfall patterns on the map.

https://weathermaps.weatherapi.com/precip/tiles/{0}{1}/{z}/{x}/{y}.png
🛠 Technologies Used

Flutter

Dart

Google Maps Flutter

REST APIs

Geolocation

GetX (State Management)

📦 Flutter Packages

Main packages used in the project:

http
google_maps_flutter
geolocator
get
📂 Project Structure
lib
│
├── controller
│   └── weather_controller.dart
│
├── service
│   └── weather_service.dart
│
├── view
│   ├── home_screen
│   ├── history_screen
│   └── map_screen
│
└── main.dart
▶️ How to Run the Project
1️⃣ Clone the Repository
git clone https://github.com/yourusername/weather_app.git
2️⃣ Navigate to the Project Folder
cd weather_app
3️⃣ Install Dependencies
flutter pub get
4️⃣ Add API Keys

Add your API keys inside the project.

Required APIs:

OpenWeatherMap API Key

WeatherAPI Key

5️⃣ Run the Application
flutter run
📱 Screens in the Application

Current Weather Screen

Historical Weather Screen (Last 5 Days)

Weather Map Screen (Temperature & Precipitation Layers)

🎯 Learning Objectives

This project demonstrates:

Flutter API integration

Working with multiple weather APIs

Handling geolocation in Flutter

Integrating Google Maps

Displaying weather map tile layers

👨‍💻 Author

Abhinav S
Flutter Developer

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
