import 'package:flutter/material.dart';
import 'package:margdarshak/screens/auth_screen.dart';

class StartAuthscreen extends StatelessWidget {
  final void Function() skipTheLoginFn;

  StartAuthscreen(this.skipTheLoginFn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AuthScreen(true),
          Positioned(
            bottom: 10,
            right: 10,
            child: FlatButton(
              onPressed: skipTheLoginFn,
              child: Text("Skip For Now"),
              textColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
