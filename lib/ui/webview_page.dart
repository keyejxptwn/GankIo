import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState(title, url);
}

class _WebViewPageState extends State<WebViewPage> {
  final String title;
  final String url;
  bool _isLoadFinnish = false;

  _WebViewPageState(this.title, this.url);

  @override
  void initState() {
    super.initState();
    print("title:$title   url:$url");
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _isLoadFinnish,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
          Offstage(
            offstage: !_isLoadFinnish,
            child: WebView(
              initialUrl: url,
              onPageFinished: (value) {
                _isLoadFinnish = true;
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
