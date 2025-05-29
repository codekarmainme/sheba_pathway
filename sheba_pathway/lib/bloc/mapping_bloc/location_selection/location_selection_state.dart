class LocationSelectionState {
  final Map<String, dynamic>? startLocation;
  final Map<String, dynamic>? destinationLocation;
   bool isChangeApeared=false;
  LocationSelectionState({this.startLocation, this.destinationLocation, this.isChangeApeared=false});

  LocationSelectionState copyWith({
    Map<String, dynamic>? startLocation,
    Map<String, dynamic>? destinationLocation,
    bool? isChangeApeared,
  }) {
    return LocationSelectionState(
      startLocation: startLocation ?? this.startLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
       isChangeApeared: isChangeApeared ?? 
        ((startLocation ?? this.startLocation) != null && (destinationLocation ?? this.destinationLocation) != null
          ? true
          : this.isChangeApeared),
    );
  }
}