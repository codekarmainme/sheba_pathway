import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/map_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sheba_pathway/widgets/review_container.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Text(
                      "Selassie house view",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.favorite_border)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/Hailselassie house.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Hailselassie house.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Hailselassie house.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Selassie House",
                  style: GoogleFonts.sora(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black.withOpacity(0.5),
                      size: 15,
                    ),
                    Text(
                      "Harar",
                      style: GoogleFonts.sora(
                          color: Colors.black.withOpacity(0.5), fontSize: 12),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_circle_fill,
                        color: primaryColor,
                      ),
                      Text(
                        "Selassie house is  found in eastern  region of Ethiopia, Harar in 1700 meter above sea level which te deepes in ethiopia and 4th in African. It is the dource of for the river called Abay(Nile) which the the longest river in the world.it is a site of many ecosystem and profound of many historical places.it surface is between 300 and 3500 square kilo meter based on rainfall.",
                        style: GoogleFonts.sora(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: FlutterMap(children: [
                        TileLayer(
                          urlTemplate:
                              'https://api.maptiler.com/maps/basic-v2-dark/256/{z}/{x}/{y}.png?key=egOiZJUpRA3sNsKcxi0p',
                        ),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.navigation,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  "Go to map",
                                  style:
                                      normalText.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ReviewContainer(),
                    ReviewContainer(),
                    ReviewContainer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
