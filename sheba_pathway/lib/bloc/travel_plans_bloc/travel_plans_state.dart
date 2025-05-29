import 'package:equatable/equatable.dart';
import 'package:sheba_pathway/models/travel_plan_model.dart';

abstract class TravelPlansState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TravelPlansInitial extends TravelPlansState {}

class TravelPlansLoading extends TravelPlansState {}

class TravelPlansAdding extends TravelPlansState {}

class TravelPlansLoaded extends TravelPlansState {
  final List<TripPlanModel> plans;
  TravelPlansLoaded(this.plans);

  @override
  List<Object?> get props => [plans];
}

class TravelPlansError extends TravelPlansState {
  final String message;
  TravelPlansError(this.message);

  @override
  List<Object?> get props => [message];
}

class TravelPlansAddingError extends TravelPlansState {
  final String message;
  TravelPlansAddingError(this.message);

  @override
  List<Object?> get props => [message];
}

class TravelPlanAdded extends TravelPlansState {}
