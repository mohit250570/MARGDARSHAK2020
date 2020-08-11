import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black87,
              BlendMode.luminosity,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              Text(
                "A great app to search any type of place near your location. You can search Hospitals, ATM, Medical Store, Bank, Restaurant, Cafe, Departmental Store, Doctors, Laundary, Lodging, School, Taxi Stand, Police Station, Parking, Night club and many more places near you.\n\nGet all the details about the place like Contact, Rating, User Reviews and Images.\n\nJust tap and Go anywhere you want!",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
