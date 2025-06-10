import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:sheba_pathway/models/top_trips_model.dart';

final List<TopTripsModel> allTrips = [
  // Gondar
  TopTripsModel(
    assetName: "assets/images/Fasil.jpg",
    location: "Gondar",
    price: "ETB 3500",
    placeName: "Fasil Ghebbi (Royal Enclosure)",
    catagory: 'Gondar',
    coordinates: LatLng(12.6070, 37.4710),
  ),
  TopTripsModel(
    assetName: "assets/images/selassie church.jpg",
    location: "Gondar",
    price: "ETB 2000",
    placeName: "Debre Berhan Selassie Church",
    catagory: 'Gondar',
    coordinates: LatLng(12.6133, 37.4717),
  ),

  // Addis Ababa
  TopTripsModel(
    assetName: "assets/images/national museum lucy.jpg",
    location: "Addis Ababa",
    price: "ETB 1500",
    placeName: "National Museum",
    catagory: 'Addis Ababa',
    coordinates: LatLng(9.0360, 38.7613),
  ),
  TopTripsModel(
    assetName: "assets/images/entoto park.jpg",
    location: "Addis Ababa",
    price: "ETB 1800",
    placeName: "Entoto Park",
    catagory: 'Addis Ababa',
    coordinates: LatLng(9.0920, 38.7546),
  ),

  // Bahir Dar
  TopTripsModel(
    assetName: "assets/images/lake tana b.jpg",
    location: "Bahir Dar",
    price: "ETB 4000",
    placeName: "Lake Tana",
    catagory: 'Bahir dar',
    coordinates: LatLng(11.6031, 37.3833),
  ),
  TopTripsModel(
    assetName: "assets/images/nile fall.jpg",
    location: "Bahir Dar",
    price: "ETB 3500",
    placeName: "Blue Nile Falls",
    catagory: 'Bahir dar',
    coordinates: LatLng(11.4869, 37.5875),
  ),

  // Lalibela
  TopTripsModel(
    assetName: "assets/images/lalibela.jpg",
    location: "Lalibela",
    price: "ETB 5000",
    placeName: "Rock-Hewn Churches",
    catagory: 'Lalibela',
    coordinates: LatLng(12.0315, 39.0477),
  ),

  // Axum
  TopTripsModel(
    assetName: "assets/images/axum.jpg",
    location: "Axum",
    price: "ETB 4200",
    placeName: "Obelisk of Axum",
    catagory: 'Axum',
    coordinates: LatLng(14.1211, 38.7246),
  ),
  TopTripsModel(
    assetName: "assets/images/Queen of Sheba.jpg",
    location: "Axum",
    price: "ETB 2500",
    placeName: "Queen of Sheba's Bath",
    catagory: 'Axum',
    coordinates: LatLng(14.1215, 38.7220),
  ),

  // Harar
  TopTripsModel(
    assetName: "assets/images/jegol ginb.png",
    location: "Harar",
    price: "ETB 3500",
    placeName: "Jegol Wall",
    catagory: 'Harar',
    coordinates: LatLng(9.3148, 42.1278),
  ),
 

  // Hawassa
  TopTripsModel(
    assetName: "assets/images/lake hawasa.jpg",
    location: "Hawassa",
    price: "ETB 3200",
    placeName: "Lake Hawassa",
    catagory: 'Hawssa',
    coordinates: LatLng(7.0667, 38.4833),
  ),
  TopTripsModel(
    assetName: "assets/images/amora gedel park.jpg",
    location: "Hawassa",
    price: "ETB 2000",
    placeName: "Amora Gedel Park",
    catagory: 'Hawssa',
    coordinates: LatLng(7.0667, 38.5000),
  ),
];