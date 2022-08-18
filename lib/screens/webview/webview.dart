import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview_Screen extends StatelessWidget {
final String url;
Webview_Screen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(initialUrl: url,),
    );
  }
}
