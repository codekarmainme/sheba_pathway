import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/common/colors.dart';

import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/screens/main_navigator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/tour with map.jpg'),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "We need your location for the better experience and acurate result of trips and hotels.",
                  style: mediumText.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final mappingProvider =
                      Provider.of<MappingProvider>(context, listen: false);
                  final position =
                      await mappingProvider.determinePosition(context);
                      print(position);
                      await mappingProvider.determinePlaceName(position);
                      print("object");
                  if (position != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainNavigator()));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  child: Center(
                      child: Text(
                    "Allow location",
                    style: mediumText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25)),
                ),
              )
            ]));
  }
}
