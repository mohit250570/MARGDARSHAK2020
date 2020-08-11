import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:margdarshak/providers/place_reviews.dart';

class MyFeedbacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Feedbacks"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (!userSnapshot.hasData) {
              return Center(
                child: Text("Please Login to view your feedbacks!"),
              );
            }
            return FutureBuilder(
              future: PlaceReview.fetchAndSetMyFeedbacks(),
              builder: (ctx, feedbackSnapshot) {
                if (feedbackSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<ReviewModel> reviews = feedbackSnapshot.data;
                return reviews.length == 0
                    ? Center(
                        child: Text("No feedbacks available!"),
                      )
                    : ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (ctx, index) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      "Place Name: ${reviews[index].placeName}\nReview: ${reviews[index].reviewText}",
                                      maxLines: 10,
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Text("Image:"),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            reviews[index].reviewImageUrl,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                "${DateFormat.yMMMd().format(reviews[index].dateTime)}",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            );
          }),
    );
  }
}
