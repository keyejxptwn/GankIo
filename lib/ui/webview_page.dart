import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewPage(this.title, this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState(title, url);
}

class _WebViewPageState extends State<WebViewPage> {
  final String title;
  final String url;

  _WebViewPageState(this.title, this.url);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
