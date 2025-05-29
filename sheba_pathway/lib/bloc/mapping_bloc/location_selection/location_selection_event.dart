abstract class LocationSelectionEvent {}

class SetStartLocation extends LocationSelectionEvent {
  final Map<String, dynamic> startLocation;
  SetStartLocation(this.startLocation);
}

class SetDestinationLocation extends LocationSelectionEvent {
  final Map<String, dynamic> destinationLocation;
  SetDestinationLocation(this.destinationLocation);
}
class SetIsChangeApeared extends LocationSelectionEvent {
  final bool value;
  SetIsChangeApeared(this.value);
}
class ClearLocations extends LocationSelectionEvent {}