import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_flutter/models/weather_model.dart';
import 'package:weather_flutter/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("e6fcff8c5fab948bca310372013e0f4b");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getcurrencyCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print(error);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_weather?.cityName ?? "loading city..", style: TextStyle(fontSize: 30)),
        Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        Text('${_weather?.temperature.round()}°C'),
        Text(_weather?.mainCondition ?? ''),
      ],
    )));
  }
}
