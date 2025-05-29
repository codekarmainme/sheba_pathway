import 'package:maplibre_gl/maplibre_gl.dart';

class TopTripsModel {
  final String assetName;
  final String location;
  final String price;
  final String placeName;
  final String catagory;
  final LatLng coordinates;
  TopTripsModel(
      {required this.assetName,
      required this.location,
      required this.placeName,
      required this.price,
      required this.catagory,
      required this.coordinates
      });
}
