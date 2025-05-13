import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:sheba_pathway/screens/home_screen.dart';
import 'package:sheba_pathway/widgets/turn_container.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TurnByTurnModal extends StatefulWidget {


  @override
  State<TurnByTurnModal> createState() => _TurnByTurnModalState();
}

class _TurnByTurnModalState extends State<TurnByTurnModal> {
  bool isfitedRoute=true;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5, // Start with half screen
      minChildSize: 0.2, // Minimum size when dragged down
      maxChildSize: 0.8, // Maximum size when dragged up

      builder: (BuildContext context, ScrollController scrollController) {
        return Consumer<MappingProvider>(
          builder: (context, mappingProvider, child) {
            return StreamBuilder<Position>(
              stream: mappingProvider.positionStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      'No position data available',
                      style: mediumText.copyWith(color: black2),
                    ),
                  );
                } else {
                  final position = snapshot.data!;
                  return SingleChildScrollView(
                    controller: scrollController, // Pass the scroll controller
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    if (mappingProvider.timetake != null)
                                      Text(
                                        "${mappingProvider.timetake!.toStringAsFixed(2)} min",
                                        style: mediumText.copyWith(
                                            color: primaryColor,fontWeight: FontWeight.bold),
                                      ),
                                    if (mappingProvider.distencebnpoints !=
                                        null)
                                      Row(
                                        children: [
                                          Text(
                                            "${mappingProvider.distencebnpoints!.toStringAsFixed(2)} KM",
                                            style: smallText.copyWith(
                                                color: black2,fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            child: Container(
                                              height: 5,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: black2),
                                            ),
                                          ),
                                          Text(
                                            DateFormat('h:mm a')
                                                .format(DateTime.now()),
                                            style: smallText.copyWith(
                                                color: black2,fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                   
                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            elevation: 0),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));
                                        },
                                        child: Text(
                                          "Exit",
                                          style: mediumText.copyWith(
                                              color: Colors.white,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView(
                              controller:
                                  scrollController, // Also pass controller to inner ListView
                              children:
                                  mappingProvider.maneuvers.map((maneuver) {
                                // final isActive = locationProvider
                                //     .checkuserProximityToManeuvers(position,
                                //         maneuver['lat'], maneuver['lon']);
                                return TurnContainer(
                                  type: maneuver['type'],
                                  instruction: maneuver['instruction'],
                                  length: maneuver['length'].toString(),
                                  time: maneuver['time'].toString(),
                                  street_name:
                                      maneuver['street_names'].isNotEmpty
                                          ? maneuver['street_names'][0]
                                          : '',
                                  lat: maneuver['lat'],
                                  lon: maneuver['lon'],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
