import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/home_screen.dart';
import 'package:sheba_pathway/widgets/turn_container.dart';
import 'package:flutter/material.dart';

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
    initialChildSize: 0.5,
    minChildSize: 0.2,
    maxChildSize: 0.8,
    builder: (BuildContext context, ScrollController scrollController) {
      return BlocBuilder<MappingBloc, MappingState>(
        builder: (context, mappingstate) {
          if (mappingstate is MappingSuccess) {
            final maneuvers = mappingstate.routingdata['manuevers'] as List<dynamic>;
            final timetake = mappingstate.routingdata['timetake'];
            final distancebnpoints = mappingstate.routingdata['distancebnpoints'];

            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              if (timetake != null)
                                Text(
                                  "${timetake.toStringAsFixed(2)} min",
                                  style: mediumText.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (distancebnpoints != null)
                                Row(
                                  children: [
                                    Text(
                                      "${distancebnpoints.toStringAsFixed(2)} KM",
                                      style: smallText.copyWith(
                                        color: black2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: black2,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateFormat('h:mm a').format(DateTime.now()),
                                      style: smallText.copyWith(
                                        color: black2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },
                            child: Text(
                              "Exit",
                              style: mediumText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView(
                        controller: scrollController,
                        children: maneuvers.map<Widget>((maneuver) {
                          return TurnContainer(
                            type: maneuver['type'],
                            instruction: maneuver['instruction'],
                            length: maneuver['length'].toString(),
                            time: maneuver['time'].toString(),
                            street_name: maneuver['street_names'].isNotEmpty
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
          } else if (mappingstate is MappingLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text("No routing data available"));
          }
        },
      );
    },
  );
}
}
