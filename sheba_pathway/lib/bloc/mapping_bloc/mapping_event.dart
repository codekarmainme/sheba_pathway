import 'package:equatable/equatable.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

abstract class MappingEvent extends  Equatable {
  @override
  List<Object?> get props =>[];
}

class FetchRoutingDataBetweenTwoPoints extends MappingEvent{
 final LatLng startLocation;
 final LatLng destinationLocation;
 final String costModel;
 FetchRoutingDataBetweenTwoPoints( this.startLocation, this.destinationLocation, this.costModel);
}

class FetchAutoCompleteResults extends MappingEvent {
  final String query;
  final bool isStartLocation;
  FetchAutoCompleteResults(this.query, this.isStartLocation);
  @override
  List<Object?> get props => [query, isStartLocation];
}