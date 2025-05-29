import 'package:equatable/equatable.dart';
abstract class HotelPickerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelPickerInitial extends HotelPickerState {}

class HotelPickerLoading extends HotelPickerState {}

class HotelPickerLoaded extends HotelPickerState {
  final List<Map<String,dynamic>> hotels;
  HotelPickerLoaded(this.hotels);

  @override
  List<Object?> get props => [hotels];
}

class HotelPickerError extends HotelPickerState {
  final String message;
  HotelPickerError(this.message);

  @override
  List<Object?> get props => [message];
}
