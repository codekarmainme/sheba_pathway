import 'dart:ui';
import 'package:flutter/material.dart';

class WeatherContainer extends StatelessWidget {
  final String city;
  final double temperature;
  final int humidity;
  final double rain; // in mm or %
  final IconData icon;
  final String weather;

  const WeatherContainer({
    super.key,
    this.city = "Addis Ababa",
    this.temperature = 24.5,
    this.humidity = 60,
    this.rain = 0.0,
    this.icon = Icons.wb_sunny_rounded,
    this.weather = "Sunny",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent.withOpacity(0.22),
                  Colors.white.withOpacity(0.12),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.09),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blueGrey[900],
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        weather,
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(Icons.thermostat, color: Colors.redAccent, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "${temperature.toStringAsFixed(1)}°C",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent[700],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.water_drop, color: Colors.blue, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "$humidity%",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.grain, color: Colors.lightBlue, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "${rain.toStringAsFixed(1)} mm",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}