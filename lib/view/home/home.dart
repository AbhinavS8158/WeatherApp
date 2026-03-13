import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/home/widget/main_weather.dart';
import 'package:weather_app/view/home/widget/top_bar.dart';

class WeatherHomeScreen extends StatelessWidget {
  WeatherHomeScreen({super.key});

  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey,
              Colors.black,
            ],
          ),
        ),

        child: SafeArea(
          child: FadeTransition(
            opacity: controller.fadeAnimation,
            child: Column(
              children: [

                /// TOP BAR
                buildTopBar(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [

                        buildMainWeather(),
                        // buildWeatherDetails(),
                        // buildDailyForecast(),
                        // buildHistoryWeather(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}