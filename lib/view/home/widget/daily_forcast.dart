


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/view/home/widget/selectionTitle.dart';

Widget buildDailyForecast() {
  final WeatherController controller = Get.find<WeatherController>();

  return Obx(() {
    final List<DailyWeather> daily = controller.dailyForecast;

   if (daily.isEmpty) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Column(
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                const Spacer(),
                Container(
                  width: 80,
                  height: 6,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Container(
                  width: 30,
                  height: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Container(
                  width: 25,
                  height: 14,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }),
      ),
    ),
  );
}
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle('5-Day Forecast'),
          const SizedBox(height: 14),

          Container(
            decoration: BoxDecoration(
              color: AppColor.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColor.white.withOpacity(0.1)),
            ),

            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daily.length,

              separatorBuilder: (_, __) => Divider(
                color: AppColor.white.withOpacity(0.08),
                height: 1,
                indent: 16,
                endIndent: 16,
              ),

              itemBuilder: (_, i) {
                final d = daily[i];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

                  child: Row(
                    children: [

                      /// Day
                      SizedBox(
                        width: 44,
                        child: Text(
                          d.day,
                          style: TextStyle(
                            color: i == 0 ? AppColor.white : AppColor.icon,
                            fontSize: 14,
                            fontWeight:
                                i == 0 ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),

                      /// Weather icon
                      Image.network(
                        d.icon,
                        width: 24,
                        height: 24,
                      ),

                      const Spacer(),

                      /// Temperature bar
                      _tempBar(d.low, d.high, daily),

                      const SizedBox(width: 12),

                      /// High temp
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${d.high}°',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      /// Low temp
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${d.low}°',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: AppColor.time,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  });
}

Widget _tempBar(int low, int high, List<DailyWeather> daily) {

  final allHighs = daily.map((d) => d.high).toList();
  final allLows = daily.map((d) => d.low).toList();

  final globalMin = allLows.reduce(min).toDouble();
  final globalMax = allHighs.reduce(max).toDouble();

  final range = max(globalMax - globalMin, 1);

  double leftFrac = (low - globalMin) / range;
  double widthFrac = (high - low) / range;

  /// Prevent negative values
  leftFrac = leftFrac.clamp(0.0, 1.0);
  widthFrac = widthFrac.clamp(0.0, 1.0);

  return SizedBox(
    width: 80,
    height: 6,
    child: Stack(
      children: [

        /// background
        Container(
          decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(3),
          ),
        ),

        /// temperature range
        FractionallySizedBox(
          widthFactor: leftFrac + widthFrac,
          child: FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: widthFrac == 0 ? 0.01 : widthFrac,

            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.lightBlue,
                    AppColor.orange,
                  ],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


