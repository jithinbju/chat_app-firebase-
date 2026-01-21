import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource datasource;

  WeatherRepositoryImpl(this.datasource);

  @override
  Future<WeatherEntity> getCurrentWeather(String city) {
    return datasource.fetchWeather(city);
  }
}
