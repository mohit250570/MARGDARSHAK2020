import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:margdarshak/screens/about_us_screen.dart';
import 'package:margdarshak/screens/auth_screen.dart';
import 'package:margdarshak/screens/contact_us_screen.dart';
import 'package:margdarshak/screens/my_feedbacks.dart';
import 'package:margdarshak/screens/rewards_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void pushScreen(Widget screen) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => screen,
        ),
      );
    }

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Menu"),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (ctx, userSnapshot) {
                if (userSnapshot.hasData) {
                  var uid = userSnapshot.data.uid;
                  return Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: Firestore.instance
                            .collection('users')
                            .document(uid)
                            .get(),
                        builder: (ctx, snapshot) {
                          return Container(
                            width: double.infinity,
                            height: 30,
                            alignment: Alignment.center,
                            child: snapshot.connectionState ==
                                    ConnectionState.waiting
                                ? Text("")
                                : Text(
                                    "Hi, ${snapshot.data["username"]}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Color(0xFF7B808C),
                        ),
                        title: Text("Logout"),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  );
                }
                return ListTile(
                  leading: Icon(
                    Icons.touch_app,
                    color: Color(0xFF7B808C),
                  ),
                  title: Text("Login"),
                  onTap: () {
                    pushScreen(AuthScreen(false));
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.chrome_reader_mode,
                color: Color(0xFF7B808C),
              ),
              title: Text("About Us"),
              onTap: () {
                pushScreen(AboutUsScreen());
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.card_giftcard,
                color: Color(0xFF7B808C),
              ),
              title: Text("Rewards"),
              onTap: () {
                pushScreen(RewardsScreen());
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.forum,
                color: Color(0xFF7B808C),
              ),
              title: Text("Contact Us"),
              onTap: () {
                pushScreen(ContactUsScreen());
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: Color(0xFF7B808C),
              ),
              title: Text("Feedbacks"),
              onTap: () {
                pushScreen(MyFeedbacks());
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
