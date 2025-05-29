import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/models/top_trips_model.dart';
import 'package:sheba_pathway/screens/map_screen.dart';
import 'package:sheba_pathway/widgets/add_sheet.dart';
import 'package:sheba_pathway/widgets/review_container.dart';

class ViewScreen extends StatefulWidget {
  final TopTripsModel trip;

  const ViewScreen({super.key, required this.trip});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  MapLibreMapController? mapController;
  late List<String> assetNames;
  int _currentImage = 0;
  @override
  void initState() {
    super.initState();
    assetNames = [
      widget.trip.assetName,
      widget.trip.assetName,
      widget.trip.assetName
    ];
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
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            itemCount: assetNames.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentImage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: AssetImage(assetNames[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 24,
                            left: 16,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back button
                                CircleAvatar(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.white),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                // Place name
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        widget.trip.placeName,
                                        style: GoogleFonts.sora(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  child: IconButton(
                                    icon: Icon(Icons.favorite_border,
                                        color: Colors.white),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                assetNames.length,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  width: _currentImage == index ? 12 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentImage == index
                                        ? primaryColor
                                        : Colors.white70,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.trip.placeName,
                      style: GoogleFonts.sora(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) => AddSheet(
                            lat: widget.trip.coordinates.latitude,
                            lng: widget.trip.coordinates.longitude,
                            tripName: widget.trip.placeName,
                          ),
                        );
                      },
                      icon: Icon(Icons.add_task, color: Colors.white),
                      label: Text(
                        'Add to plan',
                        style: normalText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 6,
                        shadowColor: primaryColor.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        textStyle:
                            normalText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
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
                      widget.trip.location,
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
                      child: MapLibreMap(
                        styleString:
                            'https://api.maptiler.com/maps/0196d39b-1c1e-7bae-9032-c853a35836c1/style.json?key=egOiZJUpRA3sNsKcxi0p',
                        initialCameraPosition: CameraPosition(
                          target: widget.trip.coordinates,
                          zoom: 15,
                        ),
                        onMapCreated: (controller) async {
                          mapController = controller;
                          if (mapController != null) {
                            try {
                              final ByteData bytes = await rootBundle
                                  .load('assets/images/location.png');
                              final Uint8List imageData =
                                  bytes.buffer.asUint8List();
                              await mapController!
                                  .addImage("marker-custom", imageData);

                              mapController!.addSymbol(
                                SymbolOptions(
                                  geometry: widget.trip.coordinates,
                                  iconImage: "marker-custom",
                                  iconSize: 0.1,
                                  textOffset: const Offset(0, 1.5),
                                ),
                              );
                            } catch (e) {
                              debugPrint("Error adding custom marker: $e");
                            }
                          }
                        },
                      ),
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
