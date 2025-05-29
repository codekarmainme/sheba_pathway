import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/current_location/current_location_event.dart';
import 'package:sheba_pathway/bloc/current_location/current_location_state.dart';
import 'package:sheba_pathway/repository/mapping_repository.dart';

class CurrentLocationBloc extends Bloc<CurrentLocationEvent,CurrentLocationState>{
  final MappingRepository mappingRepository;
  CurrentLocationBloc({required this.mappingRepository}):super(CurrentLocationIntialState()){
    on<DeterrminePositionEvent>((event, emit)async{
    emit(CurrentLocationLoadingState());
    try{
      String placeName= await mappingRepository.determinePosition(event.context);
      emit(CurrentLocationSuccessState(placeName: placeName));
    }
    catch(e){
      emit(CurrentLocationErrorState(error: e.toString()));
    }
    });
  }
}
