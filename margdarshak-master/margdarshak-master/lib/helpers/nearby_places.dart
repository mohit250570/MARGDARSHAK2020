import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:margdarshak/providers/favorite_places.dart';
import 'package:margdarshak/models/place_model.dart';

class NearbyPlaces {
  static LatLng currentUserLocation;

  static const apikey = "AIzaSyDP1quJj6DNa3HN_hXjAbMWCTZGm6GWzPo";

  static setUserLocation(LatLng userLocation) {
    currentUserLocation = userLocation;
  }

  Future<List<Place>> searchNearbyPlaces(String placeType) async {
    var placeTypeString = placeType == null ? "" : "&types=$placeType";
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentUserLocation.latitude},${currentUserLocation.longitude}&radius=20000$placeTypeString&key=$apikey";

    var response = await http.get(url);
    List data = json.decode(response.body)["results"];

    List<Place> places = [];

    data.forEach((f) {
      places.add(Place(
        icon: f["icon"],
        id: f["place_id"],
        name: f["name"],
        rating: f["rating"].toString(),
        vicinity: f["vicinity"],
        location: LatLng(
            f["geometry"]["location"]["lat"], f["geometry"]["location"]["lng"]),
      ));
    });

    return places;
  }

  Future<Place> getAdditionalPlaceDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apikey";

    var response = await http.get(url);

    Map<String, dynamic> data = json.decode(response.body)["result"];
    // print(placeId);

    List<String> weekdays = [];
    if (data["opening_hours"] != null) {
      Map<String, dynamic> openingHours = data["opening_hours"];
      (openingHours["weekday_text"] as List<Object>).forEach((element) {
        weekdays.add(element);
      });
    }
    // print(weekdays);
    var fetchedPlace = Place(
      formattedAddress: data["formatted_address"],
      internationalPhoneNumber: data.containsKey("international_phone_number")
          ? data["international_phone_number"]
          : null,
      weekdayText: weekdays,
      icon: data["icon"],
      id: data["place_id"],
      name: data["name"],
      rating: data["rating"].toString(),
      vicinity: data["vicinity"],
      location: LatLng(data["geometry"]["location"]["lat"],
          data["geometry"]["location"]["lng"]),
    );
    return fetchedPlace;
  }

}
