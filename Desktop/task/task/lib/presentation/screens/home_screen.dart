import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/presentation/state/weather_provider.dart';
import 'package:task/presentation/widgets/weather_card.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('Crop Advisory'),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          children: [
             Spacer(),

            if (provider.isLoading)
               CircularProgressIndicator(),

            if (provider.error != null)
              Text(
                provider.error!,
                style:  TextStyle(color: Colors.red),
              ),

            if (provider.weather != null)
              AdvisoryCard(
                city: provider.weather!.city,
                temperature: provider.weather!.temperature,
                description: provider.weather!.description,
              ),

             SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:  EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: provider.isLoading
                    ? null
                    : () => provider.loadWeather('Palakkad'),
                child:  Text(
                  'View Today’s Advisory',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

             Spacer(),
          ],
        ),
      ),
    );
  }
}
