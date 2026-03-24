import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  final String apiKey = "ff1c421de06ad9628711a6018ba0ebe8";
  final String freeapiKey = 'f13cf58b19e7437b80b55203261303';

  final String _baseUrl = 'http://api.weatherapi.com/v1';

  /// Common response handler
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);

      case 400:
        throw Exception("Bad Request - Invalid parameters");

      case 401:
        throw Exception("Unauthorized - Invalid API key");

      case 403:
        throw Exception("Forbidden - Access denied");

      case 404:
        throw Exception("Not Found - Resource not available");

      case 429:
        throw Exception("Too Many Requests - API limit exceeded");

      case 500:
        throw Exception("Server Error - Try again later");

      default:
        throw Exception(
            "Unexpected Error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  }

  /// Current Weather API
  Future<Map<String, dynamic>> getCurrentWeather(
      double lat, double lon) async {
    try {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Failed to fetch current weather: $e");
    }
  }

  /// Forecast API
  Future<Map<String, dynamic>> getForecast(
      double lat, double lon) async {
    try {
      final url =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Failed to fetch forecast: $e");
    }
  }

  /// History API (Last 5 Days)
  Future<List<HistoryWeather>> fetchLastFiveDaysWeather(
      double lat, double lon) async {
    List<HistoryWeather> historyList = [];

    DateTime today = DateTime.now();

    for (int i = 1; i <= 5; i++) {
      try {
        DateTime previousDay = today.subtract(Duration(days: i));

        String date =
            "${previousDay.year}-${previousDay.month.toString().padLeft(2, '0')}-${previousDay.day.toString().padLeft(2, '0')}";

        final url = Uri.parse(
          "$_baseUrl/history.json"
          "?key=$freeapiKey"
          "&q=$lat,$lon"
          "&dt=$date",
        );

        final response = await http.get(url);

        final data = _handleResponse(response);

        final dayData = data["forecast"]["forecastday"][0]["day"];

        historyList.add(
          HistoryWeather(
            data["forecast"]["forecastday"][0]["date"],
            dayData["avgtemp_c"].round(),
            dayData["avghumidity"].round(),
            dayData["condition"]["text"],
            "https:${dayData["condition"]["icon"]}",
          ),
        );
      } catch (e) {
        // Important: Continue loop even if one day fails
        print("Error fetching history for day $i: $e");
      }
    }

    return historyList;
  }
}