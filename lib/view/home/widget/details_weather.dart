
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';

Widget buildWeatherDetails() {
  final controller = Get.find<WeatherController>();

  return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Humidity: ${controller.humidity.value}%"),
          Text("Wind: ${controller.windSpeed.value} km/h"),
        ],
      ));
}


