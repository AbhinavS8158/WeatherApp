import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/view/home/widget/daily_forcast.dart';
import 'package:weather_app/view/home/widget/details_weather.dart';
import 'package:weather_app/view/home/widget/history_weather.dart';
import 'package:weather_app/view/home/widget/main_weather.dart';
import 'package:weather_app/view/home/widget/top_bar.dart';

class WeatherHomeScreen extends StatelessWidget {
  WeatherHomeScreen({super.key});

  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        double maxWidth = 600;

        if (constraints.maxWidth > 1100) {
          maxWidth = 800; // desktop
        } else if (constraints.maxWidth > 600) {
          maxWidth = 700; // tablet
        }

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.backgroundStart,
                  AppColor.backgroundEnd,
                ],
              ),
            ),

            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),

                  child: FadeTransition(
                    opacity: controller.fadeAnimation,

                    child: Column(
                      children: [

                        buildTopBar(),

                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [

                                buildMainWeather(),

                                const SizedBox(height: 10),

                                buildWeatherDetails(),

                                const SizedBox(height: 10),

                                buildDailyForecast(),

                                const SizedBox(height: 10),

                                buildHistoryWeather(),

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
            ),
          ),
        );
      },
    );
  }
}