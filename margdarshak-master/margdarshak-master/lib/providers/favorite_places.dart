import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/models/place_model.dart';

class FavoritePlaces with ChangeNotifier {
  List<String> _placeIds = [];

  List<Place> _favPlaces = [];

  List<String> get getFavoritePlaceIds {
    return [..._placeIds];
  }

  List<Place> get favPlaces {
    return [..._favPlaces];
  }

  Future<void> toggleFavoritePlace(String placeId) async {
    if (_placeIds.contains(placeId)) {
      _placeIds.remove(placeId);
    } else {
      _placeIds.add(placeId);
    }
    var user = await FirebaseAuth.instance.currentUser();

    await Firestore.instance
        .collection('userFavorites')
        .document(user.uid)
        .setData({
      "placeIds": [..._placeIds],
    });
    notifyListeners();
  }

  Future<void> setFavoritePlaces() async {
    _favPlaces.clear();
    

    var user = await FirebaseAuth.instance.currentUser();

    final doc = await Firestore.instance
        .collection('userFavorites')
        .document(user.uid)
        .get();

    print(doc.data["placeIds"]);
    _placeIds.clear();
    (doc.data["placeIds"] as List<dynamic>).forEach((element) {
      _placeIds.add(element);
    });

    _placeIds.forEach((placeId) async {
      var fetchedPlace =
          await NearbyPlaces().getAdditionalPlaceDetails(placeId);
      _favPlaces.add(fetchedPlace);
      notifyListeners();
    });
  }

  bool isFavorite(String placeId) {
    return _placeIds.contains(placeId);
  }
}
