import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/colors.dart';

import '../../../controller/weather_controller.dart';

Widget buildWeatherDetails() {
  final controller = Get.find<WeatherController>();

  return Obx(() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 20,
          runSpacing: 10,

          children: [
            Text(
              "Humidity: ${controller.humidity.value}%",
              style: const TextStyle(color: AppColor.white),
            ),

            Text(
              "Wind: ${controller.windSpeed.value} km/h",
              style: const TextStyle(color: AppColor.white),
            ),
          ],
        ),
      ));
}