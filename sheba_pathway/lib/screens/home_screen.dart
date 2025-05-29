import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/models/top_trips_model.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/screens/added_travel_plans.dart';
import 'package:sheba_pathway/widgets/group_trip_container.dart';
import 'package:sheba_pathway/widgets/top_trip_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/fake data/top_trips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.currentPlaceName});
  final String? currentPlaceName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFilterOpened = false;
  String selectedCatagory = 'Lakes';
  void setSelectedCatagory(String catagory) {
    setState(() {
      selectedCatagory = catagory;
    });
  }

  final List<Map<String, dynamic>> _catagories = [
    {
      "catagory": 'Lakes',
      "icon": FontAwesomeIcons.water,
    },
    {
      "catagory": 'Castles',
      "icon": FontAwesomeIcons.landmark,
    },
    {
      "catagory": 'Mountains',
      "icon": FontAwesomeIcons.mountain,
    },
    {
      "catagory": 'Forest',
      "icon": FontAwesomeIcons.tree,
    }
  ];
  void setisFilteredOpened() {
    setState(() {
      isFilterOpened = !isFilterOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    
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
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: black2,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.currentPlaceName ?? "",
                                  style: normalText.copyWith(
                                    color: black2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Added Plans Icon with Badge
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.event_note,
                                      color: primaryColor, size: 28),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddedTravelPlans()));
                                  },
                                  tooltip: "Added Plans",
                                ),
                                // Badge
                                Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '3', // Replace with your dynamic plans count
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            // Notifications Icon
                            Stack(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.bell,
                                      color: black2, size: 22),
                                  onPressed: () {},
                                  tooltip: "Notifications",
                                ),
                                  Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '1', // Replace with your dynamic plans count
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
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
                              borderRadius: BorderRadius.circular(10),
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
                      GestureDetector(
                          onTap: setisFilteredOpened, child: Icon(Icons.tune)),
                    ],
                  ),
                ),
                if (isFilterOpened)
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
                    children: topTrips
                        .map((trip) => TopTripContainer(
                              trip: trip,
                            ))
                        .toList(),
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
                  child: ListView.builder(
                    itemCount: _catagories.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      final catagory = _catagories[index];
                      return GestureDetector(
                        onTap: () {
                          setSelectedCatagory(catagory['catagory']);
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: catagory['catagory'] == selectedCatagory
                                ? primaryColor
                                : Colors.white,
                            border: Border.all(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                catagory['icon'],
                                color: catagory['catagory'] == selectedCatagory
                                    ? Colors.white
                                    : black2,
                                size: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  catagory['catagory'],
                                  style: normalText.copyWith(
                                      color: catagory['catagory'] ==
                                              selectedCatagory
                                          ? Colors.white
                                          : black2),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
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
                        trip: TopTripsModel(
                            assetName: "assets/images/lake tana.jpg",
                            location: 'Bahir dar',
                            price: "ETB 4000",
                            placeName: 'Lake Tana',
                            catagory: 'Lakes',
                            coordinates: LatLng(11.6031, 37.3833)
                            ),
                      ),
                      TopTripContainer(
                        trip: TopTripsModel(
                            assetName: "assets/images/lake tana.jpg",
                            location: 'Fikr hayq',
                            price: "ETB 3000",
                            placeName: 'Fikr Hayq',
                            catagory: 'Lakes',
                            coordinates: LatLng(11.6031, 37.3833)
                            
                            ),
                      ),
                      TopTripContainer(
                        trip: TopTripsModel(
                            assetName: "assets/images/lake tana.jpg",
                            location: 'Langano',
                            price: "ETB 4000",
                            placeName: 'Arbamnich',
                            catagory: 'Lakes',
                            coordinates: LatLng(11.6031, 37.3833)
                            
                            ),
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
                  placeName: "Semein",
                  percentFilled: 0.6,
                )
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
              style: normalText.copyWith(color: Colors.black),
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
