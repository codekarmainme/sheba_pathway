import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/added_travel_plans.dart';
import 'package:sheba_pathway/widgets/discount_section.dart';
import 'package:sheba_pathway/widgets/group_trip_container.dart';
import 'package:sheba_pathway/widgets/top_trip_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/fake data/top_trips.dart';
import 'package:sheba_pathway/screens/trip_search_screen.dart';
import 'package:sheba_pathway/fake data/all_trips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.currentPlaceName});
  final String? currentPlaceName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFilterOpened = false;
  String selectedCatagory = 'Gondar';
  void setSelectedCatagory(String catagory) {
    setState(() {
      selectedCatagory = catagory;
    });
  }

  final List<Map<String, dynamic>> _catagories = [
    {
      "catagory": 'Gondar',
      "icon": FontAwesomeIcons.landmark,
    },
    {
      "catagory": 'Addis Ababa',
      "icon": FontAwesomeIcons.city,
    },
    {
      "catagory": 'Bahir dar',
      "icon": FontAwesomeIcons.water,
    },
    {
      "catagory": 'Lalibela',
      "icon": FontAwesomeIcons.landmark,
    },
    {
      "catagory": 'Axum',
      "icon": FontAwesomeIcons.landmark,
    },
    {
      "catagory": 'Harar',
      "icon": FontAwesomeIcons.landmark,
    },
    {
      "catagory": 'Hawssa',
      "icon": FontAwesomeIcons.water,
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
            body: SingleChildScrollView(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddedTravelPlans()));
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
                    showSearch(
                      context: context,
                      delegate: TripSearchDelegate(
                        topTrips.map((trip) => trip.placeName).toList(),
                      ),
                    );
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
          DiscountSection(
            onTap: (index) {
              if (index == 0) {
              } else if (index == 1) {}
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Near by Trips",
                    style: mediumText.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
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
                        color: Colors.black, fontWeight: FontWeight.bold)),
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
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: catagory['catagory'] == selectedCatagory
                          ? primaryColor
                          : Colors.white,
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                  color:
                                      catagory['catagory'] == selectedCatagory
                                          ? Colors.white
                                          : black2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allTrips
                  .where((trip) => trip.catagory == selectedCatagory)
                  .map((trip) => TopTripContainer(trip: trip))
                  .toList(),
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
    )));
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
