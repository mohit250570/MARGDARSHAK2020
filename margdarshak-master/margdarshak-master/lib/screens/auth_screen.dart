import 'dart:io';

// import 'package:chat_app/widgets/auth/auth_form.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:margdarshak/screens/tabs_screen.dart';
import '../widgets/auth_screen/auth_form.dart';

class AuthScreen extends StatefulWidget {
  final bool isStart;

  AuthScreen(this.isStart);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _auth = FirebaseAuth.instance;
  AuthResult authResult;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'points': 0,
        });
      }
      if (widget.isStart == false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => TabsScreen(),
          ),
        );
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, Please check the credentials!';

      if (error.message != null) {
        message = error.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: widget.isStart
            ? null
            : IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(10),
              alignment: Alignment(-0.8,-0.2),
              child: Text(
                "Margdarshak",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                ),
              ),
            ),
            AuthForm(_submitAuthForm, _isLoading),
          ],
        ),
      ),
    );
  }
}
