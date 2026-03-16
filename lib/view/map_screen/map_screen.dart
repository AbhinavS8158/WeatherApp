import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/controller/weather_controller.dart';

class WeatherMapScreen extends StatelessWidget {
  WeatherMapScreen({super.key});

  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.mapTitle.value)),

        // Make AppBar transparent so gradient shows
        backgroundColor: Colors.blueGrey,
      
      ),

      body: Obx(
        () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              controller.latitude.value,
              controller.longitude.value,
            ),
            zoom: 5,
          ),
          tileOverlays: controller.overlays.value,
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          /// TEMPERATURE BUTTON
          FloatingActionButton(
            heroTag: "temperature",
            child: const Icon(Icons.thermostat),
            onPressed: () {
              controller.addTemperatureLayer();

              Get.snackbar(
                "Layer Added",
                "Temperature layer displayed",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
          ),

          const SizedBox(height: 10),

          /// PRECIPITATION BUTTON
          FloatingActionButton(
            heroTag: "precipitation",
            child: const Icon(Icons.water_drop),
            onPressed: () {
              controller.addPrecipitationLayer();

              Get.snackbar(
                "Layer Added",
                "Precipitation layer displayed",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
          ),

          const SizedBox(height: 10),

          /// CLEAR BUTTON
          FloatingActionButton(
            heroTag: "clear",
            child: const Icon(Icons.clear),
            onPressed: () {
              controller.clearLayers();

              Get.snackbar(
                "Layers Removed",
                "Weather layers cleared",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
          ),
        ],
      ),
    );
  }
}