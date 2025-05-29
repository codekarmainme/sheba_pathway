import 'package:sheba_pathway/models/hotel_models.dart';
abstract class AllHotelsState{}

class AllHotelIntialState extends AllHotelsState{}

class AllHotelsLoadingState extends AllHotelsState{}

class AllHotelsLoadedState extends AllHotelsState{
   final List<HotelModels> hotels;
   AllHotelsLoadedState(this.hotels);

}

class AllHotelsErrorState extends AllHotelsState{
  final String message;
  AllHotelsErrorState(this.message);
}