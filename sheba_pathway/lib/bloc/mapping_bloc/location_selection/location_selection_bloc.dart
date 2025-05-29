import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_event.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/location_selection/location_selection_state.dart';

class LocationSelectionBloc
    extends Bloc<LocationSelectionEvent, LocationSelectionState> {
  LocationSelectionBloc() : super(LocationSelectionState()) {
    on<SetStartLocation>((event, emit) {
      emit(state.copyWith(startLocation: event.startLocation));
    });
    on<SetDestinationLocation>((event, emit) {
      emit(state.copyWith(destinationLocation: event.destinationLocation));
    });
    on<ClearLocations>((event, emit) {
      emit(LocationSelectionState());
    });
    // location_selection_bloc.dart
    on<SetIsChangeApeared>((event, emit) {
      emit(state.copyWith(isChangeApeared: event.value));
    });
  }
}
