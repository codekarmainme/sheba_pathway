import 'package:equatable/equatable.dart';

abstract class HotelPickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHotels extends HotelPickerEvent {
  final double lat;
  final double lng;
  final int radius;

  FetchHotels({required this.lat, required this.lng, required this.radius});

  @override
  List<Object?> get props => [lat, lng, radius];
}
