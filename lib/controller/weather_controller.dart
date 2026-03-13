import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/api.dart';

class WeatherController extends GetxController
    with GetTickerProviderStateMixin {

  final WeatherService weatherService = WeatherService();

  /// Forecast lists
  var hourlyForecast = <HourlyWeather>[].obs;
  var dailyForecast = <DailyWeather>[].obs;
  var historyWeather = <HistoryWeather>[].obs;

  /// Location
  RxString cityName = "Loading...".obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  /// Weather data
  RxDouble temperature = 0.0.obs;
  RxString condition = "".obs;
  RxInt humidity = 0.obs;
  RxDouble windSpeed = 0.0.obs;

  /// Animations
  late AnimationController fadeController;
  late AnimationController floatController;

  late Animation<double> fadeAnimation;
  late Animation<double> floatAnimation;

  @override
  void onInit() {
    super.onInit();
    initAnimations();
    getCurrentLocation();
  }

  /// Initialize animations
  void initAnimations() {

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    fadeAnimation =
        CurvedAnimation(parent: fadeController, curve: Curves.easeInOut);

    floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: floatController, curve: Curves.easeInOut),
    );

    fadeController.forward();
  }

  /// Get device location
  Future<void> getCurrentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    /// Check if location service enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    /// Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
    print(latitude.value);
    print(longitude.value);

    await getCityFromCoordinates(latitude.value, longitude.value);

    await fetchWeather();
    await fetchForecast();
    await fetchHistoryWeather();  
  }

  /// Get city name from coordinates
  Future<void> getCityFromCoordinates(double lat, double lon) async {

    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, lon);

    cityName.value =
        "${placemarks.first.locality}, ${placemarks.first.country}";
  }

  /// Fetch current weather
  Future<void> fetchWeather() async {

    final data =
        await weatherService.getCurrentWeather(latitude.value, longitude.value);

    temperature.value = data["main"]["temp"].toDouble();
    humidity.value = data["main"]["humidity"];
    condition.value = data["weather"][0]["main"];
    windSpeed.value = data["wind"]["speed"].toDouble();
  }

  /// Fetch forecast data
  Future<void> fetchForecast() async {

  final data =
      await weatherService.getForecast(latitude.value, longitude.value);

  hourlyForecast.clear();
  dailyForecast.clear();

  /// ---------- HOURLY FORECAST (Next 24 hours) ----------
  for (var item in data["list"].take(8)) {

    DateTime dt = DateTime.parse(item["dt_txt"]);

    hourlyForecast.add(
      HourlyWeather(
        "${dt.hour}:00",
        item["main"]["temp"].round(),
        "https://openweathermap.org/img/wn/${item["weather"][0]["icon"]}@2x.png",
      ),
    );
  }

  /// ---------- DAILY FORECAST ----------
  Map<String, List<dynamic>> grouped = {};

  for (var item in data["list"]) {

    String date = item["dt_txt"].split(" ")[0];

    if (!grouped.containsKey(date)) {
      grouped[date] = [];
    }

    grouped[date]!.add(item);
  }

  /// Take only first 5 days
  int count = 0;

  for (var entry in grouped.entries) {

    if (count == 5) break;

    List items = entry.value;

    double minTemp = items
        .map((e) => e["main"]["temp"].toDouble())
        .reduce((a, b) => a < b ? a : b);

    double maxTemp = items
        .map((e) => e["main"]["temp"].toDouble())
        .reduce((a, b) => a > b ? a : b);

    DateTime dt = DateTime.parse(entry.key);

    dailyForecast.add(
      DailyWeather(
        getDayName(dt),
        minTemp.round(),
        maxTemp.round(),
        "https://openweathermap.org/img/wn/${items.first["weather"][0]["icon"]}@2x.png",
      ),
    );

    count++;
  }
}
  /// Convert date to weekday name
  String getDayName(DateTime date) {

    List<String> days = [
      "Sun",
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat"
    ];

    return days[date.weekday % 7];
  }
// History of 5 days
  Future<void> fetchHistoryWeather() async {

  final history = await weatherService.fetchLastFiveDaysWeather(
      latitude.value, longitude.value);

  historyWeather.assignAll(history);
}

  @override
  void onClose() {
    fadeController.dispose();
    floatController.dispose();
    super.onClose();
  }
}