import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/view/map_screen/map_screen.dart';

Widget buildTopBar() {

  final WeatherController controller = Get.find<WeatherController>();

  return Padding(
    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.location_on,
                  color: AppColor.icon,
                  size: 14,
                ),

                const SizedBox(width: 4),

               
                Obx(() => Text(
                      controller.cityName.value,
                      style: const TextStyle(
                        color: AppColor.icon,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    )),
              ],
            ),

            const SizedBox(height: 2),

            Text(
              getLocalTime(),
              style: const TextStyle(
                color: AppColor.time,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(onPressed: (){
          Get.to(()=>WeatherMapScreen());
        }, icon:Icon(Icons.map_rounded,color: AppColor.icon,))
      ],
    ),
  );
}
String getLocalTime() {
  final now = DateTime.now();
  final hour = now.hour;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

  return '$displayHour:$minute $period';
}