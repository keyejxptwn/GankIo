import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigGirlPage extends StatefulWidget {
  String title;
  String imageUrl;

  BigGirlPage({Key key, @required this.title, @required this.imageUrl})
      : super(key: key);

  @override
  _BigGirlPageState createState() => _BigGirlPageState(title, imageUrl);
}

class _BigGirlPageState extends State<BigGirlPage> {
  String title;
  String imageUrl;
  bool isLoadFinnish = false;

  _BigGirlPageState(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fitHeight,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          appBar: AppBar(
            backgroundColor: Color(0xE52097F4), //把appbar的背景色改成透明
            // elevation: 0,//appbar的阴影
            title: Text(title),
          ),
        ));
  }

  _imageLoadListener() {}
}
