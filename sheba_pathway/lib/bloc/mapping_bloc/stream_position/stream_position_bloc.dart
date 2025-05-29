import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/stream_position/stream_position_state.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/stream_position/stream_position_event.dart';


class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _positionSubscription;

  LocationBloc() : super(LocationInitial()) {
    on<StartLocationUpdates>((event, emit) {
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream().listen((position) {
        add(LocationChanged(position));
      });
    });

    on<LocationChanged>((event, emit) {
      emit(LocationUpdateSuccess(event.position));
    });
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}