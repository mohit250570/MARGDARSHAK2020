import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CustomWebView extends StatefulWidget {
  final String title;
  final String url;

  CustomWebView({this.title, this.url});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
          ),
        ),
        url: widget.url,
        allowFileURLs: true,
        hidden: true,
        withJavascript: true,
        withLocalStorage: true,
        withLocalUrl: true,
      ),
    );
  }
}
