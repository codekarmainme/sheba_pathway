import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/hotel_bloc/all_hotels_widget/all_hotels_event.dart';
import 'package:sheba_pathway/bloc/hotel_bloc/all_hotels_widget/all_hotels_state.dart';
import 'package:sheba_pathway/models/hotel_models.dart';
import 'package:sheba_pathway/repository/hotel_repository.dart';

class AllHotelsBloc extends Bloc<AllHotelsEvent,AllHotelsState> {
  final HotelRepository hotelRepository;
  AllHotelsBloc(this.hotelRepository):super(AllHotelIntialState()){
    on<LoadAllHotels>((event, emit)async{
      emit(AllHotelsLoadingState());
      try{
        List<HotelModels> hotels = await hotelRepository.fetchHotels(event.latitude, event.longtitude, event.diameter);
        emit(AllHotelsLoadedState(hotels));
      }
      catch(e){
        emit(AllHotelsErrorState('We could not load hotels ${e.toString()}'));
      }
    });
  }
}