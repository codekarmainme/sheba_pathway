import 'package:equatable/equatable.dart';

abstract class MappingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MappingIntial extends MappingState {}

class MappingLoading extends MappingState {}

class MappingSuccess extends MappingState {
  final Map<String, dynamic> routingdata;
  MappingSuccess({
    this.routingdata = const {},
  });
}

class MappingError extends MappingState {
  final String errorMessage;
  MappingError({required this.errorMessage});
  List<Object?> get props => [errorMessage];
}
