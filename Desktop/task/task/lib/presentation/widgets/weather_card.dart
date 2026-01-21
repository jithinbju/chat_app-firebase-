import 'package:flutter/material.dart';

class AdvisoryCard extends StatelessWidget {
  final String city;
  final double temperature;
  final String description;

   AdvisoryCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.description,
  });

  String get advisoryMessage {
    if (temperature > 30) {
      return 'High temperature detected. Irrigate crops in the evening.';
    } else if (temperature < 20) {
      return 'Low temperature. Monitor crop growth carefully.';
    } else {
      return 'Weather conditions are favorable for crops.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding:  EdgeInsets.all(24),
        child: Column(
          children: [
             Icon(Icons.eco, size: 36, color: Colors.green),
             SizedBox(height: 8),

            Text(
              city,
              style: Theme.of(context).textTheme.titleLarge,
            ),

             SizedBox(height: 12),

            Text(
              'Weather: ${temperature.toStringAsFixed(1)}°C • $description',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),

             SizedBox(height: 16),

            Text(
              'Today’s Advisory',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
             SizedBox(height: 6),
            Text(
              advisoryMessage,
              textAlign: TextAlign.center,
            ),

             SizedBox(height: 12),

            Chip(
              label:  Text('Crop-friendly conditions'),
              backgroundColor: Colors.green.shade100,
            ),
          ],
        ),
      ),
    );
  }
}
