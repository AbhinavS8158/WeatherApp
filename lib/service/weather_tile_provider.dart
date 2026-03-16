import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class WeatherTileProvider implements TileProvider {

  final String urlTemplate;

  WeatherTileProvider(this.urlTemplate);

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {

    final url = urlTemplate
        .replaceAll("{z}", (zoom ?? 0).toString())
        .replaceAll("{x}", x.toString())
        .replaceAll("{y}", y.toString());

    debugPrint("Tile URL: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Tile(256, 256, response.bodyBytes);
    }

    return const Tile(256, 256, null);
  }
}