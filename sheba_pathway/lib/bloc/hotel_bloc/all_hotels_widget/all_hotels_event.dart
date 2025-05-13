abstract class AllHotelsEvent {}

class LoadAllHotels extends AllHotelsEvent{
  final double latitude;
  final double longtitude;
  final int diameter;
  LoadAllHotels(this.latitude, this.longtitude, this.diameter);
}
