import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_event.dart';
import 'package:sheba_pathway/bloc/travel_plans_bloc/travel_plans_state.dart';
import 'package:sheba_pathway/models/travel_plan_model.dart';
import 'package:sheba_pathway/repository/travel_plans_repository.dart';

class TravelPlansBloc extends Bloc<TravelPlansEvent, TravelPlansState> {
  final TravelPlansRepository repository;

  TravelPlansBloc(this.repository) : super(TravelPlansInitial()) {
    // Load all plans (stream)
    on<LoadTravelPlans>((event, emit) async {
      emit(TravelPlansLoading());
      try {
        await emit.forEach<List<TripPlanModel>>(
          repository.getUserTravelPlans(),
          onData: (plans) => TravelPlansLoaded(plans),
          onError: (_, error) {
            print('TravelPlansBloc error: $error');
            return TravelPlansError(
                'Something gone wrong on loading the plans.');
          },
        );
      } catch (e) {
        emit(TravelPlansError(e.toString()));
      }
    });

    // Add  new plan
    on<AddTravelPlan>((event, emit) async {
      emit(TravelPlansAdding());
      try {
        await repository.addTripPlan(event.plan);
        emit(TravelPlanAdded());
      } catch (e) {
        emit(TravelPlansAddingError(e.toString()));
      }
    });
  }
}
