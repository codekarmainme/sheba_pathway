import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:dio/dio.dart';

class MappingRepository {
  Future<String> determinePlaceName(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return "${place.subAdministrativeArea},${place.country}";
    } catch (e) {
      return "Unknown";
    }
  }

  Future<String> determinePosition(BuildContext context) async {
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
    Position _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    String placeName = await determinePlaceName(_currentPosition);
    return placeName;
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

  Future<List<Map<String, dynamic>>> fetchAutoCompleteResults(
      String query, bool isStartlocation) async {
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=geojson&countrycodes=ET&limit=5&bounded=1';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        return (data['features'] as List).map<Map<String, dynamic>>((feature) {
          return {
            'name': feature['properties']['display_name'],
            'coordinates': feature['geometry']['coordinates'],
          };
        }).toList();
      } else {
        throw Exception("Failed to load auto completion");
      }
    } catch (error) {
      print("Failed to load the auto completion result: $error");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRoute(
    LatLng startlocation,
    LatLng destinationLocation,
    String costModel,
  ) async {
    List<Map<String, dynamic>> _maneuvers = [];
    final locations = [
      {"lat": startlocation.latitude, "lon": startlocation.longitude},
      {
        "lat": destinationLocation.latitude,
        "lon": destinationLocation.longitude
      },
    ];
    final url =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":${jsonEncode(locations)},"costing":"${costModel.toLowerCase()}","directions_options":{"units":"km"}}';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final List<LatLng> route = [];
        for (var leg in data['trip']['legs']) {
          final shape = leg['shape'];
          route.addAll(decodePolyline(shape));
          route.insert(
            0,
            LatLng(startlocation.latitude, startlocation.longitude),
          );

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

        final distancebnpoints = data['trip']['summary']['length'];
        final timetake = data['trip']['summary']['time'] / 60;
        final routePoints = route;
        print(routePoints);
        return {
          'distancebnpoints': distancebnpoints,
          'timetake': timetake,
          'routePoints': routePoints,
          'manuevers': _maneuvers
        };
      } else if (response.statusCode == 429) {
        print("Too many requests. Please wait and try again.");
        return {};
      } else {
        return {};
      }
    } catch (error) {
      print("Failed to get route: $error");
      return {};
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
}
