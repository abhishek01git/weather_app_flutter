import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  static const url = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKeys;

  WeatherServices({required this.apiKeys});

  Future<Weather> getWeather(String CityNmame) async {
    final client = http.Client();
    try {
      final response = await client
          .get(Uri.parse('$url?q=$CityNmame&appid=$apiKeys&units=metric'));
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load weather data. Status Code: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }

  Future<String> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      throw Exception('Failed to obtain location. Error: $e');
    }

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemark.isNotEmpty ? placemark[0].locality : null;
    return city ?? '';
  }
}
