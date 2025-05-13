import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/provider/mapping_provider.dart';
import 'package:provider/provider.dart';
import 'package:sheba_pathway/widgets/dragablesheetmodal.dart';
import 'package:sheba_pathway/widgets/turn_by_turn_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;
  bool isturnbyturn_on = false;
  void setIsturnbyturn_on() {
    setState(() {
      isturnbyturn_on =true;
    });
  }

  void _fitPolylineBounds() {
    var bounds;
    List<LatLng> locations = [];
    final mappingProvider =
        Provider.of<MappingProvider>(context, listen: false);
    mappingProvider.addedSelectedDestination
        .where((destination) =>
            destination.isNotEmpty && destination[1]['coordinates'] != null)
        .map((destination) {
      locations.add(LatLng(
        destination[1]['coordinates'][0],
        destination[1]['coordinates'][1],
      ));
    });
    if (mappingProvider.selectedStartlocation.isNotEmpty &&
        mappingProvider.selectedDestinationLocation.isNotEmpty) {
      locations.add(LatLng(
          mappingProvider.selectedDestinationLocation[1]['coordinates'][0],
          mappingProvider.selectedDestinationLocation[1]["coordinates"][1]));
      locations.add(LatLng(
          mappingProvider.selectedStartlocation[1]['coordinates'][0],
          mappingProvider.selectedStartlocation[1]["coordinates"][1]));
      bounds = LatLngBounds.fromPoints(locations);
    }

    Future.delayed(Duration(milliseconds: 500), () {
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: EdgeInsets.all(10),
          maxZoom: 20,
          minZoom: 2,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _mapController = MapController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<MappingProvider>(builder: (context, mappingProvider, child) {
        return StreamBuilder<Position>(
            stream: mappingProvider.positionStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final currentPosition = snapshot.data!;
              
              if (mappingProvider.selectedDestinationLocation.isNotEmpty &&
                  mappingProvider.selectedStartlocation.isNotEmpty &&
                  mappingProvider.ischangeApeared) {
                mappingProvider.getRoute();
              }

              return Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      maxZoom: 20,
                      minZoom: 2,
                      initialZoom: 14,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.maptiler.com/maps/basic-v2-dark/256/{z}/{x}/{y}.png?key=egOiZJUpRA3sNsKcxi0p',
                      ),
                      CircleLayer(circles: [
                        if (mappingProvider.selectedStartlocation.isNotEmpty)
                          CircleMarker(
                            color: pupleColor,
                            borderColor: warningColor,
                            borderStrokeWidth: 10,
                            radius: 10,
                            point: LatLng(
                                mappingProvider.selectedStartlocation[1]
                                    ['coordinates'][0],
                                mappingProvider.selectedStartlocation[1]
                                    ['coordinates'][1]),
                          )
                      ]),
                      CircleLayer(circles: [
                        if (mappingProvider
                                .selectedDestinationLocation.isNotEmpty &&
                            mappingProvider.selectedDestinationLocation.length >
                                1)
                          CircleMarker(
                            color: pupleColor,
                            borderColor: warningColor,
                            borderStrokeWidth: 10,
                            radius: 10,

                            point: LatLng(
                                mappingProvider.selectedDestinationLocation[1]
                                    ['coordinates'][0],
                                mappingProvider.selectedDestinationLocation[1]
                                    ["coordinates"][1]),

                            // Adjust anchor to the tip
                          ),
                      ]),
                      MarkerLayer(markers: [
                        Marker(
                            point: LatLng(currentPosition.latitude,
                                currentPosition.longitude),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/pp.jpg"),
                            )),
                        if (mappingProvider
                            .selectedDestinationLocation.isNotEmpty)
                          Marker(
                            height: 30,
                            width: 30,
                            alignment: Alignment(0, -2),
                            point: LatLng(
                                mappingProvider.selectedDestinationLocation[1]
                                    ['coordinates'][0],
                                mappingProvider.selectedDestinationLocation[1]
                                    ['coordinates'][1]),
                            child: SvgPicture.asset(
                              "assets/images/location.svg",
                              height: 30,
                              width: 30,
                            ),
                          )
                      ]),
                      if (mappingProvider.routePoints.isNotEmpty)
                        PolylineLayer(polylines: [
                          Polyline(
                              points: mappingProvider.routePoints,
                              color: warningColor,
                              strokeWidth: 8),
                        ])
                    ],
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/pp.jpg")),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: secondaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white.withOpacity(0.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                        Text(
                                          "Search",
                                          style: mediumText.copyWith(
                                            color:
                                                Colors.white.withOpacity(0.5),
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
                                  _mapController.move(
                                      LatLng(currentPosition.latitude,
                                          currentPosition.longitude),
                                      16);
                                },
                                child: Icon(Icons.my_location_outlined),
                                backgroundColor: Colors.white,
                                shape: CircleBorder(),
                                heroTag: 'my_location',
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: FloatingActionButton.small(
                                onPressed:
                                    mappingProvider.routePoints.isNotEmpty
                                        ? _fitPolylineBounds
                                        : null,
                                child: Icon(Icons.route_outlined),
                                backgroundColor: Colors.white,
                                shape: CircleBorder(),
                                heroTag: 'route',
                              ))
                        ],
                      ),
                    ),
                  ),
                isturnbyturn_on?TurnByTurnModal() : Dragablesheetmodal(startCallback: setIsturnbyturn_on,)
                ],
              );
            });
      }),
    );
  }
}
