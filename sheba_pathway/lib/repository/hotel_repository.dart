import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheba_pathway/models/hotel_models.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class HotelRepository {
  String buildHotelQuery(double lat, double lng, int radius) {
    String query = "[out:json];\n(";

    // Query for hotels
    query += "node[\"tourism\"=\"hotel\"](around:$radius,$lat,$lng);";
    query += "way[\"tourism\"=\"hotel\"](around:$radius,$lat,$lng);";
    query += "relation[\"tourism\"=\"hotel\"](around:$radius,$lat,$lng);";

    query += ");\nout center;";
    return query;
  }

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

  Future<List<HotelModels>> fetchHotels(
      double lat, double lng, int radius) async {
    // Build the query for hotels
    String query = buildHotelQuery(lat, lng, radius);

    // Encode the query
    String encodedQuery = Uri.encodeComponent(query);

    // Overpass API URL
    String url = "https://overpass-api.de/api/interpreter?data=$encodedQuery";

    try {
      Response response = await Dio().get(url);
      print(response.data);
      if (response.statusCode == 200) {
        var data = response.data;
        if (data != null && data.containsKey('elements')) {
          List<HotelModels> hotels = [];

          for (var element in data['elements']) {
            // Extract hotel name dynamically
            String? hotelName;
            if (element['tags'].containsKey('name:en')) {
              hotelName = element['tags']['name:en'] ?? "----";
            } else if (element['tags'].containsKey('name')) {
              hotelName = element['tags']['name'] ?? "----";
            } else if (element['tags'].containsKey('name:am')) {
              hotelName = element['tags']['name:am'] ?? "----";
            } else {
              hotelName = "---";
            }

            // Extract latitude and longitude dynamically
            double hotelLat = element['lat'] ?? element['center']['lat'];
            ;
            double hotelLon = element['lon'] ?? element['center']['lon'];
            if (element['type'] == "node") {
              hotelLat = element['lat'];
              hotelLon = element['lon'];
            } else if (element['type'] == "way" &&
                element.containsKey('center')) {
              hotelLat = element['center']['lat'];
              hotelLon = element['center']['lon'];
            }
            // Calculate distance and time
            List info = await getInfotoHotel(
              LatLng(lat, lng),
              LatLng(hotelLat, hotelLon),
            );
            String hotelDistance = "${info[0].toStringAsFixed(1)} km";
            String hotelTime = "${info[1].toStringAsFixed(1)} min";

            // Get place name
            String hotelLocation = await determinePlaceName(
              Position(
                  latitude: hotelLat,
                  longitude: hotelLon,
                  timestamp: DateTime.now(),
                  accuracy: 0.0,
                  altitude: 0.0,
                  heading: 0.0,
                  speed: 0.0,
                  speedAccuracy: 0.0,
                  altitudeAccuracy: 0.0,
                  headingAccuracy: 0.0),
            );

            // Create a HotelModels instance
            hotels.add(HotelModels(
                hotelName: hotelName,
                hotelLocation: hotelLocation,
                hotelDistance: hotelDistance,
                hotelTime: hotelTime,
                rating:
                    element['tags']?['stars'] ?? 'N/A', // Example for rating
                phoneNumber: element['tags']?['phone'] ?? 'N/A',
                lat: hotelLat,
                lon: hotelLon));
          }

          return hotels;
        } else {
          print("No elements found for hotels.");
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List> getInfotoHotel(LatLng start, LatLng end) async {
    final url =
        'https://valhalla1.openstreetmap.de/optimized_route?json={"locations":[{"lat":${start.latitude},"lon":${start.longitude}},{"lat":${end.latitude},"lon":${end.longitude}}],"costing":"taxi","directions_options":{"units":"km"}}';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final List<LatLng> route = [];

        final _distancebnpoints = data['trip']['summary']['length'];
        final _timetake = data['trip']['summary']['time'] / 60;
        return [_distancebnpoints, _timetake];
      } else {
        return [0, 0];
      }
    } catch (error) {
      return [0, 0];
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
