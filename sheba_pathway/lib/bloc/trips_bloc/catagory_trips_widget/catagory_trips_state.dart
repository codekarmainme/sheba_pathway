abstract class CatagoryTripsState {}

class CatagoryTripIntial extends CatagoryTripsState{}
class CatagoryTripLoaded extends CatagoryTripsState{
    final String selectedCatagory;
    CatagoryTripLoaded(this.selectedCatagory);
}
class CatagoryTripError extends CatagoryTripsState{}
