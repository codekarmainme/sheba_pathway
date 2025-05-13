import 'dart:convert';

import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';

class MappingProvider extends ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  Stream<Position> get positionStream => Geolocator.getPositionStream();
  bool _currentLocationChecked = true;
  bool get currentLocationChecked => _currentLocationChecked;
  List<LatLng> routePoints = [];
  List<LatLng> walkingroutePoints = [];
  List<LatLng> busroutePoints = [];
  List<LatLng> routePointsbnTwoPoints = [];
  num? _distancebnpoints;
  num? _timetake;
  num? get distencebnpoints => _distancebnpoints;
  num? get timetake => _timetake;
  String? _currentPlaceName;
  String? get currentPlaceName => _currentPlaceName;
  List<Map<String, dynamic>> _maneuvers = [];
  List<Map<String, dynamic>> get maneuvers => _maneuvers;
  Map<String, dynamic> _costingModel = {
    'label': 'Taxi',
    'icon': FontAwesomeIcons.taxi,
    "action": 'Drive'
  };
  Map<String, dynamic> get selctedcostingModel => _costingModel;
  List<Map<String, dynamic>> _startautoComplteResults = [];
  List<Map<String, dynamic>> get startautoCompleteResults =>
      _startautoComplteResults;
  List<Map<String, dynamic>> _specificLocationSearch = [];
  List<Map<String, dynamic>> get specificLocationSearch =>
      _specificLocationSearch;
  List<Map<String, dynamic>> _destinationautoComplteResults = [];
  List<Map<String, dynamic>> get destinationautoCompleteResults =>
      _destinationautoComplteResults;
  List<Map<String, dynamic>> _selectedStartlocation = [];
  List<Map<String, dynamic>> get selectedStartlocation =>
      _selectedStartlocation;
  List<Map<String, dynamic>> _selectedDestinationLocation = [];
  List<Map<String, dynamic>> get selectedDestinationLocation =>
      _selectedDestinationLocation;
  List<List<Map<String, dynamic>>> _addedSelectedDestination = [];
  List<List<Map<String, dynamic>>> get addedSelectedDestination =>
      _addedSelectedDestination;
  List<Map<String, dynamic>> _selectedSpecficLocation = [];
  List<Map<String, dynamic>> get selectedSpecficLocation =>
      _selectedSpecficLocation;
  Map<String, dynamic> _selectedInstitutionCatagory = {
    'label': 'Hotel',
    'icon': Icons.hotel
  };
  Map<String, dynamic> get selectedInstitutionCatagory =>
      _selectedInstitutionCatagory;
  String searchedQuery = '';
  List<Map<String, dynamic>> _fetchedPlaces = [];
  List<Map<String, dynamic>> get fetchedPlaces => _fetchedPlaces;
  String currrentMap =
      'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=egOiZJUpRA3sNsKcxi0p';
  
  final List<Map<String, dynamic>> costModels = [
    {'label': 'Taxi', 'icon': FontAwesomeIcons.taxi, 'action': "Drive"},
    {
      'label': 'Pedestrian',
      'icon': FontAwesomeIcons.personWalking,
      'action': "Walk"
    },
    {
      'label': 'Bus',
      'icon': FontAwesomeIcons.bus,
      "action": "Public transport"
    },
    // {'label': 'Motorcycle', 'icon': FontAwesomeIcons.motorcycle},
    // {'label': 'Bicycle', 'icon': FontAwesomeIcons.bicycle},
    // {'label': 'Truck', 'icon': FontAwesomeIcons.truck},
  ];

  final List<Map<String, dynamic>> mapTypes = [
    {
      "label": 'Satellite',
      "satellite":
          'https://api.maptiler.com/maps/satellite/256/{z}/{x}/{y}.jpg?key=egOiZJUpRA3sNsKcxi0p'
    },
    {
      "label": "Dark",
      "street":
          'https://api.maptiler.com/maps/basic-v2-dark/256/{z}/{x}/{y}.png?key=egOiZJUpRA3sNsKcxi0p'
    },
    {
      "label": 'Default',
      "default":
          'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=egOiZJUpRA3sNsKcxi0p'
    }
  ];
  int addedDestination = 0;
  bool _ischangeApeared = false;
  bool get ischangeApeared => _ischangeApeared;
  bool _isCatagoryChangeApear = false;
  bool get isCatagoryChangeApear => _isCatagoryChangeApear;

  void disposeData() {
    _maneuvers.clear();
    selectedDestinationLocation.clear();
    selectedStartlocation.clear();
    routePoints.clear();
    walkingroutePoints.clear();
    _addedSelectedDestination.clear();
    _specificLocationSearch.clear();
  }

  void setsearchedQuery(String query) {
    searchedQuery = query;
    notifyListeners();
  }

  void setMapType(String map) {
    currrentMap = map;
    notifyListeners();
  }

  void setQuery(String query) {
    query = query;
  }

  void setselectedInstitutionCatagory(Map<String, dynamic> value) {
    _selectedInstitutionCatagory = value;
    routePointsbnTwoPoints = [];
    _isCatagoryChangeApear = true;
    notifyListeners();
  }

  void setCostingModel(Map<String, dynamic> newvalue) {
    _costingModel = newvalue;
    _ischangeApeared = true;
    notifyListeners();
  }

  void setselectedDestinationLocation(List<Map<String, dynamic>> newvalue) {
    _selectedDestinationLocation = newvalue;
    _ischangeApeared = true;
    notifyListeners();
  }

  void setselectedStartlocation(List<Map<String, dynamic>> newvalue) {
    _selectedStartlocation = newvalue;
    _ischangeApeared = true;
    notifyListeners();
  }

  void setspecificLocation(List<Map<String, dynamic>> newvalue) {
    _specificLocationSearch = newvalue;
    print(_specificLocationSearch);
    _ischangeApeared = true;
    notifyListeners();
  }

  void addSelectedDestination(List<Map<String, dynamic>> newvalue) {
    _addedSelectedDestination.add(newvalue);
    _ischangeApeared = true;
    notifyListeners();
  }

  void cancleDestination(int index) {
    addedDestination--;
    if (addedSelectedDestination.isNotEmpty) {
      addedSelectedDestination.removeAt(index);
    }

    _ischangeApeared = true;
  }

  void takeCurrentLocation() {
    _currentLocationChecked = !_currentLocationChecked;
    _ischangeApeared = true;
    notifyListeners();
  }

  Future<void> determinePlaceName(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      _currentPlaceName = "${place.subAdministrativeArea},${place.country}";
    } catch (e) {
      _currentPlaceName = "Unknown";
    }
  }

Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await _showLocationServiceDialog(context);
    return Future.error('Location services are disabled.');
  }

  // Check and request location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Try to get the last known position first
  Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
  if (lastKnownPosition != null) {
    _currentPosition = lastKnownPosition;
    _selectedStartlocation = [
      {"name": ''},
      {
        'coordinates': [
          lastKnownPosition.latitude,
          lastKnownPosition.longitude
        ]
      }
    ];
    notifyListeners();
    return lastKnownPosition;
  }

  // If no last known position, fetch the current position
  _currentPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  _selectedStartlocation = [
    {"name": ''},
    {
      'coordinates': [
        _currentPosition!.latitude,
        _currentPosition!.longitude
      ]
    }
  ];
  notifyListeners();
  return _currentPosition!;
}

  double calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }


  Future<void> fetchAutoCompleteResults(
      String query, bool isStartlocation) async {
    const viewbox = "38.6500,8.8500,39.0000,9.1500";
    // final url =
    //     'https://nominatim.openstreetmap.org/search?q=$query&format=geojson&polygon_geojson=1&addressdetails=1&viewbox=$viewbox&bounded=1';
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=geojson&countrycodes=ET&limit=5&bounded=1';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;

        if (isStartlocation) {
          _startautoComplteResults = (data['features'] as List).map((feature) {
            return {
              'name': feature['properties']['display_name'],
              'coordinates': feature['geometry']['coordinates'],
            };
          }).toList();
        } else {
          _destinationautoComplteResults =
              (data['features'] as List).map((feature) {
            return {
              'name': feature['properties']['display_name'],
              'coordinates': feature['geometry']['coordinates'],
            };
          }).toList();
        }
        notifyListeners();
      } else {
        throw Exception("Failed to load auto completion");
      }
    } catch (error) {
      print("Failed to load the auto completion result: $error");
    }
  }

  Future<void> fetchSpecificlocationSearch(String query) async {

    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=geojson&countrycodes=ET&limit=5&bounded=1';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;

        _specificLocationSearch = (data['features'] as List).map((feature) {
          return {
            'name': feature['properties']['display_name'],
            'coordinates': feature['geometry']['coordinates'],
          };
        }).toList();

        notifyListeners();
      } else {
        throw Exception("Failed to load auto completion");
      }
    } catch (error) {
      print("Failed to load the auto completion result: $error");
    }
  }

  void clearAutoCompleteResults() {
    _startautoComplteResults = [];
    _destinationautoComplteResults = [];
    notifyListeners();
  }

  List<LatLng> get waypoints {
    List<LatLng> points = [];

    if (_selectedStartlocation != null && _selectedStartlocation.isNotEmpty) {
      points.add(LatLng(
        _selectedStartlocation[1]['coordinates'][0],
        _selectedStartlocation[1]['coordinates'][1],
      ));
    }

    if (selectedDestinationLocation.isNotEmpty) {
      points.add(LatLng(
        selectedDestinationLocation[1]['coordinates'][0],
        selectedDestinationLocation[1]['coordinates'][1],
      ));
    }

    for (var destination in addedSelectedDestination) {
      if (destination.isNotEmpty && destination[1]['coordinates'] != null) {
        points.add(LatLng(
          destination[1]['coordinates'][0],
          destination[1]['coordinates'][1],
        ));
      }
    }

    return points;
  }

  Future<void> getroute_to_cost_models() async {
    List<LatLng> waypoints = this.waypoints;

    List<Map<String, double>> locations = waypoints.map((point) {
      return {"lat": point.latitude, "lon": point.longitude};
    }).toList();
    final taxiurl =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":${jsonEncode(locations)},"costing":"taxi","directions_options":{"units":"km"}}';
    final walkurl =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":${jsonEncode(locations)},"costing":"pedestrian","directions_options":{"units":"km"}}';
    final busurl =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":${jsonEncode(locations)},"costing":"bus","directions_options":{"units":"km"}}';
    try {
      final response = await Dio().get(walkurl);
      if (response.statusCode == 200) {
        final data = response.data;
        final List<LatLng> route = [];

        for (var leg in data['trip']['legs']) {
          final shape = leg['shape'];
          route.addAll(decodePolyline(shape));
          route.insert(
              0,
              LatLng(
                _selectedStartlocation[1]['coordinates'][0],
                _selectedStartlocation[1]['coordinates'][1],
              ));
          // route.add(LatLng(
          //   _selectedDestinationLocation[1]['coordinates'][0],
          //   _selectedDestinationLocation[1]['coordinates'][1],
          // ));
        }
        
        notifyListeners();
        walkingroutePoints = route;
      } else {}
    } catch (error) {
      print(error);
    }
  }

  Future<void> getRoute() async {
    _maneuvers.clear();
    _distancebnpoints = null;
    _timetake = null;
     routePointsbnTwoPoints.clear();
    routePoints.clear();
    walkingroutePoints.clear();
    List<LatLng> waypoints = this.waypoints;

    List<Map<String, double>> locations = waypoints.map((point) {
      return {"lat": point.latitude, "lon": point.longitude};
    }).toList();
    print(locations);
    final url =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":${jsonEncode(locations)},"costing":"${selctedcostingModel['label'].toLowerCase()}","directions_options":{"units":"km"}}';

    try {
      print(selctedcostingModel['label']);
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final List<LatLng> route = [];
        print(data);
        for (var leg in data['trip']['legs']) {
          final shape = leg['shape'];
          route.addAll(decodePolyline(shape));
          route.insert(
              0,
              LatLng(
                _selectedStartlocation[1]['coordinates'][0],
                _selectedStartlocation[1]['coordinates'][1],
              ));
          // route.add(LatLng(
          //   _selectedDestinationLocation[1]['coordinates'][0],
          //   _selectedDestinationLocation[1]['coordinates'][1],
          // ));

          _maneuvers
              .addAll(leg['maneuvers'].map<Map<String, dynamic>>((maneuver) {
            int beginIndex = maneuver['begin_shape_index'];
            int endIndex = maneuver['end_shape_index'];
            LatLng beginLatLng = route[beginIndex];
            LatLng endLatLng = route[endIndex];

            return {
              'instruction': maneuver['verbal_pre_transition_instruction'],
              'lat': beginLatLng.latitude,
              'lon': beginLatLng.longitude,
              'street_names': maneuver['street_names'] ?? [],
              'length': maneuver['length'],
              'time': maneuver['time'],
              'type': maneuver['type']
            };
          }).toList());
        }

        _distancebnpoints = data['trip']['summary']['length'];
        _timetake = data['trip']['summary']['time'] / 60;
        _ischangeApeared = false;
        notifyListeners();
        routePoints = route;
      } else {}
    } catch (error) {}
  }

  Future<void> getRoutebnTwopoints(LatLng start, LatLng end) async {
    _maneuvers.clear();
    String costingValue = _costingModel['label'].toString().toLowerCase();
    routePointsbnTwoPoints.clear();
    routePoints.clear();
    
    final url =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":[{"lat":${start.latitude},"lon":${start.longitude}},{"lat":${end.latitude},"lon":${end.longitude}}],"costing":"$costingValue","directions_options":{"units":"km"}}';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final List<LatLng> route = [];

        for (var leg in data['trip']['legs']) {
          final shape = leg['shape'];
          route.addAll(decodePolyline(shape));

          _maneuvers
              .addAll(leg['maneuvers'].map<Map<String, dynamic>>((maneuver) {
            int beginIndex = maneuver['begin_shape_index'];
            int endIndex = maneuver['end_shape_index'];
            LatLng beginLatLng = route[beginIndex];
            LatLng endLatLng = route[endIndex];

            return {
              'instruction': maneuver['verbal_pre_transition_instruction'],
              'lat': beginLatLng.latitude,
              'lon': beginLatLng.longitude,
              'street_names': maneuver['street_names'] ?? [],
              'length': maneuver['length'],
              'time': maneuver['time'],
              'type': maneuver['type']
            };
          }).toList());
        }

        _distancebnpoints = data['trip']['summary']['length'];
        _timetake = data['trip']['summary']['time'] / 60;
        _ischangeApeared = false;
        notifyListeners();
        routePoints = route;
      } else {}
    } catch (error) {
      print(error);
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    int factor = 1E6.toInt(); // Use six digits of precision

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng(lat / factor, lng / factor);
      poly.add(p);
    }
    return poly;
  }

  Future<void> _showLocationServiceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Services Disabled', style: mediumText),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enable location services to continue.',
                    style: normalText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text('OK', style: mediumText.copyWith(color: primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  bool checkuserProximityToManeuvers(
      Position position, double maneuverLat, double maneuverLon) {
    bool isuserClosetoManeuvers = false;
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      maneuverLat,
      maneuverLon,
    );

    if (distance < 50) {
      isuserClosetoManeuvers = true;
    }
    return isuserClosetoManeuvers;
  }
}
