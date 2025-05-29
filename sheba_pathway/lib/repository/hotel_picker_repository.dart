import 'package:dio/dio.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class HotelPickerRepository {
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
  Future<List<Map<String,dynamic>>> fetchHotelNames(double lat, double lng, int radius) async {
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
        List<Map<String,dynamic>> hotels = [];

        for (var element in data['elements']) {
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
          hotels.add({
            'hotelName':hotelName,
            'hotelCoordinate':LatLng(hotelLat, hotelLon),
            'hotelLocation':hotelLocation
          });
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
    print("Error fetching hotels: $e");
    return [];
  }
}
}