import 'package:flutter/material.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_weather_forecast.dart';

class WeatherProvider extends ChangeNotifier {
  final GetWeatherForecast getWeatherForecast;

  WeatherProvider(this.getWeatherForecast);

  bool isLoading = false;
  String? error;
  WeatherEntity? weather;

  Future<void> loadWeather(String city) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      weather = await getWeatherForecast(city);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
