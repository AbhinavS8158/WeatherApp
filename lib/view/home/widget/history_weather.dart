import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/view/home/widget/selectionTitle.dart';

Widget buildHistoryWeather() {
  final WeatherController controller = Get.find();

  return Obx(() {
    final history = controller.historyWeather;

    if (history.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Lottie.asset(
            'assets/animation/loading.json',
            width: 120,
            height: 120,
            repeat: true,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: sectionTitle("History of last five days"),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 110,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: history.length,

            itemBuilder: (_, i) {
              final day = history[i];
                String formattedDate = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(day.day));

              return Container(
                width: 120,
                margin: const EdgeInsets.only(left: 16),

                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: AppColor.icon,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Image.network(day.icon, width: 32, height: 32),

                    const SizedBox(height: 6),

                    Text(
                      "${day.temp}°",
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  });
}
