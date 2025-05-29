import 'package:equatable/equatable.dart';
import 'package:sheba_pathway/models/travel_plan_model.dart';

abstract class TravelPlansEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTravelPlans extends TravelPlansEvent {}

class AddTravelPlan extends TravelPlansEvent {
  final TripPlanModel plan;
  AddTravelPlan(this.plan);

  @override
  List<Object?> get props => [plan];
}