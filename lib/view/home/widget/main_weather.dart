

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
Widget buildMainWeather() {

  final controller = Get.find<WeatherController>();

  return Obx(() => Column(
        children: [

          AnimatedBuilder(
            animation: controller.floatAnimation,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, controller.floatAnimation.value),
              child: const Icon(Icons.cloud, size: 90, color: Colors.white),
            ),
          ),

          Text(
            "${controller.temperature.value}°",
            style: const TextStyle(
                color: Colors.white, fontSize: 80),
          ),

          Text(
            controller.condition.value,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ));
}


