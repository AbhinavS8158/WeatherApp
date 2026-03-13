import 'package:flutter/material.dart';

class WeatherData {
  final String city;
  final String country;
  final int temperature;
  final int feelsLike;
  final String condition;
  final String icon;
  final int humidity;
  final int windSpeed;
  final int uvIndex;
  final int visibility;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final Color primaryColor;
  final Color secondaryColor;

  const WeatherData({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.uvIndex,
    required this.visibility,
    required this.hourly,
    required this.daily, 
    required this.primaryColor,
     required this.secondaryColor,
  });
}

class HourlyWeather {
  final String time;
  final int temp;
  final String icon;

  const HourlyWeather(this.time, this.temp, this.icon);
}

class DailyWeather {
  final String day;
  final int high;
  final int low;
  final String icon;

  const DailyWeather(this.day, this.high, this.low, this.icon);
}

class HistoryWeather {
  final String day;
  final int temp;
  final int humidity;
  final String condition;
  final String icon;

  HistoryWeather(
    this.day,
    this.temp,
    this.humidity,
    this.condition,
    this.icon,
  );
}