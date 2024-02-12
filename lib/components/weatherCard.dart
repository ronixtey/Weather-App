import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final int temperature;
  final String iconCode;

  const WeatherCard({
    required this.title,
    required this.temperature,
    required this.iconCode,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  "http://openweathermap.org/img/wn/${this.iconCode}@4x.png"),
              Text(
                '${this.temperature}°',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              ),
              Text(
                'Feels like ${this.title}°',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}