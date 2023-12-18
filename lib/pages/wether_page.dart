import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final _WeatherService =
      WeatherServices(apiKeys: '8a97015d932da6b511c927d6ced0a204');
  Weather? _weather;

  fetchWeather() async {
    String CityName = await _WeatherService.getLocation();
    try {
      final Weather = await _WeatherService.getWeather(CityName);
      setState(() {
        _weather = Weather;
      });
    } catch (e) {
      ("error");
    }
  }

  String getLocationWetherAssets(String? mainCondation) {
    if (mainCondation == null) return 'asset/images/sunrise.json';
    switch (mainCondation.toLowerCase()) {
      case 'cloude':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'asset/images/cloudyrain.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'asset/images/cloudy.json';
      case 'clear':
        return 'asset/images/cloudy.json';
      default:
        return 'asset/images/sunrise.json';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(getLocationWetherAssets(_weather?.mainCondation)),
            Text(
              _weather?.CityName ?? 'Loading city......',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            Text(_weather?.mainCondation ?? "")
          ],
        ),
      ),
    );
  }
}
