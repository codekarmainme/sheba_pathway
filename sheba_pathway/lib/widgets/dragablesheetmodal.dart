import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/search_screen.dart';
import 'package:intl/intl.dart';
import 'package:sheba_pathway/widgets/cost_model_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_state.dart';

class Dragablesheetmodal extends StatefulWidget {
  const Dragablesheetmodal({super.key, required this.startCallback});
  final VoidCallback startCallback;

  @override
  State<Dragablesheetmodal> createState() => _DragablesheetmodalState();
}

class _DragablesheetmodalState extends State<Dragablesheetmodal> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return BlocBuilder<LocationSelectionBloc, LocationSelectionState>(
          builder: (context, locationState) {
            final startLocation = locationState.startLocation;
            final destinationLocation = locationState.destinationLocation;

            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Start Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.my_location_outlined, color: purpleColor, size: 15),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: PlaceSearchDelegate(isStartLocation: true),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          startLocation != null && startLocation['name'] != null && startLocation['name'].toString().isNotEmpty
                                              ? startLocation['name']
                                              : "Your location",
                                          overflow: TextOverflow.visible,
                                          style: normalText.copyWith(
                                            color: black3.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.swap_vert_outlined),
                      // Destination Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/location.svg", height: 15, width: 15),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: PlaceSearchDelegate(isStartLocation: false),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          destinationLocation != null && destinationLocation['name'] != null && destinationLocation['name'].toString().isNotEmpty
                                              ? destinationLocation['name']
                                              : "Choose destination",
                                          overflow: TextOverflow.visible,
                                          style: normalText.copyWith(
                                            color: black3.withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CostModelContainer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Wrap(
                          spacing: 20,
                          children: [
                            Text(
                              DateFormat('h:mm a').format(DateTime.now()),
                              style: smallText.copyWith(
                                color: black2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Add BlocBuilder for route/timing data here if needed
                            // Example:
                            // BlocBuilder<RouteBloc, RouteState>(
                            //   builder: (context, routeState) {
                            //     if (routeState is RouteLoaded) {
                            //       return Text("${routeState.time} min");
                            //     }
                            //     return SizedBox();
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      const Divider(),
                      // Example: Show buttons if both locations are selected
                      if (startLocation != null && destinationLocation != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _button('Start', Icons.navigation, widget.startCallback),
                                const SizedBox(width: 5),
                                _button('Save', Icons.favorite, () {}),
                                const SizedBox(width: 5),
                                _button('Export', Icons.arrow_outward, () {}),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _button(String txt, IconData icon, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black, size: 15),
              Text(
                txt,
                style: normalText.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: primaryColor, width: 1),
        ),
      ),
    );
  }
}