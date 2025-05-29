import 'package:geolocator/geolocator.dart';

abstract class LocationEvent {}

class StartLocationUpdates extends LocationEvent {}

class LocationChanged extends LocationEvent {
  final Position position;
  LocationChanged(this.position);
}