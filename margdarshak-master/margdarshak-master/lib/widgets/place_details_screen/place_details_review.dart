import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:margdarshak/providers/place_reviews.dart';
import 'package:margdarshak/widgets/place_details_screen/place_details_body.dart';

class PlaceDetailReviews extends StatelessWidget {
  const PlaceDetailReviews({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final PlaceDetailsBody widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            PlaceReview.fetchAndSetUserReviews(widget.additionalPlaceDetail.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          List<ReviewModel> reviews = snapshot.data;
          return Container(
              width: double.infinity,
              height: reviews.length > 0 ? min(150, reviews.length * 60.0) : 0,
              margin: const EdgeInsets.only(top: 10),
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView.builder(
                    itemBuilder: (ctx, index) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      reviews[index].reviewImageUrl,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${reviews[index].username}", //(${DateFormat.yMMMd().format(reviews[index].dateTime)})",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      " ${reviews[index].reviewText}",
                                      maxLines: 10,
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    itemCount: reviews.length),
              ));
        });
  }
}
