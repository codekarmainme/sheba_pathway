import 'package:equatable/equatable.dart';

abstract class CurrentLocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentLocationIntialState extends CurrentLocationState {}

class CurrentLocationLoadingState extends CurrentLocationState {}

class CurrentLocationSuccessState extends CurrentLocationState {
  final Map<String, dynamic> place;
  CurrentLocationSuccessState({required this.place});
  @override
  List<Object?> get props => [place];
}

class CurrentLocationErrorState extends CurrentLocationState {
  final String error;
  CurrentLocationErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
