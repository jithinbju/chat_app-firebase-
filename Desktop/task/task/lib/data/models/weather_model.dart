import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.city,
    required super.temperature,
    required super.description,
  });
factory WeatherModel.fromJson(Map<String, dynamic> json) {
  return WeatherModel(
    city: json['name'] ?? '',
    temperature: (json['main']?['temp'] ?? 0).toDouble(),
    description: json['weather']?[0]?['description'] ?? '',
  );
}

}
