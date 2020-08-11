import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/utils/maps_screen_mixins.dart';

class MapScreen extends StatefulWidget {
  final Set<Marker> markers;
  final bool placeDetail;
  LatLng destination;

  MapScreen(
    this.markers, {
    this.placeDetail = false,
    this.destination,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with MapScreenMixins {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng currLocation;

  @override
  void initState() {
    getPermission();
    getCurrentLocation().then((value) {
      print("LocationData => $value");
      currLocation = LatLng(value.latitude, value.longitude);
      setState(() {});
      NearbyPlaces.setUserLocation(currLocation);
      print("UserLocation = ${NearbyPlaces.currentUserLocation}");
    });
    super.initState();
  }

  static final CameraPosition _currPos = CameraPosition(
    target: currLocation,
    zoom: 10,
  );

  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDP1quJj6DNa3HN_hXjAbMWCTZGm6GWzPo";

  void setPolyLines() async {
    print("setPolyLines");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(currLocation.latitude, currLocation.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
    );
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
     setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
         polylineId: PolylineId("poly"),
         color: Color.fromARGB(255, 40, 122, 198),
         points: polylineCoordinates
      );
 
      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currLocation != null
          ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _currPos,
              onMapCreated: (GoogleMapController controller) {
                print("initialised maps");
                _controller.complete(controller);
                if (widget.placeDetail) {
                  setPolyLines();
                }
              },
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: widget.markers,
              polylines: _polylines,
              mapToolbarEnabled: false,
            )
          : Scaffold(),
    );
  }
}
