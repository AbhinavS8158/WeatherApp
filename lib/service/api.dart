import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {

  
final  String apiKey ="ff1c421de06ad9628711a6018ba0ebe8";
final String freeapiKey='f13cf58b19e7437b80b55203261303';

final String _baseUrl='http://api.weatherapi.com/v1';
  /// Current Weather API
  Future<Map<String, dynamic>> getCurrentWeather(
      double lat, double lon) async {

    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load weather");
  }

  /// Forecast API
  Future<Map<String, dynamic>> getForecast(
      double lat, double lon) async {

    final url =
    "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
      

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load forecast");
  }
//history
Future<List<HistoryWeather>> fetchLastFiveDaysWeather(
    double lat, double lon) async {

  List<HistoryWeather> historyList = [];

  DateTime today = DateTime.now();

  for (int i = 1; i <= 5; i++) {

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

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

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
    }
  }

  return historyList;
}
}