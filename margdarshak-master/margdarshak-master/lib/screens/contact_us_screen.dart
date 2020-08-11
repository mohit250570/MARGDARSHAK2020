import 'package:flutter/material.dart';
import 'package:margdarshak/screens/custom_webview.dart';

class ContactUsScreen extends StatelessWidget {
  void launchWebView(String title, String url, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CustomWebView(
          title: title,
          url: url,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      iconSize: 40,
                      icon: Image.asset("assets/icons/fb.png"),
                      onPressed: () {
                        launchWebView(
                          "Margdarshak",
                          "https://m.facebook.com/Margdarshak-106150961199670/",
                          context,
                        );
                      },
                    ),
                    InkWell(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/logo.jpeg"),
                      ),
                      onTap: () {
                        launchWebView(
                          "Margdarshak",
                          "https://margdarshakakgec20.wixsite.com/website",
                          context,
                        );
                      },
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: Image.asset("assets/icons/insta.png"),
                      onPressed: () {
                        launchWebView(
                          "Margdarshak",
                          "https://www.instagram.com/marg.darshak/",
                          context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  Text(
                    "Developed by:\n",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  Text(
                      "Kshitij Srivastava\nMridul Arora\nMohit Rathaur\nPrashant Gupta"),
                  Divider(
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Mail us at: "),
                  ),
                  Text("margdarshak.akgec.2020@gmail.com"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
