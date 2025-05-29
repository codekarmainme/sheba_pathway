abstract class CatagoryTripsEvent {}

class LoadCatagoryTrips extends CatagoryTripsEvent{
  String catagory;
  LoadCatagoryTrips(this.catagory);
}