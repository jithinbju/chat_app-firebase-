import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeatherForecast {
  final WeatherRepository repository;

  GetWeatherForecast(this.repository);

  Future<WeatherEntity> call(String city) {
    return repository.getCurrentWeather(city);
  }
}
