import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:sheba_pathway/models/top_trips_model.dart';

final List<TopTripsModel> topTrips = [
  
  TopTripsModel(
    assetName: "assets/images/jegol ginb.png",
    location: "Harar",
    price: "ETB 3500",
    placeName: "Jegol Wall",
    catagory: 'Castles',
    coordinates: LatLng(9.3148, 42.1278)
  ),  
  TopTripsModel(
    assetName: "assets/images/Hailselassie house.png",
    location: "Harar",
    price: "ETB 4200",
    placeName: "Selassie House",
    catagory: 'Castles',
    coordinates: LatLng(9.3120, 42.1240)
  ),
  TopTripsModel(
    assetName: "assets/images/Midr babur.png",
    location: "Dire Dawa",
    price: "ETB 3200",
    placeName: "Metro",
    catagory: 'Castles',
   coordinates: LatLng(9.6000, 41.8667)
  ),
  TopTripsModel(
    assetName: "assets/images/yedro midr babur.png",
    location: "Dire Dawa",
    price: "ETB 3800",
    placeName: "Old metro",
    catagory: 'Castles',
    coordinates: LatLng(9.6050, 41.8700)
  ),
  TopTripsModel(
    assetName: "assets/images/lake tana.jpg",
    location: "Bahir Dar",
    price: "ETB 4000",
    placeName: "Lake Tana",
    catagory: 'Lakes',
    coordinates: LatLng(11.6031, 37.3833)
  ),
];