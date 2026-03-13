
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/home/widget/selectionTitle.dart';

Widget buildHistoryWeather() {

  final WeatherController controller = Get.find();

  return Obx(() {

    final history = controller.historyWeather;

    if (history.isEmpty) {
      return const CircularProgressIndicator();
    }
    
    return Padding(
     padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle('History of Last 5 days'),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
             color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha:  0.1)),
            ),
            child: ListView.separated(
              separatorBuilder:(context, index) {
                return Divider( color: Colors.white.withValues(alpha:  0.08),
                        height: 1,
                        indent: 16,
                        endIndent: 16,);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (_, i) {
            
                final day = history[i];
            
                return ListTile(
                  leading: Image.network(day.icon),
                  title: Text(day.day,style: TextStyle(color: Colors.black),),
                  subtitle: Text(day.condition,style: TextStyle(color: Colors.white),),
                  trailing: Text("${day.temp}°",style: TextStyle(color: Colors.white70),),
                );
              },
            ),
          ),
        ],
      ),
    );
  });
}
