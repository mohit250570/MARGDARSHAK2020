import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:margdarshak/helpers/nearby_places.dart';

class ReviewModel {
  String username;
  DateTime dateTime;
  String reviewText;
  String reviewImageUrl;
  String placeName;
  String placeId;

  ReviewModel({
    this.username,
    this.dateTime,
    this.reviewText,
    this.placeId,
    this.placeName,
    this.reviewImageUrl,
  });
}

class PlaceReview {
  static Future<void> submitAReview(
      String placeId, String reviewText, File reviewImage) async {
    final timestamp = DateTime.now().toIso8601String();

    try {
      final user = await FirebaseAuth.instance.currentUser();

      final userData =
          await Firestore.instance.collection('users').document(user.uid).get();
      final username = userData["username"];

      //...upload image file
      final ref = FirebaseStorage.instance
          .ref()
          .child("place_images")
          .child(placeId)
          .child("${user.uid}_$timestamp.jpg");

      await ref.putFile(reviewImage).onComplete;

      final reviewImageUrl = await ref.getDownloadURL();

      //storing review for individual place

      final newReview = [
        {
          "username": username,
          "timestamp": timestamp,
          "review_text": reviewText,
          "image_url": reviewImageUrl,
        }
      ];

      await Firestore.instance
          .collection('userReviews')
          .document(placeId)
          .setData({"reviews": FieldValue.arrayUnion(newReview)}, merge: true);

      //storing feebacks mapped to individual user

      var place = await NearbyPlaces().getAdditionalPlaceDetails(placeId);
      var placeName = place.name;

      final newFeedback = [
        {
          "username": username,
          "timestamp": timestamp,
          "review_text": reviewText,
          "image_url": reviewImageUrl,
          "placename": placeName,
          "placeid": placeId,
        }
      ];

      await Firestore.instance
          .collection('myFeedbacks')
          .document(user.uid)
          .setData({"reviews": FieldValue.arrayUnion(newFeedback)},
              merge: true);
      await Firestore.instance.collection('users').document(user.uid).setData(
        {
          "points": FieldValue.increment(10),
        },
        merge: true,
      );
    } catch (error) {
      throw error;
    }
  }

  static Future<List<ReviewModel>> fetchAndSetUserReviews(
      String placeId) async {
    print("started");
    final doc = await Firestore.instance
        .collection('userReviews')
        .document(placeId)
        .get();
    print("getting");

    List<ReviewModel> reviews = [];

    if (doc.data == null) {
      print("null");
    } else {
      final userReviews = doc.data["reviews"] as List<dynamic>;
      userReviews.forEach((review) {
        DateTime timestamp = DateTime.parse(review["timestamp"]);
        reviews.add(
          ReviewModel(
            dateTime: timestamp,
            reviewText: review["review_text"],
            username: review["username"],
            reviewImageUrl: review["image_url"],
          ),
        );
      });
      print("ok");
    }
    return reviews;
  }

  static Future<List<ReviewModel>> fetchAndSetMyFeedbacks() async {
    final user = await FirebaseAuth.instance.currentUser();

    final doc = await Firestore.instance
        .collection('myFeedbacks')
        .document(user.uid)
        .get();

    List<ReviewModel> reviews = [];

    if (doc.data == null) {
      print("null");
    } else {
      final userReviews = doc.data["reviews"] as List<dynamic>;
      userReviews.forEach((review) {
        DateTime timestamp = DateTime.parse(review["timestamp"]);
        reviews.add(
          ReviewModel(
            dateTime: timestamp,
            reviewText: review["review_text"],
            username: review["username"],
            placeId: review["placeid"],
            placeName: review["placename"],
            reviewImageUrl: review["image_url"],
          ),
        );
      });
    }
    return reviews;
  }

  static Future<int> getMyRewardPoints() async {
    final user = await FirebaseAuth.instance.currentUser();

    try {
      final doc =
          await Firestore.instance.collection('users').document(user.uid).get();

      return doc.data['points'];
    } catch (error) {
      throw error;
    }
  }

  static Future<void> redeemMyRewardPoints(
      int points, String phonenumber) async {
    final user = await FirebaseAuth.instance.currentUser();

    try {
      await Firestore.instance.collection('users').document(user.uid).setData(
        {
          "points": 0,
        },
        merge: true,
      );

      String username = 'shopocusasset@gmail.com';
      String password = 'Shubh123456';

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'Margdarshak')
        ..recipients.add('margdarshak.akgec.2020@gmail.com')
        ..subject = '${user.email} :: ${DateTime.now()}'
        ..text =
            'Redeemer email: ${user.email}\nRedeemer uid: ${user.uid}\nRedeemed points: $points\nUser Phone No.: $phonenumber';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
