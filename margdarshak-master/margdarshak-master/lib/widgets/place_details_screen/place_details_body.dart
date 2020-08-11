import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:margdarshak/providers/favorite_places.dart';
import 'package:margdarshak/helpers/place_markers.dart';
import 'package:margdarshak/models/place_model.dart';
import 'package:margdarshak/providers/place_reviews.dart';
import 'package:margdarshak/screens/map_screen.dart';
import 'package:margdarshak/screens/submit_review_screen.dart';
import 'package:margdarshak/widgets/place_details_screen/place_details_review.dart';
import 'package:provider/provider.dart';

class PlaceDetailsBody extends StatefulWidget {
  const PlaceDetailsBody({
    Key key,
    @required this.additionalPlaceDetail,
  }) : super(key: key);

  final Place additionalPlaceDetail;

  @override
  _PlaceDetailsBodyState createState() => _PlaceDetailsBodyState();
}

class _PlaceDetailsBodyState extends State<PlaceDetailsBody> {
  Set<Marker> _marker;
  bool isFavoritePlace;

  @override
  void initState() {
    super.initState();
    _marker = PlaceMarkers.getMarkers([widget.additionalPlaceDetail], context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.additionalPlaceDetail.name,
                    maxLines: 5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseAuth.instance.onAuthStateChanged,
                  builder: (ctx, userSnapshot) {
                    if (!userSnapshot.hasData) {
                      return Container();
                    }
                    return Consumer<FavoritePlaces>(
                      builder: (ctx, favPlacesProvider, _) {
                        isFavoritePlace = favPlacesProvider
                            .isFavorite(widget.additionalPlaceDetail.id);
                        return IconButton(
                          icon: Icon(
                              isFavoritePlace ? Icons.star : Icons.star_border),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Provider.of<FavoritePlaces>(context, listen: false)
                                .toggleFavoritePlace(
                                    widget.additionalPlaceDetail.id);
                            setState(() {
                              isFavoritePlace = !isFavoritePlace;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  "Address:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.additionalPlaceDetail.formattedAddress),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Timings: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (widget.additionalPlaceDetail.weekdayText.isEmpty)
              Text("Not Available!"),
            if (widget.additionalPlaceDetail.weekdayText.isNotEmpty)
              Text(widget.additionalPlaceDetail.weekdayText.join("\n")),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Reviews:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      widget.additionalPlaceDetail.rating == "null"
                          ? Text("  No ratings yet!")
                          : Row(
                              children: <Widget>[
                                Text(
                                  widget.additionalPlaceDetail.rating,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(Icons.star),
                              ],
                            ),
                    ],
                  ),
                  PlaceDetailReviews(widget: widget),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: MapScreen(_marker, placeDetail: true,destination: widget.additionalPlaceDetail.location,),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (ctx, userSnapshot) {
                if (userSnapshot.hasData) {
                  return Align(
                    alignment: Alignment.center,
                    child: OutlineButton.icon(
                      textColor: Theme.of(context).buttonColor,
                      borderSide:
                          BorderSide(color: Theme.of(context).buttonColor),
                      icon: Icon(
                        Icons.rate_review,
                      ),
                      label: Text("Submit a review"),
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (ctx) => SubmitReviewScreen(
                              widget.additionalPlaceDetail,
                              context,
                            ),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
