import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/widgets/group_trip_container.dart';
import 'package:sheba_pathway/widgets/top_trip_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFilterOpened=false;
  void setisFilteredOpened(){
    setState(() {
      isFilterOpened=!isFilterOpened;
    });}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor, // Change this to your desired color
        statusBarIconBrightness: Brightness.light, // or Brightness.dark
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Consumer<MappingProvider>(
            builder: (context, mappingProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: normalText.copyWith(
                                color: Colors.black.withOpacity(0.8)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 18,
                              ),
                              Text(
                                  mappingProvider.currentPlaceName ??
                                      "Untracked",
                                  style: normalText.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage("assets/images/pp.jpg")),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // showSearch(
                          //     context: context, delegate: PlaceSearchDelegate());
                        },
                        child: Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black.withOpacity(0.1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                Text(
                                  "Search",
                                  style: mediumText.copyWith(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                       GestureDetector(onTap: setisFilteredOpened, child:Icon(Icons.tune)),
                    ],
                  ),
                ),
                if(isFilterOpened)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                _buttonTune("Top rated", () {}),
                SizedBox(
                  width: 10,
                ),
                _buttonTune("Closest", () {}),
                SizedBox(
                  width: 10,
                ),
                _buttonTune("Open now", () {})
              ],
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Near by Trips",
                          style: mediumText.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("See all",
                          style: normalText.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TopTripContainer(
                        assetName: "assets/images/Hailselassie house.png",
                        locaition: 'Harar',
                        price: "ETB 4000",
                        placeName: 'Selassie House',
                      ),
                      TopTripContainer(
                        assetName:
                            "assets/images/hararge traditional houses.png",
                        locaition: 'Dire Dawa',
                        price: "ETB 3000",
                        placeName: 'Traditional Houses',
                      ),
                      TopTripContainer(
                        assetName: "assets/images/jegol ginb.png",
                        locaition: 'Harar',
                        price: "ETB 4000",
                        placeName: 'Gegol Castle',
                      ),
                      TopTripContainer(
                        assetName: "assets/images/Midr babur.png",
                        locaition: 'Dire Dawa',
                        price: "ETB 4000",
                        placeName: 'Metro',
                      ),
                      TopTripContainer(
                        assetName: "assets/images/yedro midr babur.png",
                        locaition: 'Dire Dawa',
                        price: "ETB 4000",
                        placeName: 'Old metro',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Catagories",
                          style: mediumText.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("See all",
                          style: normalText.copyWith(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.5),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.water,
                              color: primaryColor,
                              size: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                "Lakes",
                                style: normalText,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.landmark,
                              color: primaryColor,
                              size: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                "Castles",
                                style: normalText,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.mountain,
                              color: primaryColor,
                              size: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                "Mountain",
                                style: normalText,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.tree,
                              color: primaryColor,
                              size: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                "Forest",
                                style: normalText,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Top Trips",
                          style: mediumText.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("See all",
                          style: normalText.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TopTripContainer(
                        assetName: "assets/images/lake tana.jpg",
                        locaition: 'Bahir dar',
                        price: "ETB 4000",
                        placeName: 'Lake Tana',
                      ),
                      TopTripContainer(
                        assetName: "assets/images/lake tana.jpg",
                        locaition: 'Fikr hayq',
                        price: "ETB 3000",
                        placeName: 'Fikr Hayq',
                      ),
                      TopTripContainer(
                        assetName: "assets/images/lake tana.jpg",
                        locaition: 'Langano',
                        price: "ETB 4000",
                        placeName: 'Arbamnich',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Group Trips",
                          style: mediumText.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("See all",
                          style: normalText.copyWith(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.5),
                          ))
                    ],
                  ),
                ),
                GroupTripContainer(
                    assetName: "assets/images/mountain.jpg",
                    locaition: "Gondar",
                    price: "ETB 3000",
                    placeName: "Semein")
              ],
            ),
          );
        }),
      ),
    );
  }
  
  Widget _buttonTune(String txt, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              txt,
              style: normalText.copyWith(
                  color: Colors.black),
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
           ),
      ),
    );
  }
}
