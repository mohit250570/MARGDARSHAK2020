import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:margdarshak/providers/place_reviews.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void redeemPoints(int points) async {
    if (_phoneController.text.trim().length != 10) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Phone Number"),
          content:
              Text("Please provide a valid phone no. to recieve paytm cash on"),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    if (points > 0 && _phoneController.text.trim().length == 10) {
      await PlaceReview.redeemMyRewardPoints(points, _phoneController.text.trim());
      setState(() {});
      showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
          backgroundColor: Colors.red,
          contentPadding: const EdgeInsets.all(10),
          title: Text(
            "Points Redeemed Successfully!",
            style: TextStyle(color: Colors.white),
          ),
          children: <Widget>[
            Text(
              'You will soon recieve paytm cash on this submitted phone number',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Rewards"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (!userSnapshot.hasData) {
              return Center(
                child: Text("Please Login to view your rewards!"),
              );
            }
            return FutureBuilder(
              future: PlaceReview.getMyRewardPoints(),
              builder: (ctx, rewardsSnapshot) {
                if (rewardsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 2,
                      colors: [
                        Colors.grey,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          "My Reward Points",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        Divider(
                          color: Colors.red,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Text(
                          "${rewardsSnapshot.data}",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        if (rewardsSnapshot.data >= 50)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Enter mobile no. for paytm cash",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                              controller: _phoneController,
                              onChanged: (_){
                                if(_phoneController.text.trim().length == 10){
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        RaisedButton.icon(
                          color: Colors.red,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                          onPressed: rewardsSnapshot.data >= 50 &&
                                  (_phoneController.text.length == 10)
                              ? () {
                                  redeemPoints(rewardsSnapshot.data);
                                }
                              : null,
                          icon: Icon(
                            Icons.redeem,
                            size: 30,
                          ),
                          label: Text(
                            rewardsSnapshot.data >= 50
                                ? "Redeem my points"
                                : "Min. 50 points \nrequired to redeem",
                            style: TextStyle(
                              fontSize: rewardsSnapshot.data >= 50 ? 30 : 20,
                            ),
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
