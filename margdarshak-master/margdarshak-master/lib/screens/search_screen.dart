import 'package:flutter/material.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/screens/place_details_screen.dart';
import 'package:search_map_place/search_map_place.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SearchMapPlaceWidget(
            apiKey: NearbyPlaces.apikey,
            hasClearButton: true,
            location: NearbyPlaces.currentUserLocation,
            radius: 20000,
            strictBounds: true,
            placeholder: "Search...",
            icon: Icons.search,
            onSelected: (place) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailsScreen(place.placeId),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
