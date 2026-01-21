import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/presentation/screens/splash_screen.dart';
import 'data/datasources/weather_remote_datasource.dart';
import 'data/datasources/weather_repository_impl.dart';
import 'domain/usecases/get_weather_forecast.dart';
import 'presentation/state/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            GetWeatherForecast(
              WeatherRepositoryImpl(
                WeatherRemoteDatasource(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
