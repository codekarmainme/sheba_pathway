import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class YouScreen extends StatelessWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/pp.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color for the icon
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: black2,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Joe Doe",
            style:
                normalText.copyWith(color: black2, fontWeight: FontWeight.bold),
          ),
          Text(
            "Traveler",
            style: normalText.copyWith(color: black2.withOpacity(0.8)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _contributeTypeContainer("Hotel", Icons.hotel),
                _contributeTypeContainer("Home", Icons.home),
                _contributeTypeContainer(
                    "Travel destination", Icons.add_location),
                    _contributeTypeContainer("Add hotel", Icons.add_location),
                _contributeTypeContainer("Update places", Icons.edit_location),
                

              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Your places",
                style: normalText.copyWith(
                    color: black2, fontWeight: FontWeight.bold),
              ),
              Text("Saved",
                  style: normalText.copyWith(
                      color: black2, fontWeight: FontWeight.bold)),
              Text(
                "Want to go",
                style: normalText.copyWith(
                    color: black2, fontWeight: FontWeight.bold),
              ),
              Text(
                "Reviwed",
                style: normalText.copyWith(
                    color: black2, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(

          ),
          Expanded(child: Center(child: Text("You don't add any place yet",style: normalText,)))
        ],
      ),
    );
  }

  Widget _contributeTypeContainer(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: secondaryColor, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 16,
                      ),
                    )),
                Text(text,
                    style: smallText.copyWith(
                        color: secondaryColor, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
