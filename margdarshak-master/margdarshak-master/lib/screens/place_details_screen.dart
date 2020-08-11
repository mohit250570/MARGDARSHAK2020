import 'package:flutter/material.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/models/place_model.dart';
import 'package:margdarshak/widgets/place_details_screen/place_details_body.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final String placeId;

  PlaceDetailsScreen(this.placeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MARGDARSHAK"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: NearbyPlaces().getAdditionalPlaceDetails(placeId),
        builder: (ctx, placeSnapshot) {
          if (!placeSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print("Place details fetched!");

          Place additionalPlaceDetail = placeSnapshot.data;
          return PlaceDetailsBody(additionalPlaceDetail: additionalPlaceDetail);
        },
      ),
    );
  }
}
