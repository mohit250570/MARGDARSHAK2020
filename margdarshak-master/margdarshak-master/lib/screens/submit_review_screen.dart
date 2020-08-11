import 'dart:io';

import 'package:flutter/material.dart';
import 'package:margdarshak/models/place_model.dart';
import 'package:margdarshak/providers/place_reviews.dart';
import 'package:margdarshak/widgets/submit_review_screen/place_image_input.dart';

class SubmitReviewScreen extends StatefulWidget {
  final Place place;
  final BuildContext ancestorContext;

  SubmitReviewScreen(this.place, this.ancestorContext);
  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  final reviewController = TextEditingController();
  File _reviewPlaceImageFile;

  var isLoading = false;

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void imagePickFn(File image) {
    _reviewPlaceImageFile = image;
  }

  void submitReview() async {
    FocusScope.of(context).unfocus();
    if (reviewController.text.isEmpty || _reviewPlaceImageFile == null) {
      print("returned");
      return;
    }
    print("submitted");
    setState(() {
      isLoading = true;
    });
    try {
      await PlaceReview.submitAReview(widget.place.id, reviewController.text, _reviewPlaceImageFile);
      Scaffold.of(widget.ancestorContext).hideCurrentSnackBar();

      Scaffold.of(widget.ancestorContext).showSnackBar(
        SnackBar(
          content: Text("Review submitted successfully!"),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (err) {
      Scaffold.of(widget.ancestorContext).hideCurrentSnackBar();
      Scaffold.of(widget.ancestorContext).showSnackBar(
        SnackBar(
          content: Text("Failed to submit review !"),
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit A Review"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text("Submitting Review For:"),
              Text(widget.place.name),
              Divider(),
              TextField(
                decoration: InputDecoration(labelText: "Add a review"),
                controller: reviewController,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(
                height: 10,
              ),
              PlaceImageInput(imagePickFn),
              RaisedButton(
                  onPressed: submitReview,
                  child: Text(isLoading ? "Submitting..." : "Submit Review"),
                  color: Theme.of(context).buttonColor,
                  textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
