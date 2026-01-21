import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/weather_model.dart';

class WeatherRemoteDatasource {
  Future<WeatherModel> fetchWeather(String city) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/$city?format=j1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final temp =
          double.parse(jsonData['current_condition'][0]['temp_C']);
      final desc =
          jsonData['current_condition'][0]['weatherDesc'][0]['value'];

      return WeatherModel(
        city: city,
        temperature: temp,
        description: desc,
      );
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
