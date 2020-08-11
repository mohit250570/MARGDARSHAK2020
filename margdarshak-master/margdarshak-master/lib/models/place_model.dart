import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String icon;
  String name;
  String vicinity;
  String rating;
  String id;
  String internationalPhoneNumber;
  String formattedAddress;
  List<String> weekdayText;
  LatLng location;

  Place(
      {this.icon,
      this.name,
      this.vicinity,
      this.rating,
      this.id,
      this.formattedAddress,
      this.internationalPhoneNumber,
      this.weekdayText,
      this.location,
      });
}
