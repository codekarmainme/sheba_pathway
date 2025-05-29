import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/mapping_bloc/mapping_event.dart';

import 'package:sheba_pathway/bloc/mapping_bloc/mapping_state.dart';
import 'package:sheba_pathway/repository/mapping_repository.dart';

class MappingBloc extends Bloc<MappingEvent, MappingState> {
  final MappingRepository mappingRepository;
  MappingBloc(this.mappingRepository) : super(MappingIntial()) {
    on<FetchRoutingDataBetweenTwoPoints>((event, emit) async {
      emit(MappingLoading());
      try {
        final routingData = await mappingRepository.getRoute(
            event.startLocation, event.destinationLocation, event.costModel);
       
        emit(MappingSuccess(routingdata: routingData));
      } catch (e) {
        emit(MappingError(errorMessage: e.toString()));
      }
    });
  }
}
