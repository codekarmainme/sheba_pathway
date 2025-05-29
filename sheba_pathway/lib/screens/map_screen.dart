import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/cost_model/cost_model_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_state.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_state.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/stream_position/stream_position_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/stream_position/stream_position_state.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/stream_position/stream_position_bloc.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:provider/provider.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sheba_pathway/widgets/dragablesheetmodal.dart';
import 'package:sheba_pathway/widgets/turn_by_turn_sheet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // late MapController _mapController;
  MapLibreMapController? mapController;
  late String MAPTILER;
  bool isturnbyturn_on = false;
  void setIsturnbyturn_on() {
    setState(() {
      isturnbyturn_on = true;
    });
  }

  void _fitPolylineBounds(BuildContext context) {
    List<LatLng> locations = [];

    final locationState = context.read<LocationSelectionBloc>().state;

    if (locationState.startLocation != null &&
        locationState.startLocation!['coordinates'] != null) {
      final coords = locationState.startLocation!['coordinates'];
      locations.add(LatLng(coords[1], coords[0])); // [lat, lng]
    }

    if (locationState.destinationLocation != null &&
        locationState.destinationLocation!['coordinates'] != null) {
      final coords = locationState.destinationLocation!['coordinates'];
      locations.add(LatLng(coords[1], coords[0])); // [lat, lng]
    }

    if (locations.isNotEmpty) {
      // Initialize the bounds with the first point
      LatLngBounds bounds = LatLngBounds(
        southwest: locations.first,
        northeast: locations.first,
      );

      // Expand the bounds to include all points
      for (var point in locations) {
        bounds = LatLngBounds(
          southwest: LatLng(
            bounds.southwest.latitude < point.latitude
                ? bounds.southwest.latitude
                : point.latitude,
            bounds.southwest.longitude < point.longitude
                ? bounds.southwest.longitude
                : point.longitude,
          ),
          northeast: LatLng(
            bounds.northeast.latitude > point.latitude
                ? bounds.northeast.latitude
                : point.latitude,
            bounds.northeast.longitude > point.longitude
                ? bounds.northeast.longitude
                : point.longitude,
          ),
        );
      }

      // Animate the camera to fit the bounds
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mapController != null) {
          mapController!.moveCamera(CameraUpdate.newLatLngBounds(bounds));
        } else {
          debugPrint("MapLibreMapController is null. Cannot fit bounds.");
        }
      });
    } else {
      debugPrint("No route points available to fit bounds.");
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(StartLocationUpdates());
    MAPTILER=dotenv.env['MAPTILER']!;

  }

  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocConsumer<MappingBloc, MappingState>(
            listener: (context, mappingstate) => {
         if (mappingstate is MappingSuccess) {
         if (mapController != null && mappingstate.routingdata['routePoints'].isNotEmpty) {
        mapController!.addLine(
          LineOptions(
            geometry: mappingstate.routingdata['routePoints'],
            lineColor: "#7603A0",
            lineWidth: 8.0,
          ),
        )
      }
      // You can also access distance and time if needed:
      // final distance = mappingstate.routingdata['distancebnpoints'];
      // final time = mappingstate.routingdata['timetake'];
    }

            },
            builder: (context, mappingstate) {
              
              return BlocConsumer<LocationBloc, LocationState>(
                  listener: (context, state) {},
                  builder: (context, locationstate) {
                    if (locationstate is LocationUpdateSuccess) {
                      final currentPosition = locationstate.position;

                      return Stack(
                        children: [
                          BlocBuilder<LocationSelectionBloc,
                              LocationSelectionState>(
                            builder: (context, state) {
                              final startlocation = state.startLocation;
                              final destinationLocation =
                                  state.destinationLocation;
                              final costModelState =
                                  context.watch<CostModelBloc>().state;
                              String selectedCostModel =
                                  costModelState.selectedCostingModel['label'];

                              if (startlocation != null &&
                                  destinationLocation != null &&
                                  state.isChangeApeared) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  context.read<MappingBloc>().add(
                                        FetchRoutingDataBetweenTwoPoints(
                                          LatLng(
                                            startlocation['coordinates'][0],
                                            startlocation['coordinates'][1],
                                          ),
                                          LatLng(
                                            destinationLocation['coordinates']
                                                [0],
                                            destinationLocation['coordinates']
                                                [1],
                                          ),
                                          selectedCostModel, // Pass the cost model here
                                        ),
                                      );
                                });
                                context
                                    .read<LocationSelectionBloc>()
                                    .add(SetIsChangeApeared(false));
                              }

                              if (mapController !=
                                      null &&
                                  destinationLocation != null) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) async {
                                  try {
                                    // Check if marker already exists, or remove previous if needed
                                    final ByteData bytes = await rootBundle
                                        .load('assets/images/location.png');
                                    final Uint8List imageData =
                                        bytes.buffer.asUint8List();
                                    await mapController!
                                        .addImage("marker-custom", imageData);

                                    mapController!.addSymbol(
                                      SymbolOptions(
                                        geometry: LatLng(
                                          destinationLocation['coordinates'][0],
                                          destinationLocation['coordinates'][1],
                                        ),
                                        iconImage: "marker-custom",
                                        iconSize: 0.1,
                                        textOffset: const Offset(0, 1.5),
                                      ),
                                    );
                                  } catch (e) {
                                    debugPrint(
                                        "Error adding custom marker: $e");
                                  }
                                });
                              }
                                if (mapController !=
                                      null &&
                                  startlocation != null) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) async {
                                  try {
                                    // Check if marker already exists, or remove previous if needed
                                    final ByteData bytes = await rootBundle
                                        .load('assets/images/location.png');
                                    final Uint8List imageData =
                                        bytes.buffer.asUint8List();
                                    await mapController!
                                        .addImage("marker-custom", imageData);

                                    mapController!.addSymbol(
                                      SymbolOptions(
                                        geometry: LatLng(
                                          startlocation['coordinates'][0],
                                          startlocation['coordinates'][1],
                                        ),
                                        iconImage: "marker-custom",
                                        iconSize: 0.1,
                                        textOffset: const Offset(0, 1.5),
                                      ),
                                    );
                                  } catch (e) {
                                    debugPrint(
                                        "Error adding custom marker: $e");
                                  }
                                });
                              }
                              if (mapController != null &&
                                  destinationLocation != null &&
                                  startlocation != null) {}
                              return MapLibreMap(
                                styleString:
                                    'https://api.maptiler.com/maps/0196d39b-1c1e-7bae-9032-c853a35836c1/style.json?key=$MAPTILER',
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(currentPosition.latitude,
                                      currentPosition.longitude),
                                  zoom: 15,
                                ),
                                onMapCreated: (controller) async {
                                  mapController = controller;

                                  if (mapController != null) {
                                    mapController!.addCircleLayer(
                                      "start_position_source",
                                      "start_position_layer",
                                      CircleLayerProperties(
                                        circleRadius: 10,
                                        circleColor: "#6A0DAD", // Purple color
                                        circleStrokeWidth: 5,
                                        circleStrokeColor:
                                            "#808080", // Grey color
                                      ),
                                    );
                                  }
                                  // Add the current position as a GeoJSON source
                                  if (mapController != null) {
                                    mapController!.addGeoJsonSource(
                                      "start_position_source",
                                      {
                                        "type": "FeatureCollection",
                                        "features": [
                                          {
                                            "type": "Feature",
                                            "geometry": {
                                              "type": "Point",
                                              "coordinates": [
                                                currentPosition.longitude,
                                                currentPosition.latitude,
                                              ],
                                            },
                                          },
                                        ],
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/pp.jpg")),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // showSearch(
                                          //     context: context,
                                          //     delegate: PlaceSearchDelegate());
                                        },
                                        child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: black2),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: grey1),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color:
                                                      black2.withOpacity(0.5),
                                                ),
                                                Text(
                                                  "Search",
                                                  style: mediumText.copyWith(
                                                    color:
                                                        black2.withOpacity(0.5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: FloatingActionButton.small(
                                        onPressed: () {
                                          mapController!.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude),zoom: 17,tilt: 60)
                                            )
                                              );
                                        },
                                        child: Icon(Icons.my_location_outlined),
                                        backgroundColor: Colors.white,
                                        shape: CircleBorder(),
                                        heroTag: 'my_location',
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: FloatingActionButton.small(
                                        onPressed: () {
                                          _fitPolylineBounds(context);
                                        },
                                        child: Icon(Icons.route_outlined),
                                        backgroundColor: Colors.white,
                                        shape: CircleBorder(),
                                        heroTag: 'route',
                                      ))
                                ],
                              ),
                            ),
                          ),
                          isturnbyturn_on
                              ? TurnByTurnModal()
                              : Dragablesheetmodal(
                                  startCallback: setIsturnbyturn_on,
                                )
                        ],
                      );
                    }
                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: successColor,
                        secondRingColor: warningColor,
                        thirdRingColor: errorColor,
                        size: 50,
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
