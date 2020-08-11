import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:margdarshak/providers/favorite_places.dart';
import 'package:margdarshak/screens/start_auth_screen.dart';
import 'package:margdarshak/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppChild();
  }
}

class MyAppChild extends StatefulWidget {
  @override
  _MyAppChildState createState() => _MyAppChildState();
}

class _MyAppChildState extends State<MyAppChild> {
  bool skipLogin = false;

  void skipTheLogin() {
    setState(() {
      skipLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FavoritePlaces(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Margdarshak',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: AppBarTheme(
            color: Color(0xFF3A3D42),
            textTheme: TextTheme(
                headline6: TextStyle(
              fontFamily: "mavenPro",
              // fontWeight: FontWeight.w300,
              fontSize: 24,
              color: Colors.white,
            )),
          ),
          primaryIconTheme:
              ThemeData.light().primaryIconTheme.copyWith(color: Colors.white),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "mavenPro",
                ),
                bodyText1: TextStyle(
                  fontFamily: "mavenPro",
                  fontSize: 16,

                ),
                bodyText2: TextStyle(
                  fontFamily: "mavenPro",
                  fontSize: 16,

                ),
                button: TextStyle(
                  fontFamily: "mavenPro",
                  fontSize: 18,
                ),
              ),
          buttonTheme: ThemeData.light().buttonTheme.copyWith(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          buttonColor: Color(0xFF3A3D42),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData || skipLogin) {
              return TabsScreen();
            }
            return StartAuthscreen(skipTheLogin);
          },
        ),
      ),
    );
  }
}
