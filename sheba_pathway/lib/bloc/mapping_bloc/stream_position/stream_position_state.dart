import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationUpdateSuccess extends LocationState {
  final Position position;
  LocationUpdateSuccess(this.position);
}