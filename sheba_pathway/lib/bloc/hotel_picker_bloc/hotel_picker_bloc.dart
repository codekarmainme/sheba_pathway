import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/hotel_picker_bloc/hotel_picker_event.dart';
import 'package:sheba_pathway/bloc/hotel_picker_bloc/hotel_picker_state.dart';
import 'package:sheba_pathway/repository/hotel_picker_repository.dart';

class HotelPickerBloc extends Bloc<HotelPickerEvent, HotelPickerState> {
  final HotelPickerRepository repository;

  HotelPickerBloc(this.repository) : super(HotelPickerInitial()) {
    on<FetchHotels>((event, emit) async {
      emit(HotelPickerLoading());
      try {
        final hotels = await repository.fetchHotelNames(event.lat, event.lng, event.radius);
        emit(HotelPickerLoaded(hotels));
      } catch (e) {
        emit(HotelPickerError(e.toString()));
      }
    });
  }
}