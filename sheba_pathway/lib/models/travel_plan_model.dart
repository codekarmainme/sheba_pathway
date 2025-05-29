import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripPlanModel {
  final String? id; 
  final String destinationName;
  final DateTime tripDate;
  final String hotel;
  final int numberOfTravellers;
  final int tripDuration;
  final double budget;
  final String phoneNumber;
  final String purposeOfTrip;
  final DateTime createdAt;
  final bool isPaid;
  final LatLng hotelCoordinate;
  TripPlanModel({
    this.id,
    required this.destinationName,
    required this.tripDate,
    required this.hotel,
    required this.hotelCoordinate,
    required this.numberOfTravellers,
    required this.tripDuration,
    required this.budget,
    required this.phoneNumber,
    required this.purposeOfTrip,
    DateTime? createdAt,
    required this.isPaid,
    
  }) : createdAt = createdAt ?? DateTime.now();

  // For posting to API (toJson)
  Map<String, dynamic> toJson() => {
        "destinationName": destinationName,
        "tripDate": tripDate.toIso8601String(),
        "hotel": hotel,
        "numberOfTravellers": numberOfTravellers,
        "tripDuration": tripDuration,
        "budget": budget,
        "phoneNumber": phoneNumber,
        "purposeOfTrip": purposeOfTrip,
        "createdAt": createdAt.toIso8601String(),
        'hotelCoordinate':GeoPoint(hotelCoordinate.latitude, hotelCoordinate.longitude),
        'isPaid':isPaid
      };

  // For retrieving from API (fromJson)
  factory TripPlanModel.fromJson(Map<String, dynamic> json, {String? id}) => TripPlanModel(
        id: id, 
        destinationName: json["destinationName"],
        tripDate: DateTime.parse(json["tripDate"]),
        hotel: json["hotel"],
        numberOfTravellers: json["numberOfTravellers"],
        tripDuration: json["tripDuration"],
        budget: (json["budget"] as num).toDouble(),
        phoneNumber: json["phoneNumber"],
        purposeOfTrip: json["purposeOfTrip"],
        createdAt: DateTime.parse(json["createdAt"]),
        isPaid: json['isPaid'],
        hotelCoordinate: json['hotelCoordinate'] is GeoPoint
            ? LatLng(
                (json['hotelCoordinate'] as GeoPoint).latitude,
                (json['hotelCoordinate'] as GeoPoint).longitude,
              )
            : LatLng(0, 0),
      );
}