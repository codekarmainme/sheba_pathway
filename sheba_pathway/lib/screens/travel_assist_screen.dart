import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/widgets/destnation_text_container.dart';
import 'package:sheba_pathway/widgets/weather_container.dart';

class TravelAssistScreen extends StatefulWidget {
  const TravelAssistScreen({super.key});

  @override
  State<TravelAssistScreen> createState() => _TravelAssistScreenState();
}

class _TravelAssistScreenState extends State<TravelAssistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Harar Jegol',
          style: largeText.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.route, color: successColor))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.cloudSunRain,
                            size: 20,
                            color: warningColor,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Weather Forecast',
                            style: mediumText.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    WeatherContainer(
                      city: 'Addis Ababa',
                      temperature: 12.0,
                      humidity: 90,
                      rain: 60,
                      weather: 'Sunny',
                      icon: Icons.cloudy_snowing,
                    ),
                    WeatherContainer(
                      city: 'Dire Dawa',
                      temperature: 30.0,
                      humidity: 50,
                      rain: 5,
                      weather: 'Sunny',
                      icon: Icons.wb_sunny_rounded,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.route, color: Colors.white),
                    onPressed: () {
                      // Navigation logic here
                    },
                    label: Text(
                      'Open map',
                      style: mediumText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      textStyle:
                          mediumText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _poiContainer(
                        Icons.restaurant, "Restaurants", restaurantColor),
                    _poiContainer(Icons.hotel, "Hotels", purpleColor),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    DestnationTextContainer(
                      imagePath: "assets/images/jegol ginb.png",
                      title: "Harar Jegol Wall",
                      description:
                          "Harar Jegol Wall is one of the oldest city walls in Africa, built in the 16th century to protect the city of Harar. It is a UNESCO World Heritage site and a symbol of the city's rich history and culture.",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _poiContainer(IconData icon, String widgettitle, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width /2 -16,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              widgettitle,
              style: mediumText.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
