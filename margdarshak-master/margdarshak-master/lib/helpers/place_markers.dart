import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:margdarshak/models/place_model.dart';
import 'package:margdarshak/screens/place_details_screen.dart';

class PlaceMarkers {
  static Set<Marker> getMarkers(List<Place> places, BuildContext context) {
    Set<Marker> markers = {};

    places.forEach((place) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(
            title: place.name,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailsScreen(place.id),
                ),
              );
            },
          ),
          position: LatLng(place.location.latitude, place.location.longitude),
          visible: true,
        ),
      );
    });

    return markers;
  }
}
