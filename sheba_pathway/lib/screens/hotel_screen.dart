import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/hotel_provider.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/widgets/hotel_container.dart';
import 'package:sheba_pathway/widgets/shimmer_container.dart';
import 'package:sheba_pathway/common/colors.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  Position? currentPosition;
  bool isFilterOpened=false;
  void setisFilteredOpened(){
    setState(() {
      isFilterOpened=!isFilterOpened;
    });
  }
  void getCurrentPosition() async {
    final mappingProvider =
        Provider.of<MappingProvider>(context, listen: false);
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);

    currentPosition = await mappingProvider.determinePosition(context);
    if (currentPosition != null) {
      hotelProvider.fetchHotels(
        currentPosition!.latitude,
        currentPosition!.longitude,
        1000,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hotels",
                  style: largeText.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/pp.jpg"),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // Add search functionality here
                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black.withOpacity(0.1),
                      ),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(onTap: setisFilteredOpened, child: Icon(Icons.tune)),
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
            Expanded(
              child: Consumer<HotelProvider>(
                builder: (context, hotelProvider, child) {
                  if (hotelProvider.fetchedHotels.isEmpty) {
                    return ListView.builder(
                      itemCount: 5, // Number of shimmer placeholders
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerContainer(
                                    height: 10,
                                    width: MediaQuery.of(context).size.width *
                                        0.5),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ShimmerContainer(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 100),
                                    ShimmerContainer(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 100)
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ShimmerContainer(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                    ShimmerContainer(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2)
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ShimmerContainer(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                    ShimmerContainer(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2)
                                  ],
                                )
                              ],
                            ));
                      },
                    );
                  } else {
                    // Render fetched hotels
                    return ListView.builder(
                      itemCount: hotelProvider.fetchedHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = hotelProvider.fetchedHotels[
                            index]; // Access HotelModels instance
                        return HotelContainer(
                          name: hotel.hotelName ??
                              'Unknown', // Use hotelName from HotelModels
                          distnce: hotel.hotelDistance ??
                              'N/A', // Use hotelDistance from HotelModels
                          time: hotel.hotelTime ??
                              'N/A', // Use hotelTime from HotelModels
                          location: hotel.hotelLocation ?? 'Unknown Location',
                          lat: hotel.lat!,
                          long: hotel.lon!,
                          phoneNumber: hotel
                              .phoneNumber!, // Use hotelLocation from HotelModels
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: black2, width: 2)),
      ),
    );
  }
}
