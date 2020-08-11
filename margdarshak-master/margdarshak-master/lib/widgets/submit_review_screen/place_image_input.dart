import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlaceImageInput extends StatefulWidget {
  final void Function(File reviewPlaceImage) imagePickFn;

  PlaceImageInput(this.imagePickFn);

  @override
  _PlaceImageInputState createState() => _PlaceImageInputState();
}

class _PlaceImageInputState extends State<PlaceImageInput> {
  File _placeImage;

  void inputImage(bool fromCamera) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 80,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _placeImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            image: _placeImage != null
                ? DecorationImage(
                    image: FileImage(_placeImage),
                  )
                : null,
          ),
          child: _placeImage == null
              ? Center(
                  child: Text(
                    "Add an image \nof this place",
                    textAlign: TextAlign.center,
                  ),
                )
              : null,
        ),
        FlatButton.icon(
          onPressed: () {
            inputImage(true);
          },
          icon: Icon(Icons.camera),
          label: Text("Take Picture"),
        ),
        FlatButton.icon(
          onPressed: () {
            inputImage(false);
          },
          icon: Icon(Icons.image),
          label: Text("Choose from gallery"),
        ),
      ],
    );
  }
}
